import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/recipe_bloc.dart';
import 'services/api_service.dart';
import 'screens/home_screen.dart';
import '../bloc/recipe_event.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (_) => RecipeBloc(
        ApiService(),
      )..add(FetchRecipes()),

      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        title: 'RecipeSnap',

        theme: ThemeData(
          scaffoldBackgroundColor:
          Colors.white,
        ),

        home: const HomeScreen(),
      ),
    );
  }
}