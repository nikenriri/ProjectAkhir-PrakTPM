import 'package:flutter/material.dart';
import 'package:projectakhir_praktpm/pages/currency.dart';
import 'package:projectakhir_praktpm/pages/favorite.dart';
import 'package:projectakhir_praktpm/pages/list.dart';
import 'package:projectakhir_praktpm/pages/login.dart';
import 'package:projectakhir_praktpm/pages/profile.dart';
import 'package:projectakhir_praktpm/pages/time.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController();
  List<Widget> pages = [const HomePage(), const ProfilePage()];

  int selectedIndex = 0;
  void onPageChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void onItemTapped(int selectedItems) {
    pageController.jumpToPage(selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              minWidth: 200,
              height: 42,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PageListCharacter(),
                  ),
                );
              },
              color: Colors.teal,
              child: const Text(
                'Rick n Morty',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            MaterialButton(
              minWidth: 200,
              height: 42,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoritePage(),
                  ),
                );
              },
              color: Colors.teal,
              child: const Text(
                'Favorite Character',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            MaterialButton(
              minWidth: 200,
              height: 42,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CurrencyPage(),
                  ),
                );
              },
              color: Colors.teal,
              child: const Text(
                'Currency Conversion',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            MaterialButton(
              minWidth: 200,
              height: 42,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TimePage(),
                  ),
                );
              },
              color: Colors.teal,
              child: const Text(
                'Time Conversion',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15),
            ),
          ],
        ),
      ),
    );
  }
}
