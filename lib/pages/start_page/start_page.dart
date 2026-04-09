import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key, required this.onTapStart});

  final Function onTapStart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "EcoSaver",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 38),
              ),
              const SizedBox(height: 64),
              ElevatedButton(
                  onPressed: () {
                    onTapStart.call();
                  },
                  child: Text('Start!')),
            ],
          ),
        ),
      ),
    );
  }
}
