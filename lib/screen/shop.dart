import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/test.dart';

class shop extends StatefulWidget {
  const shop({super.key});

  @override
  State<shop> createState() => _shopState();
}

class _shopState extends State<shop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
    );
  }
}
