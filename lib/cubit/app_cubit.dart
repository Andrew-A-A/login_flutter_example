import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() :super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  //Boolean used to switch show/hide password state
  bool passwordVisible=false;

  User? currentUser;

  void togglePasswordVisibility(){
    passwordVisible= !passwordVisible;
    emit(TogglePasswordVisibilityState());
  }
}