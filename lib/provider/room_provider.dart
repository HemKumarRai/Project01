import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:project01_app/provider/room.dart';

class RoomProvider with ChangeNotifier {
  int notification = 0;
  final String _authToken;
  final String _userId;

  List<Room> _rooms = [
//    Room(
//        id: '1',
//        description:
//            'Room near balkumari with the facility of water and kdhafaja kdsahj asdfjhakhuierdaj jhasdkjfhkjahdfjjkasdfh'
//            'ajdshhafjhauifafjkasd ashjdfjakshfui  electricityy',
//        location: 'Gwarko',
//        rent: 50000,
//        isFavourite: false,
//        feat1: "2 BedRooms ",
//        feat2: "2 BathRooms,",
//        feat3: "Wifi",
//        feat4: "Electricity",
//        district: 'Bhaktapur',
//        phone: '98000000000',
//        forWhom: "Girls",
//        isBooked: false,
//        imageUrl:
//            "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/alex-papachristidis-hamptons-guest-bedroom-1589223872.png"),
//    Room(
//        id: '2',
//        description:
//            'Room near balkumari with the facility of water and electricityy',
//        location: 'Balkumari',
//        rent: 7000,
//        isFavourite: false,
//        district: 'LalitPur',
//        forWhom: "boys",
//        isBooked: false,
//        feat1: "24/7 Water/Electricity",
//        feat2: "Near Marker",
//        feat3: "Garden View",
//        feat4: "Near Airport",
//        phone: '98000000000',
//        imageUrl:
//            "https://i.pinimg.com/originals/3a/89/59/3a8959f959df6159e58b80d8ebbf4a81.jpg"),
//    Room(
//        id: '3',
//        description:
//            'Room near balkumari with the facility of water and electricityajfhajlndf;ajkny',
//        location: 'Satdobato',
//        rent: 6000,
//        isFavourite: false,
//        isBooked: false,
//        district: 'Bhaktapur',
//        feat1: "24/7 Water/Electricity",
//        feat2: "Near Marker",
//        feat3: "Garden View",
//        feat4: "Loundry",
//        forWhom: " Office",
//        phone: '98000000000',
//        imageUrl:
//            "https://lh3.googleusercontent.com/proxy/XuZfzYm9pNouhedfqtBwqzv7JM_EyQatkjqmm6LJ-nxbKXXiCK4ylpcEiMfjDcT6g-_JkdlT7sWb1JZzRmupxYbJu7_dcW4ITnjiblglSsE5DwFTEoUXcp4T9O4oXaDsczpqc7otTcBoz86lKJA36f59kFzuK8NsKbc"),
  ];
  RoomProvider(this._authToken, this._rooms, this._userId);

  List<Room> get items {
    return [..._rooms];
  }

  Room findById(String id) {
    return items.firstWhere((room) {
      return room.id == id;
    });
  }

  List<Room> get favourites {
    return _rooms.where((roomItem) {
      return roomItem.isFavourite;
    }).toList();
  }

  Future<void> addRoom(Room room) async {
    final url =
        "https://jhjbkm-3a86e.firebaseio.com/rooms.json?auth=$_authToken";
    try {
      final response = await http.post(url,
          body: json.encode({
            'imageUrl': room.imageUrl,
            'rent': room.rent,
            'description': room.description,
            'location': room.location,
            'district': room.district,
            'forWhom': room.forWhom,
            'phone': room.phone,
            'feature1': room.feat1,
            'feature2': room.feat2,
            'feature3': room.feat3,
            'feature4': room.feat4,
          }));

      final newRoom = Room(
        district: room.district,
        forWhom: room.forWhom,
        id: json.decode(response.body)['name'],
        phone: room.phone,
        feat1: room.feat1,
        feat2: room.feat2,
        feat3: room.feat3,
        feat4: room.feat4,
        rent: room.rent,
        location: room.location,
        description: room.description,
        imageUrl: room.imageUrl,
      );
      _rooms.add(newRoom);
      notification++;
      notifyListeners();
    } catch (e) {}
  }

  void deleteRoom(String id) {
//items.retainWhere((room)=>
//room.id==id,
//
//);
//notifyListeners();

    final existingRoomIndex = items.indexWhere((room) => room.id == id);
    _rooms.removeAt(existingRoomIndex);
    notifyListeners();
  }

  void updateProduct(String id, Room upRoom) {
    final roomIndex = _rooms.indexWhere(
      (room) => room.id == id,
    );
    if (roomIndex >= 0) {
      _rooms[roomIndex] = upRoom;
      notifyListeners();
    }
  }

  Future<void> fetchAndShowProducts() async {
    final url =
        "https://jhjbkm-3a86e.firebaseio.com/rooms.json?auth=$_authToken";
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
//      final extractedData = jsonDecode(response.body) ;
      final favouriteResponse = await http.get(
          "https://jhjbkm-3a86e.firebaseio.com/userFavourites/$_userId.json?auth=$_authToken");
      final favouriteData = json.decode(favouriteResponse.body);

      final List<Room> loadedRoom = [];
      extractedData.forEach((roomId, roomData) {
        return loadedRoom.add(Room(
            district: roomData['district'],
            forWhom: roomData['forWhom'],
            id: roomId,
            phone: roomData['phone'],
            feat1: roomData['feature1'],
            feat2: roomData['feature2'],
            feat3: roomData['feature3'],
            feat4: roomData['feature4'],
            rent: roomData['rent'],
            location: roomData['location'],
            description: roomData['description'],
            isFavourite:
                favouriteData == null ? false : favouriteData[roomId] ?? false,
            imageUrl: roomData['imageUrl']));
      });
      _rooms = loadedRoom;
      notifyListeners();
    } catch (e) {
      return Text(
        'Data are not stored in firebase dataBase',
        style: TextStyle(
          fontSize: 67,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  List<Room> getSearchItem(String query) {
    if (query.isNotEmpty && query != null) {
      notifyListeners();
      return _rooms
          .where((room) => room.location.toLowerCase().startsWith(query))
          .toList();
    }
    return [];
  }
}
