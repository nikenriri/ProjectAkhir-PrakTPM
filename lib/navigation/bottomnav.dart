import 'package:flutter/material.dart';
import 'package:projectakhir_praktpm/pages/home.dart';
import 'package:projectakhir_praktpm/pages/profile.dart';
import 'package:projectakhir_praktpm/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  PageController pageController = PageController();
  List<Widget> pages = [const HomePage(), const ProfilePage(), const LoginPage()];

  int selectedIndex = 0;
  void onPageChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void onItemTapped(int selectedItems) {
    if (selectedItems == 2) {
      _logout();
    } else {
      pageController.jumpToPage(selectedItems);
    }
  }

  Future<void> _logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: pages,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: onItemTapped,
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_rounded,
                color: selectedIndex == 0 ? Colors.teal : Colors.grey,
              ),
              label: "Home"
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: selectedIndex == 1 ? Colors.teal : Colors.grey,
              ),
              label: "Profile"
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.logout_rounded,
              color: selectedIndex == 2 ? Colors.teal : Colors.grey,
            ),
            label: "Log out",
          ),
        ],
      ),
    );
  }
}
