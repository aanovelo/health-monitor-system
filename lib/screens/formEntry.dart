import 'package:amante_contaoi_novelo_olipas/api/firebase_auth_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/entry_model.dart';
import '../providers/entry_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/appColors.dart';
import 'package:intl/intl.dart';

class FormEntryPage extends StatefulWidget {
  const FormEntryPage({Key? key}) : super(key: key);

  @override
  State<FormEntryPage> createState() => _FormEntryPageState();
}

class _FormEntryPageState extends State<FormEntryPage>
    with TickerProviderStateMixin {
  bool _contact = false;
  String todayStatus = 'Cleared';
  Map<String, dynamic> checkboxValues = {
    'Fever (37.8 C and above)': false,
    'Feeling feverish': false,
    'Muscle or joint pains': false,
    'Cough': false,
    'Colds': false,
    'Sore throat': false,
    'Difficulty of breathing': false,
    'Diarrhea': false,
    'Loss of taste': false,
    'Loss of smell': false,
  };

  Widget symptomsCheckbox() {
    return Column(
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
        SizedBox(height: 15),
        CheckboxListTile(
          tileColor: AppColors.defaultColor,
          title: const Text(
              'Did you have a face-to-face encounter or contact with a confirmed COVID-19 case?',
              style: TextStyle(fontSize: 15.0, color: AppColors.lightColor)),
          value: _contact,
          onChanged: (bool? value) {
            setState(() {
              _contact = value!;

              if (_contact) {
                todayStatus = 'Under Monitoring';
              } else {
                todayStatus = 'Cleared';
              }
            });
          },
        ),
      ],
    );
  }

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget buildSignupButton(String userId) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.075,
      child: Padding(
        key: const Key('signupButton'),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.darkColor,
            elevation: 0,
          ),
          child: Text(
            'Submit',
            style: TextStyle(fontSize: 15.0, color: AppColors.lightColor),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Container(
                    height: 200,
                    width: 200,
                    child: Center(
                      child: AnimatedBuilder(
                        animation: _animationController,
                        builder: (BuildContext context, Widget? child) {
                          return AnimatedOpacity(
                            opacity: _animationController.value,
                            duration: Duration(milliseconds: 3000),
                            child: Icon(
                              Icons.check,
                              color: AppColors.defaultColor,
                              size: 64.0,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            );

            _animationController.forward(from: 0.0).then((_) {
              bool stat = false;
              checkboxValues.forEach((key, value) {
              if (value == true) {
                stat = true;
                return;
              }
            });
              if (todayStatus != "Under Monitoring" && stat == true){
                todayStatus = "With Symptoms";
              }
              String currentDate =
                  DateFormat('MM-dd-yyyy').format(DateTime.now());
              Entry temp = Entry(
                fever: checkboxValues['Fever (37.8 C and above)'],
                feel_fever: checkboxValues['Feeling feverish'],
                muscle_pain: checkboxValues['Muscle or joint pains'],
                cough: checkboxValues['Cough'],
                colds: checkboxValues['Colds'],
                sore_throat: checkboxValues['Sore throat'],
                diff_breathing: checkboxValues['Difficulty of breathing'],
                diarrhea: checkboxValues['Diarrhea'],
                no_taste: checkboxValues['Loss of taste'],
                no_smell: checkboxValues['Loss of smell'],
                contact: _contact,
                studNo: userId,
                date: currentDate,
                status: todayStatus,
              );
              context.read<EntryListProvider>().addEntry(temp);
              Navigator.pop(context);
              Navigator.pop(context);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    User? currUser = FirebaseAuthAPI().getCurrentUser();
    String userId = currUser!.uid;
    Stream<QuerySnapshot> entryStream =
        context.watch<EntryListProvider>().entries;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(''),
        ),
        body: StreamBuilder(
            stream: entryStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error encountered! ${snapshot.error}"),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!snapshot.hasData) {
                return Center(
                  child: Text("No Todos Found"),
                );
              }
              return Center(
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
                            'Add Today\'s Entry!',
                            style: TextStyle(
                              color: AppColors.darkColor,
                              fontSize: MediaQuery.of(context).size.width *
                                  0.12, // Adjust the multiplier to achieve the desired font size
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Please tick all the symptoms that apply',
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
                    symptomsCheckbox(),
                    SizedBox(height: 30.0),
                    buildSignupButton(userId),
                  ],
                ),
              );
            }));
  }
} //branch: amante