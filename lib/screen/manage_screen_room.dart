import 'package:flutter/material.dart';
import 'package:project01_app/modal/imageurl_picker.dart';
import 'package:project01_app/modal/manage_screen_item.dart';
import 'package:project01_app/provider/room_provider.dart';
import 'package:provider/provider.dart';

class RoomManageScreen extends StatefulWidget {
  static const routName = 'manage_room';
  @override
  _RoomManageScreenState createState() => _RoomManageScreenState();
}

class _RoomManageScreenState extends State<RoomManageScreen> {
  @override
  Widget build(BuildContext context) {
    final room = Provider.of<RoomProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Available Rooms"),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10),
            child: CircleAvatar(
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImagePickerFromMobile()));
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 26,
                ),
              ),
            ),
          ),
        ],
      ),
      body: room != null
          ? ListView.builder(
              itemCount: room.items.length,
              itemBuilder: (context, index) => ManageScreenItem(
                  room.items[index].location,
                  room.items[index].imageUrl,
                  room.items[index].id))
          : "",
    );
  }
}
