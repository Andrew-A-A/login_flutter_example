import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_task/home.dart';
import 'package:login_task/utils/firebase_auth.dart';
import 'package:login_task/utils/form_validator.dart';
import 'cubit/app_cubit.dart';
import 'cubit/app_states.dart';

class LoginApp extends StatelessWidget {
    LoginApp({super.key});
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context){
    AppCubit cubit=BlocProvider.of<AppCubit>(context);
    var loginFormKey = GlobalKey<FormState>();
    return BlocBuilder<AppCubit,AppStates>(
        builder: (BuildContext context,dynamic state){
          return  Scaffold(
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical:20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //First row contains word 'Login' only
                   const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children:[
                        Text("Let's sign you in.", style:
                        TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 45,
                            fontFamily: 'Roboto')
                        ),
                        Text("Welcome Back.\nYou have been missed!",
                            style: TextStyle(fontWeight: FontWeight.w400,
                                fontSize: 35,
                                fontFamily: 'Roboto') ),
                      ]),
                  const SizedBox(height: 40),

                  Form(
                    key:loginFormKey,
                    child: Column(
                      children:[
                        //Email text box
                        TextFormField(
                          autovalidateMode:(cubit.isLoggedIn)?AutovalidateMode.disabled:AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Email",
                              prefixIcon: Icon(Icons.mail_outline_rounded)
                          ),
                          validator: (value) =>Validator.validateEmail(email: value),
                        ),
                        const SizedBox(height: 20),
                        //Password text box
                        TextFormField(
                          autovalidateMode:(cubit.isLoggedIn)?AutovalidateMode.disabled:AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          obscureText: !cubit.passwordVisible,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration:  InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: "Password",
                              prefixIcon: const Icon(Icons.password),
                            suffixIcon: IconButton(
                              icon: Icon(
                                  cubit.passwordVisible ?
                                  Icons.visibility_off
                                  : Icons.visibility
                              ),
                              onPressed: cubit.togglePasswordVisibility
                            ),
                          ),
                          validator: (value)=> Validator.isPasswordValid(password: value),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),
                  //Login button
                  SizedBox(
                    width: double.infinity, // This ensures the button fills the available width
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        onLoginButtonPress(loginFormKey, context, cubit);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent,
                        disabledBackgroundColor: Colors.grey,
                      ),
                      child: const Text("Sign in"),
                    ),
                  ),
                  const SizedBox(height: 15),

                  //Last row contains signup text and button
                  Row(
                      children:[
                        const Text("Don't have an account?", style: TextStyle(fontFamily: 'Roboto',color: Colors.grey)),
                        TextButton(onPressed: (){
                        //  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> Signup()));
                          //cubit.loginSucceeded();
                        }, child: const Text("Register"))
                      ]
                  )
                ],
              ),
            ),
          );
        }
    );

  }

  void onLoginButtonPress(GlobalKey<FormState> loginFormKey, BuildContext context, AppCubit cubit) {
    if ( loginFormKey.currentState!.validate()) {
      FirebaseAuthentication.signInUsingEmailPassword(
        email: emailController.text,
        password:passwordController.text, context: context
      ).then((user){
        if(user!=null) {
          cubit.currentUser = user;
          if (context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const HomeScreen()),
            );
          }
        }
      });
    }
  }
}