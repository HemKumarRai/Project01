import 'package:flutter/material.dart';
import 'package:project01_app/helperfunction/authentication.dart';
import 'package:project01_app/provider/room.dart';
import 'package:project01_app/screen/room_details_screen.dart';
import 'package:provider/provider.dart';

class RoomItemModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final room = Provider.of<Room>(context);
    final auth = Provider.of<Authentication>(context, listen: false);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.black38,
              Colors.teal,
              Colors.white24,
              Colors.white,
              Colors.white24,
              Colors.black38,
            ]),
            boxShadow: [
              BoxShadow(
                  color: Colors.green,
                  offset: Offset(0.0, 2.0),
                  blurRadius: 5.0),
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Positioned(
                top: 210,
                left: 5.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SafeArea(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.lightBlue,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 16),
                            width: MediaQuery.of(context).size.width / 2,
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2),
                                child: SafeArea(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8),
                                        child: Text(
                                          "Room Features",
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 22,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "1. ${room.feat1}",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      Text(
                                        "2. ${room.feat2}",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      Text(
                                        "3. ${room.feat3}",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      Text(
                                        "4. ${room.feat4}",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20)),
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          child: Text(
                            room.forWhom,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    SafeArea(
                      child: Card(
                        color: Colors.blue.withOpacity(0.6),
                        child: Container(
                          decoration: BoxDecoration(
//                            boxShadow: [
//                              BoxShadow(
//                                  color: Colors.green,
//                                  offset: Offset(0.0, 2.0),
//                                  blurRadius: 9.0),
//                            ],
                              color: Colors.green.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 22, vertical: 22),
                          child: Text(
                            'Rs ${room.rent}',
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.red,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.red,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0)
                  ]),
              child: Stack(
                children: <Widget>[
                  Hero(
                    tag: room.imageUrl,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, RoomDetailScreen.routName,
                              arguments: room.id);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          child: Image.network(
                            room.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 8.0,
                    bottom: 9.0,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.place,
                              color: ThemeData().accentColor,
                              size: 22,
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    room.location,
                                    style: TextStyle(
                                        color:
                                            ThemeData().scaffoldBackgroundColor,
                                        fontSize: 22),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    room.district,
                                    style: TextStyle(
                                        color: Colors.limeAccent, fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 8.0,
                    bottom: 6.0,
                    child: Container(
                      child: Consumer<Room>(
                        builder: (cxt, room, _) {
                          return IconButton(
                            icon: room.isFavourite
                                ? Icon(
                                    Icons.favorite,
                                    size: 26,
                                    color: Colors.red,
                                  )
                                : Icon(
                                    Icons.favorite_border,
                                    size: 26,
                                    color: Colors.brown,
                                  ),
                            onPressed: () {
                              room.toggleIsFavourite(auth.userId, auth.token);
                            },
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
