import 'package:flutter/material.dart';
import 'package:project01_app/provider/bookedroomprovider.dart';
import 'package:project01_app/provider/room_provider.dart';
import 'package:provider/provider.dart';

class RoomDetailScreen extends StatefulWidget {
  static const routName = 'room_detail_screen';

  @override
  _RoomDetailScreenState createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  Stream commentStream;
  bool isRoomBooked = false;
  bool isBooked = false;
  void isToggledRoomBooked(String id) {
    isBooked = !isBooked;
  }

  Widget commentList() {
    return StreamBuilder(
      stream: commentStream,
      builder: (context, snapshot) => CommentTile(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;
    final roomProvider = Provider.of<RoomProvider>(context).findById(id);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            roomProvider.location,
            style: TextStyle(
              letterSpacing: 2,
              fontSize: 26,
              color: Colors.white70,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: MediaQuery.of(context).size.width / 1.2,
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(
                          roomProvider.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      )),
                ],
//                child:
              ),
              Container(
                child: Text(
                  roomProvider.description,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(color: Colors.brown),
                    child: Text(
                      'If You Like This Room ?',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration:
                        BoxDecoration(color: Colors.brown.withOpacity(0.8)),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: Text(
                                      "Are You Sure To Book Room At ${roomProvider.location}?"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("No"),
                                      onPressed: () {
                                        Provider.of<BookedRoomProvider>(context,
                                                listen: false)
                                            .cancelBookedRoom(id);
                                        Navigator.pop(context);
                                      },
                                    ),
                                    FlatButton(
                                      child: Text('Yes'),
                                      onPressed: () {
                                        Provider.of<BookedRoomProvider>(context,
                                                listen: false)
                                            .bookedRoom(
                                                id,
                                                roomProvider.location,
                                                roomProvider.rent);
                                        Navigator.of(context).pop();
//                                        Scaffold.of(context)
//                                            .showSnackBar(SnackBar(
//                                          content: Text(
//                                              "You booked room at ${roomProvider.location} successfully.."),
//                                          duration: Duration(seconds: 3),
//                                        ));
                                      },
                                    )
                                  ],
                                ));
//                      Scaffold.of(context).removeCurrentSnackBar();
//                      Scaffold.of(context, nullOk: true).showSnackBar(SnackBar(
//                        content: Text('Booked SuccessFully'),
//                        duration: Duration(seconds: 3),
//                        action: SnackBarAction(
//                          label: 'Undo',
//                          textColor: Colors.black,
//                          onPressed: () {},
//                        ),
//                      ));
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          child: Text(
                            'Book Now',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white70,
                                decoration: TextDecoration.underline),
                          )),
                    ),
                  ),
//                Consumer<Room>(
//                  builder: (context, room, child) => IconButton(
//                    icon: room.isBooked
//                        ? Icon(
//                            Icons.bookmark,
//                            size: 18,
//                          )
//                        : Icon(
//                            Icons.bookmark_border,
//                          ),
//                    onPressed: () {
//                      room.toggleIsBooked(id);
//                    },
//                  ),
//                )
                ],
              ),
              isBooked
                  ? Container(
                      color: Colors.blue,
                      child: Text(
                        "This roomProvider is already booked",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          wordSpacing: 1.5,
                        ),
                      ),
                    )
                  : Container(child: Text('')),
            ],
          ),
        ),
      ),
    );
  }
}

class CommentTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column();
  }
}
