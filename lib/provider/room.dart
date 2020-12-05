import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Room with ChangeNotifier {
  final String id;
  final String location;
  final double rent;
  final String description;
  final String feat1;
  final String feat2;
  final String feat3;
  final String feat4;
  bool isBooked;

  final String forWhom;
  final String imageUrl;
  final String phone;
  final String district;
  bool isFavourite;
  Room({
    this.isBooked,
    @required this.id,
    @required this.location,
    @required this.rent,
    @required this.description,
    @required this.imageUrl,
    @required this.feat1,
    @required this.feat2,
    this.feat3,
    this.feat4,
    @required this.phone,
    @required this.forWhom,
    this.isFavourite = false,
    @required this.district,
  });

  void toggleIsBooked(String id) {
    isBooked = !isBooked;
    notifyListeners();
  }

  Future<void> toggleIsFavourite(String userId, String authToken) async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final url =
        "https://jhjbkm-3a86e.firebaseio.com/userFavourites/$userId/$id.json?auth=$authToken";
    try {
      final response = await http.put(url, body: json.encode(isFavourite));
      if (response.statusCode >= 400) {
        isFavourite = oldStatus;
        notifyListeners();
      }
    } catch (e) {
      isFavourite = oldStatus;
      notifyListeners();
    }
  }
}
