import 'package:flutter/material.dart';
import 'package:project01_app/provider/room.dart';
import 'package:project01_app/provider/room_provider.dart';
import 'package:project01_app/screen/RoomOverView%20Screen.dart';
import 'package:provider/provider.dart';

class EditRoomScreen extends StatefulWidget {
  static const String routeName = 'room_edit_screen';
  @override
  _EditRoomScreenState createState() => _EditRoomScreenState();
}

class _EditRoomScreenState extends State<EditRoomScreen> {
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
  var initValues = {
    'imageUrl': '',
    'location': '',
    'phone': '',
    'rent': '',
    'district': '',
    'forWhom': '',
    'description': '',
    'feat1': '',
    'feat2': '',
    'feat3': '',
    'feat4': '',
  };
  bool isInit = true;

  void saveForm() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      if (_newRoom.id != null) {
        Provider.of<RoomProvider>(context, listen: false)
            .updateProduct(_newRoom.id, _newRoom);
      } else
        Provider.of<RoomProvider>(context, listen: false).addRoom(_newRoom);

      Navigator.pushNamed(context, RoomOverViwScreen.routName);
    }
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      final roomId = ModalRoute.of(context).settings.arguments.toString();
      if (roomId != null) {
        _newRoom = Provider.of<RoomProvider>(context).findById(roomId);
        initValues = {
          'imageUrl': '',
          'location': _newRoom.location,
          'phone': _newRoom.phone,
          'rent': _newRoom.rent.toString(),
          'district': _newRoom.district,
          'forWhom': _newRoom.forWhom,
          'description': _newRoom.description,
          'feat1': _newRoom.feat1,
          'feat2': _newRoom.feat2,
          'feat3': _newRoom.feat3,
          'feat4': _newRoom.feat4,
        };

        imageUrlController.text = _newRoom.imageUrl;
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_newRoom.id != null ? "Edit Room" : "Add Room"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 200,
                  width: 200,
                  color: Colors.black38,
                  child: imageUrlController.text.isEmpty
                      ? Container(
                          child: Center(
                            child: Text('Enter An Url'),
                          ),
                        )
                      : FittedBox(
                          child: Image.network(imageUrlController.text),
                          fit: BoxFit.cover,
                        ),
                ),
                TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'The ImageUrl mustnot be empty!!';
                    }
                    if (!val.startsWith('http') && !val.startsWith('https')) {
                      return 'The ImageUrl is not valid';
                    }
                    return null;
                  },
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
                  controller: imageUrlController,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black87, fontSize: 14),
                    labelText: 'imageUrl',
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
                TextFormField(
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Description must not be empty';
                    }
                    if (val.length < 10) {
                      return 'Description contain atleast 10 words';
                    }
                    return null;
                  },
                  initialValue: initValues['description'],
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
                    labelStyle: TextStyle(color: Colors.black87, fontSize: 14),
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
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'lacation must not be empty and not wrong address';
                          }
                          return null;
                        },
                        initialValue: initValues['location'],
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
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'District Name must not be empty and not  wrong name';
                          }
                          return null;
                        },
                        initialValue: initValues['district'],
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
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'You have to specify your targeted people';
                          }
                          return null;
                        },
                        initialValue: initValues['forWhom'],
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
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'Rent section mustnot be empty';
                          }
                          if (double.parse(val) <= 0) {
                            return 'The rent price should not be less then zero';
                          }
                          if (double.parse(val) == null) {
                            return 'Rent Mus be in Number';
                          }
                          return null;
                        },
                        initialValue: initValues['rent'],
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
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'Phone must not be empty and should not be wrong contact';
                    }
                    if (double.parse(val) == null) {
                      return 'Phone number must be numeric';
                    }

                    return null;
                  },
                  initialValue: initValues['phone'],
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
                    labelStyle: TextStyle(color: Colors.black87, fontSize: 14),
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'You must have fill 4 features of your room';
                          }
                          return null;
                        },
                        initialValue: initValues['feat1'],
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
                            feat1: val,
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
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'You must have fill 4 features of your room';
                          }
                          return null;
                        },
                        initialValue: initValues['feat2'],
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
                            feat2: val,
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
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'You must have fill 4 features of your room';
                          }
                          return null;
                        },
                        initialValue: initValues['feat3'],
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
                            feat3: val,
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
                        validator: (val) {
                          if (val.isEmpty) {
                            return 'You must have fill 4 features of your room';
                          }
                          return null;
                        },
                        initialValue: initValues['feat4'],
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
                            feat4: val,
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
    );
  }
}
