import 'package:flutter/material.dart';
import 'signup_page.dart';

class AdminSignupPage extends SignupPage {
  @override
  AdminSignupPageState createState() => AdminSignupPageState();
}

class AdminSignupPageState extends SignupPageState<AdminSignupPage> {
  @override
  Widget buildFormFields() {
    return Column(
      children: [
        nameFormField(),
        employeeNoFormField(),
        positionFormField(),
        homeUnitFormField(),
        emailFormField(),
        passwordFormField(),
      ],
    );
  }

  @override
  String getTitle() {
    return 'Admin';
  }
}
