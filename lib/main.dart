
import 'package:amante_contaoi_novelo_olipas/screens/Admin.dart';
import 'package:amante_contaoi_novelo_olipas/screens/Homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/screens/Profile.dart';
import '/screens/formEntry.dart';

import 'package:firebase_core/firebase_core.dart';
import 'providers/entry_provider.dart';
import 'screens/role_page.dart';
import 'firebase_options.dart';
import '../providers/auth_provider.dart';
import 'providers/logs_provider.dart';
import '/screens/Profile.dart';
import 'package:provider/provider.dart';
import '/screens/formEntry.dart';
import 'screens/StudentLogs.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/Entrance Monitor.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,

  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => EntryListProvider())),
        ChangeNotifierProvider(create: ((context) => LogListProvider())),
        ChangeNotifierProvider(create: ((context) => AuthProvider())),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OHMS',
      initialRoute: '/',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 58, 183, 83)),
        useMaterial3: true,
      ),
      
      routes: {
        '/': (context) => const RolePage(),
        '/profile': (context) => Profile(),
        '/homepage': (context) => Homepage(),
        '/formentry': (context) => FormEntryPage(),
        '/admin':(context) => Admin(),
        '/entrance':(context) => QRScannerPage(),
        '/logs':(context) => StudentLogs()
      },

    );
  }
}
