import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../api/user_apis/friends_api.dart';
import '../../buttons/light_yellow.dart';
import '../../constants/color.dart';
import '../../constants/globals/loading.dart';
import '../../constants/urls.dart';
import '../../models/friend_notification_model.dart';

class FriendNotification extends StatefulWidget {
  const FriendNotification({Key? key}) : super(key: key);

  @override
  State<FriendNotification> createState() => _FriendNotificationState();
}

class _FriendNotificationState extends State<FriendNotification> {
  final requestController = TextEditingController();


  List<FriendNotificationModel> friendNotification = [];
  // FriendNotificationModel? friendNotification;
  bool isLoading = false;
  getFriendNotifications() {
    isLoading = true;
    var resp = getFriendNotificationApi();
    resp.then((value) {
      if(mounted) {
        if(value['status'] == true) {
          setState(() {
            for (var v in value['data']) {
              friendNotification.add(FriendNotificationModel.fromJson(v));
            }
            // friendNotification = FriendNotificationModel.fromJson(value);
            isLoading = false;
          });

        } else {
          setState(() {
            isLoading = false;
          });
        }
      }
    });
  }

  @override
  void initState() {
    getFriendNotifications();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 140),
                  child: Text(
                    "Notifications",
                    style: AppTextStyle().textColor29292916w500,
                  ),
                ),
              ],
            ),
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
        ),
      ),
      body:isLoading ? Loading():
          friendNotification.isEmpty ?
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline,
                  color: Colors.black,
                  size: 80,
                ),
                // Image.asset("assets/images/delivery.png",height: 100,),
                SizedBox(height: 5),
                Text('No Notification',
                  style: AppTextStyle().textColor29292914w500,)
              ],
            ),
          ) :
      SingleChildScrollView(
        child:  ListView.separated(
          padding: EdgeInsets.only(top: 16,bottom: 200,left: 16,right: 16),
          itemCount: friendNotification.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          insetPadding: EdgeInsets.only(left: 20, right: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                          backgroundColor: Colors.white,
                          content: SizedBox(
                            width: 1.sw,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

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
                                                        builder: (context) => RequestStatusBottomSheet(
                                                          eventType: requestController.text,
                                                          onPop: (val) {
                                                            setState(() {
                                                              requestController.text = val;
                                                            });
                                                          },
                                                        ));
                                                  },
                                                  onChanged: (v) {
                                                    setState(() {});
                                                  },
                                                  controller: requestController,
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      hintText: "Accept Request",
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
                                      SizedBox(height: 16),
                                      LightYellowButtonWithText(
                                        onTap: () {
                                          // print(requestController.text);
                                          // print(friendNotification[i].id.toString());
                                            updateFriendRequestApi(
                                                status: requestController.text,
                                                id:friendNotification[i].id.toString()
                                            ).then((value) async {
                                              if(value['status'] == true) {
                                                Fluttertoast.showToast(msg: value['message']);
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              } else {
                                                Fluttertoast.showToast(msg:'Please fill all details fields');
                                              }
                                            });
                                        },
                                        backgroundColor :/*:(
                                              nameController.text.isNotEmpty &&
                                                  typeController.text.isNotEmpty ||
                                                  dateController.text.isNotEmpty
                                          ) ? MaterialStateProperty.all(ColorSelect.colorF7E641)
                                              // :*/ MaterialStateProperty.all(ColorSelect.colorF7E641),
                                        textStyleColor: /*nameController.text.isNotEmpty &&
                                              typeController.text.isNotEmpty ||
                                              dateController.text.isNotEmpty ?*/
                                        Colors.black, /*:
                                          ColorSelect.colorB5B07A,*/
                                        title: 'save',
                                      ),

                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                    // Navigator.push(
                    //     context, MaterialPageRoute(builder: (_) =>
                    //     AddDateAndEvents()));

                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Container(
                          height:50,
                          width:50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:Colors.grey.shade200,
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: CachedNetworkImage(
                            imageUrl: baseUrl+friendNotification[i].user!.photo.toString(),
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            progressIndicatorBuilder:  (a,b,c) =>
                                Opacity(
                                  opacity: 0.3,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.black12,
                                    highlightColor: Colors.white,
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      //margin: EdgeInsets.symmetric(horizontal: 24),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle
                                      ),
                                    ),
                                  ),
                                ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                friendNotification[i].user!.name!.toString(),
                                // "Andy Bernard",
                                style: AppTextStyle().textColor29292914w500,
                              ),
                              SizedBox(height: 4),
                              Text(
                                friendNotification[i].user!.username!.toString(),
                                // "AndyAngie3260",
                                style: AppTextStyle().textColor70707014w400,
                              )
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color:ColorSelect.colorF6E3DB,
                              borderRadius: BorderRadius.circular(80)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 6),
                            child: Text(friendNotification[i].status.toString(),
                              style: AppTextStyle().textColor29292912w400,),
                          ),
                        )

                      ],
                    ),
                  ),
                )
              ],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 16,
            );
          },
        ),
      ),
    );
  }
}


class RequestStatusBottomSheet extends StatefulWidget {
  final String eventType;
  final Function(String) onPop;
  const RequestStatusBottomSheet(
      {Key? key, required this.eventType, required this.onPop})
      : super(key: key);

  @override
  State<RequestStatusBottomSheet> createState() => _RequestStatusBottomSheet();
}

class _RequestStatusBottomSheet extends State<RequestStatusBottomSheet> {
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
                  'Accept Request',
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
                      widget.onPop("accepted");
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
                            'accepted',
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
                      widget.onPop("rejected");
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
                            'rejected',
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
    if (widget.eventType == "accepted") {
      _gIndex = 0;
    } /*else if (widget.eventType == "upcoming") {
      _gIndex = 1;
    }*/ else {
      _gIndex = 2;
    }
    super.initState();
  }
}
