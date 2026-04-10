# Dotsoft interview project

## Architecture Decisions

### Folder Structure:
```
-lib/
  helpers/
    points_helper.dart
    tasks_helper.dart
  pages/
    games_page/
      games_page.dart
      my_photos_page.dart
      pick_up_page.dart
      quiz_page.dart
    home_page/
      home_page.dart
    leaderboard/
      leaderboard.dart
    start_page/
      start_page.dart
    tasks_page/
      task_item.dart
      tasks_page.dart
  main.dart
```
The reason is to keep the logic seperated from the UI and it is scalable for more pages. A service folder can be added later to isolate logic for more complicated functionalities like API calls.

### State management:
Used `StatefulWidget` for simple UI state, with plans to migrate to `Provider` or `Bloc` if scaling.

### Flow
The app has a main hub with bottom navigation, to make the user expirience smooth without a lote of back and forth. The main pages are `HomePage`, with user information and point, `TasksPage`, for the daily task, `GamesPage`, a second hub with 3 games, and `LeaderboardPage`, a page with other users scores. The `GamePage` has 3 games: `Quiz`, `Photos` and the custom game `PickUpTrash`.

### Helpers
Two simple singleton classes are used to manage the quiz questions and track the user’s total points. In a real project, these would likely be replaced with API calls to a backend service.

## Gamification Logic

The game I chose is a `finde the match`. It is a grid of 12 items and the user has to find 2 trashes that match with limited tries. If any 2 are matched, an alert is poped with information about that item, or ways to help the environment that are relevant to that item. The user wants to get the correct matches to get points and at the same time they learn useful informations.
