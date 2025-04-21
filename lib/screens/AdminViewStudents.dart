import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import 'AdminViewMonitored.dart';
import 'AdminViewQuarantined.dart';

class AdminViewStudents extends StatefulWidget {
  const AdminViewStudents({super.key});

  @override
  State<AdminViewStudents> createState() => _AdminViewStudentsState();
}

class _AdminViewStudentsState extends State<AdminViewStudents> {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //   body: ListView.builder(
        //     itemCount: students.length,
        //     itemBuilder: (BuildContext context, int index) {
        //       final student = students[index];
        //       final date = student['date'];
        //       final name = student['name'];
        //       final studno = student['studno'];
        //       final college = student['college'];
        //       final course = student['course'];
        //       return ListTile(
        //         trailing: TextButton(
        //           onPressed: () {
        //             showDialog(
        //                 context: context,
        //                 builder: (BuildContext context) {
        //                   return AlertDialog(
        //                     title: const Text("Student Details"),
        //                     content: Container(
        //                       height: 130,
        //                       child: Column(
        //                         children: [
        //                           Text(
        //                               'Name: $name\nStudent number: $studno\nCollege: $college\nCourse: $course'),
        //                           TextButton(
        //                               onPressed: () {},
        //                               child: Text("Add to Quarantined"))
        //                         ],
        //                       ),
        //                     ),
        //                     actions: [
        //                       TextButton(
        //                         onPressed: () {
        //                           Navigator.of(context).pop();
        //                         },
        //                         child: const Text("Close"),
        //                       )
        //                     ],
        //                   );
        //                 });
        //           },
        //           child: const Text("Details"),
        //         ),
        //         title: Text("$name"),
        //         subtitle: Text("$date"),
        //       );
        //     },
        //   ),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(children: [
                  Align(
                    child: Text(
                      "Students",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  Container(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: db
                          .collection('users')
                          .where('userType', isEqualTo: "User")
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }

                        final List<QueryDocumentSnapshot> userDataList =
                            snapshot.data!.docs;

                        final numOfStudents = userDataList.length;

                        return Column(children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child:
                                  Text("Number of students: $numOfStudents")),
                          ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: userDataList.length,
                            itemBuilder: (context, index) {
                              final userData = userDataList[index];
                              final userID = userData.reference.id;

                              final name = userData['name'] ?? '';
                              final studNo = userData['studNo'] ?? '';
                              final email = userData['email'] ?? '';
                              final college = userData['college'] ?? '';
                              final course = userData['course'] ?? '';
                              //final status = userData['status'] ?? '';

                              return ListTile(
                                title: Text(name),
                                subtitle: Text(studNo),
                                trailing: Text(email),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            title: Center(child: Text(name)),
                                            content: Container(
                                                height: 250,
                                                child: Column(
                                                  children: [
                                                    Text('Name: $name\n'),
                                                    Text('Email: $email\n'),
                                                    Text(
                                                        'Student Number: $studNo\n'),
                                                    Text('College: $college\n'),
                                                    Text('Course: $course\n'),
                                                    //Text('Status: $status\n'),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        try {
                                                          db
                                                              .collection(
                                                                  'users')
                                                              .doc(userID)
                                                              .update({
                                                            'status':
                                                                'Under Quarantine'
                                                          });
                                                        } catch (e) {
                                                          print(
                                                              "Error removing the student from Quarantine");
                                                        }
                                                      },
                                                      child: Text(
                                                          "Move to Quarantine"),
                                                    ),
                                                  ],
                                                )));
                                      });
                                },
                              );
                            },
                          ),
                        ]);
                      },
                    ),
                  )
                ]))));
  }
}
