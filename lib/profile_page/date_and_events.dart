import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:swishlist/api/user_apis/event_date_api.dart';
import 'package:swishlist/constants/color.dart';

import '../buttons/light_yellow.dart';
import '../constants/globals/loading.dart';
import '../models/DateModel.dart';
import '../models/date_and_events_model.dart';

class DateAndEvents extends StatefulWidget {
  const DateAndEvents({Key? key}) : super(key: key);

  @override
  State<DateAndEvents> createState() => _DateAndEventsState();
}

class _DateAndEventsState extends State<DateAndEvents> {
  @override
  void initState() {
    // getAllEvent();
    getUpcomingEvent();
    super.initState();
  }

  bool isLoading = false;
  EventModel? event;
  // EventModel? eventUpcoming;

  List<DateModel> eventUpcoming2 = [];
  List<int> selectedItems = [];
  bool showLoad = false;
  bool show = false;

  // getAllEvent() {
  //   isLoading = true;
  //   var resp = getDateAndEventApi();
  //   resp.then((value) {
  //     if (value['status'] == true) {
  //       setState(() {
  //         event = EventModel.fromJson(value);
  //         // for (var v in event!.data! ) {
  //         //   if (v.type == "all") {
  //         //     event2.add(v);
  //         //   }
  //         // }
  //         isLoading = false;
  //       });
  //     } else {
  //       isLoading = false;
  //     }
  //   });
  // }

  Future<void> _handleRefresh() async {
    getUpcomingEvent();

    // Implement your refresh logic here.
    // For example, fetch new data from an API or update some data.
    // You can use async/await for asynchronous operations.

    // For demonstration purposes, let's delay for 2 seconds.
    await Future.delayed(Duration(seconds: 2));

    // Once the refresh operation is complete, call setState to rebuild the UI.
    setState(() {
      // Update your data or UI state as needed.
    });
  }

  // ModelEvent
  // List<ModelEvent> eventUp = [];
  DateTime currentDateTime = DateTime.now();
  List<DateModel> eventUpcoming = [];
  // final filteredItems = eventUpcoming2.where((item) => item.dateTime.isAfter(now)).toList();
  getUpcomingEvent() {
    isLoading = true;
    var resp = getDateAndEventApi();
    resp.then((value) {
      eventUpcoming2.clear();
      eventUpcoming.clear();
      if (value['status'] == true) {
        setState(() {
          // eventUpcoming = EventModel.fromJson(value);
          for (var q in value['data']) {
            eventUpcoming.add(DateModel.fromJson(q));
          }

          for (var v in value['data']) {
            eventUpcoming2.add(DateModel.fromJson(v));
          }
          eventUpcoming2.removeWhere((element) =>
              DateTime.parse("${element.date}").isBefore(DateTime.now()
                  // DateTime(
                  //     DateTime.now().year,
                  //     DateTime.now().month,
                  //     DateTime.now().day,
                  //     DateTime.now().hour,
                  //     60)
                  ));

          // eventUpcoming2.removeWhere((element) => element.date)

          // for(var v in eventUpcoming!.data!) {
          //
          //
          //
          // }
          // eventUpcoming!.data!.removeWhere((date) => date == DateTime.now());

          // for (var v in upcomingO) {
          //   if (DateTime.parse("${v.date} ${v.timeSlot}")
          //       .add(Duration(minutes: int.parse(v.slotTimePeriod.toString())))
          //       .isBefore(DateTime.now())) {
          //     upcomingO.remove(v);
          //     print("check" + upcomingO.length.toString());
          //   }
          // }

          // for (var v in eventUpcoming!.data!) {
          //   if (v.type == "upcoming") {
          //     eventUpcoming2.add(v);
          //   }
          // }
          isLoading = false;
        });
      } else {
        isLoading = false;
        setState(() {});
      }
    });
  }

