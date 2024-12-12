import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/app_cubit.dart';
import 'cubit/app_states.dart';

class LoginApp extends StatelessWidget {
    const LoginApp({super.key});

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
                          controller: cubit.emailController,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Email",
                              prefixIcon: Icon(Icons.mail_outline_rounded)
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email Must Not Be Empty";
                            }
                           // cubit.wrongEmail(email: value);
                            return cubit.emailcheck;
                            //  return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      //Password text box
                      Padding(
                        padding:  const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                        child: TextFormField(
                          autovalidateMode:(cubit.isLoggedIn)?AutovalidateMode.disabled:AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.visiblePassword,
                          controller: cubit.passwordController,
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password Must Not Be Empty";
                            }
                            else if(cubit.emailcheck==null) {
                              //cubit.wrongPassword(password: value);
                            }
                            return cubit.passwordcheck;

                          },
                        ),
                      ),
                    ],
                  ),
                ),

                //Login button
                ElevatedButton(
                    onPressed: () {
                      if ( loginFormKey.currentState!.validate()) {
                        AppCubit.signInUsingEmailPassword(
                          email: cubit.emailController.text,
                          password:cubit.passwordController.text, context: context ,);
                        //cubit.loginSucceeded();
                       // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>  const Home()));
                        if (kDebugMode) {
                          print("FOUND!!");
                        }
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