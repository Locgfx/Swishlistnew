import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swishlist/constants/globals/loading.dart';

import '../../constants/color.dart';
import '../api/family_member_apis/family_details_api.dart';
import '../models/new_models/family_details_models.dart';

class FamilyDatesAndEvents extends StatefulWidget {
  final String friendId;
  const FamilyDatesAndEvents({Key? key, required this.friendId})
      : super(key: key);

  @override
  State<FamilyDatesAndEvents> createState() => _FamilyDatesAndEventsState();
}

class _FamilyDatesAndEventsState extends State<FamilyDatesAndEvents> {
  List upcomingDetails = ['Event Name'];
  List allDetails = [
    'Birthday',
    'First Job',
    'Anniversary',
  ];
  @override
  void initState() {
    getAllFriendEventDetails();
    // getUpFriendEventDetails();
    super.initState();
  }

  bool isLoading = false;
  // FriendDetailsModel? friendDetails;
  FamilyDetailsModel? familyEventDetails;
  List<EventDate> eventListAll = [];
  List<EventDate> eventListUp = [];

  getAllFriendEventDetails() {
    isLoading = true;
    var resp = getFamilyDetailsApi(familyMemberId: widget.friendId);
    resp.then((value) {
      if (value['status'] == true) {
        setState(() {
          familyEventDetails = FamilyDetailsModel.fromJson(value);
          for (var v in familyEventDetails!.data!.eventDate!) {
            if (v.type == "all") {
              eventListAll.add(v);
            }
          }
          for (var q in familyEventDetails!.data!.eventDate!) {
            eventListUp.add(q);
          }
          eventListUp.removeWhere((element) =>
              DateTime.parse("${element.date}").isBefore(DateTime.now()));
          isLoading = false;
        });
      } else {
        isLoading = false;
      }
    });
  }

  // getUpFriendEventDetails() {
  //   isLoading = true;
  //   var resp = friendDetailsApi(friendUserId: widget.friendId);
  //   resp.then((value) {
  //     if (value['status'] == true) {
  //       setState(() {
  //         friendDetails1 = FriendDetailsModel.fromJson(value);
  //         for (var v in friendDetails1!.data!.eventDate!) {
  //           if (v.type == "upcoming") {
  //             eventListUp.add(v);
  //           }
  //         }
  //         isLoading = false;
  //       });
  //     } else {
  //       isLoading = false;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset('assets/images/Vector190.png')),
          ),
          title: Text(
            "Dates and Events",
            style: AppTextStyle().textColor39393916w500,
          ),
          centerTitle: false,
        ),
        body: isLoading
            ? Loading()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 40.h,
                      ),
                      Text(
                        "Upcoming",
                        style: AppTextStyle().textColor29292914w600,
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      eventListUp.isEmpty
                          ? Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  /*      Icon(Icons.error_outline,color: Colors.black,size: 80,),
                          SizedBox(height: 5),*/
                                  Text(
                                      "No upcoming event dates of family member")
                                ],
                              ),
                            )
                          : ListView.separated(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: eventListUp.length,
                              itemBuilder: (context, i) {
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.yellow),
                                    color: Colors.grey.withOpacity(0.02),
                                    borderRadius: BorderRadius.circular(10),
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
                                                  eventListUp[i]
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
                                                  eventListUp[i]
                                                      .date
                                                      .toString(),
                                                  style: AppTextStyle()
                                                      .textColor29292914w400,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                                //   Row(
                                //   children: [
                                //     Text(
                                //       eventListUp[i].name.toString(),
                                //       // "Birthday",
                                //       style:
                                //           AppTextStyle().textColor70707014w400,
                                //     ),
                                //     Spacer(),
                                //     Text(
                                //       eventListUp[i].date.toString(),
                                //       // '12 July, 1988',
                                //       style:
                                //           AppTextStyle().textColor29292914w400,
                                //     ),
                                //   ],
                                // );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) => SizedBox(
                                height: 10,
                              ),
                            ),
                      // UpcomingRowWidget(eventDate: event!,),
                      SizedBox(
                        height: 20.h,
                      ),

                      Text(
                        "All",
                        style: AppTextStyle().textColor29292914w600,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      familyEventDetails!.data!.eventDate!.isEmpty
                          ? Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      "No upcoming event dates of family member")
                                ],
                              ),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              itemCount: eventListAll.length,
                              itemBuilder: (context, i) {
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.yellow),
                                    color: Colors.grey.withOpacity(0.02),
                                    borderRadius: BorderRadius.circular(10),
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
                                                  eventListAll[i]
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
                                                  eventListAll[i]
                                                      .date
                                                      .toString(),
                                                  style: AppTextStyle()
                                                      .textColor29292914w400,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                                //   Row(
                                //   children: [
                                //     Text(
                                //       eventListAll[i].name.toString(),
                                //       // "Birthday",
                                //       style:
                                //           AppTextStyle().textColor70707014w400,
                                //     ),
                                //     Spacer(),
                                //     Text(
                                //       eventListAll[i].date.toString(),
                                //       // '12 July, 1988',
                                //       style:
                                //           AppTextStyle().textColor29292914w400,
                                //     ),
                                //   ],
                                // );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) => SizedBox(
                                height: 10,
                              ),
                            ),
                    ],
                  ),
                ),
              ));
  }
}
