import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class AdminViewAll extends StatefulWidget {
  const AdminViewAll({super.key});

  @override
  State<AdminViewAll> createState() => _AdminViewAllState();
}

class _AdminViewAllState extends State<AdminViewAll> {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(children: [
                  Align(
                    child: Text(
                      "All Users",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  Container(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: db.collection('users').snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }

                        final List<QueryDocumentSnapshot> userDataList =
                            snapshot.data!.docs;

                        final numOfUsers = userDataList.length;

                        return Column(children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text("Number of users: $numOfUsers")),
                          ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: userDataList.length,
                            itemBuilder: (context, index) {
                              final userData = userDataList[index];
                              final userID = userData.reference.id;

                              final name = userData['name'] ?? '';
                              final userType = userData['userType'] ?? '';

                              return ListTile(
                                title: Text(name),
                                subtitle: Text(userType),
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            title: Center(child: Text(name)),
                                            content: Container(
                                                height: 230,
                                                child: Column(
                                                  children: [
                                                    Text('Name: $name\n'),
                                                    Text(
                                                        'Current Type: $userType\n'),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        try {
                                                          db
                                                              .collection(
                                                                  'users')
                                                              .doc(userID)
                                                              .update({
                                                            'userType': 'User'
                                                          });
                                                        } catch (e) {
                                                          print(
                                                              "Error setting user as entrance monitor");
                                                        }
                                                      },
                                                      child: Text("Reset User"),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        try {
                                                          db
                                                              .collection(
                                                                  'users')
                                                              .doc(userID)
                                                              .update({
                                                            'userType': 'Admin'
                                                          });
                                                        } catch (e) {
                                                          print(
                                                              "Error setting user as admin");
                                                        }
                                                      },
                                                      child:
                                                          Text("Set as Admin"),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        try {
                                                          db
                                                              .collection(
                                                                  'users')
                                                              .doc(userID)
                                                              .update({
                                                            'userType':
                                                                'Entrance Monitor'
                                                          });
                                                        } catch (e) {
                                                          print(
                                                              "Error setting user as entrance monitor");
                                                        }
                                                      },
                                                      child: Text(
                                                          "Set as Entrance Monitor"),
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
