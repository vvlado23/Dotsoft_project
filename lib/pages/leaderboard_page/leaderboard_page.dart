import 'package:flutter/material.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 24),
          firstPlace(),
          const SizedBox(height: 12),
          mainLeaderboard(),
          const SizedBox(height: 36),
          myPlace(),
        ],
      ),
    );
  }

  Widget firstPlace() {
    return Column(
      children: [
        Icon(
          Icons.star,
          color: Colors.deepOrangeAccent,
          size: 36,
        ),
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        Text(
          "1 Name Name",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget mainLeaderboard() {
    Map<int, String> leaderboard = {
      2: 'Name Name2',
      3: 'Bob',
      4: 'Anna',
      5: 'John',
      6: 'Angela',
      7: 'Gorge',
      8: 'Chris',
      9: 'Dimitris',
      10: 'Vasilis',
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Column(
        children: leaderboard.entries
            .map((entry) => userRow(entry.key, entry.value))
            .toList(),
      ),
    );
  }

  Widget userRow(int place, String name) {
    bool isOdd = place % 2 == 1;
    TextStyle textStyle = TextStyle(
      fontWeight:
          (place == 2 || place == 3) ? FontWeight.bold : FontWeight.normal,
      fontSize: (place == 2 || place == 3) ? 16 : 14,
    );
    return Container(
      color: isOdd ? Color(0xFFFBE8CE) : Colors.transparent,
      child: Row(
        children: [
          SizedBox(
            width: 16,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                place.toString(),
                style: textStyle,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Container(
            height: 24,
            width: 24,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          const SizedBox(width: 4),
          Text(
            name,
            style: textStyle,
          ),
        ],
      ),
    );
  }

  Widget myPlace() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36),
      child: Container(
        color: Colors.grey,
        child: userRow(45, 'my account name'),
      ),
    );
  }
}
