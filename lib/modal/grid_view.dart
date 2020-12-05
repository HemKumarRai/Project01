import 'package:flutter/material.dart';
import 'package:project01_app/modal/room_item.dart';
import 'package:project01_app/provider/room_provider.dart';
import 'package:provider/provider.dart';

class GridViewModal extends StatelessWidget {
  final bool isFavourite;
  GridViewModal(this.isFavourite);
  @override
  Widget build(BuildContext context) {
    final room = isFavourite
        ? Provider.of<RoomProvider>(context).favourites
        : Provider.of<RoomProvider>(context).items;
    return GridView.builder(
        itemCount: room.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 20,
          crossAxisSpacing: 80,
          childAspectRatio: 4 / 5,
        ),
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
            value: room[index],
            child: room.isNotEmpty ? RoomItemModal() : Container()));
  }
}
