import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_bloc/core/utils/app_image_url.dart';
import 'package:todo_bloc/screen/task/task_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    navToTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(AppImageUrl.appLogo, width: 80, height: 80),
      ),
    );
  }

  void navToTask() {
    Future.delayed(const Duration(seconds: 3), () {
      context.go('/task');
    });
  }

}