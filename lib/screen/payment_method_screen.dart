import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentMethodScreen extends StatelessWidget {
  static const routName = 'payment_method_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Please Pick One'),
      ),
      body: Container(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Card(
              color: Colors.blueGrey.withOpacity(0.9),
              clipBehavior: Clip.hardEdge,
              margin: EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 25),
              child: ListTile(
                leading: Icon(
                  Icons.email,
                ),
                title: Text(
                  "E-Sewa",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
            ),
            Card(
              color: Colors.blueGrey.withOpacity(0.9),
              clipBehavior: Clip.hardEdge,
              margin: EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 25),
              child: ListTile(
                leading: Icon(
                  Icons.opacity,
                ),
                title: Text(
                  "Online-Banking",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
            ),
            Card(
              color: Colors.blueGrey.withOpacity(0.9),
              clipBehavior: Clip.hardEdge,
              margin: EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 25),
              child: ListTile(
                leading: Icon(
                  Icons.image,
                ),
                title: Text(
                  "Ime-Pay",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              height: 60,
            )
          ],
        ),
      ),
    );
  }
}
