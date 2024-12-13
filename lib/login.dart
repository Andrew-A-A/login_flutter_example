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
            body: Column(
              children: [
                Image.asset('assets/images/login.jpg',scale: 6,alignment: Alignment.topCenter,fit: BoxFit.contain ),
                //First row contains word 'Login' only
                const Row(
                    children:[
                      Padding(
                        padding: EdgeInsets.only(left: 20,bottom: 15 , top: 15),
                        child: Text("Login", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,fontFamily: 'Roboto') ),
                      ),
                    ]),

                Form(
                  key:loginFormKey,
                  child: Column(
                    children:[
                      //Email text box
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: TextFormField(
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
                      ),
                      const SizedBox(height: 20),
                      //Password text box
                      Padding(
                        padding:  const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                        child: TextFormField(
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
                      ),
                    ],
                  ),
                ),

                //Login button
                ElevatedButton(
                    onPressed: () {
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
                      else {
                        null;
                      }
                    },
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(horizontal:170,vertical: 15),
                        disabledBackgroundColor: Colors.grey
                    ),
                    child: const Text("Login")
                ),
                const SizedBox(height: 20),

                //Last row contains signup text and button
                Row(
                    children:[
                      const Padding(
                        padding: EdgeInsets.only(left: 30 ),
                        child: Text("New to the app?", style: TextStyle(fontFamily: 'Roboto',color: Colors.grey)),
                      ),
                      TextButton(onPressed: (){
                      //  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> Signup()));
                        //cubit.loginSucceeded();
                      }, child: const Text("Register"))
                    ]
                )
              ],
            ),
          );
        }
    );

  }
}