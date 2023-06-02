
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:swishlist/buttons/light_yellow.dart';
import 'package:swishlist/profile_page/pets.dart';
import 'package:swishlist/profile_page/widgets/date_picker.dart';
import 'dart:io';
import '../../constants/color.dart';
import '../api/user_apis/event_date_api.dart';
import '../api/user_apis/pets_api.dart';

class AddDateAndEvents extends StatefulWidget {
  const AddDateAndEvents({Key? key}) : super(key: key);

  @override
  State<AddDateAndEvents> createState() => _AddDateAndEventsState();
}

class _AddDateAndEventsState extends State<AddDateAndEvents> {
  final nameController = TextEditingController();
  final typeController = TextEditingController();
  final dateController = TextEditingController();
  String dateFormat ='';
  // final privacyController = TextEditingController();
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(children: [
          Text(
            "Event and Dates",
            style: AppTextStyle().textColor29292916w500,
          ),
        ]),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset('assets/images/Vector190.png')
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Enter details",
                  style: AppTextStyle().textColor29292924w700,
                ),
                SizedBox(height: 8,),
                // Text(
                //   "Fill the details of product you own already.",
                //   style: AppTextStyle().textColor70707014w400,
                // ),
                SizedBox(height: 28,),
                SizedBox(height: 20),
                Container(
                  width: 328.w,
                  height: 52.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorSelect.colorEDEDF1,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onChanged: (v) {
                              setState(() {});
                            },
                            controller: nameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Name of event",
                                hintStyle: AppTextStyle().textColor70707014w400
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  width: 328.w,
                  height: 52.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ColorSelect.colorEDEDF1
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onTap:() {
                              showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                  ),
                                  context: context,
                                  builder: (context) => EventTypeBottomSheet(
                                    eventType: typeController.text,
                                    onPop: (val) {
                                      setState(() {
                                        typeController.text = val;
                                      });
                                    },
                                  ));

                            },
                            onChanged: (v) {
                              setState(() {});
                            },
                            controller: typeController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Type of the Event",
                                hintStyle: AppTextStyle().textColor70707014w400,
                                suffixIconConstraints: BoxConstraints(maxHeight: 40,maxWidth: 40),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: Image.asset('assets/images/down-arrow.png',height: 25,),
                                )
                            ),
                            keyboardType: TextInputType.text,
                            readOnly: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  width: 328.w,
                  height: 52.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ColorSelect.colorEDEDF1
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onChanged: (v) {
                              setState(() {

                              });
                            },
                            controller: dateController,
                            keyboardType: TextInputType.text,
                            readOnly: true,
                            onTap: ()  {
                              setState(() async {
                                DateTime? pickedDate = await showDialog(
                                  context: context,
                                  builder: (_) => DatePickerWidget(onPop: (date) {
                                    dateController.text=DateFormat.yMMMd().format(date);
                                    dateFormat = DateFormat('yyyy-MM-dd').format(date) ;
                                  }, maximumDate: 2030,
                                  ),
                                );
                              });
                              //
                              // DateTime? pickedDate = await showDatePicker(
                              //     context: context,
                              //     initialDate: DateTime.now(),
                              //     firstDate: DateTime(1950),
                              //     //DateTime.now() - not to allow to choose before today.
                              //     lastDate: DateTime(2100));
                              //
                              // if (pickedDate != null) {
                              //   print(
                              //       pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              //   String formattedDate =
                              //   DateFormat('yyyy-MM-dd').format(pickedDate);
                              //   print(
                              //       formattedDate); //formatted date output using intl package =>  2021-03-16
                              //   setState(() {
                              //     dateController.text =
                              //         formattedDate; //set output date to TextField value.
                              //   });
                              // } else {}
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Date Purchased",
                                hintStyle: AppTextStyle().textColor70707014w400,
                                suffixIcon:
                                Image.asset("assets/images/calendarimg.png")),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 56),
                SizedBox(
                  width: 328.w,
                  height: 52.h,
                  child: /*isLoading ?
                  LoadingLightYellowButton():*/
                  LightYellowButtonWithText(
                    onTap: () {
                      if(nameController.text.isNotEmpty &&
                      typeController.text.isNotEmpty &&
                      dateController.text.isNotEmpty) {
                        postDateAndEventApi(
                            name: nameController.text,
                            date: dateFormat,
                            type: typeController.text,
                            privacy: 'public').then((value) async {
                              if(value['status'] == true) {
                                Fluttertoast.showToast(msg: value['message']);
                              } else {
                                Fluttertoast.showToast(msg: value['message']);
                              }
                        });
                      }


                    },
                    backgroundColor:(
                        nameController.text.isNotEmpty &&
                            typeController.text.isNotEmpty ||
                            dateController.text.isNotEmpty
                    ) ? MaterialStateProperty.all(ColorSelect.colorF7E641)
                        : MaterialStateProperty.all(ColorSelect.colorFCF5B6),
                    textStyleColor: nameController.text.isNotEmpty &&
                        typeController.text.isNotEmpty ||
                        dateController.text.isNotEmpty ?
                    Colors.black :
                    ColorSelect.colorB5B07A,
                    title: 'Add',
                  ),
                ),
                SizedBox(height: 24)
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class EventTypeBottomSheet extends StatefulWidget {
  final String eventType;
  final Function(String) onPop;
  const EventTypeBottomSheet(
      {Key? key, required this.eventType, required this.onPop})
      : super(key: key);

  @override
  State<EventTypeBottomSheet> createState() => _EventTypeBottomSheet();
}

