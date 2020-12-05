import 'package:flutter/material.dart';
import 'package:project01_app/provider/bookedroomprovider.dart';
import 'package:provider/provider.dart';

class BookedRoomItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bookedRoom = Provider.of<BookedRoom>(context);
    return Dismissible(
      key: ValueKey(DateTime.now()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text('Are You Sure?'),
                content: Text('Do You Want Remove From the Cart'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                  ),
                  FlatButton(
                    child: Text('Yes'),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                  )
                ],
              );
            });
      },
      background: Container(
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        padding: EdgeInsets.only(right: 20),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 2,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.all(2.0),
              child: FittedBox(
                child: Chip(label: Text('रू ${bookedRoom.price.toString()}')),
              ),
            ),
            title: Text(bookedRoom.title),
            subtitle: Text(bookedRoom.price.toString()),
          ),
        ),
      ),
    );
  }
}
