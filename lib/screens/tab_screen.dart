import 'package:flutter/material.dart';
import 'package:restaurant_api/screens/favorite_screen.dart';
import 'package:restaurant_api/screens/home_page_screen.dart';
import 'package:restaurant_api/screens/setting_page.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});
  static const routeName = '/tabScreen';

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  late List<Map<String, dynamic>> _pages;
  int _selectedIndex = 0;

  void selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {'page': HomePage(), 'title': "Home Page"},
      {'page': const FavoritePage(), 'title': "Favorite Page"},
      {'page': const SettingPage(), 'title': "Setting Page"}
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          onTap: selectedPage,
          currentIndex: _selectedIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home Page"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Favorite Page"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Setting Page")
          ]),
    );
  }
}
