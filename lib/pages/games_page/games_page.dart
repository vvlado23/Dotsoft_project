import 'package:dotsoft/pages/games_page/my_photos_page.dart';
import 'package:dotsoft/pages/games_page/pick_up_page.dart';
import 'package:dotsoft/pages/games_page/quiz_page.dart';
import 'package:flutter/material.dart';

class GamesPage extends StatefulWidget {
  const GamesPage({super.key});

  @override
  State<GamesPage> createState() => _GamesPageState();
}

class _GamesPageState extends State<GamesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          gameButton(
            'Quiz',
            true,
            () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return QuizPage();
                },
              ));
            },
          ),
          gameButton(
            'My photos',
            false,
            () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return MyPhotosPage();
                },
              ));
            },
          ),
          gameButton(
            'Pick up trash',
            false,
            () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return PickUpPage();
                },
              ));
            },
          ),
        ],
      ),
    );
  }

  Widget gameButton(String title, bool isDone, Function onTap) {
    return GestureDetector(
      onTap: () {
        onTap.call();
      },
      child: Container(
        height: 112,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isDone ? Color(0xFFC3CC9B) : Color(0xFFE4DFB5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Text(title),
            const Spacer(),
            Icon(isDone ? Icons.check_circle_outline : Icons.circle_outlined),
          ],
        ),
      ),
    );
  }
}
