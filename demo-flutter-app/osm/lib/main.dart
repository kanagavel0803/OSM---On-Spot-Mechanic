import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'loginpage.dart';  
import 'firebase_options.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const OsmApp());
}

class OsmApp extends StatelessWidget {
  const OsmApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedSplashScreen(
          splash: Center(
            child: Image.asset(
              'images/logo_clr.png',
            ),
          ),
          splashIconSize: 300.0,
          duration: 3000,
          nextScreen: LoginPage(),  
          backgroundColor: Color.fromARGB(255, 31, 157, 161),
          splashTransition: SplashTransition.scaleTransition,
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment(0.0, 0.6),
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: Colors.white,
              size: 100,
            ),
          ),
        ),
      ],
    );
  }
}
