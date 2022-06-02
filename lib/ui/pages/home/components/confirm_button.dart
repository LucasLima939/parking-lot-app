import 'package:flutter/material.dart';

class ConfirmButton extends StatelessWidget {
  final Future<void> Function() onTap;
  final bool isEnabled;
  const ConfirmButton({required this.isEnabled, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Theme.of(context).primaryColor.withOpacity(0.5);
                  } else {
                    return Theme.of(context).primaryColor;
                  }
                },
              ),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                // Change your radius here
                borderRadius: BorderRadius.circular(16),
              ))),
          onPressed: isEnabled ? () async => await onTap() : null,
          child: Text(
            'Confirmar',
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
