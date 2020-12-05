import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project01_app/helperfunction/authentication.dart';
import 'package:project01_app/modal/imageurl_picker.dart';
import 'package:project01_app/screen/RoomOverView%20Screen.dart';
import 'package:project01_app/screen/booked_room_screen.dart';
import 'package:project01_app/screen/manage_screen_room.dart';
import 'package:project01_app/screen/sign_up_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool isInit = true;
  String email = '';
  String userType = '';

  getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final extractedData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    print(extractedData);
    setState(() {
      email = extractedData['email'];
      userType = extractedData['userType'];
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (isInit) {
      getUserData();
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: Text(userType == 'admin' ? "Admin" : "Client"),
              accountEmail: Text(email),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/ktm.jpg'),
              )),
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, RoomOverViwScreen.routName);
            },
            leading: Icon(Icons.home),
            title: Text("Home"),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImagePickerFromMobile()));
            },
            leading: Icon(Icons.add),
            title: Text("Add Room"),
          ),
          userType == 'admin'
              ? ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, RoomManageScreen.routName);
                  },
                  leading: Icon(Icons.settings),
                  title: Text("Manage Room"),
                )
              : Container(),
          userType == 'admin'
              ? ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, BookedRoomScreen.routName);
                  },
                  leading: Icon(
                    Icons.collections_bookmark,
                  ),
                  title: Text('Booked Room'),
                )
              : Container(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Log Out"),
            onTap: () async {
              Navigator.of(context).pop();
              await Provider.of<Authentication>(context, listen: false)
                  .logOut();
              Navigator.of(context).pushReplacementNamed(SignUpScreen.routName);
            },
          )
        ],
      ),
    );
  }
}
