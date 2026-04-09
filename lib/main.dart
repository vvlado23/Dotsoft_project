import 'package:dotsoft/pages/games_page/games_page.dart';
import 'package:dotsoft/pages/home_page/home_page.dart';
import 'package:dotsoft/pages/leaderboard_page/leaderboard_page.dart';
import 'package:dotsoft/pages/start_page/start_page.dart';
import 'package:dotsoft/pages/tasks_page/tasks_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasks',
      theme: ThemeData(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, Widget> _widgetOptions = {};

  @override
  void initState() {
    super.initState();

    _widgetOptions = <String, Widget>{
      "Home": HomePage(
        onTapGoToLogs: () {
          _onItemTapped(1);
        },
        onTapPlayGames: () {
          _onItemTapped(2);
        },
      ),
      "My Tasks": TasksPage(),
      "Games": GamesPage(),
      "Leaderboard": LeaderboardPage(),
    };
  }

  bool _inStartScreen = true;

  int _selectedIndex = 0;

  void goToHomeScreen() {
    setState(() {
      _inStartScreen = false;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _inStartScreen
        ? StartPage(
            onTapStart: () {
              goToHomeScreen();
            },
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF9AB17A),
              title: Text(_widgetOptions.keys.toList()[_selectedIndex]),
            ),
            body: _widgetOptions.values.toList()[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.portrait),
                  label: "Home",
                  backgroundColor: Color(0xFF9AB17A),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_box_outlined),
                  label: "My Tasks",
                  backgroundColor: Color(0xFF9AB17A),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.insert_emoticon),
                  label: "Games",
                  backgroundColor: Color(0xFF9AB17A),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.leaderboard),
                  label: "Leaderboard",
                  backgroundColor: Color(0xFF9AB17A),
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              selectedItemColor: Colors.white,
              backgroundColor: Color(0xFF9AB17A),
            ),
          );
  }
}
