import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_bloc/blocs/task/task_bloc.dart';
import 'package:todo_bloc/repository/auth_repository.dart';
import 'package:todo_bloc/routes/routes.dart';

import 'blocs/login/login_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // // HydratedBloc.storage = await HydratedStorage.build(
  // //   storageDirectory: kIsWeb
  // //       ? HydratedStorageDirectory.web
  // //       : HydratedStorageDirectory((await getApplicationDocumentsDirectory()).path),
  // // );
  // final storage = await HydratedStorage.build(
  //   storageDirectory: HydratedStorageDirectory
  //     (getApplicationDocumentsDirectory.toString()),
  // );
  //
  // HydratedBloc.storage = storage;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LoginBloc(authRepository: AuthRepository()),
        ),
        BlocProvider(
          create: (_) => TaskBloc(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Bloc Demo',
      routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

