import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:project01_app/modal/custom_search%20delegate.dart';
import 'package:project01_app/modal/drawer.dart';
import 'package:project01_app/provider/room_provider.dart';
import 'package:provider/provider.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double _preferredHeight = 250.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(60), bottomLeft: Radius.circular(60)),
        color: Colors.blueGrey,
      ),
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
//          SizedBox(
//            height: 25,
//          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: Icon(
                      Icons.person,
                      size: 26,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AppDrawer()));
                    },
                  ),
                ),
                Text(
                  "Find Room With Us",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Stack(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.notifications_active,
                        size: 26,
                        color: Colors.brown,
                      ),
                      onPressed: () {},
                    ),
                    Positioned(
                      right: 3,
                      top: 1,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.white,
                        child: Text(
                          '${Provider.of<RoomProvider>(context, listen: false).notification}',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 100,
            child: Carousel(
              boxFit: BoxFit.cover,
              autoplay: true,
              animationCurve: Curves.fastOutSlowIn,
              animationDuration: Duration(milliseconds: 1000),
              dotSize: 6.0,
              dotIncreasedColor: Color(0xFFFF335C),
              dotBgColor: Colors.transparent,
              dotPosition: DotPosition.topRight,
              dotVerticalPadding: 10.0,
              showIndicator: true,
              indicatorBgPadding: 7.0,
              images: [
                Image.asset(
                  'assets/images/ktm.jpg',
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  'assets/images/pokhara.jpg',
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  'assets/images/chitawan.jpg',
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 6, left: 6, top: 8),
            child: Container(
              width: MediaQuery.of(context).size.width - 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(colors: [
                    Colors.white70,
                    Colors.white,
                    Colors.lightGreen,
                    Colors.black12
                  ])),
              child: GestureDetector(
                onTap: () {
                  showSearch(
                      context: context, delegate: CustomSearchDelegate());
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Container(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Search ',
                            style: TextStyle(
                                letterSpacing: 4,
                                decoration: TextDecoration.underline,
                                fontSize: 16),
                          ),
                          CircleAvatar(
                            child: Center(
                              child: IconButton(
                                icon: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      )
//                        child: TextFormField(
//                          style: TextStyle(color: Colors.redAccent),
//                          decoration: InputDecoration(
//                              enabledBorder: UnderlineInputBorder(
//                                borderSide: BorderSide.none,
//                              ),
//                              focusedBorder: UnderlineInputBorder(
//                                borderSide: BorderSide.none,
//                              ),
//                              hintText: 'Search Room',
//                              hintStyle: TextStyle(
//                                color: Colors.redAccent,
//                                fontSize: 16,
//                              )),
//                        ),
                      ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(_preferredHeight);
}
