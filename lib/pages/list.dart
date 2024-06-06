import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectakhir_praktpm/api_data_source.dart';
import 'package:projectakhir_praktpm/model/list_model.dart';
import 'package:projectakhir_praktpm/pages/detail.dart';

class PageListCharacter extends StatefulWidget {
  const PageListCharacter({Key? key}) : super(key: key);

  @override
  State<PageListCharacter> createState() => _PageListCharacterState();
}

class _PageListCharacterState extends State<PageListCharacter> {
  List<Results>? _allCharacters;
  List<Results>? _filteredCharacters;
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: _isSearching ? _buildSearchField() : const Text("Rick n Morty's Character"),
        actions: _buildAppBarActions(),
      ),
      body: _buildListUsersBody(),
    );
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            setState(() {
              _isSearching = false;
              _filteredCharacters = _allCharacters;
            });
          },
        ),
      ];
    } else {
      return [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            setState(() {
              _isSearching = true;
            });
          },
        ),
      ];
    }
  }

  Widget _buildSearchField() {
    return TextField(
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Enter name character...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white60),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) {
        setState(() {
          _filteredCharacters = _allCharacters!.where((character) {
            return character.name!.toLowerCase().contains(query.toLowerCase());
          }).toList();
        });
      },
    );
  }

  Widget _buildListUsersBody() {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadCharacter(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            RickMortyModel usersModel = RickMortyModel.fromJson(snapshot.data);
            _allCharacters = usersModel.results;
            _filteredCharacters ??= _allCharacters;
            return _buildSuccessSection(_filteredCharacters!);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return const Center(child: Text("ERROR"));
  }

  Widget _buildLoadingSection() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(List<Results> data) {
    if (data.isEmpty) {
      return const Center(child: Text("No characters found."));
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5, // Number of columns
        crossAxisSpacing: 30.0, // Horizontal space between grid items
        mainAxisSpacing: 30.0, // Vertical space between grid items
        childAspectRatio: 0.7, // Aspect ratio of each grid item
      ),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return _buildItemUsers(data[index]);
      },
    );
  }

  Widget _buildItemUsers(Results characterData) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PageDetailCharacter(
            idCharacter: characterData.id!,
            name: characterData.name!,
          ),
        ),
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
              child: Image.network(
                characterData.image!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  characterData.name!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
