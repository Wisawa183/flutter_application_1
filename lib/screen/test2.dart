import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อมูลผู้ใช้'),
      ),
      body: Column(
        children: [
          Text(
            auth.currentUser!.email != null
                ? auth.currentUser!.email!
                : 'ไม่มีอีเมล',
          ),
        ],
      ),
    );
  }
}
