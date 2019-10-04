import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class LoginButtonPressed extends LoginEvent {
  LoginButtonPressed({
    @required this.username,
    @required this.password,
  }) : super([username, password]);

  final String username;
  final String password;



  @override
  String toString() =>
      'LoginButtonPressed { username: $username, password: $password }';
}