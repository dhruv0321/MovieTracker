import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:yellow_class_assignment/components/google_sign_in.dart';
import 'package:yellow_class_assignment/screens/home/home_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.blueGrey[900],
          // appBarTheme: AppBarTheme(
          //   backgroundColor: Colors.transparent,
          //   elevation: 0,
          // ),
        ),
        title: 'Yellow Class Assignment',
        home: HomePage(),
      ),
    );
  }
}
