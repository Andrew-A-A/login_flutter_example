import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_states.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() :super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);


  //Boolean used to switch show/hide password state
  bool passwordVisible=false;

  User? currentUser;

  //Error messages (if any) for password and email text boxes
  String? emailcheck;
  String? passwordcheck;

  //Boolean used to make sure that the email used in signup is unique
  bool uniqueEmail = false;

  //Boolean detect current state (loggedIn or not)
  bool isLoggedIn = false;


  void togglePasswordVisibility(){
    passwordVisible= !passwordVisible;
    emit(TogglePasswordVisibilityState());
  }
  

}