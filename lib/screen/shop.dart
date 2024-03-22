import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/test.dart';

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ข้อมูลผู้ใช้'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(auth.currentUser!.uid)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('เกิดข้อผิดพลาด: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                var userData = <String, dynamic>{};
                if (snapshot.data != null && snapshot.data!.exists) {
                  userData = snapshot.data!.data() as Map<String, dynamic>;
                }
                var coins = userData['Coins'];

                return Text(
                  'Coins: $coins',
                  style: TextStyle(fontSize: 20),
                );
              },
            ),
            SizedBox(height: 20), // เพิ่มระยะห่างระหว่างปุ่มด้วย SizedBox
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyWidget(),
                  ),
                );
              },
              child: Text('go'),
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('questions')
                    .get()
                    .then((querySnapshot) {
                  querySnapshot.docs.forEach((doc) {
                    print('Question ID: ${doc.id}');
                    print('Question: ${doc['question']}');
                    print('Choices: ${doc['choices']}');
                    print('Answer: ${doc['answer']}');
                  });
                }).catchError((error) {
                  print("Failed to get questions: $error");
                });
              },
              child: Text('test'),
            ),
          ],
        ),
      ),
    );
  }
}
