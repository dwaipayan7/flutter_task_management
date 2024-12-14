import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_management/feature/auth/pages/login_page.dart';
import 'package:flutter_task_management/feature/auth/pages/signup_page.dart';
import 'package:flutter_task_management/feature/auth/repository/auth_repository.dart';

import 'feature/auth/bloc/auth_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(authRepository: AuthRepository()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Management',
        theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
            // hintText: "Email",
            contentPadding: const EdgeInsets.all(27),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.grey.shade300,
                  width: 3
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 3
              ),
              borderRadius: BorderRadius.circular(10),
            ),

            border: OutlineInputBorder(
              borderSide: const BorderSide(
                  width: 3
              ),
              borderRadius: BorderRadius.circular(10),
            ),

            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Colors.red,
                  width: 3
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 60),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
              ),
            ),
          ),

          useMaterial3: true,
        ),
        home: const LoginPage(),
      ),
    );
  }
}

