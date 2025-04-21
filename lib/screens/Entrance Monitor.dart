import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../providers/logs_provider.dart';
import '../models/logs_model.dart';

class QRScannerPage extends StatefulWidget {
  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  Stream<QuerySnapshot> logStream = FirebaseFirestore.instance.collection("logs").snapshots();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
      ),
      body: StreamBuilder(
        stream: logStream,
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
              child: Text("No Logs Found"),
            );
          }
          return buildQRView(context);
        },
      ),
    );
  }

  Widget buildQRView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderRadius: 10,
        borderColor: Theme.of(context).primaryColor,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: 250,
      ),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      // Stop scanning
      controller.stopCamera();

      // Decode the QR code data
      String qrData = scanData.code!;

      // Display the details of the QR code in a dialog
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text('QR Code Details'),
            content: Text(qrData),
            actions: [
              ElevatedButton(
                child: Text('Add Log'),
                onPressed: () {
                  // Close the dialog
                  Navigator.of(dialogContext).pop();

                  // Add log to Firebase
                  addLogToFirebase(qrData, context);

                  // Resume scanning
                  controller.resumeCamera();
                },
              ),
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  // Close the dialog
                  Navigator.of(dialogContext).pop();

                  // Resume scanning
                  controller.resumeCamera();
                },
              ),
            ],
          );
        },
      );
    });
  }

  void addLogToFirebase(String qrData, BuildContext context) {
    // Parse the QR code data and create a Log object
    // with the required fields
    Log log = Log(
      dateTime: DateTime.now().toString(),
      location: 'Some Location', // Replace with actual location
      studNo: '123456', // Replace with actual student number
      status: 'Some Status', // Replace with actual status
      uid: 'some_uid', // Replace with actual user ID
    );
    // Add the log to Firebase
    context.read<LogListProvider>().addLog(log);
  }
}
