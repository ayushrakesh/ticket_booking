import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ticket_booking/screens/all_tickets_screen.dart';
import 'package:ticket_booking/screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ticket_booking/widgets/bottom_bar.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: BottomNavigation(),
      home: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BottomNavigation();
          }
          return LoginScreen();
        },
        stream: FirebaseAuth.instance.authStateChanges(),
      ),
      routes: {
        AllTicketsScreen.routename: (context) => AllTicketsScreen(),
      },
    );
  }
}
