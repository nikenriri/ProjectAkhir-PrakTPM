import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
  static List<String> favoriteList = []; // List to store favorite data

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Favorite Characters'),
      ),
      body: ListView.builder(
        itemCount: FavoritePage.favoriteList.length,
        itemBuilder: (context, index) {
          final name = FavoritePage.favoriteList[index];
          return Card(
            child: ListTile(
              title: Text(name),
              trailing: IconButton(
                icon: Icon(Icons.favorite, color: Colors.red),
                onPressed: () {
                  setState(() {
                    FavoritePage.favoriteList.removeAt(index);
                    _showRemovalNotification(context, name);
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void _showRemovalNotification(BuildContext context, String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$name removed from favorite character'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
