import 'package:flutter/material.dart';
import 'package:project01_app/provider/room_provider.dart';
import 'package:project01_app/screen/room_edit_screen.dart';
import 'package:provider/provider.dart';

class ManageScreenItem extends StatelessWidget {
  final String placeName;
  final String image;
  final String id;
  ManageScreenItem(this.placeName, this.image, this.id);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: ListTile(
            leading: CircleAvatar(
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(placeName),
            trailing: Container(
              width: 100,
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete_forever),
                    onPressed: () {
                      Provider.of<RoomProvider>(context, listen: false)
                          .deleteRoom(id);
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text('Deleted SuccessFully'),
                        duration: Duration(seconds: 3),
                      ));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.pushNamed(context,EditRoomScreen.routeName,arguments: id);
                    },
                  )
                ],
              ),
            )),
      ),
    );
  }
}
