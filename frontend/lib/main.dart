import 'package:flutter/material.dart';
import 'package:frontend/apis/google_signin_api.dart';
import 'package:frontend/screens/authScreen.dart';
import 'package:frontend/screens/landingScreen.dart';
import 'package:frontend/screens/splashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter engine is initialized
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final SocketService _socketService = SocketService();

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // _socketService.connect();
    return MaterialApp(
      title: 'VeloCity',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(), // Specify the initial screen here
      debugShowCheckedModeBanner: false,
    );
  }
}
