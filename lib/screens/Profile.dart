import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../models/appColors.dart';

import '../api/firebase_auth_api.dart';
import '../providers/auth_provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  String receivedString = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    receivedString = ModalRoute.of(context)?.settings.arguments as String? ?? '';
  }

  Map<String, dynamic> userDetails = {};

  String generateQrData(Map<String, dynamic> userDetails) {
    String data = '';
    userDetails.forEach((key, value) {
      data += '$key: $value\n';
    });
    return data;
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

  Future<Map<String, dynamic>?> fetchData(String uid) async {
    DocumentSnapshot<Map<String, dynamic>>? userDocument =
        await getUserDocument(uid);
    if (userDocument != null) {
      // Document exists, you can access its data using userDocument.data()
      Map<String, dynamic> userData = userDocument.data()!;
      return userData;
    } else {
      // Document does not exist or error occurred
      return null;
    }
  }

  Future<String?> fetchInfo(String uid, String docInfo) async {
    Map<String, dynamic>? userData = await fetchData(uid);
    if (userData != null) {
      // Access specific field from the userData map
      return userData[docInfo];
    } else {
      // Document does not exist or error occurred
      return null;
    }
  }

  Widget buildInfoRow(
      String labelText, IconData icon, Future<String?> futureData) {
    return FutureBuilder<String?>(
      future: futureData,
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          String? data = snapshot.data;

          return Row(
              children: [
                Flexible(
                  child: Icon(icon,
                    size: 40,
                    color: AppColors.darkColor),
                ),
                
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                ),
                Text(data ?? '', style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05)),
              ],
            );
        }
      },
    );
  }

    Widget generateLogout() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.075,
      child: Padding( 
        key: const Key('signupButton'),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ElevatedButton(
          onPressed: () {
            context.read<AuthProvider>().signOut();
            Navigator.pushNamed(context, '/');
          },
          child: Text(
            'LOGOUT',
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

  Widget generateButton() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.075,
      child: Padding( 
        key: const Key('signupButton'),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ElevatedButton(
          onPressed: () {
            _showDialog();
          },
          child: Text(
            'GENERATE QR',
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

    void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (receivedString == 'Cleared') {
          return AlertDialog(
            title: Text('Generate QR'),
            content: SizedBox(
            width: 300,
            height: 300,
            child: QrImageView(
              data: generateQrData(userDetails),
              version: QrVersions.auto,
              size: 300,
              gapless: false,
            ),
          ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back'),
              ),
            ],
          );
        } else {
          return AlertDialog(
            title: Text('Generate QR'),
            content: Text("User Disabled to Generate QR"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back'),
              ),
            ],
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    User? currUser = FirebaseAuthAPI().getCurrentUser();
    String userId = currUser!.uid;
    fetchData(userId).then((userData) {
      if (userData != null) {
        setState(() {
          userDetails["name"] = userData["name"];
          userDetails["username"] = userData["username"];
          userDetails["studentNo"] = userData["studNo"];
          userDetails["course"] = userData["course"];
          userDetails["college"] = userData["college"];
          userDetails["email"] = userData["email"];
          userDetails["status"] = userData["status"];
          userDetails["uid"] = userId;
        });
      } else {
        // Document does not exist or error occurred
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body:userDetails.isEmpty // Check if userDetails is empty
        ? Center(child: CircularProgressIndicator()) // Show loading indicator
        : Center(
          child: Padding(
            padding: EdgeInsets.all(50.0),
            child: Column (children: <Widget>[
                        Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: AppColors.darkColor,
                  child: Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
                Text(
                  userDetails["name"] ?? '',
                  style: TextStyle(
                    color: AppColors.darkColor,
                    fontSize: MediaQuery.of(context).size.width * 0.09, // Adjust the multiplier to achieve the desired font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
                  Text(
                    '@${userDetails["username"]}' ?? '',
                    style: TextStyle(
                      color: AppColors.darkColor,
                      fontSize: MediaQuery.of(context).size.width * 0.07, // Adjust the multiplier to achieve the desired font size
                    ),
                  ),
              ],
            ),
          ),
              Expanded(
                child: SizedBox(height: 1),
              ),
              Expanded(
                child: buildInfoRow('College', Icons.business, fetchInfo(userDetails["uid"], 'college'),),
              ),
              Expanded( child: Divider()),
              Expanded(
                child: buildInfoRow('Course', Icons.school, fetchInfo(userDetails["uid"], 'course'),),
              ),
              Expanded( child: Divider()),
              Expanded(
                child: buildInfoRow('Student No.',Icons.assignment_ind,fetchInfo(userDetails["uid"], 'studNo'),),
              ),
              Expanded( child: Divider()),
              Expanded(
                child: buildInfoRow('Email', Icons.email, fetchInfo(userDetails["uid"], 'email'),),
              ),
              Expanded(
                child: SizedBox(height: 30),
              ),
              generateButton(),
              generateLogout(),
            ],
            ),
          ),
        ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: AppColors.darkColor,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Homepage'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/homepage');
              },
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Sign Out'),
              onTap: () {
                context.read<AuthProvider>().signOut();
                Navigator.pop(context);
              },
            ),            
          ],
        ),
      ),
    );
  }
}
