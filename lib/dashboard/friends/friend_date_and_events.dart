import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swishlist/constants/globals/loading.dart';
import 'package:swishlist/models/friends_details_model.dart';
import '../../api/user_apis/friends_api.dart';
import '../../constants/color.dart';


class FDatesAndEvents extends StatefulWidget {
  final String friendId;
  const FDatesAndEvents({Key? key, required this.friendId}) : super(key: key);

  @override
  State<FDatesAndEvents> createState() => _FDatesAndEventsState();
}

class _FDatesAndEventsState extends State<FDatesAndEvents> {
  List upcomingDetails = ['Event Name'];
  List allDetails = [
    'Birthday',
    'First Job',
    'Anniversary',
  ];
  @override
  void initState() {
    getAllFriendEventDetails();
    getUpFriendEventDetails();
    super.initState();
  }
  bool isLoading = false;
  // FriendDetailsModel? friendDetails;
  FriendDetailsModel? friendDetails1 ;
  List<EventDate> eventListAll = [];
  List<EventDate> eventListUp = [];

  getAllFriendEventDetails() {
    isLoading = true;
    var resp = friendDetailsApi(friendUserId: widget.friendId);
    resp.then((value) {
      if(value['status'] == true) {
        setState(() {
          friendDetails1 = FriendDetailsModel.fromJson(value);
          for (var v in friendDetails1!.data!.eventDate! ) {
            if (v.type == "all") {
              eventListAll.add(v);
            }
          }
          isLoading = false;
        });
      } else{
        isLoading = false;
      }
    });
  }

  getUpFriendEventDetails() {
    isLoading = true;
    var resp = friendDetailsApi(friendUserId: widget.friendId);
    resp.then((value) {
      if(value['status'] == true) {
        setState(() {
          friendDetails1 = FriendDetailsModel.fromJson(value);
          for (var v in friendDetails1!.data!.eventDate! ) {
            if (v.type == "upcoming") {
              eventListUp.add(v);
            }
          }
          isLoading = false;
        });
      } else{
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
      body: isLoading ? Loading() :SingleChildScrollView(
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
                height: 20.h,
              ),

              friendDetails1!.data!.eventDate!.isEmpty ?
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline,color: Colors.black,size: 80,),
                    // Image.asset("assets/images/delivery.png",height: 100,),
                    SizedBox(height: 5),
                    Text('No Upcoming event yet',
                      style: AppTextStyle().textColor29292914w500,)
                  ],
                ),
              ) :
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: eventListUp.length,
                  itemBuilder: (context,i) {
                    return Row(
                      children: [
                        Text(
                          eventListUp[i].name.toString(),
                          // "Birthday",
                          style: AppTextStyle().textColor70707014w400,
                        ),
                        Spacer(),
                        Text(
                          eventListUp[i].date.toString(),
                          // '12 July, 1988',
                          style:AppTextStyle().textColor29292914w400,
                        ),

                      ],
                    );
                  }),
              // UpcomingRowWidget(eventDate: event!,),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 40.h,
              ),
              Text(
                "All",
                style: AppTextStyle().textColor29292914w600,
              ),
              SizedBox(
                height: 20.h,
              ),
              friendDetails1!.data!.eventDate!.isEmpty ?
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline,color: Colors.black,size: 80,),
                    // Image.asset("assets/images/delivery.png",height: 100,),
                    SizedBox(height: 5),
                    Text('No all event yet',
                      style: AppTextStyle().textColor29292914w500,)
                  ],
                ),
              ) :
              ListView.builder(
                shrinkWrap: true,
                itemCount: eventListAll.length,
                  itemBuilder: (context,i) {
                return Row(
                  children: [
                    Text(
                      eventListAll[i].name.toString(),
                      // "Birthday",
                      style: AppTextStyle().textColor70707014w400,
                    ),
                    Spacer(),
                    Text(
                      eventListAll[i].date.toString(),
                      // '12 July, 1988',
                      style:AppTextStyle().textColor29292914w400,
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      )
    );
  }
}
