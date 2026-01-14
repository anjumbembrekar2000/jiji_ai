import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiji_ai_app/view/landing%20screen/chat_bloc.dart';
import 'view/splash_screen.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => ChatBloc(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jiji AI',

      home: const SplashScreen(),
    );
  }
}
