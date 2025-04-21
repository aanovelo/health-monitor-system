// ignore_for_file: file_names, use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/appColors.dart';
import 'package:intl/intl.dart';

import '../api/firebase_auth_api.dart';

class Homepage extends StatelessWidget {
  Homepage({Key? key}) : super(key: key);

  Widget buildEntryDetailsTable(Map<String, dynamic>? todayEntry) {
  return SingleChildScrollView(
    child: DataTable(
      columns: [
        DataColumn(label: Text('Entry')),
        DataColumn(label: Text('Value')),
      ],
      rows: [
        DataRow(
          cells: [
            DataCell(Text('Fever')),
            DataCell(todayEntry?['fever'] == true ? Icon(Icons.check) : Text('')),
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text('Feeling feverish')),
            DataCell(todayEntry?['feel_fever'] == true ? Icon(Icons.check) : Text('')),
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text('Muscle or joint pains')),
            DataCell(todayEntry?['muscle_pain'] == true ? Icon(Icons.check) : Text('')),
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text('Cough')),
            DataCell(todayEntry?['cough'] == true ? Icon(Icons.check) : Text('')),
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text('Colds')),
            DataCell(todayEntry?['colds'] == true ? Icon(Icons.check) : Text('')),
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text('Sore Throat')),
            DataCell(todayEntry?['sore_throat'] == true ? Icon(Icons.check) : Text('')),
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text('Difficulty of Breathing')),
            DataCell(todayEntry?['diff_breathing'] == true ? Icon(Icons.check) : Text('')),
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text('Diarrhea')),
            DataCell(todayEntry?['diarrhea'] == true ? Icon(Icons.check) : Text('')),
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text('Loss of taste')),
            DataCell(todayEntry?['no_taste'] == true ? Icon(Icons.check) : Text('')),
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text('Loss of smell')),
            DataCell(todayEntry?['no_smell'] == true ? Icon(Icons.check) : Text('')),
          ],
        ),
        DataRow(
          cells: [
            DataCell(Text('Encounter/contact with COVID-19 case')),
            DataCell(todayEntry?['contact'] == true ? Icon(Icons.check) : Text('')),
          ],
        ),
      ],
    ),
  );
}


  Future<DocumentSnapshot<Map<String, dynamic>>?> getUserDocument(
      String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection(
                  'users') // Replace 'users' with the desired collection name
              .doc(uid) // Use the uid to retrieve the specific document
              .get();

      if (documentSnapshot.exists) {
        // Document found, you can access its data
        return documentSnapshot;
      } else {
        // Document does not exist
        return null;
      }
    } catch (e) {
      // Error occurred while fetching the document
      print('Error getting user document: $e');
      return null;
    }
  }

// Call the function within an async context
  Future<String?> fetchData(String uid) async {
    String? userType;
    DocumentSnapshot<Map<String, dynamic>>? userDocument =
        await getUserDocument(uid);
    if (userDocument != null) {
      // Document exists, you can access its data using userDocument.data()
      Map<String, dynamic> userData = userDocument.data()!;
      // Access specific fields from the userData map
      userType = userData['userType'];
      // ...
    } else {
      // Document does not exist or error occurred
    }
    return userType;
  }

// Call the fetchData function to retrieve the document

