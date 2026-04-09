enum TaskType {
  daily,
  weekly,
}

class TasksHelper {
  TasksHelper();

  static TasksHelper instance = TasksHelper();

  int dailyPoints = 5;
  int weeklyPoints = 10;

  List<TaskLog> staticTasksMap = [
    TaskLog(
      TaskType.daily,
      'Turned off lights when leaving a room',
      'Reasons to do the tasks and what are the benefits for the environment',
    ),
    TaskLog(
      TaskType.daily,
      'Reduced heating or air conditioning usage',
      'Reasons to do the tasks and what are the benefits for the environment',
    ),
    TaskLog(
      TaskType.daily,
      'Unplugged unused devices',
      'Reasons to do the tasks and what are the benefits for the environment',
    ),
    TaskLog(
      TaskType.daily,
      'Used public transport / walked / biked',
      'Reasons to do the tasks and what are the benefits for the environment',
    ),
    TaskLog(
      TaskType.daily,
      'Ran full-load appliances',
      'Reasons to do the tasks and what are the benefits for the environment',
    ),
    TaskLog(
      TaskType.weekly,
      'Plant a tree',
      'Reasons to do the tasks and what are the benefits for the environment',
    ),
    TaskLog(
      TaskType.weekly,
      'Support an environmental programme',
      'Reasons to do the tasks and what are the benefits for the environment',
    ),
    TaskLog(
      TaskType.weekly,
      'Recycle',
      'Reasons to do the tasks and what are the benefits for the environment',
    ),
    TaskLog(
      TaskType.weekly,
      'Pick up trash from the street / beach / forest',
      'Reasons to do the tasks and what are the benefits for the environment',
    ),
  ];

  int getActiveDailyCount() {
    int dailySelectedCount = 0;
    for (var t in staticTasksMap) {
      if (t.isSelected && t.type == TaskType.daily) {
        dailySelectedCount += 1;
      }
    }
    return dailySelectedCount;
  }

  int getActiveWeeklyCount() {
    int weeklySelectedCount = 0;
    for (var t in staticTasksMap) {
      if (t.isSelected && t.type == TaskType.weekly) {
        weeklySelectedCount += 1;
      }
    }
    return weeklySelectedCount;
  }

  int getMyPoints() {
    int totalPoints = 0;
    int dailySelectedCount = getActiveDailyCount();
    int weeklySelectedCount = getActiveWeeklyCount();

    totalPoints += (dailySelectedCount * dailyPoints);
    totalPoints += (weeklySelectedCount * weeklyPoints);

    if (dailySelectedCount >= 5) {
      totalPoints += 20;
    } else if (dailySelectedCount >= 3) {
      totalPoints += 10;
    }

    return totalPoints;
  }

  List<TaskLog> getDailyTasks() {
    List<TaskLog> dTasks = [];
    for (var t in staticTasksMap) {
      if (t.type == TaskType.daily) {
        dTasks.add(t);
      }
    }
    return dTasks;
  }

  List<TaskLog> getWeeklyTasks() {
    List<TaskLog> wTasks = [];
    for (var t in staticTasksMap) {
      if (t.type == TaskType.weekly) {
        wTasks.add(t);
      }
    }
    return wTasks;
  }
}

class TaskLog {
  TaskLog(this.type, this.title, this.description);

  TaskType type;
  String title;
  String description;
  bool isSelected = false;
}
