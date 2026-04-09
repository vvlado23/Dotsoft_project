import 'package:dotsoft/helpers/tasks_helper.dart';
import 'package:dotsoft/pages/tasks_page/task_item.dart';
import 'package:flutter/material.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  TasksHelper tHelper = TasksHelper();
  List<TaskLog> _dailyTasks = [];
  List<TaskLog> _weeklyTasks = [];

  @override
  void initState() {
    _dailyTasks = tHelper.getDailyTasks();
    _weeklyTasks = tHelper.getWeeklyTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        TasksTitle('Daily Tasks'),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, int index) {
              return TaskItem(
                log: _dailyTasks[index],
                onTapCheck: () {
                  setState(() {
                    _dailyTasks[index].isSelected =
                        !_dailyTasks[index].isSelected;
                  });
                  if (_dailyTasks[index].isSelected) {
                    openAlertBox(_dailyTasks[index]);
                  }
                },
              );
            },
            childCount: _dailyTasks.length,
          ),
        ),
        TasksTitle('Weekly Tasks'),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, int index) {
              return TaskItem(
                log: _weeklyTasks[index],
                onTapCheck: () {
                  setState(() {
                    _weeklyTasks[index].isSelected =
                        !_weeklyTasks[index].isSelected;
                  });
                  if (_weeklyTasks[index].isSelected) {
                    openAlertBox(_weeklyTasks[index]);
                  }
                },
              );
            },
            childCount: _weeklyTasks.length,
          ),
        ),
      ],
    );
  }

  void openAlertBox(TaskLog task) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(task.title),
            content: Text(task.description),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          );
        });
  }
}

class TasksTitle extends StatelessWidget {
  const TasksTitle(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 12),
        height: 46,
        decoration: BoxDecoration(
          color: Color(0xFFC3CC9B),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22),
          ),
        ),
      ),
    );
  }
}
