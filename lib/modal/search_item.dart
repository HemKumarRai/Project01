import 'package:flutter/material.dart';
import 'package:project01_app/screen/room_details_screen.dart';

class SearchItem extends StatelessWidget {
  final String placeName;
  final String imageUrl;
  final String rent;
  final String id;
  SearchItem({this.rent, this.imageUrl, this.placeName, this.id});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey,
      child: Container(
        height: 100,
        color: Colors.white70,
        child: ListTile(
          onTap: () {
            Navigator.pushNamed(context, RoomDetailScreen.routName,
                arguments: id);
          },
          title: Text(
            placeName,
          ),
          subtitle: Text("Rs $rent"),
          trailing: Image.network(imageUrl),
        ),
      ),
    );
  }
}
