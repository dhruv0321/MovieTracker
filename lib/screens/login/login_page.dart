import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yellow_class_assignment/components/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 20,
            bottom: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Movie Tracker',
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 40,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 40,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.greenAccent,
                        onPrimary: Colors.black,
                        minimumSize: Size(double.infinity, 50),
                      ),
                      onPressed: () {
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.googleLogin();
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.google,
                        color: Colors.black,
                      ),
                      label: Text(
                        'Sign In with Google',
                        style: TextStyle(fontSize: 20),
                      )),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
