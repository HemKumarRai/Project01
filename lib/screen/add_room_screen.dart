import 'package:flutter/material.dart';
import 'package:project01_app/provider/room.dart';
import 'package:project01_app/provider/room_provider.dart';
import 'package:provider/provider.dart';

import 'RoomOverView Screen.dart';

class AddRoomScreen extends StatefulWidget {
  static const routName = 'add_room_screen';

  final String url;
  AddRoomScreen(this.url);

  @override
  _AddRoomScreenState createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  String imageUrl;

  TextEditingController imageUrlController = new TextEditingController();
  final formKey = GlobalKey<FormState>();

  var _newRoom = Room(
    id: null,
    imageUrl: '',
    location: '',
    phone: '',
    rent: 0,
    district: '',
    forWhom: '',
    description: '',
    feat1: '',
    feat2: '',
    feat3: '',
    feat4: '',
  );
  void saveForm() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      Provider.of<RoomProvider>(context, listen: false).addRoom(_newRoom);

      Navigator.pushNamed(context, RoomOverViwScreen.routName);
    }
  }

  @override
  void initState() {
    setState(() {
      if (widget.url.isNotEmpty) {
        imageUrl = widget.url;
      }
      return null;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Room"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          alignment: Alignment.bottomCenter,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black38,
                    child: imageUrl.isEmpty
                        ? Container(
                            child: Center(
                              child: Text('Enter An Url'),
                            ),
                          )
                        : FittedBox(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.network(imageUrl)),
                            fit: BoxFit.cover,
                          ),
                  ),
                  TextFormField(
                    enabled: imageUrl == null,
                    initialValue: imageUrl,
                    onSaved: (val) {
                      _newRoom = Room(
                        id: _newRoom.id,
                        imageUrl: val,
                        rent: _newRoom.rent,
                        location: _newRoom.location,
                        phone: _newRoom.phone,
                        district: _newRoom.district,
                        forWhom: _newRoom.forWhom,
                        description: _newRoom.description,
                        feat1: _newRoom.feat1,
                        feat2: _newRoom.feat2,
                        feat3: _newRoom.feat3,
                        feat4: _newRoom.feat4,
                      );
                    },
                    decoration: InputDecoration(
                      disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 0,
                      color: Colors.white,
                    ),
//                  decoration: InputDecoration(
//                    labelStyle: TextStyle(color: Colors.black87, fontSize: 14),
//                    labelText: 'imageUrl',
//                    focusedBorder: UnderlineInputBorder(
//                      borderSide: BorderSide(
//                        color: Colors.red,
//                      ),
//                    ),
//                    enabledBorder: UnderlineInputBorder(
//                      borderSide: BorderSide(
//                        color: Colors.green,
//                      ),
//                    ),
//                  ),
                  ),
                  TextFormField(
                    onSaved: (val) {
                      _newRoom = Room(
                        id: _newRoom.id,
                        imageUrl: _newRoom.imageUrl,
                        rent: _newRoom.rent,
                        location: _newRoom.location,
                        phone: _newRoom.phone,
                        district: _newRoom.district,
                        forWhom: _newRoom.forWhom,
                        description: val,
                        feat1: _newRoom.feat1,
                        feat2: _newRoom.feat2,
                        feat3: _newRoom.feat3,
                        feat4: _newRoom.feat4,
                      );
                    },
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      labelStyle:
                          TextStyle(color: Colors.black87, fontSize: 14),
                      labelText: 'Description',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          onSaved: (val) {
                            _newRoom = Room(
                              id: _newRoom.id,
                              imageUrl: _newRoom.imageUrl,
                              rent: _newRoom.rent,
                              phone: _newRoom.phone,
                              location: val,
                              district: _newRoom.district,
                              forWhom: _newRoom.forWhom,
                              description: _newRoom.description,
                              feat1: _newRoom.feat1,
                              feat2: _newRoom.feat2,
                              feat3: _newRoom.feat3,
                              feat4: _newRoom.feat4,
                            );
                          },
                          keyboardType: TextInputType.multiline,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            labelStyle:
                                TextStyle(color: Colors.black87, fontSize: 14),
                            labelText: 'Location',
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: TextFormField(
                          onSaved: (val) {
                            _newRoom = Room(
                              id: _newRoom.id,
                              imageUrl: _newRoom.imageUrl,
                              rent: _newRoom.rent,
                              phone: _newRoom.phone,
                              location: _newRoom.location,
                              district: val,
                              forWhom: _newRoom.forWhom,
                              description: _newRoom.description,
                              feat1: _newRoom.feat1,
                              feat2: _newRoom.feat2,
                              feat3: _newRoom.feat3,
                              feat4: _newRoom.feat4,
                            );
                          },
                          keyboardType: TextInputType.multiline,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            labelStyle:
                                TextStyle(color: Colors.black87, fontSize: 14),
                            labelText: 'District',
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          onSaved: (val) {
                            _newRoom = Room(
                              id: _newRoom.id,
                              imageUrl: _newRoom.imageUrl,
                              rent: _newRoom.rent,
                              location: _newRoom.location,
                              phone: _newRoom.phone,
                              district: _newRoom.district,
                              forWhom: val,
                              description: _newRoom.description,
                              feat1: _newRoom.feat1,
                              feat2: _newRoom.feat2,
                              feat3: _newRoom.feat3,
                              feat4: _newRoom.feat4,
                            );
                          },
                          keyboardType: TextInputType.multiline,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            labelStyle:
                                TextStyle(color: Colors.black87, fontSize: 14),
                            labelText: 'Only For',
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 13,
                      ),
                      Expanded(
                        child: TextFormField(
                          onSaved: (val) {
                            _newRoom = Room(
                              id: _newRoom.id,
                              imageUrl: _newRoom.imageUrl,
                              rent: double.parse(val),
                              phone: _newRoom.phone,
                              location: _newRoom.location,
                              district: _newRoom.district,
                              forWhom: _newRoom.forWhom,
                              description: _newRoom.description,
                              feat1: _newRoom.feat1,
                              feat2: _newRoom.feat2,
                              feat3: _newRoom.feat3,
                              feat4: _newRoom.feat4,
                            );
                          },
                          keyboardType: TextInputType.multiline,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            labelStyle:
                                TextStyle(color: Colors.black87, fontSize: 14),
                            labelText: 'Rent (Rs)',
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    onSaved: (val) {
                      _newRoom = Room(
                        id: _newRoom.id,
                        imageUrl: _newRoom.imageUrl,
                        rent: _newRoom.rent,
                        phone: val,
                        location: _newRoom.location,
                        district: _newRoom.district,
                        forWhom: _newRoom.forWhom,
                        description: _newRoom.description,
                        feat1: _newRoom.feat1,
                        feat2: _newRoom.feat2,
                        feat3: _newRoom.feat3,
                        feat4: _newRoom.feat4,
                      );
                    },
                    keyboardType: TextInputType.phone,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      labelStyle:
                          TextStyle(color: Colors.black87, fontSize: 14),
                      labelText: 'Contact Number',
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 24, bottom: 12),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Room Features',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          onSaved: (val) {
                            _newRoom = Room(
                              id: _newRoom.id,
                              imageUrl: _newRoom.imageUrl,
                              rent: _newRoom.rent,
                              phone: _newRoom.phone,
                              location: _newRoom.location,
                              district: _newRoom.district,
                              forWhom: _newRoom.forWhom,
                              description: _newRoom.description,
                              feat1: val.toString(),
                              feat2: _newRoom.feat2,
                              feat3: _newRoom.feat3,
                              feat4: _newRoom.feat4,
                            );
                          },
                          keyboardType: TextInputType.multiline,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            labelStyle:
                                TextStyle(color: Colors.black87, fontSize: 14),
                            labelText: '1*',
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 13,
                      ),
                      Expanded(
                        child: TextFormField(
                          onSaved: (val) {
                            _newRoom = Room(
                              id: _newRoom.id,
                              imageUrl: _newRoom.imageUrl,
                              rent: _newRoom.rent,
                              phone: _newRoom.phone,
                              location: _newRoom.location,
                              district: _newRoom.district,
                              forWhom: _newRoom.forWhom,
                              description: _newRoom.description,
                              feat1: _newRoom.feat1,
                              feat2: val.toString(),
                              feat3: _newRoom.feat3,
                              feat4: _newRoom.feat4,
                            );
                          },
                          keyboardType: TextInputType.multiline,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            labelStyle:
                                TextStyle(color: Colors.black87, fontSize: 14),
                            labelText: '2*',
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          onSaved: (val) {
                            _newRoom = Room(
                              id: _newRoom.id,
                              imageUrl: _newRoom.imageUrl,
                              rent: _newRoom.rent,
                              phone: _newRoom.phone,
                              location: _newRoom.location,
                              district: _newRoom.district,
                              forWhom: _newRoom.forWhom,
                              description: _newRoom.description,
                              feat1: _newRoom.feat1,
                              feat2: _newRoom.feat2,
                              feat3: val.toString(),
                              feat4: _newRoom.feat4,
                            );
                          },
                          keyboardType: TextInputType.multiline,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            labelStyle:
                                TextStyle(color: Colors.black87, fontSize: 14),
                            labelText: '3',
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 13,
                      ),
                      Expanded(
                        child: TextFormField(
                          onSaved: (val) {
                            _newRoom = Room(
                              id: _newRoom.id,
                              imageUrl: _newRoom.imageUrl,
                              rent: _newRoom.rent,
                              phone: _newRoom.phone,
                              location: _newRoom.location,
                              district: _newRoom.district,
                              forWhom: _newRoom.forWhom,
                              description: _newRoom.description,
                              feat1: _newRoom.feat1,
                              feat2: _newRoom.feat2,
                              feat3: _newRoom.feat3,
                              feat4: val.toString(),
                            );
                          },
                          keyboardType: TextInputType.multiline,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            labelStyle:
                                TextStyle(color: Colors.black87, fontSize: 14),
                            labelText: '4',
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      saveForm();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 18),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(colors: [
                              Colors.green,
                              Colors.greenAccent,
                              Colors.black38,
                              Colors.white,
                            ])),
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Text(
                          'Add Room',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
