import 'package:amante_contaoi_novelo_olipas/models/appColors.dart';
import 'package:amante_contaoi_novelo_olipas/screens/AdminViewAll.dart';
import 'package:amante_contaoi_novelo_olipas/screens/AdminViewStudents.dart';
import 'package:flutter/material.dart';

import 'package:amante_contaoi_novelo_olipas/screens/AdminViewMonitored.dart';
import 'package:amante_contaoi_novelo_olipas/screens/AdminViewQuarantined.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  int _selectedIndex = 0;

  void onTabChosen(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _children = [
    AdminViewAll(),
    AdminViewStudents(),
    AdminViewQuarantined(),
    AdminViewMonitored(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Dashboard")),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () {
              context.read<AuthProvider>().signOut();
              Navigator.pushNamed(context, '/');            },
          ),
        ],
      )),
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabChosen,
        fixedColor: AppColors.darkColor,
        unselectedItemColor: Color.fromARGB(100, 42, 142, 127),
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.groups), label: "All Users"),
          BottomNavigationBarItem(
              icon: Icon(Icons.school), label: "All Students"),
          BottomNavigationBarItem(
              icon: Icon(Icons.masks), label: "Quarantined"),
          BottomNavigationBarItem(
              icon: Icon(Icons.sensor_occupied), label: "Under Monitoring"),
        ],
      ),
    );
  }
}
