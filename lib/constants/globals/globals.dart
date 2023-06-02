import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Globals{
  showErrorMessage(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          msg,
        )));
  }
}

class Keys{
  final String email = 'email';
  final String password = 'password';
}

class TextFieldUnFocusOnTap extends StatelessWidget {
  final Widget child;
  const TextFieldUnFocusOnTap({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: child,
    );
  }
}
