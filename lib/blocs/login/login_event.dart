import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class LoginRequested extends LoginEvent{
  late final String email;
  late final String password;

  LoginRequested(this.email,this.password);

  @override
  // TODO: implement props
  List<Object?> get props => [email,password];
}

class LogoutRequested extends LoginEvent {}
