//import 'dart:convert';
//
//import 'package:flutter/cupertino.dart';
//import 'package:http/http.dart' as http;
//
//class BookedRoom {
//  final String id;
//  final String title;
//  final double price;
//  BookedRoom({
//    @required this.id,
//    @required this.title,
//    @required this.price,
//  });
//}
//
//class BookedRoomProvider with ChangeNotifier {
//  final String _authToken;
//  final String _userId;
//
//  BookedRoomProvider(this._authToken, this._room, this._userId);
//
//  String customerName;
//  bool isRoomBooked = false;
//
//  Map<String, BookedRoom> _room = {};
//  Map<String, BookedRoom> get rooms {
//    return {..._room};
//  }
//
//  Future<List<BookedRoom>> bookedRoom(
//      String roomId, String title, double price) async {
//    final url =
//        "https://jhjbkm-3a86e.firebaseio.com/BookedRoom/$_userId.json?auth=$_authToken";
//
//    try {
//      final response = await http.post(url,
//          body: jsonEncode({
//            'roomId': roomId,
//            'Price': price,
//            'location': title,
//          }));
//      print(response.body);
//      _room.putIfAbsent(
//          roomId,
//          () => BookedRoom(
//                id: DateTime.now().toString(),
//                title: title,
//                price: price,
//              ));
//      isRoomBooked = true;
//    } catch (e) {
//      print.toString();
//    }
//  }
//
//  double get totalAmount {
//    double total = 0.0;
//    _room.forEach((key, bookedRoom) {
//      total += 1 * bookedRoom.price;
//    });
//    return total;
//  }
//
//  void clearBookedRoom() {
//    _room = {};
//    notifyListeners();
//  }
//
//  void cancelBookedRoom(String id) {
//    _room.remove(id);
//  }
//}
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class BookedRoom with ChangeNotifier {
  final String id;
  final String title;
  final double price;
  BookedRoom({
    @required this.id,
    @required this.title,
    @required this.price,
  });
}

class BookedRoomProvider with ChangeNotifier {
  final String _authToken;
  final String _userId;

  BookedRoomProvider(this._authToken, this._room, this._userId);

  String customerName;
  bool isRoomBooked = false;

  List<BookedRoom> _room = [
    BookedRoom(id: 'abc', price: double.parse('400'), title: 'opq'),
    BookedRoom(id: 'abc', price: double.parse('400'), title: 'opq')
  ];
  List<BookedRoom> get room {
    return [..._room];
  }

  Future<void> bookedRoom(String roomId, String title, double price) async {
    final url =
        "https://jhjbkm-3a86e.firebaseio.com/BookedRoom/$_userId.json?auth=$_authToken";

    try {
      final response = await http.post(url,
          body: jsonEncode({
            'roomId': roomId,
            'Price': price,
            'location': title,
          }));
      print(response.body);
      _room.add(BookedRoom(id: roomId, title: title, price: price));
      isRoomBooked = true;
    } catch (e) {
      print.toString();
    }
  }

  double get totalAmount {
    _room.contains(
      (BookedRoom bookedRoom) {
        return bookedRoom.price;
      },
    );
    return null;
  }

  void clearBookedRoom() {
    _room = [];
    notifyListeners();
  }

  void cancelBookedRoom(String id) {
    _room.remove(id);
  }
}
