import 'package:flutter/material.dart';
import 'package:projectakhir_praktpm/api_data_source.dart';
import 'package:projectakhir_praktpm/model/detail_model.dart';
import 'package:projectakhir_praktpm/pages/favorite.dart';

class PageDetailCharacter extends StatefulWidget {
  final int idCharacter;
  final String name;

  const PageDetailCharacter(
      {Key? key, required this.idCharacter, required this.name})
      : super(key: key);

  @override
  _PageDetailCharacterState createState() => _PageDetailCharacterState();
}

class _PageDetailCharacterState extends State<PageDetailCharacter> {
  bool isFavorite = false; // Track the favorite state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(widget.name),
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: _buildDetailUsersBody(),
    );
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      String message;

      if (isFavorite) {
        // Add the character to the favorite list
        FavoritePage.favoriteList.add(widget.name);
        message = '${widget.name} added to favorites';
      } else {
        // Remove the character from the favorite list
        FavoritePage.favoriteList.remove(widget.name);
        message = '${widget.name} removed from favorites';
      }

      // Show a SnackBar with the result
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

  Widget _buildDetailUsersBody() {
    return Container(
      child: FutureBuilder<DetailModel>(
        future: ApiDataSource.instance.loadDetailCharacter(widget.idCharacter),
        builder: (BuildContext context, AsyncSnapshot<DetailModel> snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection(snapshot.error.toString());
          }
          if (snapshot.hasData) {
            DetailModel character = snapshot.data!;
            return _buildSuccessSection(character);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection(String errorMessage) {
    return Center(
      child: Text("ERROR: $errorMessage"),
    );
  }

  Widget _buildLoadingSection() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(DetailModel character) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  height: 200,
                  width: 300,
                  child: Image.network(character.image!),
                ),
                const SizedBox(height: 30),
                Text(
                  character.name!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                Table(
                  defaultColumnWidth: FixedColumnWidth(90),
                  children: [
                    TableRow(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Status",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              ":",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              character.status!,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Species",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              ":",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              character.species!,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Gender",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              ":",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              character.gender!,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
