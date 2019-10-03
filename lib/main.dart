import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/src/common/auth/authentication_bloc.dart';
import 'package:login/src/common/auth/authentication_event.dart';
import 'package:login/src/common/auth/authentication_state.dart';
import 'package:login/src/common/bloc/simple_bloc_delegate.dart';
import 'package:bloc/bloc.dart';
import 'package:login/src/common/widgets/loading_indicator.dart';
import 'package:login/src/repository/user_repository.dart';
import 'package:login/src/screen/home/home_screen.dart';
import 'package:login/src/screen/login/login_screen.dart';
import 'package:login/src/screen/splash/splash_screen.dart';

void main(){
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider<AuthenticationBloc>(
      builder: (context) {
        return AuthenticationBloc(userRepository: userRepository)
            ..dispatch(AppStarted());
      },
      child: MyApp(userRepository: userRepository),
    )
  );
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  MyApp({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Tutorial',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state){
          if (state is AuthenticationUninitialized) {
            return SplashScreen();
          }
          if (state is AuthenticationAuthenticated) {
            return HomeScreen();
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginScreen(userRepository: userRepository);
          }
          
            return LoadingIndicator();

        },
      ),
    );
  }
}
