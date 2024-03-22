import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/test.dart';

class shop extends StatefulWidget {
  const shop({super.key});

  @override
  State<shop> createState() => _shopState();
}

final auth = FirebaseAuth.instance;

class _shopState extends State<shop> {
  var coins;
  @override
  void initState() {
    coins = getCoins();
  }

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
          FutureBuilder<int?>(
            future: coins,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While data is still loading, show a loading indicator or a placeholder
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // If an error occurred while fetching data, display an error message
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                // If data is successfully fetched, display the coins value
                return Text(snapshot.data.toString());
              } else {
                // If no data is available, display a placeholder or a message
                return Text('No data');
              }
            },
          ),
          Center(
            child: ElevatedButton(
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
          ),
          Center(
            child: ElevatedButton(
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
          ),
        ],
      ),
    );
  }

  Future<String?> getDocumentId() async {
    try {
      String? userId;
      String? userEmail = FirebaseAuth.instance.currentUser?.email;
      String? userUID = FirebaseAuth.instance.currentUser?.uid;

      if (userEmail != null) {
        // Query the collection for the user with the specified email
        var querySnapshot = await FirebaseFirestore.instance
            .collection('Profile')
            .where('Email', isEqualTo: userEmail)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          // If the user with the specified email exists, get their document ID
          userId = querySnapshot.docs.first.id;
        }
      } else if (userUID != null) {
        // Query the collection for the user with the specified UID
        var querySnapshot = await FirebaseFirestore.instance
            .collection('Profile')
            .where('Email', isEqualTo: userEmail)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          // If the user with the specified UID exists, get their document ID
          userId = querySnapshot.docs.first.id;
        }
      }
      return userId;
    } catch (e) {
      print('Error getting document ID: $e');
      return null;
    }
  }

  Future<int?> getCoins() async {
    var docID = await getDocumentId();
    print(docID);
    try {
      // Get the document reference using docID
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('Profile').doc(docID);

      // Get the document snapshot
      DocumentSnapshot snapshot = await documentReference.get();

      // Check if the document exists and has the "coins" field
      if (snapshot.exists && snapshot.data() != null) {
        // Cast the data to Map<String, dynamic>
        var data = snapshot.data() as Map<String, dynamic>?;

        // Check if the data is not null and contains the "Coins" field
        if (data != null && data.containsKey('Coins')) {
          // Access the value of "Coins" field
          int coins = data['Coins'];

          // Return the coins value
          print(coins);
          return coins;
        } else {
          // Document does not have "Coins" field
          print("Document does not have 'Coins' field.");
          return null;
        }
      } else {
        // Document does not exist
        print("Document does not exist.");
        return null;
      }
    } catch (e) {
      print('Error getting coins: $e');
      return null;
    }
  }
}
