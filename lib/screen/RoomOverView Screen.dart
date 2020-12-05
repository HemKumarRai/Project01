import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project01_app/helperfunction/custom_appbar.dart';
import 'package:project01_app/modal/grid_view.dart';
import 'package:project01_app/provider/room_provider.dart';
import 'package:provider/provider.dart';

enum FilterOption { showFavourite, showAll }

class RoomOverViwScreen extends StatefulWidget {
  static const routName = 'room_overview_screen';

  @override
  _RoomOverViwScreenState createState() => _RoomOverViwScreenState();
}

class _RoomOverViwScreenState extends State<RoomOverViwScreen> {
  bool _isInit = true;

  bool _isLoading = false;
  bool _showFavourites = false;
  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<RoomProvider>(context)
          .fetchAndShowProducts()
          .catchError((e) {
        print(e.toString());
      }).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: PopupMenuButton(
          child: Icon(Icons.more_vert),
          onSelected: (FilterOption selectedItem) {
            setState(() {
              if (selectedItem == FilterOption.showFavourite) {
                _showFavourites = true;
              } else {
                _showFavourites = false;
              }
            });
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: FilterOption.showFavourite,
              child: Text("Show Favourites"),
            ),
            PopupMenuItem(
              value: FilterOption.showAll,
              child: Text("Show All"),
            )
          ],
        ),
      ),

//      AppBar(
//
//        leading: CircleAvatar(
//          backgroundColor: Colors.amber,
//          child: IconButton(
//            onPressed: () {
//              Navigator.push(context,
//                  MaterialPageRoute(builder: (context) => AppDrawer()));
//            },
//            icon: Icon(Icons.person),
//          ),
//        ),
//        title:
//            _showFavourites ? Text("Your Favourites") : Text("Available Rooms"),
//        centerTitle: true,
//        actions: <Widget>[
//          Stack(
//            children: <Widget>[
//              CircleAvatar(
//                child: IconButton(
//                  icon: Icon(
//                    Icons.notifications_active,
//                  ),
//                  onPressed: () {},
//                ),
//              ),
//              Positioned(
//                top: 2,
//                right: 3,
//                child: Text("1"),
//              ),
//            ],
//          ),
//          PopupMenuButton(
//            child: Icon(Icons.more_vert),
//            onSelected: (FilterOption selectedItem) {
//              setState(() {
//                if (selectedItem == FilterOption.showFavourite) {
//                  _showFavourites = true;
//                } else {
//                  _showFavourites = false;
//                }
//              });
//            },
//            itemBuilder: (context) => [
//              PopupMenuItem(
//                value: FilterOption.showFavourite,
//                child: Text("Show Favourites"),
//              ),
//              PopupMenuItem(
//                value: FilterOption.showAll,
//                child: Text("Show All"),
//              )
//            ],
//          )
//        ],
//      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : GridViewModal(_showFavourites),
      ),
    );
  }
}
