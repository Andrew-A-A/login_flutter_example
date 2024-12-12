import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_states.dart';
import 'package:firebase_core/firebase_core.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() :super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);


  //Boolean used to switch show/hide password state
  bool passwordVisible=false;



  //Error messages (if any) for password and email text boxes
  String? emailcheck;
  String? passwordcheck;

  //Boolean used to make sure that the email used in signup is unique
  bool uniqueEmail = false;

  //Boolean detect current state (loggedIn or not)
  bool isLoggedIn = false;

  //Text boxes controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var ageController = TextEditingController();
  var heightController = TextEditingController();

  void togglePasswordVisibility(){
    passwordVisible= !passwordVisible;
    emit(TogglePasswordVisibilityState());
  }
  
  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }

    return user;
  }
}