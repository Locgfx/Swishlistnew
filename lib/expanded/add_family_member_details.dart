import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swishlist/buttons/light_yellow.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/expanded/added.dart';

class AddFamilyMemberDetails extends StatefulWidget {
  const AddFamilyMemberDetails({Key? key}) : super(key: key);

  @override
  State<AddFamilyMemberDetails> createState() => _AddFamilyMemberDetailsState();
}

class _AddFamilyMemberDetailsState extends State<AddFamilyMemberDetails> {
  String dropdownValue = 'One';
  String? newValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Text(
              "Member’s details",
              style: AppTextStyle().textColor29292916w500,
            ),
          ],
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Image.asset('assets/images/Vector190.png'),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 52.h,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        child: LightYellowButtonWithText(
          backgroundColor: MaterialStateProperty.all(ColorSelect.colorFCF5B6),
          textStyleColor: ColorSelect.colorB5B07A,
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Added()));
          },
          title: 'Add',
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text(
                "Enter family member details",
                style: AppTextStyle().textColor29292924w700,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Text(
                "Fill the following details so that you can start \n        managing account for them.",
                style: AppTextStyle().textColor70707012w400,
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            SizedBox(
              height: 100,
              width: 100,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    backgroundImage:
                        AssetImage('assets/images/Frame1000002321.png'),
                  ),
                  Positioned(
                      top: 60,
                      right: 0.0,
                      child: Image.asset('assets/images/Frame1000003.png'))
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: 52.h,
              width: 328.w,
              decoration: BoxDecoration(
                  color: ColorSelect.colorEDEDF1,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: "Enter name"),
                  keyboardType: TextInputType.name,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Container(
              height: 52.h,
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: ColorSelect.colorEDEDF1,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    'Select relationship',
                    style: AppTextStyle().textColor70707014w400,
                  ),
                ),
                icon: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Image.asset('assets/images/Vector123.png'),
                ),
                iconSize: 24,
                elevation: 0,
                underline: SizedBox(),
                items: <String>['Father', 'Mother', 'Brother', 'Child']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
