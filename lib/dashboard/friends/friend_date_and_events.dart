import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swishlist/api/friend_apis/user_details_api.dart';
import 'package:swishlist/constants/globals/loading.dart';
import 'package:swishlist/models/friends_details_model.dart';
import 'package:swishlist/models/user_details_model.dart';

import '../../api/user_apis/friends_api.dart';
import '../../constants/color.dart';
import '../../models/DateModel.dart';

class FDatesAndEvents extends StatefulWidget {
  final String friendId;
  const FDatesAndEvents({Key? key, required this.friendId}) : super(key: key);

  @override
  State<FDatesAndEvents> createState() => _FDatesAndEventsState();
}

class _FDatesAndEventsState extends State<FDatesAndEvents> {
  Future<void> _handleRefresh() async {
    //getAllFriendEventDetails();
    getUserDetails();

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

  List upcomingDetails = ['Event Name'];
  List allDetails = [
    'Birthday',
    'First Job',
    'Anniversary',
  ];
  @override
  void initState() {
    getUserDetails();
   // getAllFriendEventDetails();
    // getUpFriendEventDetails();
    super.initState();
  }

  bool isLoading = false;
  // FriendDetailsModel? friendDetails;
  FriendDetailsModel? friendDetails1;
  // List<EventDate> eventListAll = [];
  // List<EventDate> eventListUp = [];

  List<Events> eventList = [];
  List<Events> upcomingList = [];

/*  getAllFriendEventDetails() {
    isLoading = true;
    var resp = friendDetailsApi(friendUserId: widget.friendId);
    resp.then((value) {
      eventListAll.clear();
      eventListUp.clear();
      if (value['status'] == true) {
        setState(() {
          friendDetails1 = FriendDetailsModel.fromJson(value);
          for (var v in friendDetails1!.data!.eventDate!) {
            if (v.type == "all") {
              eventListAll.add(v);
            }
          }
          for (var q in friendDetails1!.data!.eventDate!) {
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
  }*/
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

  UserDetailsModel ? userDetails;


  getUserDetails(){
    isLoading = true;
    var resp = userDetailsApi(id: widget.friendId);
    resp.then((value) {
      if(value['error'] == false){
        setState(() {
          userDetails = UserDetailsModel.fromJson(value);
          for(var v in userDetails!.data!.events!.toList()){
            eventList.add(v);

          }
          for(var q in eventList){
            if(q.type == "upcoming"){
              upcomingList.add(q);
            }
          }
        });
        isLoading = false;

      }
      else{
        isLoading = false;
      }
    });


  }

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
        body:
        isLoading
            ? Loading()
            : RefreshIndicator(
                backgroundColor: Colors.white,
                color: ColorSelect.colorF7E641,
                strokeWidth: 3,
                onRefresh: _handleRefresh,
                child: SingleChildScrollView(
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
                        upcomingList.isEmpty
                            ? Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    /*      Icon(Icons.error_outline,color: Colors.black,size: 80,),
                            SizedBox(height: 5),*/
                                    Text("No upcoming event dates of friend")
                                  ],
                                ),
                              )
                            : ListView.separated(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: upcomingList.length,
                                //eventListUp.length,
                                physics: NeverScrollableScrollPhysics(),
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
                                                    upcomingList[i].name.toString(),
                                                    // eventListUp[i]
                                                    //     .name
                                                    //     .toString(),
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
                                                    upcomingList[i].date.toString(),
                                                    // eventListUp[i]
                                                    //     .date
                                                    //     .toString(),
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
                                    (BuildContext context, int index) =>
                                        SizedBox(
                                  height: 10,
                                ),
                              ),
                        // UpcomingRowWidget(eventDate: event!,),
                        // SizedBox(
                        //   height: 20.h,
                        // ),
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
                        //friendDetails1!.data!.eventDate!.isEmpty
                      userDetails!.data!.events!.isEmpty
                            ? Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("No upcoming event dates of friend")
                                  ],
                                ),
                              )
                            : ListView.separated(
                                padding: EdgeInsets.only(bottom: 16),
                                shrinkWrap: true,
                                itemCount: eventList.length,
                                //eventListAll.length,
                                physics: NeverScrollableScrollPhysics(),
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
                                                    eventList[i].name.toString(),
                                                    // eventListAll[i]
                                                    //     .name
                                                    //     .toString(),
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
                                                    eventList[i].date.toString(),
                                                    // eventListAll[i]
                                                    //     .date
                                                    //     .toString(),
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
                                    (BuildContext context, int index) =>
                                        SizedBox(
                                  height: 10,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ));
  }
}