  final nameController = TextEditingController();
  final typeController = TextEditingController();
  final dateController = TextEditingController();
  String dateFormat = '';

  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final viewInsets = mediaQuery.viewInsets;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 100),
                    child: Text(
                      "Date and Events",
                      style: AppTextStyle().textColor29292916w500,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 140),
                  //   child: Text(
                  //     "60% Completed",
                  //     style: AppTextStyle().textColor70707012w400,
                  //   ),
                  // )
                ],
              ),
              selectedItems.isEmpty
                  ? SizedBox()
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          isLoading = true;
                        });
                        for (var v in selectedItems) {
                          deleteEventAndDate(id: v.toString())
                              .then((value) async {
                            print(selectedItems.toString());
                            if (value['status'] == true) {
                              setState(() {});
                              Fluttertoast.showToast(msg: value['message']);
                            } else {
                              Fluttertoast.showToast(msg: value['message']);
                            }
                            setState(
                              () {
                                isLoading = false;
                              },
                            );
                          });
                        }
                      },
                      child: Container(
                        width: 36,
                        height: 36,
                        color: Colors.transparent,
                        child: Image.asset('assets/images/del.png'),
                      ),
                    )
            ],
          ),
          leadingWidth: 40,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(
                "assets/icons/arrowback.svg",
              ),
            ),
          )),
      backgroundColor: Colors.white,
      body: isLoading
          ? Loading()
          : RefreshIndicator(
              backgroundColor: Colors.white,
              color: ColorSelect.colorF7E641,
              strokeWidth: 3,
              onRefresh: _handleRefresh,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 8.h,
                          width: 360.w,
                          decoration: BoxDecoration(
                              color: ColorSelect.colorBA54DE,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0))),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 8.h,
                              width: 216.w,
                              decoration: BoxDecoration(
                                  color: ColorSelect.colorBA54DE,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12),
                                      bottomRight: Radius.circular(0))),
                            ),
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          GestureDetector(
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                      builder: (context, StateSetter setState) {
                                    return AlertDialog(
                                      insetPadding:
                                          EdgeInsets.only(left: 38, right: 38),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 0,
                                      backgroundColor: Colors.white,
                                      content: SizedBox(
                                        width: 1.sw,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Enter details",
                                                style: AppTextStyle()
                                                    .textColor29292916w500,
                                              ),
                                              SizedBox(
                                                height: 16,
                                              ),
                                              // Text(
                                              //   "Fill the details of product you own already.",
                                              //   style: AppTextStyle().textColor70707014w400,
                                              // ),

                                              Container(
                                                width: 328.w,
                                                height: 40.h,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color:
                                                      ColorSelect.colorEDEDF1,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: TextFormField(
                                                          inputFormatters: [
                                                            LengthLimitingTextInputFormatter(
                                                                30),
                                                          ],
                                                          onChanged: (v) {
                                                            setState(() {});
                                                          },
                                                          controller:
                                                              nameController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          decoration: InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              hintText:
                                                                  "Name of event",
                                                              hintStyle:
                                                                  AppTextStyle()
                                                                      .textColor70707014w400),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 12),

                                              SizedBox(height: 8),
                                              Container(
                                                width: 328.w,
                                                height: 40.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: ColorSelect
                                                        .colorEDEDF1),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: TextFormField(
                                                          onChanged: (v) {
                                                            setState(() {});
                                                          },
                                                          controller:
                                                              dateController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          readOnly: true,
                                                          onTap: () async {
                                                            var datePicked =
                                                                await showRoundedDatePicker(
                                                              height: 250,
                                                              context: context,
                                                              styleDatePicker:
                                                                  MaterialRoundedDatePickerStyle(
                                                                paddingDatePicker:
                                                                    EdgeInsets.only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            10),
                                                                textStyleButtonPositive:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                                textStyleButtonNegative:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                              theme: ThemeData(
                                                                  primarySwatch:
                                                                      Colors
                                                                          .yellow,
                                                                  textTheme:
                                                                      TextTheme()),
                                                              initialDate:
                                                                  DateTime
                                                                      .now(),
                                                              firstDate: DateTime(
                                                                  DateTime.now()
                                                                          .year -
                                                                      10),
                                                              lastDate: DateTime(
                                                                  DateTime.now()
                                                                          .year +
                                                                      10),
                                                              borderRadius: 16,
                                                            );

                                                            setState(() {
                                                              dateController
                                                                  .text = DateFormat
                                                                      .yMMMd()
                                                                  .format(
                                                                      datePicked!);
                                                              dateFormat = DateFormat(
                                                                      'yyyy-MM-dd')
                                                                  .format(
                                                                      datePicked);
                                                            });
                                                          },
                                                          decoration: InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              hintText:
                                                                  "Enter Date",
                                                              hintStyle:
                                                                  AppTextStyle()
                                                                      .textColor70707014w400,
                                                              suffixIcon:
                                                                  Image.asset(
                                                                      "assets/images/calendarimg.png")),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 22),
                                              showLoad
                                                  ? LoadingLightYellowButton()
                                                  : LightYellowButtonWithText(
                                                      size: 14,
                                                      onTap: () {
                                                        setState(() {
                                                          showLoad = !showLoad;
                                                        });
                                                        Timer timer = Timer(
                                                            Duration(
                                                                seconds: 2),
                                                            () {
                                                          setState(() {
                                                            showLoad = false;
                                                          });
                                                        });
                                                        if (nameController.text
                                                                .isNotEmpty &&
                                                            dateController.text
                                                                .isNotEmpty) {
                                                          postDateAndEventApi(
                                                                  name:
                                                                      nameController
                                                                          .text,
                                                                  date:
                                                                      dateFormat,
                                                                  type: "all",
                                                                  privacy:
                                                                      'public')
                                                              .then(
                                                                  (value) async {
                                                            if (value[
                                                                    'status'] ==
                                                                true) {
                                                              setState(() {
                                                                showLoad =
                                                                    false;

                                                                isLoading
                                                                    ? Loading
                                                                    : _handleRefresh();
                                                              });

                                                              Fluttertoast.showToast(
                                                                  msg: value[
                                                                      'message']);
                                                              Navigator.pop(
                                                                  context);
                                                              // Navigator.pop(
                                                              //     context);
                                                            } else {
                                                              Fluttertoast
                                                                  .showToast(
                                                                      msg:
                                                                          'Please fill all details fields');
                                                            }
                                                          });
                                                        }
                                                      },
                                                      backgroundColor: (nameController
                                                                  .text
                                                                  .isNotEmpty &&
                                                              dateController
                                                                  .text
                                                                  .isNotEmpty)
                                                          ? MaterialStateProperty
                                                              .all(ColorSelect
                                                                  .colorF7E641)
                                                          : MaterialStateProperty
                                                              .all(ColorSelect
                                                                  .colorFCF5B6),
                                                      textStyleColor: (nameController
                                                                  .text
                                                                  .isNotEmpty &&
                                                              dateController
                                                                  .text
                                                                  .isNotEmpty)
                                                          ? Colors.black
                                                          : ColorSelect
                                                              .colorB5B07A,
                                                      title: 'Save',
                                                    ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                                },
                              );
                            },
                            child: Text(
                              '+ Add Events',
                              style: AppTextStyle().textColorBA54DE14w500,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            "Upcoming",
                            style: AppTextStyle().textColor29292914w600,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          eventUpcoming2.isEmpty
                              ? Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      /*      Icon(Icons.error_outline,color: Colors.black,size: 80,),
                          SizedBox(height: 5),*/
                                      Text("No Upcoming Dates yet")
                                    ],
                                  ),
                                )
                              : ListView.separated(
                                  padding: EdgeInsets.all(0),
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: eventUpcoming2.length,
                                  // itemCount: 6,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, i) {
                                    return GestureDetector(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1, color: Colors.yellow),
                                          color: Colors.grey.withOpacity(0.02),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Event : ',
                                                        style: AppTextStyle()
                                                            .textColor29292914w600,
                                                      ),
                                                      Text(
                                                        eventUpcoming2[i]
                                                            .name
                                                            .toString(),
                                                        style: AppTextStyle()
                                                            .textColor29292914w400,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Date : ',
                                                        style: AppTextStyle()
                                                            .textColor29292914w600,
                                                      ),
                                                      Text(
                                                        eventUpcoming2[i]
                                                            .date
                                                            .toString(),
                                                        style: AppTextStyle()
                                                            .textColor29292914w400,
                                                      ),
                                                    ],
                                                  ),

                                                  // Row(
                                                  //   children: [
                                                  //     Text(
                                                  //       eventUpcoming!
                                                  //           .data![i].name
                                                  //           .toString(),
                                                  //       style: AppTextStyle()
                                                  //           .textColor70707014w400,
                                                  //     ),
                                                  //     Spacer(),
                                                  //     Text(
                                                  //       eventUpcoming!
                                                  //           .data![i].date
                                                  //           .toString(),
                                                  //       style: AppTextStyle()
                                                  //           .textColor29292914w400,
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // child: Padding(
                                      //   padding: const EdgeInsets.all(8.0),
                                      //   child: Column(
                                      //     children: [
                                      //       Row(
                                      //         children: [
                                      //           Text(
                                      //             eventUpcoming2[i]
                                      //                 .name
                                      //                 .toString(),
                                      //             style: AppTextStyle()
                                      //                 .textColor70707014w400,
                                      //           ),
                                      //           Spacer(),
                                      //           Text(
                                      //             eventUpcoming2[i]
                                      //                 .date
                                      //                 .toString(),
                                      //             style: AppTextStyle()
                                      //                 .textColor29292914w400,
                                      //           ),
                                      //         ],
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          SizedBox(
                                    height: 16,
                                  ),
                                ),

                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            "All",
                            style: AppTextStyle().textColor29292914w600,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              eventUpcoming.isEmpty
                                  ? Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          /*      Icon(Icons.error_outline,color: Colors.black,size: 80,),
                                          SizedBox(height: 5),*/
                                          Text("No events yet")
                                        ],
                                      ),
                                    )
                                  : ListView.separated(
                                      padding: EdgeInsets.only(bottom: 16),
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: eventUpcoming.length,
                                      // itemCount: 6,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, i) {
                                        return GestureDetector(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.yellow),
                                              color:
                                                  Colors.grey.withOpacity(0.02),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Event : ',
                                                            style: AppTextStyle()
                                                                .textColor29292914w600,
                                                          ),
                                                          Text(
                                                            eventUpcoming[i]
                                                                .name
                                                                .toString(),
                                                            style: AppTextStyle()
                                                                .textColor29292914w400,
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Date : ',
                                                            style: AppTextStyle()
                                                                .textColor29292914w600,
                                                          ),
                                                          Text(
                                                            eventUpcoming[i]
                                                                .date
                                                                .toString(),
                                                            style: AppTextStyle()
                                                                .textColor29292914w400,
                                                          ),
                                                        ],
                                                      ),

                                                      // Row(
                                                      //   children: [
                                                      //     Text(
                                                      //       eventUpcoming!
                                                      //           .data![i].name
                                                      //           .toString(),
                                                      //       style: AppTextStyle()
                                                      //           .textColor70707014w400,
                                                      //     ),
                                                      //     Spacer(),
                                                      //     Text(
                                                      //       eventUpcoming!
                                                      //           .data![i].date
                                                      //           .toString(),
                                                      //       style: AppTextStyle()
                                                      //           .textColor29292914w400,
                                                      //     ),
                                                      //   ],
                                                      // ),
                                                    ],
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        show = !show;
                                                      });
                                                      Timer timer = Timer(
                                                          Duration(seconds: 2),
                                                          () {
                                                        setState(() {
                                                          show = false;
                                                        });
                                                      });
                                                      deleteEventAndDate(
                                                              id: eventUpcoming[
                                                                      i]
                                                                  .id
                                                                  .toString())
                                                          .then((value) async {
                                                        print(selectedItems
                                                            .toString());
                                                        if (value['status'] ==
                                                            true) {
                                                          isLoading
                                                              ? Loading()
                                                              : getUpcomingEvent();

                                                          Fluttertoast.showToast(
                                                              msg: value[
                                                                  'message']);
                                                        } else {
                                                          Fluttertoast.showToast(
                                                              msg: value[
                                                                  'message']);
                                                        }

                                                        setState(() {
                                                          isLoading = false;
                                                        });
                                                      });
                                                    },
                                                    child: show
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4.0),
                                                            child:
                                                                CircularProgressIndicator(
                                                              color:
                                                                  Colors.yellow,
                                                            ),
                                                          )
                                                        : Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                "Delete",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .redAccent),
                                                              ),
                                                            )),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              SizedBox(
                                        height: 16,
                                      ),
                                    ),
                            ],
                          ),

                          // event!.data!.isEmpty
                          //     ? Center(
                          //         child: Column(
                          //           crossAxisAlignment: CrossAxisAlignment.center,
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             /*   Icon(Icons.error_outline,color: Colors.black,size: 80,),
                          // // Image.asset("assets/images/delivery.png",height: 100,),
                          // SizedBox(height: 5),*/
                          //             Text(
                          //               'No Dates Added Yet',
                          //               style:
                          //                   AppTextStyle().textColor29292914w500,
                          //             ),
                          //             SizedBox(height: 30),
                          //           ],
                          //         ),
                          //       )
                          //     : ListView.separated(
                          //         padding: EdgeInsets.only(bottom: 30),
                          //         physics: NeverScrollableScrollPhysics(),
                          //         itemCount: event!.data!.length,
                          //         shrinkWrap: true,
                          //         scrollDirection: Axis.vertical,
                          //         itemBuilder: (context, i) {
                          //           return GestureDetector(
                          //             onLongPress: () {
                          //               if (selectedItems.isEmpty) {
                          //                 setState(() {
                          //                   selectedItems
                          //                       .add(event!.data![i].id!);
                          //                 });
                          //               }
                          //             },
                          //             onTap: () {
                          //               if (selectedItems
                          //                   .contains(event!.data![i].id!)) {
                          //                 setState(() {
                          //                   selectedItems
                          //                       .remove(event!.data![i].id!);
                          //                 });
                          //               } else {
                          //                 setState(() {
                          //                   selectedItems
                          //                       .add(event!.data![i].id!);
                          //                 });
                          //               }
                          //             },
                          //             child: Column(
                          //               children: [
                          //                 Row(
                          //                   children: [
                          //                     Text(
                          //                       event!.data![i].name.toString(),
                          //                       style: selectedItems.contains(
                          //                               event!.data![i].id!)
                          //                           ? AppTextStyle()
                          //                               .textColorD5574514w500
                          //                           : AppTextStyle()
                          //                               .textColor70707014w400,
                          //                     ),
                          //                     Spacer(),
                          //                     Text(
                          //                       event!.data![i].date.toString(),
                          //                       style: selectedItems.contains(
                          //                               event!.data![i].id!)
                          //                           ? AppTextStyle()
                          //                               .textColorD5574514w500
                          //                           : AppTextStyle()
                          //                               .textColor29292914w400,
                          //                     ),
                          //                   ],
                          //                 ),
                          //               ],
                          //             ),
                          //           );
                          //         },
                          //         separatorBuilder:
                          //             (BuildContext context, int index) =>
                          //                 SizedBox(
                          //           height: 16,
                          //         ),
                          //       ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
