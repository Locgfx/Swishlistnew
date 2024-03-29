import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';

import '../../api/user_apis/friends_api.dart';
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
      friendNotification.clear();
      if (mounted) {
        if (value['status'] == true) {
          setState(() {
            for (var v in value['data']) {
              friendNotification.add(FriendNotificationModel.fromJson(v));
            }

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

  final List<bool> delete = List.generate(1000, (index) => false);
  final List<bool> accept = List.generate(1000, (index) => false);

  // final List<bool> reject = List.generate(50, (index) => false);

  @override
  void initState() {
    getFriendNotifications();
    super.initState();
  }

  Future<void> _handleRefresh() async {
    getFriendNotifications();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 140),
                  child: Text(
                    "Friend Request",
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
      body: isLoading
          ? Loading()
          : friendNotification.isEmpty
              ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/addproducts2.png",
                        height: 204,
                        width: 180,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No Friend Requests',
                      )
                    ],
                  ),
                )
              : RefreshIndicator(
                  backgroundColor: Colors.white,
                  color: ColorSelect.colorF7E641,
                  strokeWidth: 3,
                  onRefresh: _handleRefresh,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: ListView.separated(
                      padding: EdgeInsets.only(
                          top: 16, bottom: 200, left: 16, right: 16),
                      itemCount: friendNotification.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        // final List<bool> delete = List.generate(
                        //     friendNotification.length, (i) => false);
                        return Column(
                          children: [
                            Container(
                              color: Colors.transparent,
                              child: Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey.shade200,
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    child: CachedNetworkImage(
                                      imageUrl: friendNotification[i]
                                              .user!
                                              .photo
                                              .toString()
                                              .contains('http')
                                          ? friendNotification[i]
                                              .user!
                                              .photo
                                              .toString()
                                          : baseUrl +
                                              friendNotification[i]
                                                  .user!
                                                  .photo
                                                  .toString(),
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                              "assets/icons/userico.jpg"),
                                      progressIndicatorBuilder: (a, b, c) =>
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
                                                shape: BoxShape.circle),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          friendNotification[i]
                                              .user!
                                              .name!
                                              .toString(),
                                          // "Andy Bernard",
                                          style: AppTextStyle()
                                              .textColor29292914w500,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          friendNotification[i]
                                              .user!
                                              .username!
                                              .toString(),
                                          // "AndyAngie3260",
                                          style: AppTextStyle()
                                              .textColor70707014w400,
                                        )
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        accept[i] = !accept[i];
                                      });
                                      Timer timer =
                                          Timer(Duration(seconds: 2), () {
                                        setState(() {
                                          accept[i] = false;
                                        });
                                      });
                                      updateFriendRequestApi(
                                              status: 'accepted',
                                              id: friendNotification[i]
                                                  .id
                                                  .toString())
                                          .then((value) async {
                                        if (value['status'] == true) {
                                          setState(() {
                                            isLoading
                                                ? Loading()
                                                : getFriendNotifications();
                                          });
                                          Fluttertoast.showToast(
                                              msg: value['message']);
                                        } else {
                                          // Fluttertoast.showToast(
                                          //     msg:
                                          //     'Please fill all details fields');
                                        }
                                      });
                                    },
                                    child: accept[i]
                                        ? CircularProgressIndicator(
                                            color: ColorSelect.colorF7E641,
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: ColorSelect.colorF7E641,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text("Accept"),
                                            ),
                                          ),
                                  ),
                                  SizedBox(width: 16),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        delete[i] = !delete[i];
                                      });
                                      Timer timer =
                                          Timer(Duration(seconds: 2), () {
                                        setState(() {
                                          delete[i] = false;
                                        });
                                      });
                                      // setState(() {
                                      //   delete[i] = !delete[i];
                                      // });
                                      // Timer timer =
                                      //     Timer(Duration(seconds: 2), () {
                                      //   setState(() {
                                      //     delete[i] = false;
                                      //   });
                                      // });
                                      updateFriendRequestApi(
                                              status: 'rejected',
                                              id: friendNotification[i]
                                                  .id
                                                  .toString())
                                          .then((value) async {
                                        if (value['status'] == true) {
                                          setState(() {
                                            setState(() {
                                              isLoading
                                                  ? Loading()
                                                  : getFriendNotifications();
                                            });
                                          });

                                          Fluttertoast.showToast(
                                              msg: value['message']);
                                          // Navigator.pop(context);
                                          // Navigator.pop(context);
                                        } else {
                                          // Fluttertoast.showToast(
                                          //     msg:
                                          //     'Please fill all details fields');
                                        }
                                      });
                                    },
                                    child: delete[i]
                                        ? CircularProgressIndicator(
                                            color: ColorSelect.colorF7E641,
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Colors.redAccent
                                                  .withOpacity(0.65),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text("Reject"),
                                            ),
                                          ),
                                  ),
                                  // Container(
                                  //   decoration: BoxDecoration(
                                  //       color: ColorSelect.colorF6E3DB,
                                  //       borderRadius:
                                  //           BorderRadius.circular(80)),
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.symmetric(
                                  //         horizontal: 8, vertical: 6),
                                  //     child: Text(
                                  //       friendNotification[i].status.toString(),
                                  //       style: AppTextStyle()
                                  //           .textColor29292912w400,
                                  //     ),
                                  //   ),
                                  // )
                                ],
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
                        color: _gIndex == 0
                            ? ColorSelect.colorF7E641
                            : Colors.transparent,
                      ),
                      child: Center(
                          child: Text(
                        'Accept',
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
                        color: _gIndex == 1
                            ? ColorSelect.colorF7E641
                            : Colors.transparent,
                      ),
                      child: Center(
                        child: Text(
                          'Reject',
                        ),
                      ),
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
    }*/
    else {
      _gIndex = 2;
    }
    super.initState();
  }
}
