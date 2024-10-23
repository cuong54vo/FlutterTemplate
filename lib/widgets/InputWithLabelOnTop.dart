import 'package:flutter/material.dart';

class InputWithLabelOnTop extends StatelessWidget {
  final String title;
  final bool isRequired;

  const InputWithLabelOnTop({
    Key? key,
    required this.title,
    this.isRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title + (isRequired ? ' *' : ''),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter $title',
          ),
        ),
      ],
    );
  }
}
