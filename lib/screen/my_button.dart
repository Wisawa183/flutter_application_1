import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String child;
  final VoidCallback onTap;
  var buttonColor = Colors.deepPurple[400];

  MyButton({
    Key? key,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  get whiteTextStyle => const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 32, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    if (child == 'C') {
      buttonColor = Colors.green;
    } else if (child == 'DEL') {
      buttonColor = Colors.red;
    } else if (child == '=') {
      buttonColor = Colors.deepPurple;
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              child,
              style: whiteTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
