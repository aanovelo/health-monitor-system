import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminViewQuarantined extends StatefulWidget {
  const AdminViewQuarantined({super.key});

  @override
  State<AdminViewQuarantined> createState() => _AdminViewQuarantinedState();
}

class _AdminViewQuarantinedState extends State<AdminViewQuarantined> {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Align(
                child: Text(
                  "Quarantined Students",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                alignment: Alignment.topLeft,
              ),
              Container(
                child: StreamBuilder<QuerySnapshot>(
                  stream: db
                      .collection('users')
                      .where('status', isEqualTo: "Under Quarantine")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: $snapshot.error');
                    } else if (snapshot.hasData) {
                      final List<QueryDocumentSnapshot> userDataList =
                          snapshot.data!.docs;

                      final numOfStudents = userDataList.length;

                      if (userDataList.isEmpty) {
                        return Text("No Quarantined students");
                      } else {
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
                              final status = userData['status'] ?? '';

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
                                                height: 300,
                                                child: Column(
                                                  children: [
                                                    Text('Name: $name\n'),
                                                    Text('Email: $email\n'),
                                                    Text(
                                                        'Student Number: $studNo\n'),
                                                    Text('College: $college\n'),
                                                    Text('Course: $course\n'),
                                                    Text('Status: $status\n'),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        try {
                                                          db
                                                              .collection(
                                                                  'users')
                                                              .doc(userID)
                                                              .update({
                                                            'status': 'Cleared'
                                                          });
                                                        } catch (e) {
                                                          print(
                                                              "Error removing the student from Quarantine");
                                                        }
                                                      },
                                                      child: Text(
                                                          "End Quarantine"),
                                                    ),
                                                  ],
                                                )));
                                      });
                                },
                              );
                            },
                          )
                        ]);
                      }
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
