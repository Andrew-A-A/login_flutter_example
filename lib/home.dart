import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/app_cubit.dart';
import 'cubit/app_states.dart';

class HomeScreen extends StatelessWidget {
   const HomeScreen( {super.key});
  @override
  Widget build(BuildContext context) {
    AppCubit cubit=BlocProvider.of<AppCubit>(context);
    return BlocBuilder<AppCubit,AppStates>(
        builder: (BuildContext context,dynamic state)
    {
      return Scaffold(
        body: Center(
          child: Text("Welcome ${cubit.currentUser?.email}"),
        ),
      );
    }
    );
 }
}
