// ignore_for_file: file_names
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Color? color;
  final String? label;
  final Color? textColor;
  final VoidCallback? buttonTapped;

  const MyButton({
    Key? key,
    this.color,
    this.label,
    this.textColor,
    this.buttonTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: buttonTapped,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                label!,
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
