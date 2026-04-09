import 'package:dotsoft/helpers/tasks_helper.dart';

class PointsHelper {
  PointsHelper();

  static PointsHelper instance = PointsHelper();

  int quizPoints = 0;
  bool isQuizPlayed = false;
  int photoPoints = 0;
  bool isPhotoPlayed = false;
  int pickUpPoints = 0;
  bool isPickUpPlayed = false;

  int getGamesPlayed() {
    return 0 +
        (isQuizPlayed ? 1 : 0) +
        (isPhotoPlayed ? 1 : 0) +
        (isPickUpPlayed ? 1 : 0);
  }

  int getTotalPoints() {
    int total = quizPoints +
        photoPoints +
        pickUpPoints +
        TasksHelper.instance.getMyPoints();
    return total;
  }
}
