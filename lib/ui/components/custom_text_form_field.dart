import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final void Function(String)? onChanged;
  final String title;
  const CustomTextFormField({
    Key? key,
    required this.onChanged,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: title,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(),
            ),
          )),
    );
  }
}
