import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:to_do_serverless/auth/logic/firebase_auth_service.dart';
import 'package:to_do_serverless/auth/screen/login_screen.dart';
import 'package:to_do_serverless/messaging/messaging_service.dart';
import 'package:to_do_serverless/to_do_list/logic/firestore_service.dart';
import 'package:to_do_serverless/to_do_list/screens/to_do_list_screen.dart';
import 'package:to_do_serverless/to_do_list/widget/view_task_form.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await MessagingService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.black,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              minimumSize: MaterialStateProperty.all(
                const Size(
                  double.infinity,
                  56,
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(
                Colors.black,
              ),
            ),
          ),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(color: Colors.white, elevation: 0)),
      home: const Scaffold(body: LoginScreen()),
    );
  }
}
