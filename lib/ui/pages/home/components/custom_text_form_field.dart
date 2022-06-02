import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class CustomTextFormField extends StatelessWidget {
  final void Function(String) onChanged;
  final String title;
  final TextEditingController controller = TextEditingController();
  CustomTextFormField({
    Key? key,
    required this.onChanged,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
          textCapitalization: TextCapitalization.characters,
          onChanged: onChanged,
          autocorrect: false,
          inputFormatters: [MaskedInputFormatter('####-####')],
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
