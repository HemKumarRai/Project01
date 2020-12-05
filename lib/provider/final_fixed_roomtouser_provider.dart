//import 'dart:convert';
//
//import 'package:flutter/cupertino.dart';
//import 'package:project01_app/provider/room.dart';
//import 'package:http/http.dart'as http;
//
//import 'bookedroomprovider.dart';
//
//class FixedRoomItem{
//  final String id;
//  final double amount;
//  final List<Room>rooms;
//  final DateTime dateTime;
//
//  FixedRoomItem(
//  {
//    @required this.id,
//    @required this.amount,
//    @required this.rooms,
//    @required this.dateTime
//}
//      );
//}
//
//class FixedRoom with ChangeNotifier{
////  final String _authToken;
////  final String _userId;
//
//
//List<FixedRoomItem>_fixedRooms=[];
//
//List<FixedRoomItem>get fiexedRoom{
//  return[..._fixedRooms];
//}
//
//Future<void>addOrderedRoom(List<BookedRoom> bookedItems,double total)async{
//  final url = "https://jhjbkm-3a86e.firebaseio.com/orderedRoom.json";
//  try{
//    final response=http.post(url,body: json.encode({
//      'amount':total,
//      'dateTime':DateTime.now().toIso8601String(),
//      'products':bookedItems.map((fi)=>{
//        'id':fi.id,
//        'price':fi.price,
//        'title':fi.title,
//
//      }).toList(),
//    }));
//    _fixedRooms.insert(0,
//        FixedRoomItem(
//            id: DateTime.now().toString(),
//        amount: total,
//rooms:,
//            dateTime: DateTime.now()));
//    notifyListeners();
//  }
//}
//
//}
