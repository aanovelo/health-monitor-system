import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/logs_provider.dart';

class StudentLogs extends StatefulWidget {
  @override
  _StudentLogsState createState() => _StudentLogsState();
}

class _StudentLogsState extends State<StudentLogs> {
  Stream<QuerySnapshot> logStream =
      FirebaseFirestore.instance.collection("logs").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Logs'),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: logStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Data is available, you can access the logs using snapshot.data!
            List<DocumentSnapshot> logs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: logs.length,
              itemBuilder: (context, index) {
                final log = logs[index].data() as Map<String, dynamic>;
                return ListTile(
                  title: Text('Date: ${log['date']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text('Time: ${log['time']}'),
                      // Text('Location: ${log['location']}'),
                      // Text('Student No.: ${log['studNo']}'),
                      // Text('Status: ${log['status']}'),
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Student Details'),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Name: Dummy Name'),
                                Text('Username: dummyUsername'),
                                Text('Email: dummy@example.com'),
                                Text('Student No.: ${log['studNo']}'),
                                Text('Course: BS Computer Science'),
                                Text('College: College of Arts and Sciences'),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('View'),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            // Error occurred while fetching the logs
            return Text('Error: ${snapshot.error}');
          } else {
            // Loading state
            return CircularProgressIndicator();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/entrance');
        },
        child: Icon(Icons.qr_code),
      ),
    );
  }
}
