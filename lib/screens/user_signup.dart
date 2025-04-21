import 'package:flutter/material.dart';
import 'signup_page.dart';

class UserSignupPage extends SignupPage {
  @override
  UserSignupPageState createState() => UserSignupPageState();
}

class UserSignupPageState extends SignupPageState<UserSignupPage> {
  @override
  Widget buildFormFields() {
    return Column(
      children: [
        nameFormField(),
        usernameFormField(),
        collegeFormField(),
        courseFormField(),
        studentNoFormField(),
        emailFormField(),
        passwordFormField(),
        buildPreExisting(),
      ],
    );
  }

  @override
  String getTitle() {
    return 'User';
  }
}