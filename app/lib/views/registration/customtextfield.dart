import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;

  final String title;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.title,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontFamily: 'GilroyLight',
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 15),
            ),
          ),
          Container(
            width: size.width * 0.8,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                border: Border.all(color: Colors.grey.shade300, width: 1)),
            child: TextFormField(
              controller: controller,
              style: const TextStyle(
                  fontFamily: 'GilroyLight',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
              decoration: InputDecoration(
                hintText: hintText,
                contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                hintStyle: const TextStyle(
                    fontFamily: 'GilroyLight',
                    color: Colors.grey,
                    fontSize: 15),
                border: InputBorder.none,
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Enter your $hintText';
                }
                return null;
              },
              maxLines: maxLines,
            ),
          ),
        ],
      ),
    );
  }
}
