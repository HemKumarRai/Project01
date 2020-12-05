import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:project01_app/exception/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication with ChangeNotifier {
  String _token;
  String _userId;
  DateTime _expiryDate;
  Timer _authTimer;

  bool get isAuth {
    return _token != null;
  }

  String get userId {
    return _userId;
  }

  String get token {
    if (_token != null &&
        _expiryDate != null &&
        _expiryDate.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  Future<void> _authenticate(String email, String password, urlSegment) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyBZ2snP7YPoxkU8Ba1tIrlushOU4XnQAr8";

    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      print(response.body);
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));

      String userType;
      if (urlSegment == 'signUp') {
        userType = await addUserToDatabase(_token, _userId, email);
      } else {
        userType = await getUser(_token, _userId);
      }
      _autoLogOut();

      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate.toIso8601String(),
        'email': email,
        'userType': userType,
      });
      prefs.setString("userData", userData);
    } catch (e) {
      throw (e);
    }
  }

  Future<void> signUp(String email, String password) async {
    return await _authenticate(email, password, "signUp");
  }

//  Future<void> signUp(String email, String password) async {
//    final url =
//        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBZ2snP7YPoxkU8Ba1tIrlushOU4XnQAr8";
//    try {
//      final response = await http.post(url,
//          body: json.encode({
//            'email': email,
//            'password': password,
//            'returnSecureToken': true,
//          }));
//      print(response.body);
//    } catch (e) {
//      print(e.toString());
//    }
//  }

//  Future<void> signIn(String email, String password) async {
//    final url =
//        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBZ2snP7YPoxkU8Ba1tIrlushOU4XnQAr8";
//    try {
//      final response = await http.post(url,
//          body: json.encode({
//            'email': email,
//            'password': password,
//            'returnSecureToken': true,
//          }));
//      print(response.body);
//    } catch (e) {
//      print(e.toString());
//    }
//
//
//
//  }
  Future<void> signIn(String email, String password) async {
    return await _authenticate(email, password, "signInWithPassword");
  }

  Future<String> addUserToDatabase(
      String authToken, String userId, String email) async {
    final url =
        "https://jhjbkm-3a86e.firebaseio.com/users/$userId.json?auth=$authToken";
    try {
      final response = await http.put(url,
          body: json.encode({
            'userId': userId,
            'email': email,
            'userType': 'client',
          }));
      print(json.decode(response.body));
      return 'client';
    } catch (e) {
      throw (e);
    }
  }

  Future<String> getUser(String authToken, String userId) async {
    final url =
        "https://jhjbkm-3a86e.firebaseio.com/users/$userId.json?auth=$authToken";
    try {
      final response = await http.get(url);
      final extractedUser = json.decode(response.body) as Map<String, dynamic>;
      print(extractedUser.toString());
      return extractedUser['userType'];
    } catch (e) {
      throw e;
    }
  }

  Future<bool> tryAutoLogIn() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedData['token'];
    _expiryDate = expiryDate;
    _userId = extractedData['userId'];
    notifyListeners();
    _autoLogOut();
    return true;
  }

  Future<void> logOut() async {
    _token = null;
    _expiryDate = null;
    _userId = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }

  void _autoLogOut() {
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
      final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
      _authTimer = Timer(Duration(seconds: timeToExpiry), logOut);
    }
  }
}
