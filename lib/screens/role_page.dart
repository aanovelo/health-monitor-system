import 'package:flutter/material.dart';
import '../models/appColors.dart';

import 'user_signup.dart';
import 'admin_signup.dart';
import 'entrancemonitor_signup.dart';
import 'login_pages.dart';

class RolePage extends StatefulWidget {
  const RolePage({Key? key}) : super(key: key);

  @override
  State<RolePage> createState() => _RolePageState();
}

class _RolePageState extends State<RolePage> {
  String _role = "";

  Widget buildRoleOption({
    required String role,
    required String assetPath,
    required String labelText,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _role = role;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          border: Border.all(
            color: AppColors.lightColor, // Set the color of the border
            width: 2.0, // Set the width of the border
          ),
          color: _role == role ? AppColors.lightColor : Colors.transparent,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Flexible(
              child: Image.asset(
                assetPath,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 10),
            Text(
              labelText,
              style: TextStyle(color: _role == role ? AppColors.darkColor : AppColors.lightColor, fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width * 0.05,),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }


  Widget loginButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.075,
      child: Padding(
        key: const Key('loginButton'),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ElevatedButton(
          onPressed: () async {
            if (_role == "Student") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserLoginPage()),
              );
            } else if (_role == "Admin") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminLoginPage()),
              );
            } else if (_role == "Entrance Monitor") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EntranceMonitorLoginPage()),
              );
            }
          },
          child: Text(
            'LOGIN',
            style: TextStyle(
              color: AppColors.darkColor,
              fontSize: MediaQuery.of(context).size.width * 0.045, // Adjust the font size as needed
              fontWeight: FontWeight.bold, // Make the text bold
            ),
          ),
        ),
      ),
    );
  }

  Widget signUpButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.075,
      child: Padding( 
        key: const Key('signupButton'),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ElevatedButton(
          onPressed: () async {
            if (_role == "Student") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserSignupPage()),
              );
            } else if (_role == "Admin") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminSignupPage()),
              );
            } else if (_role == "Entrance Monitor") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EntranceMonitorSignupPage()),
              );
            }
          },
          child: Text(
            'SIGNUP',
            style: TextStyle(
              color: AppColors.darkColor,
              fontSize: MediaQuery.of(context).size.width * 0.045, // Adjust the font size as needed
              fontWeight: FontWeight.bold, // Make the text bold
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 50),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello!',
                        style: TextStyle(
                          color: AppColors.lightColor,
                          fontSize: MediaQuery.of(context).size.width * 0.12, // Adjust the multiplier to achieve the desired font size
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Select a role to sign up',
                        style: TextStyle(
                          color: AppColors.lightColor,
                          fontSize: MediaQuery.of(context).size.width * 0.065, // Adjust the multiplier to achieve the desired font size
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 20),
              Expanded(
                child: buildRoleOption(
                    role: "Student",
                    assetPath: 'assets/user.png',
                    labelText: 'User',
                  ),
              ),
              SizedBox(height: 5),
              Expanded(
                child: buildRoleOption(
                  role: "Admin",
                  assetPath: 'assets/admin.png',
                  labelText: 'Admin',
                ),
              ),
              SizedBox(height: 5),
              Expanded(
                child: buildRoleOption(
                  role: "Entrance Monitor",
                  assetPath: 'assets/emonitor.png',
                  labelText: 'Entrance Monitor',
                ),
              ),
              SizedBox(height: 20),
              signUpButton(context),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1.0,
                      color: AppColors.lightColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'OR',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: AppColors.lightColor),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 1.0,
                      color: AppColors.lightColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              loginButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
