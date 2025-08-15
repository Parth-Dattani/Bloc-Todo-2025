import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/blocs/login/login_event.dart';
import 'package:todo_bloc/blocs/login/login_state.dart';

import '../../repository/auth_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  final AuthRepository authRepository;
  final FirebaseAuth auth =  FirebaseAuth.instance;

  LoginBloc({required this.authRepository}) : super(LoginInitial()){
  on<LoginRequested>((event, emit) async {
    emit(LoginLoading());
    try{
      await authRepository.login(event.email, event.password);
      emit(LoginSuccess());
    }
    on FirebaseAuthException catch (e){
      emit(LoginFailure(error:  e.toString() ?? "Login Fail...."));
    }
    catch (e){
      emit(LoginFailure(error: e.toString()));
    }
  });

  on<LogoutRequested>((event, emit) async {
    try {
      await authRepository.logout();
      emit(LoginInitial()); // Reset to initial state
    } catch (e) {
      emit(LoginFailure(error:  e.toString()));
    }
  });
  }

}