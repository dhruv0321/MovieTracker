import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yellow_class_assignment/screens/home/movie_page.dart';
import 'package:yellow_class_assignment/screens/login/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            return MoviePage();
          } else if (snapshot.hasData) {
            return Center(
              child: Text('Something Went Wrong?'),
            );
          }
          return LoginPage();
        },
      ),
    );
  }
}
