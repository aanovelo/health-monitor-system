import 'package:flutter/material.dart';
import 'signup_page.dart';

class EntranceMonitorSignupPage extends SignupPage {
  @override
  EntranceMonitorSignupPageState createState() =>
      EntranceMonitorSignupPageState();
}

class EntranceMonitorSignupPageState extends SignupPageState<EntranceMonitorSignupPage> {
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
    return 'Entrance Monitor';
  }
}
