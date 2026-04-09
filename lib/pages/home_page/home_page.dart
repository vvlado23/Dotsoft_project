import 'package:dotsoft/helpers/points_helper.dart';
import 'package:dotsoft/helpers/tasks_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {super.key, required this.onTapPlayGames, required this.onTapGoToLogs});

  final Function onTapGoToLogs;
  final Function onTapPlayGames;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 64),
            Container(
              height: 124,
              width: 124,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 6,
                    offset: Offset(4, 4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Guest',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                widget.onTapGoToLogs.call();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  profileItem(3.toString(), 'Streak'),
                  const SizedBox(width: 24),
                  profileItem(PointsHelper.instance.getTotalPoints().toString(),
                      'Points'),
                  const SizedBox(width: 24),
                  profileItem('${TasksHelper.instance.getActiveDailyCount()}/5',
                      'Today\'s Actions'),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  streakActive(),
                  streakActive(),
                  streakActive(),
                  streakDisabled(),
                  streakDisabled(),
                  streakDisabled(),
                  streakDisabled(),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xffeaeaea),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        offset: Offset(2, 2),
                      ),
                    ]),
                child: Column(
                  children: [
                    Text(
                      'Games Played ${PointsHelper.instance.getGamesPlayed()}',
                      style: TextStyle(fontSize: 24),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        widget.onTapPlayGames.call();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF9AB17A),
                        fixedSize: Size(140, 62),
                      ),
                      child: Text(
                        'Play Games',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Divider(),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Settings'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Logout',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
    /*return Text('My Point: ${TasksHelper().getMyPoints()}');*/
  }

  Widget streakDisabled() {
    return Container(
      height: 36,
      width: 36,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }

  Widget streakActive() {
    return Container(
      height: 36,
      width: 36,
      decoration: BoxDecoration(
        color: Color(0xFF9AB17A),
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }

  Widget profileItem(
    String value,
    String title,
  ) {
    return Container(
      height: 124,
      width: 100,
      decoration: BoxDecoration(
        color: Color(0xFFE4DFB5),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
            ),
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFF9AB17A),
            ),
          ),
        ],
      ),
    );
  }
}
