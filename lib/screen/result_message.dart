import 'package:flutter/material.dart';

import 'const.dart';

class ResultMessage extends StatelessWidget {
  final String message;
  final VoidCallback onTep;
  final IconData;

  const ResultMessage({
    Key? key,
    required this.message,
    required this.onTep,
    required this.IconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepPurple,
      content: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              message,
              style: whiteTextStyle,
            ),
            GestureDetector(
              onTap: onTep,
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: Colors.deepPurple[300],
                    borderRadius: BorderRadius.circular(8)),
                child: Icon(
                  IconData,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
