import 'package:dotsoft/helpers/points_helper.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> quizArray = [];
  int currentQuiz = 0;
  int correctAnswers = 0;
  bool pendingAnswer = true;

  @override
  void initState() {
    quizArray = [
      quizItem(
        'Example question 1 afdas fasdf asd fasdd fasd fsad fa da das fsda',
        [
          Answer('answer 1', false, false),
          Answer('answer 2', false, false),
          Answer('answer 3 (t)', false, true),
          Answer('answer 4', false, false),
        ],
      ),
      quizItem(
        'Example question 2',
        [
          Answer('answer 1', false, false),
          Answer('answer 2', false, false),
          Answer('answer 3 (t)', false, true),
          Answer('answer 4', false, false),
        ],
      ),
      quizItem(
        'Example question 3',
        [
          Answer('answer 1 (t)', false, true),
          Answer('answer 2', false, false),
          Answer('answer 3', false, false),
          Answer('answer 4', false, false),
        ],
      ),
      quizItem(
        'Example question 4',
        [
          Answer('answer 1', false, false),
          Answer('answer 2', false, false),
          Answer('answer 3', false, false),
          Answer('answer 4 (t)', false, true),
        ],
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF9AB17A),
        title: Text('Quiz'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 16),
            Text('Quiz: ${currentQuiz + 1}/${quizArray.length}'),
            Divider(),
            const SizedBox(height: 16),
            quizArray[currentQuiz],
            Divider(),
            ElevatedButton(
              onPressed: () {
                if (pendingAnswer) return;
                pendingAnswer = true;
                setState(() {
                  if (currentQuiz < quizArray.length - 1) {
                    currentQuiz += 1;
                  } else {
                    PointsHelper.instance.quizPoints = correctAnswers * 5;
                    PointsHelper.instance.isQuizPlayed = true;
                    openAlert();
                  }
                });
              },
              child: Text(currentQuiz < quizArray.length - 1
                  ? 'Next Question'
                  : 'Finish'),
            )
          ],
        ),
      ),
    );
  }

  void openAlert() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
              '${correctAnswers.toString()} of ${quizArray.length} correct!'),
          content: Text(
              'You did the daily quiz! \nYou gor ${correctAnswers * 5} points.'),
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

  Widget quizItem(String question, List<Answer> answers) {
    return StatefulBuilder(builder: (context, customSetState) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(question),
          ),
          const SizedBox(height: 16),
          ...answers.map((a) {
            return answerItem(
              answer: a,
              onTap: () {
                if (pendingAnswer) {
                  pendingAnswer = false;
                  a.isSelected = true;
                  if (a.isCorrect) {
                    correctAnswers += 1;
                  }
                  setState(() {});
                  customSetState(() {});
                }
              },
            );
          }),
        ],
      );
    });
  }

  Widget answerItem({
    required Answer answer,
    required Function onTap,
  }) {
    return Padding(
      key: UniqueKey(),
      padding: EdgeInsets.symmetric(vertical: 16),
      child: GestureDetector(
        onTap: () {
          onTap.call();
        },
        child: Container(
          height: 88,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 32),
          decoration: BoxDecoration(
            color: answer.isCorrect
                ? (pendingAnswer ? Color(0xFFE4DFB5) : Colors.green)
                : (answer.isSelected ? Colors.red : Color(0xFFE4DFB5)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(answer.text),
          ),
        ),
      ),
    );
  }
}

class Answer {
  Answer(this.text, this.isSelected, this.isCorrect);

  String text;
  bool isSelected;
  bool isCorrect;
}
