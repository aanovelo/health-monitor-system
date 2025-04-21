import 'package:flutter/material.dart';
import 'login_page.dart';

class UserLoginPage extends LoginPage {
  @override
  UserLoginPageState createState() => UserLoginPageState();
}

class UserLoginPageState extends LoginPageState<UserLoginPage> {
  @override
  Widget buildFormFields() {
    return Column(
      children: [
        buildEmailFormField(),
        buildPasswordFormField(),
      ]
    );
  }
  @override
  String getTitle() {
    return 'User';
  }
}

class AdminLoginPage extends LoginPage {
  @override
  AdminLoginPageState createState() => AdminLoginPageState();
}

class AdminLoginPageState extends LoginPageState<AdminLoginPage> {
  @override
  Widget buildFormFields() {
    return Column(
      children: [
        buildEmailFormField(),
        buildPasswordFormField(),
      ]
    );
  }
  @override
  String getTitle() {
    return 'Admin';
  }
}

class EntranceMonitorLoginPage extends LoginPage {
  @override
  EntranceMonitorLoginPageState createState() => EntranceMonitorLoginPageState();
}

class EntranceMonitorLoginPageState extends LoginPageState<EntranceMonitorLoginPage> {
  @override
  Widget buildFormFields() {
    return Column(
      children: [
        buildEmailFormField(),
        buildPasswordFormField(),
      ]
    );
  }
  @override
  String getTitle() {
    return 'Entrance Monitor';
  }
}
