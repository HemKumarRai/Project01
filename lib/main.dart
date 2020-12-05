import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:project01_app/helperfunction/authentication.dart';
import 'package:project01_app/helperfunction/custom_route_transition.dart';
import 'package:project01_app/provider/bookedroomprovider.dart';
import 'package:project01_app/provider/room_provider.dart';
import 'package:project01_app/screen/RoomOverView%20Screen.dart';
import 'package:project01_app/screen/booked_room_screen.dart';
import 'package:project01_app/screen/manage_screen_room.dart';
import 'package:project01_app/screen/payment_method_screen.dart';
import 'package:project01_app/screen/room_details_screen.dart';
import 'package:project01_app/screen/room_edit_screen.dart';

import 'package:project01_app/screen/sign_in_screen.dart';
import 'package:project01_app/screen/sign_up_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(SplashClass());

class SplashClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Authentication()),
        ChangeNotifierProxyProvider<Authentication, RoomProvider>(
          update: (_, Authentication auth, RoomProvider room) {
            return RoomProvider(
                auth.token, room == null ? [] : room.items, auth.userId);
          },
        ),
        ChangeNotifierProxyProvider<Authentication, BookedRoomProvider>(
          update: (_, Authentication auth, BookedRoomProvider bookRoom) {
            return BookedRoomProvider(
                auth.token, bookRoom == null ? [] : bookRoom.room, auth.userId);
          },
        ),
      ],
      child: MaterialApp(
        title: "Find The Room From Us",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
//            Color(0xFF8E87B2)
            primaryColor: Color(0xFF5E5B5F),
            accentColor: Color(0xFF130B46),
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android: CustomPageTransitionBuilder(),
              TargetPlatform.iOS: CustomPageTransitionBuilder(),
            })),
        home: SplashBetween(),
        routes: {
          RoomDetailScreen.routName: (context) => RoomDetailScreen(),
          RoomOverViwScreen.routName: (context) => RoomOverViwScreen(),
          RoomManageScreen.routName: (context) => RoomManageScreen(),
          SignInScreen.routName: (context) => SignInScreen(),
          SignUpScreen.routName: (context) => SignUpScreen(),
          EditRoomScreen.routeName: (context) => EditRoomScreen(),
          BookedRoomScreen.routName: (context) => BookedRoomScreen(),
          PaymentMethodScreen.routName: (context) => PaymentMethodScreen(),
        },
      ),
    );
  }
}

class SplashBetween extends StatefulWidget {
  @override
  _SplashBetweenState createState() => _SplashBetweenState();
}

class _SplashBetweenState extends State<SplashBetween> {
  bool isLoggedIn;
  bool isInit = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (isInit) {
      checkLoggedIn();
    }
    isInit = false;
    super.didChangeDependencies();
  }

  void checkLoggedIn() async {
    isLoggedIn = await Provider.of<Authentication>(context).tryAutoLogIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreen.navigate(
        name: 'assets/images/spl.flr',
        backgroundColor: Colors.grey,
        startAnimation: 'Untitled',
        loopAnimation: 'Untitled',
        until: () => Future.delayed(Duration(seconds: 3)),
        next: (_) => isLoggedIn ? RoomOverViwScreen() : SignInScreen(),
      ),
    );
  }
}
