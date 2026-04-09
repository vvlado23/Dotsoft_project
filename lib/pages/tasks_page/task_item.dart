import 'package:dotsoft/helpers/tasks_helper.dart';
import 'package:flutter/material.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({super.key, required this.log, required this.onTapCheck});

  final TaskLog log;
  final Function() onTapCheck;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              widget.onTapCheck.call();
            },
            child: Container(
              height: 64,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: widget.log.isSelected
                    ? Color(0xffeed389)
                    : Color(0xFFE4DFB5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Text(
                    '+${widget.log.type == TaskType.daily ? TasksHelper.instance.dailyPoints : TasksHelper.instance.weeklyPoints} ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.log.title,
                    textAlign: TextAlign.start,
                  ),
                  const Spacer(),
                  Icon(widget.log.isSelected
                      ? Icons.check_box_outlined
                      : Icons.check_box_outline_blank),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
