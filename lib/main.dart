import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/blocs/task/task_bloc.dart';
import 'package:todo_bloc/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=> TaskBloc(),
      child: MaterialApp.router(
        title: 'Flutter Bloc Demo',
      routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

