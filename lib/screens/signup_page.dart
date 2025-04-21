import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'login_pages.dart';
import '../models/appColors.dart';

abstract class SignupPage extends StatefulWidget {
  @override
  SignupPageState createState();
}

abstract class SignupPageState<T extends SignupPage> extends State<T> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static final List<String> collegeOptions = [
    "CAFS",
    "CAS",
    "CDC",
    "CEM",
    "CEAT",
    "CFNR",
    "CHE",
    "CPAD",
    "CVM",
    "SESAM"
  ];

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController usernameController = TextEditingController();
  TextEditingController collegeController = TextEditingController(text: "${collegeOptions[0]}");
  TextEditingController courseController = TextEditingController();
  TextEditingController studentNoController = TextEditingController();

  TextEditingController employeeNoController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController homeUnitController = TextEditingController();

  Map<String, bool> checkboxValues = {
    'Hypertension': false,
    'Diabetes': false,
    'Tuberculosis': false,
    'Cancer': false,
    'Kidney Disease': false,
    'Cardiac Disease': false,
    'Autoimmune Disease': false,
    'Asthma': false,
  };

  List<String> allergies = [];

  Widget buildPreExisting() {
    return Column(children: [
      SizedBox(height: 30.0),
      
      Padding(
        padding: EdgeInsets.only(top: 10.0),
        child:  Text(
          'Add Pre-Existing Illness',
          style: TextStyle(
            color: AppColors.darkColor,
            fontSize: MediaQuery.of(context).size.width * 0.065, // Adjust the multiplier to achieve the desired font size
            // fontWeight: FontWeight.bold,
          ),
        ),
      ),

      Divider(),

      Column(
        children: [
          for (var item in checkboxValues.entries)
            CheckboxListTile(
              title: Text(item.key),
              value: item.value,
              onChanged: (bool? value) {
                setState(() {
                  checkboxValues[item.key] = value!;
                });
              },
            ),
          ListTile(
            title: Text('Allergies'),
            subtitle: Column(
              children: [
                for (var allergy in allergies)
                  Text(allergy),
              ],
            ),
            trailing: ElevatedButton(
              onPressed: () {
                _showAddAllergyDialog();
              },
              child: Text('Add Allergy'),
            ),
          ),
        ],
      ),
    ],
    );
  }

  void _showAddAllergyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String allergy = '';

        return AlertDialog(
          title: Text('Add Allergy'),
          content: TextField(
            onChanged: (value) {
              allergy = value;
            },
            decoration: InputDecoration(
              hintText: 'Enter an allergy',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  allergies.add(allergy);
                  Navigator.pop(context);
                });
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  bool isValidStudNum(String studNum) {
    return RegExp(r'\d{4}-\d{5}').hasMatch(studNum);
  }

  Widget nameFormField() {
    return TextFormField(
      controller: nameController,
      decoration: InputDecoration(labelText: 'Name'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your name';
        }
        return null;
      },
    );
  }

  Widget usernameFormField() {
    return TextFormField(
      controller: usernameController,
      decoration: InputDecoration(labelText: 'Username'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your username';
        }
        return null;
      },
    );
  }

  Widget collegeFormField() {
    return DropdownButtonFormField<String>(
      value: collegeOptions[0],
      onChanged: (String? value) {
        setState(() {
          collegeController.text = value!;
        });
      },
      items: collegeOptions.map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        },
      ).toList(),
    );
  }

  Widget courseFormField() {
    return TextFormField(
      controller: courseController,
      decoration: InputDecoration(labelText: 'Course'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your course';
        }
        return null;
      },
    );
  }

  Widget studentNoFormField() {
    return TextFormField(
      controller: studentNoController,
      decoration:
          InputDecoration(labelText: 'Student Number (Format: XXXX-XXXXX)'),
      validator: (value) {
        // validator if form is empty
        if (value == null || value.isEmpty) {
          return 'Please enter your student number';
        } else if (!isValidStudNum(value)) {
          return 'Student Number must be valid';
        }
        return null;
      },
    );
  }

  Widget employeeNoFormField() {
    return TextFormField(
      controller: employeeNoController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Employee Number'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your employee number';
        }
        if (num.tryParse(value) == null) {
          // checks if inputted is a number
          return 'Please enter a number';
        }
        return null;
      },
    );
  }

  Widget positionFormField() {
    return TextFormField(
      controller: positionController,
      decoration: InputDecoration(labelText: 'Position'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your position';
        }
        return null;
      },
    );
  }

  Widget homeUnitFormField() {
    return TextFormField(
      controller: homeUnitController,
      decoration: InputDecoration(labelText: 'Home Unit'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your home unit';
        }
        return null;
      },
    );
  }

  Widget emailFormField() {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(labelText: 'Email'),
      validator: (value) {
        // validator if form is empty
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

  Widget passwordFormField() {
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

  Widget buildFormFields();

  Widget buildSignupButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.075,
      child: Padding( 
        key: const Key('signupButton'),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              // signUp();
              if (getTitle() == 'User') {
                Map<String, dynamic> mergedData = {
                  'checkboxValues': checkboxValues,
                  'allergies': allergies,
                };
                Map<String, dynamic> details = {
                  'name': nameController.text,
                  'username': usernameController.text,
                  'college': collegeController.text,
                  'course': courseController.text,
                  'studNo': studentNoController.text,
                  'email': emailController.text,
                  'pre-illness': mergedData,
                  'userType': getTitle(),
                };
                await context.read<AuthProvider>().signUp(details,
                    emailController.text, passwordController.text);
              } else if (getTitle() == 'Admin' ||
                  getTitle() == 'Entrance Monitor') {
                Map<String, dynamic> details = {
                  'name': nameController.text,
                  'employeeNum': employeeNoController.text,
                  'position': positionController.text,
                  'homeUnit': homeUnitController.text,
                  'email': emailController.text,
                  'userType': getTitle(),
                };
                await context.read<AuthProvider>().signUp(details,
                    emailController.text, passwordController.text);
              }
              if (context.mounted) Navigator.pop(context);
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

  Widget loginLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account? ",
          style: TextStyle(color: Colors.black),
        ),
        GestureDetector(
          onTap: () {
            String title = getTitle();
            if (title == "User") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserLoginPage()),
              );
            } else if (title == "Admin") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminLoginPage()),
              );
            } else if (title == "Entrance Monitor") {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EntranceMonitorLoginPage()),
              );
            }
          },
          child: Text(
            "Login",
            style: TextStyle(color: AppColors.darkColor),
          ),
        ),
      ],
    );
  }


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
                    'Hi!',
                    style: TextStyle(
                      color: AppColors.darkColor,
                      fontSize: MediaQuery.of(context).size.width * 0.12, // Adjust the multiplier to achieve the desired font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Create a new account',
                    style: TextStyle(
                      color: AppColors.darkColor,
                      fontSize: MediaQuery.of(context).size.width * 0.065, // Adjust the multiplier to achieve the desired font size
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            buildFormFields(),
            SizedBox(height: 30.0),
            buildSignupButton(),
            loginLink(context),
          ],
        ),
      ),
    );
  }

  String getTitle();
}
