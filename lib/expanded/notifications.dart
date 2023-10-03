import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/constants/globals/loading.dart';

import '../api/user_apis/notification_api.dart';
import '../buttons/light_yellow.dart';
import '../models/notification_model.dart';

class Notifications extends StatefulWidget {
  const Notifications({
    Key? key,
  }) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  void initState() {
    getNotification();
    super.initState();
  }

  bool followRequest = false;
  bool sharedWithMe = false;
  bool friendAddProduct = false;
  bool appUpdate = false;

  bool isLoading = false;
  bool loading = false;

  NotificationModel? notification;
  NotificationModel model = NotificationModel();

  getNotification() {
    isLoading = true;
    var resp = getNotificationApi();
    resp.then((value) {
      // if(mounted) {
      if (value['status'] == true) {
        setState(() {
          model = NotificationModel.fromJson(value);
          indexNotification();
          isLoading = false;
        });
      } else {
        isLoading = false;
      }
      // }
    });
  }

  indexNotification() {
    if (model.data!.followRequest == "yes") {
      followRequest = true;
    } else {
      followRequest = false;
    }
    if (model.data!.sharedWithMe == "yes") {
      sharedWithMe = true;
    } else {
      sharedWithMe = false;
    }
    if (model.data!.friendAddProduct == "yes") {
      friendAddProduct = true;
    } else {
      friendAddProduct = false;
    }
    if (model.data!.appUpdate == "yes") {
      appUpdate = true;
    } else {
      appUpdate = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: Row(children: [
                    Text(
                      "Notifications",
                      style: AppTextStyle().textColor29292916w500,
                    ),
                    SizedBox(
                      width: 130.w,
                    ),
                  ]),
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset('assets/images/Vector190.png')),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        "Follow requests",
                        style: AppTextStyle().textColor00000014w400,
                      ),
                      Spacer(),
                      Switch(
                        activeColor: ColorSelect.colorF7E641,
                        activeTrackColor: ColorSelect.colorF6EDCA,
                        inactiveTrackColor: ColorSelect.colorEBEBEB,
                        inactiveThumbColor: ColorSelect.color9F9F9F,
                        value: followRequest,
                        onChanged: (value) {
                          setState(() {
                            followRequest = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        "Shared with me",
                        style: AppTextStyle().textColor00000014w400,
                      ),
                      Spacer(),
                      Switch(
                        activeColor: ColorSelect.colorF7E641,
                        activeTrackColor: ColorSelect.colorF6EDCA,
                        inactiveTrackColor: ColorSelect.colorEBEBEB,
                        inactiveThumbColor: ColorSelect.color9F9F9F,
                        value: sharedWithMe,
                        onChanged: (value) {
                          setState(() {
                            sharedWithMe = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        "Friends add products",
                        style: AppTextStyle().textColor00000014w400,
                      ),
                      Spacer(),
                      Switch(
                        activeColor: ColorSelect.colorF7E641,
                        activeTrackColor: ColorSelect.colorF6EDCA,
                        inactiveTrackColor: ColorSelect.colorEBEBEB,
                        inactiveThumbColor: ColorSelect.color9F9F9F,
                        value: friendAddProduct,
                        onChanged: (value) {
                          setState(() {
                            friendAddProduct = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        "App update",
                        style: AppTextStyle().textColor00000014w400,
                      ),
                      Spacer(),
                      Switch(
                        activeColor: ColorSelect.colorF7E641,
                        activeTrackColor: ColorSelect.colorF6EDCA,
                        inactiveTrackColor: ColorSelect.colorEBEBEB,
                        inactiveThumbColor: ColorSelect.color9F9F9F,
                        value: appUpdate,
                        onChanged: (value) {
                          setState(() {
                            appUpdate = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, bottom: 36),
                    child: model.data!.followRequest == null
                        ? LightYellowButtonWithText(
                            backgroundColor: MaterialStateProperty.all(
                                ColorSelect.colorF7E641),
                            textStyleColor: Colors.black,
                            onTap: () {
                              postNotificationApi(
                                      followRequest:
                                          followRequest ? 'yes' : 'no',
                                      shared: sharedWithMe ? 'yes' : 'no',
                                      friendAddProduct:
                                          friendAddProduct ? 'yes' : 'no',
                                      appUpdate: appUpdate ? 'yes' : 'no')
                                  .then((value) {
                                print(followRequest);
                                if (value['status'] == true) {
                                  setState(() {
                                    isLoading ? Loading : getNotification();
                                  });
                                  Fluttertoast.showToast(msg: value['message']);
                                } else {
                                  Fluttertoast.showToast(msg: value['message']);
                                }
                              });
                            },
                            title: 'Save')
                        : LightYellowButtonWithText(
                            backgroundColor: MaterialStateProperty.all(
                                ColorSelect.colorF7E641),
                            textStyleColor: Colors.black,
                            onTap: () {
                              // print(followRequest);
                              updateNotificationApi(
                                      followRequest:
                                          followRequest ? 'yes' : 'no',
                                      friendAddProduct:
                                          friendAddProduct ? 'yes' : 'no',
                                      appUpdate: appUpdate ? 'yes' : 'no',
                                      sharedWithMe: sharedWithMe ? 'yes' : 'no',
                                      id: model.data!.id.toString())
                                  .then(
                                (value) {
                                  print(followRequest);
                                  if (value['status'] == true) {
                                    // Navigator.Pop(context);
                                    setState(() {
                                      isLoading ? Loading : getNotification();
                                    });
                                    Fluttertoast.showToast(
                                        msg: value['message']);
                                    // setState(() {
                                    //     isLoading = true;
                                    // });
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: value['message']);
                                  }
                                },
                              );
                            },
                            title: 'update')),
              ],
            ),
          );
  }
}
