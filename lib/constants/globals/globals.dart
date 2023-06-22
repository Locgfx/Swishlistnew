import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swishlist/buttons/yellow_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../color.dart';

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

class AddProductImage extends StatelessWidget {
  final String image;
  final String buttonIcon;
  final String txt;
  final String buttonTxt;
  final Function() tap;

  const AddProductImage({super.key,
    required this.image,
    required this.txt,
    required this.buttonTxt,
    required this.tap, required this.buttonIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top:40.0),
    child: Center(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Image.asset(image),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 66,right: 66,top:24 ),
          child: Text(txt,
          style: AppTextStyle().roboto29292914w500,
          textAlign: TextAlign.center,),
        ),
        SizedBox(height: 40),
        SizedBox(
          height: 50.h,
          width: 1.sw,
          child: YellowButtonWithIcon(
              backgroundColor: MaterialStateProperty.all(ColorSelect.colorF7E641),
              textStyleColor: ColorSelect.color292929,
              onTap: tap,
              title: buttonTxt, buttonIcon: buttonIcon,),
        )
      ],
    )
    ),
    );
  }
}



class AddProductError extends StatelessWidget {
  final String image;
  final Function() tap;
  final Widget? addButton;

  const AddProductError({super.key, required this.image, required this.tap, this.addButton});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 60,right: 60,bottom: 12,top: 20),
          child: Image.asset(image,),
        ),
        addButton ??
        Padding(
          padding: const EdgeInsets.only(left: 16,right: 16),
          child: SizedBox(
            height: 50.h,
            width: 1.sw,
            child: YellowButtonWithIcon(
              backgroundColor: MaterialStateProperty.all(ColorSelect.colorF7E641),
              textStyleColor: ColorSelect.color292929,
              onTap: tap,
              title: "Add Product", buttonIcon: "assets/images/plus.png",),
          ),
        )

      ],
    );
  }
}
