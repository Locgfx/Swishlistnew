import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swishlist/buttons/yellow_button.dart';

import '../constants/color.dart';

class RequestSent extends StatefulWidget {
  final String name;
  const RequestSent({Key? key, required this.name}) : super(key: key);

  @override
  State<RequestSent> createState() => _RequestSentState();
}

class _RequestSentState extends State<RequestSent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        height: 52.h,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        child: YellowButtonWithText(
          backgroundColor: MaterialStateProperty.all(ColorSelect.colorF7E641),
          textStyleColor: ColorSelect.color292929,
          onTap: () {
            int count = 0;
            Navigator.of(context).popUntil((_) => count++ >= 3);
          },
          title: 'Done',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 1.sh /*- 102*/,
              width: 1.sw,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 50,
                    right: 0,
                    child: Image.asset(
                      "assets/images/Rectangle1094.png",
                      height: 53.h,
                    ),
                  ),
                  Positioned(
                    top: 100,
                    right: -50,
                    child: Image.asset(
                      "assets/images/Rectangle1096.png",
                      height: 53.h,
                    ),
                  ),
                  Positioned(
                    top: 60,
                    child: Image.asset(
                      'assets/images/image45.png',
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 100,
                    child: Image.asset(
                      'assets/images/Rectangle1095.png',
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 180),
                        child: Text(
                          "Family Member added",
                          style: AppTextStyle().textColor29292924w700,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          "Once this person accepts your request, you will\nbe notified.",
                          textAlign: TextAlign.center,
                          style: AppTextStyle().textColor70707012w400,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 25,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 24,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: ColorSelect.colorE0E0E0),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              offset: Offset(8, 8),
                              spreadRadius: 0,
                              blurRadius: 48,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // CircleAvatar(
                            //   radius: 20,
                            //   backgroundColor: Colors.grey,
                            //   backgroundImage:
                            //       AssetImage('assets/images/Rectangle319.png'),
                            // ),
                            SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.name,
                                  style: AppTextStyle().textColor29292914w500,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Successfully Added",
                                  style: AppTextStyle().textColor3EA55514w400,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
