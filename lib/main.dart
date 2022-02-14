import 'package:flashy_tab_bar/flashy_nav_bar.dart';
import 'package:flashy_tab_bar/models/flashy_tab_item.dart';
import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Flashy Nav Bar"),
            centerTitle: true,
          ),
          bottomNavigationBar: FlashyBar(
            height: 70,
            selectedIndex: _selectedIndex,
            onItemSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            items: [
              FlashyTabBarItem(
                title: const Text("Events"),
                icon: const Icon(Icons.event),
              ),
              FlashyTabBarItem(
                title: const Text("Search"),
                icon: const Icon(Icons.search),
              ),
              FlashyTabBarItem(
                title: const Text("Flash"),
                icon: const Icon(Icons.flash_on),
              ),
              FlashyTabBarItem(
                title: const Text("Settings"),
                icon: const Icon(Icons.settings),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
