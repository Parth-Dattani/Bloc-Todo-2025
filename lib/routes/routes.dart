import 'package:go_router/go_router.dart';
import 'package:todo_bloc/screen/splash/splash_screen.dart';
import 'package:todo_bloc/screen/task/task_screen.dart';

final GoRouter router = GoRouter(
    initialLocation: "/",
    routes: [

GoRoute(
  name: "splash",
  path: "/",
  builder: (context, state) => SplashScreen()),

  GoRoute(
      name: "task",
      path: "/task",
      builder: (context, state) => TaskScreen()),
]);