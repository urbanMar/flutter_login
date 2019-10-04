import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/src/common/auth/authentication_bloc.dart';
import 'package:login/src/repository/user_repository.dart';
import 'package:login/src/screen/login/login_bloc.dart';

import 'login_form.dart';

class LoginScreen extends StatelessWidget{

  final UserRepository userRepository;

  LoginScreen({Key key, @required this.userRepository})
    : assert(userRepository != null),
      super(key: key);
  
  @override
  Widget build(BuildContext context) {

    if(context != null){
      print('asd');
    }

    try{

    } catch(e) {
      print('dd: $e');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocProvider(
        builder: (context) {
          return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            userRepository: userRepository,
          );
        },
        child: LoginForm(),
      ),
    );
  }
}