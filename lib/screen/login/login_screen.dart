import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_bloc/blocs/login/login_bloc.dart';
import 'package:todo_bloc/blocs/login/login_event.dart';
import 'package:todo_bloc/blocs/login/login_state.dart';
import 'package:todo_bloc/blocs/task/task_event.dart';
import 'package:todo_bloc/repository/auth_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  ///BlocBuilder
  // @override
  // Widget build(BuildContext context) {
  //   return
  //     BlocBuilder(
  //       builder: (context, state) {
  //         return Scaffold(
  //           body: Center(
  //             child: Form(
  //               key: loginFormKey,
  //               child: Padding(
  //                 padding: const EdgeInsets.only(left: 12, right: 12),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Image.asset("assets/images/AR.png"),
  //                     Text("Notes", style: TextStyle(color: Colors.blueAccent, fontSize: 24, fontWeight: FontWeight.bold),),
  //                     SizedBox(height: 15,),
  //                     TextFormField(
  //                       controller: emailController,
  //                       decoration: InputDecoration(
  //                           labelText: "Email",
  //                           hintText: "enter email",
  //                           border: OutlineInputBorder()
  //                       ),
  //                     ),
  //                     SizedBox(height: 5,),
  //                     TextFormField(
  //                       controller: passwordController,
  //                       decoration: InputDecoration(
  //                           labelText: "password",
  //                           hintText: "enter password",
  //                           border: OutlineInputBorder()
  //                       ),
  //                     ),
  //                     SizedBox(height: 15,),
  //                     ElevatedButton(
  //                         onPressed: (){
  //                           context.read<LoginBloc>().add(
  //                             LoginRequested(
  //                             emailController.text.toString(),
  //                             passwordController.text.toString()
  //                           ));
  //                         },
  //                         style: ElevatedButton.styleFrom(backgroundColor: Colors.teal,
  //                             elevation: 5,
  //                             shape: RoundedSuperellipseBorder()),
  //                         child: Text("Login", style: TextStyle(color: Colors.white, fontSize: 18),))
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //
  //     );
  // }

  ///Bloc Provider
  @override
  Widget build(BuildContext context) {
    return
      BlocProvider(
          create: (context) => LoginBloc(authRepository: AuthRepository()),
          child:  BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                context.go('/task'); // navigate on success
              } else if (state is LoginFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                return Scaffold(
                  body: Center(
                    child: Form(
                      key: loginFormKey,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/AR.png"),
                            Text("Notes", style: TextStyle(color: Colors.blueAccent, fontSize: 24, fontWeight: FontWeight.bold),),
                            SizedBox(height: 15,),
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                  labelText: "Email",
                                  hintText: "enter email",
                                  border: OutlineInputBorder()
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your email";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 5,),
                            TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                  labelText: "password",
                                  hintText: "enter password",
                                  border: OutlineInputBorder()
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your password";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15,),
                            ElevatedButton(
                                onPressed: (){
                                  if(loginFormKey.currentState!.validate()){
                                    context.read<LoginBloc>().add(
                                      LoginRequested(emailController.text.toString(),
                                          passwordController.text.toString())
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal,
                                    elevation: 5,
                                    shape: RoundedSuperellipseBorder()),
                                child: Text("Login", style: TextStyle(color: Colors.white,
                                    fontSize: 18),)),

                            if (state is LoginLoading) ...[
                              const SizedBox(height: 10),
                              const CircularProgressIndicator(),
                            ],
                            if (state is LoginFailure) ...[
                              const SizedBox(height: 10),
                              Text(
                                state.error,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ],

                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
      );
  }
}