@override
Widget build(BuildContext context) {
  User? currUser = FirebaseAuthAPI().getCurrentUser();
  String userId = currUser!.uid;
  bool isTodayEntryExists = false;

  Stream<QuerySnapshot> entryStream = FirebaseFirestore.instance
      .collection('entries')
      .where('studNo', isEqualTo: userId)
      .snapshots();

  // Get today's date
  DateTime today = DateTime.now();
  String formattedToday = DateFormat('MM-dd-yyyy').format(today);

  return Scaffold(
    appBar: AppBar(
      title: const Text(''),
    ),
    body: StreamBuilder<QuerySnapshot>(
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
            child: Text("No Entries Found"),
          );
        }

        // Access the documents from the snapshot
        final List<DocumentSnapshot> entries = snapshot.data!.docs;

        // Check if today's entry exists
        String? todayEntryDate;
        Map<String, dynamic>? todayEntry;
        for (DocumentSnapshot entry in entries) {
          final entryData = entry.data() as Map<String, dynamic>?;
          final entryDate = entryData?['date'];
          if (entryDate == formattedToday) {
            isTodayEntryExists = true;
            todayEntryDate = entryDate;
            todayEntry = entryData;
            break;
          }
        }
        print(isTodayEntryExists);

        return Center(
          child: ListView(
            padding: EdgeInsets.all(30.0),
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text(
                        DateFormat('MMMM d, yyyy').format(today),
                        style: TextStyle(
                          color: AppColors.darkColor,
                          fontSize: MediaQuery.of(context).size.width * 0.065,
                        ),
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/profile', arguments: todayEntry?['status']);
                            },
                            child: Text('Profile',
                                  style: TextStyle(
                                    color: AppColors.darkColor,
                                    fontSize: MediaQuery.of(context).size.width * 0.04,
                                  ),
                                ),
                          ),
                          
                              GestureDetector(
                                onTap: () {
                                  // Handle the avatar click
                                Navigator.pushNamed(context, '/profile', arguments: todayEntry?['status']);
                                },
                                child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: AppColors.darkColor,
                                    child: Icon(
                                      Icons.person,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                              ),
                              
                        ]
                      )
                    ]),

                    Text(
                      'Welcome!',
                      style: TextStyle(
                        color: AppColors.darkColor,
                        fontSize: MediaQuery.of(context).size.width * 0.12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),
                    Text(
                      'Today\'s Entry',
                      style: TextStyle(
                        color: AppColors.darkColor,
                        fontSize: MediaQuery.of(context).size.width * 0.065,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(),

                  if (!isTodayEntryExists)
                    Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.12,
                          child: Padding(
                            key: const Key('signupButton'),
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/formentry');
                              },
                              child: Text(
                                '+ Add Today\'s Entry',
                                style: TextStyle(
                                  color: AppColors.darkColor,
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.06, // Adjust the font size as needed
                                ),
                              ),
                            ),
                          ),
                        ),


                  // Display today's entry if it exists
                  if (isTodayEntryExists)
                    Column(children: [
                      Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.darkColor,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            ListTile(
                              trailing: ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Entry Details'),
                                        content: buildEntryDetailsTable(todayEntry),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Close'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Text(
                                  'Details',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              title: Text(
                                DateFormat('MMMM d, yyyy').format(
                                  DateFormat('MM-dd-yyyy').parse(todayEntryDate!),
                                ),
                                style: TextStyle(
                                  color: AppColors.lightColor,
                                  fontSize: MediaQuery.of(context).size.width * 0.05,
                                ),
                              ),
                              subtitle: Text('Status: ${todayEntry?['status']}',
                                  style: TextStyle(
                                    color: AppColors.lightColor,
                                    fontSize: MediaQuery.of(context).size.width * 0.04,
                                  ),
                                ),

                            ),
                            // Add other entry details as desired

                          ],
                        ),
                      ),),
                            Row(
                              children: [
                                Flexible(
                                  child: Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  height: MediaQuery.of(context).size.height * 0.075,
                                  child: Padding(
                                    key: const Key('edit'),
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: ElevatedButton(
                                      onPressed: () async {

                                      },
                                      child: Text(
                                        'Edit',
                                        style: TextStyle(
                                          color: AppColors.darkColor,
                                          fontSize: MediaQuery.of(context).size.width *
                                              0.045, // Adjust the font size as needed
                                          fontWeight: FontWeight.bold, // Make the text bold
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                ),
                                Flexible(
                                  child: Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  height: MediaQuery.of(context).size.height * 0.075,
                                  child: Padding(
                                    key: const Key('signupButton'),
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: ElevatedButton(
                                      onPressed: () async {

                                      },
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(
                                          color: AppColors.darkColor,
                                          fontSize: MediaQuery.of(context).size.width *
                                              0.045, // Adjust the font size as needed
                                          fontWeight: FontWeight.bold, // Make the text bold
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                ),
                              ]
                            ),

            ],),


                    Text(
                      'History',
                      style: TextStyle(
                        color: AppColors.darkColor,
                        fontSize: MediaQuery.of(context).size.width * 0.065,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),

              // Display history entries (excluding today's entry)
              ListView.builder(
                shrinkWrap: true,
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  final entryData = entries[index].data() as Map<String, dynamic>;
                  final entryDate = entryData['date'];

                  // Skip today's entry
                  if (entryDate == formattedToday) {
                    return SizedBox.shrink();
                  }

                  final entryStatus = entryData['status'];

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColors.darkColor,
                      ),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          ListTile(
                            trailing: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Entry Details'),
                                      content: buildEntryDetailsTable(entryData),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Close'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Text(
                                'Details',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            title: Text(
                              DateFormat('MMMM d, yyyy').format(
                                DateFormat('MM-dd-yyyy').parse(entryDate),
                              ),
                              style: TextStyle(
                                color: AppColors.lightColor,
                                fontSize: MediaQuery.of(context).size.width * 0.05,
                              ),
                            ),
                            subtitle: Text('Status: $entryStatus',
                              style: TextStyle(
                                color: AppColors.lightColor,
                                fontSize: MediaQuery.of(context).size.width * 0.04,
                              ),
                            ),
                          ),
                          // Add other entry details as desired
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    ),
  );
}
}
