import 'package:flutter/material.dart';
import 'package:project01_app/modal/booked_room_item.dart';
import 'package:project01_app/provider/bookedroomprovider.dart';
import 'package:project01_app/screen/payment_method_screen.dart';
import 'package:provider/provider.dart';

class BookedRoomScreen extends StatelessWidget {
  static const routName = 'booked_room_screen';
  @override
  Widget build(BuildContext context) {
    final bookRoom = Provider.of<BookedRoomProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Booked Room'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Total",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Spacer(),
                  Chip(
                    label: Text(
//                      '500',
                      bookRoom.totalAmount.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  OrderButton(
                    bookedRoom: bookRoom,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: bookRoom.room.length,
                itemBuilder: (context, index) => ChangeNotifierProvider.value(
                      value: bookRoom.room[index],
                      child: BookedRoomItem(),
                    )),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  final bookedRoom;
  OrderButton({this.bookedRoom});
  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : FlatButton(
            child: Text(
              "ORDER NOW",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onPressed: () async {
              setState(() {
                _isLoading = true;
              });
              widget.bookedRoom.totalAmount > 0
                  ? Navigator.pushNamed(context, PaymentMethodScreen.routName)
                  : Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                          'You havenot booked any room yet,Please choose atleast one first '),
                    ));

//              widget.bookedRoom.clearBookedRoom();
              setState(() {
                _isLoading = false;
              });
            },
          );
  }
}