class _EventTypeBottomSheet extends State<EventTypeBottomSheet> {
  int _gIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          // color: k006D77,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        // height: 259.h,
        child: Column(
          children: [
            Container(
              height: 71.h,
              decoration: const BoxDecoration(
                color: ColorSelect.colorF7E641,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Center(
                child: Text(
                  'Select Puppy Type',
                  // style: kManRope_700_20_white,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20.h),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => setState(() {
                      _gIndex = 0;
                      Navigator.of(context).pop();
                      widget.onPop("all");
                    }),
                    child: Container(
                      height: 44.h,
                      width: 78.w,
                      decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(5)),
                        color: _gIndex == 0 ? ColorSelect.colorF7E641 : Colors.transparent,
                      ),
                      child: Center(
                          child: Text(
                            'all',
                            // style: _gIndex == 0
                            //     ? textColorF7E64114w400
                            //     : ColorSelect.colorF7E641
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  GestureDetector(
                    onTap: () => setState(() {
                      _gIndex = 1;
                      Navigator.of(context).pop();
                      widget.onPop("upcoming");
                    }),
                    child: Container(
                      height: 44.h,
                      width: 78.w,
                      decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(5)),
                        color: _gIndex == 1 ? ColorSelect.colorF7E641 : Colors.transparent,
                      ),
                      child: Center(
                          child: Text(
                            'upcoming',
                            // style: _gIndex == 1
                            //     ? kManRope_500_16_white
                            //     : kManRope_500_16_626A6A,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    if (widget.eventType == "all") {
      _gIndex = 0;
    } /*else if (widget.eventType == "upcoming") {
      _gIndex = 1;
    }*/ else {
      _gIndex = 2;
    }
    super.initState();
  }
}


class PetOriginBottomSheet extends StatefulWidget {
  final String puppyOrigin;
  final Function(String) onPop;
  const PetOriginBottomSheet(
      {Key? key, required this.puppyOrigin, required this.onPop})
      : super(key: key);

  @override
  State<PetOriginBottomSheet> createState() => _PetOriginBottomSheet();
}

class _PetOriginBottomSheet extends State<PetOriginBottomSheet> {
  int _gIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          // color: k006D77,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        // height: 259.h,
        child: Column(
          children: [
            Container(
              height: 71.h,
              decoration: const BoxDecoration(
                color: ColorSelect.colorF7E641,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Center(
                child: Text(
                  'Select Puppy Origin',
                  // style: kManRope_700_20_white,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20.h),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => setState(() {
                      _gIndex = 0;
                      Navigator.of(context).pop();
                      widget.onPop("American");
                    }),
                    child: Container(
                      height: 44.h,
                      width: 78.w,
                      decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(5)),
                        color: _gIndex == 0 ?
                        ColorSelect.colorF7E641 :
                        Colors.transparent,
                      ),
                      child: Center(
                          child: Text(
                            'American',
                            // style: _gIndex == 0
                            //     ? textColorF7E64114w400
                            //     : ColorSelect.colorF7E641
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  GestureDetector(
                    onTap: () => setState(() {
                      _gIndex = 1;
                      Navigator.of(context).pop();
                      widget.onPop("chinese");
                    }),
                    child: Container(
                      height: 44.h,
                      width: 78.w,
                      decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(5)),
                        color: _gIndex == 1 ? ColorSelect.colorF7E641 : Colors.transparent,
                      ),
                      child: Center(
                          child: Text(
                            'chinese',
                            // style: _gIndex == 1
                            //     ? kManRope_500_16_white
                            //     : kManRope_500_16_626A6A,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  GestureDetector(
                    onTap: () => setState(() {
                      _gIndex = 2;
                      Navigator.of(context).pop();
                      widget.onPop("Indian");
                    }),
                    child: Container(
                      height: 44.h,
                      width: 78.w,
                      decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(5)),
                        color: _gIndex == 2 ? ColorSelect.colorF7E641 : Colors.transparent,
                      ),
                      child: Center(
                          child: Text(
                            'Indian',
                            // style: _gIndex == 2
                            //     ? kManRope_500_16_white
                            //     : kManRope_500_16_626A6A,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    if (widget.puppyOrigin == "American") {
      _gIndex = 0;
    } else if (widget.puppyOrigin == "chinese") {
      _gIndex = 1;
    } else {
      _gIndex = 2;
    }
    super.initState();
  }
}


class PrivacyStatusBottomSheet extends StatefulWidget {
  final String privacyStatus;
  final Function(String) onPop;
  const PrivacyStatusBottomSheet(
      {Key? key, required this.privacyStatus, required this.onPop})
      : super(key: key);

  @override
  State<PrivacyStatusBottomSheet> createState() => _PrivacyStatusBottomSheet();
}

class _PrivacyStatusBottomSheet extends State<PrivacyStatusBottomSheet> {
  int _gIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          // color: k006D77,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        // height: 259.h,
        child: Column(
          children: [
            Container(
              height: 71.h,
              decoration: const BoxDecoration(
                color: ColorSelect.colorF7E641,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Center(
                child: Text(
                  'Select Privacy Status',
                  // style: kManRope_700_20_white,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20.h),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => setState(() {
                      _gIndex = 0;
                      Navigator.of(context).pop();
                      widget.onPop("private");
                    }),
                    child: Container(
                      height: 44.h,
                      width: 78.w,
                      decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(5)),
                        color: _gIndex == 0 ? ColorSelect.colorF7E641 : Colors.transparent,
                      ),
                      child: Center(
                          child: Text(
                            'private',
                            // style: _gIndex == 0
                            //     ? textColorF7E64114w400
                            //     : ColorSelect.colorF7E641
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  GestureDetector(
                    onTap: () => setState(() {
                      _gIndex = 1;
                      Navigator.of(context).pop();
                      widget.onPop("friend");
                    }),
                    child: Container(
                      height: 44.h,
                      width: 78.w,
                      decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(5)),
                        color: _gIndex == 1 ? ColorSelect.colorF7E641 : Colors.transparent,
                      ),
                      child: Center(
                          child: Text(
                            'friend',
                            // style: _gIndex == 1
                            //     ? kManRope_500_16_white
                            //     : kManRope_500_16_626A6A,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  GestureDetector(
                    onTap: () => setState(() {
                      _gIndex = 2;
                      Navigator.of(context).pop();
                      widget.onPop("public");
                    }),
                    child: Container(
                      height: 44.h,
                      width: 78.w,
                      decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(5)),
                        color: _gIndex == 2 ? ColorSelect.colorF7E641 : Colors.transparent,
                      ),
                      child: Center(
                          child: Text(
                            'public',
                            // style: _gIndex == 2
                            //     ? kManRope_500_16_white
                            //     : kManRope_500_16_626A6A,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    if (widget.privacyStatus == "private") {
      _gIndex = 0;
    } else if (widget.privacyStatus == "friend") {
      _gIndex = 1;
    } else {
      _gIndex = 2;
    }
    super.initState();
  }
}

