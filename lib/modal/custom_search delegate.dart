import 'package:flutter/material.dart';
import 'package:project01_app/modal/search_item.dart';
import 'package:project01_app/provider/room_provider.dart';
import 'package:provider/provider.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Text('Search Room '),
        )
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final searchItem = Provider.of<RoomProvider>(context).getSearchItem(query);
    return ListView.builder(
      itemBuilder: (ctx, index) => SearchItem(
        rent: searchItem[index].rent.toString(),
        imageUrl: searchItem[index].imageUrl,
        placeName: searchItem[index].location,
        id: searchItem[index].id,
      ),
      itemCount: searchItem.length,
    );
  }
}
