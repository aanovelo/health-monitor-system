import 'package:amante_contaoi_novelo_olipas/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'user_signup.dart';
import 'admin_signup.dart';
import 'entrancemonitor_signup.dart';
import '../models/appColors.dart';
import 'package:provider/provider.dart';

abstract class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState();
}

abstract class LoginPageState<T extends LoginPage> extends State<T> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  Widget buildEmailFormField() {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(labelText: 'Email'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter email';
        } else if (!isValidEmail(value)) {
          return 'Email must be valid';
        }
        return null;
      },
    );
  }

  bool _passwordVisible = false; // State variable to toggle password visibility

  Widget buildPasswordFormField() {
    return TextFormField(
      controller: passwordController,
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
        labelText: 'Password',
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
          child: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
      validator: (value) {
        // validator if form is empty
        if (value == null || value.isEmpty) {
          return 'Please enter password';
        } else if (value.length < 6) {
          return 'Password must be greater than 5 characters!';
        }
        return null;
      },
    );
  }

  Widget buildSignInButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.075,
      child: Padding(
        key: const Key('signupButton'),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              final userContext = context;
              context
                  .read<AuthProvider>()
                  .signIn(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  )
                  .then((userType) {
                if (userType == "User") {
                  Navigator.pushNamed(userContext, '/homepage');
                } else if (userType == "Admin") {
                  Navigator.pushNamed(userContext, '/admin');
                } else if (userType == "Entrance Monitor") {
                  Navigator.pushNamed(userContext, '/logs');
                }
                // Navigate to '/homepage' after successful sign-in
              });
            }
          },
          child: Text(
            'LOGIN',
            style: TextStyle(
              color: AppColors.darkColor,
              fontSize: MediaQuery.of(context).size.width *
                  0.045, // Adjust the font size as needed
              fontWeight: FontWeight.bold, // Make the text bold
            ),
          ),
        ),
      ),
    );
  }

  Widget signupLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(color: Colors.black),
        ),
        GestureDetector(
          onTap: () {
            String title = getTitle();
            if (title == "User") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserSignupPage()),
              );
            } else if (title == "Admin") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminSignupPage()),
              );
            } else if (title == "Entrance Monitor") {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EntranceMonitorSignupPage()),
              );
            }
          },
          child: Text(
            "Sign Up",
            style: TextStyle(color: AppColors.darkColor),
          ),
        ),
      ],
    );
  }

  Widget buildFormFields();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(50.0),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome!',
                    style: TextStyle(
                      color: AppColors.darkColor,
                      fontSize: MediaQuery.of(context).size.width *
                          0.12, // Adjust the multiplier to achieve the desired font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Sign in to continue',
                    style: TextStyle(
                      color: AppColors.darkColor,
                      fontSize: MediaQuery.of(context).size.width *
                          0.065, // Adjust the multiplier to achieve the desired font size
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            buildFormFields(),
            SizedBox(height: 30.0),
            buildSignInButton(),
            signupLink(context),
          ],
        ),
      ),
    );
  }

  String getTitle();
}
