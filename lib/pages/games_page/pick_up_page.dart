import 'dart:async';

import 'package:dotsoft/helpers/points_helper.dart';
import 'package:flutter/material.dart';

class PickUpPage extends StatefulWidget {
  const PickUpPage({super.key});

  @override
  State<PickUpPage> createState() => _PickUpPageState();
}

class _PickUpPageState extends State<PickUpPage> {
  List<CardData> cards = [
    CardData(
      cardId: 0,
      name: 'Plastic Bottle',
      description:
          'Decomposition time: ~450 years. \nBreaks into microplastics that contaminate water and enter the food chain.',
    ),
    CardData(
      cardId: 0,
      name: 'Plastic Bottle',
      description:
          'Decomposition time: ~450 years. \nBreaks into microplastics that contaminate water and enter the food chain.',
    ),
    CardData(
      cardId: 1,
      name: 'Light Bulb',
      description:
          'Turn off lights when leaving a room. \nSaves electricity and reduces CO₂ emissions from power plants.',
    ),
    CardData(
      cardId: 1,
      name: 'Light Bulb',
      description:
          'Turn off lights when leaving a room. \nSaves electricity and reduces CO₂ emissions from power plants.',
    ),
    CardData(
      cardId: 2,
      name: 'Bicycle',
      description:
          'Use a bike instead of a car for short trips. \nZero emissions, reduces air pollution.',
    ),
    CardData(
      cardId: 2,
      name: 'Bicycle',
      description:
          'Use a bike instead of a car for short trips. \nZero emissions, reduces air pollution.',
    ),
    CardData(
      cardId: 3,
      name: 'Fishing Line',
      description:
          'Decomposition time: ~600 years. \nExtremely dangerous for wildlife, causes entanglement and long-term ecosystem damage.',
    ),
    CardData(
      cardId: 3,
      name: 'Fishing Line',
      description:
          'Decomposition time: ~600 years. \nExtremely dangerous for wildlife, causes entanglement and long-term ecosystem damage.',
    ),
    CardData(
      cardId: 4,
      name: 'Plastic Bag',
      description:
          'Decomposition time: ~10–20 years. \nEasily ingested by marine animals; a major cause of ocean pollution.',
    ),
    CardData(
      cardId: 4,
      name: 'Plastic Bag',
      description:
          'Decomposition time: ~10–20 years. \nEasily ingested by marine animals; a major cause of ocean pollution.',
    ),
    CardData(
      cardId: 5,
      name: 'Thermostat',
      description:
          'Lower heating or raise AC slightly. \nSaves energy and reduces carbon footprint.',
    ),
    CardData(
      cardId: 5,
      name: 'Thermostat',
      description:
          'Lower heating or raise AC slightly. \nSaves energy and reduces carbon footprint.',
    ),
  ];
  List<bool> revealedCards = List.filled(12, false);

  Timer? hideTimer;
  int triesLeft = 7;
  int correctAnswers = 0;
  List<int> currentRevealedCardsIndex = [];
  bool canInteract = true;

  @override
  void initState() {
    cards.shuffle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF9AB17A),
        title: Text('Pick up game'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Center(
                child: Text(
                  'Daily tries ${triesLeft.toString()} of 7',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Center(
                child: Text(
                  'Daily points collected: ${correctAnswers * 10}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SliverGrid.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: (context, count) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: cardItem(
                  cardData: cards[count],
                  isReviled: revealedCards[count],
                  onTap: () {
                    if (revealedCards[count] ||
                        !canInteract ||
                        triesLeft <= 0) {
                      return;
                    }

                    setState(() {
                      revealedCards[count] = !revealedCards[count];
                      currentRevealedCardsIndex.add(count);
                    });
                    if (currentRevealedCardsIndex.length == 2) {
                      triesLeft -= 1;
                      int revealedCardIndexA = currentRevealedCardsIndex[0];
                      int revealedCardIndexB = currentRevealedCardsIndex[1];
                      CardData tCardA = cards[revealedCardIndexA];
                      CardData tCardB = cards[revealedCardIndexB];
                      if (tCardA.cardId != tCardB.cardId && triesLeft > 0) {
                        setState(() {
                          canInteract = false;
                        });
                        hideTimer = Timer(Duration(seconds: 1), () {
                          setState(() {
                            revealedCards[revealedCardIndexA] = false;
                            revealedCards[revealedCardIndexB] = false;
                            canInteract = true;
                          });
                          hideTimer!.cancel();
                        });
                      } else if (tCardA.cardId == tCardB.cardId) {
                        correctAnswers += 1;
                        openAlert(tCardA);
                      }
                      if (triesLeft <= 0) {
                        PointsHelper.instance.pickUpPoints =
                            correctAnswers * 10;
                        PointsHelper.instance.isPickUpPlayed = true;
                        revealedCards = List.filled(12, true);
                      }
                      setState(() {});
                      currentRevealedCardsIndex.clear();
                    }
                  },
                ),
              );
            },
            itemCount: cards.length,
          ),
        ],
      ),
    );
  }

  Widget cardItem(
      {required CardData cardData,
      required bool isReviled,
      required Function onTap}) {
    return GestureDetector(
      onTap: () {
        if (isReviled) {
          openAlert(cardData);
        } else {
          onTap.call();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: isReviled ? Colors.lightBlueAccent : Colors.green,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 6,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: Center(
          child: isReviled
              ? Text(
                  cardData.name,
                )
              : SizedBox(),
        ),
      ),
    );
  }

  void openAlert(CardData cardData) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            cardData.name,
          ),
          content: Text(
            cardData.description,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

class CardData {
  CardData({
    required this.cardId,
    required this.name,
    required this.description,
  });

  bool isReviled = false;
  final int cardId;
  final String name;
  final String description;
}
