import 'dart:async';

import 'package:login/src/common/auth/authentication_bloc.dart';
import 'package:login/src/common/auth/authentication_event.dart';
import 'package:login/src/repository/user_repository.dart';
import 'package:login/src/screen/login/login_event.dart';
import 'package:login/src/screen/login/login_state.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{

  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if(event is LoginButtonPressed){
      yield LoginLoading();

      try{
        final token = await userRepository.authenticate(
            username: event.username,
            password: event.password,
        );
        authenticationBloc.dispatch(LoggedIn(token: token));
        yield LoginInitial();
      } catch (err) {
        yield LoginFailure(error: err.toString());
      }
    }
  }

}