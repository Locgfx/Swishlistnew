import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/constants/globals/loading.dart';
import 'package:swishlist/constants/urls.dart';
import 'package:swishlist/dashboard/notification/fcm_notification.dart';
import 'package:swishlist/models/login_models.dart';

import '../../api/fcm_notiifcations/fcm_notification_apis.dart';
import '../../constants/color.dart';
import '../../models/fcm_notification_model/fcm_notification_model.dart';

class FcmNotificationDelete extends StatefulWidget {
  final LoginResponse response;
  const FcmNotificationDelete({
    Key? key, required this.response,
  }) : super(key: key);

  @override
  State<FcmNotificationDelete> createState() => _FcmNotificationDeleteState();
}

class _FcmNotificationDeleteState extends State<FcmNotificationDelete> {
  bool isLoading = false;

  List<FcmNotificationModel> fcmNotification = [];
  LoginResponse? response;

  getFcmNotifications() {
    isLoading = true;
    var resp = fcmNotificationApi();
    resp.then((value) {
      fcmNotification.clear();
      if (value['error'] == false) {
        setState(() {
          for (var v in value['data']) {
            fcmNotification.add(FcmNotificationModel.fromJson(v));
          }
          fcmNotification.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
          fcmNotification = fcmNotification.reversed.toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }
 // FcmNotificationModel fcmnotification = FcmNotificationModel();
  // List<FcmNotificationModel> fcmnotification = [];
  // getFcmNotifications() {
  //   isLoading = true;
  //   // friendList.clear();
  //   var resp = fcmNotificationApi();
  //   resp.then((value) {
  //     if (mounted) {
  //       if (value['status'] == true) {
  //         setState(() {
  //           fcmnotification = FcmNotificationModel.fromJson(value);
  //           isLoading = false;
  //         });
  //       } else {
  //         setState(() {
  //           isLoading = false;
  //         });
  //
  //         // isLoading = false;
  //       }
  //     }
  //   });
  // }








  List<int> selectedItems = [];
  bool loading = false;
  List<int> delete = [];
  List tagsList = [];

  bool show = false;
  bool selectAll = false;



  @override
  void initState() {
   getFcmNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Loading()
          : RefreshIndicator(
              displacement: 500,
              backgroundColor: Colors.white,
              color: ColorSelect.colorF7E641,
              strokeWidth: 3,
              onRefresh: () {
                setState(() {
                  isLoading = true;
                });
                return getFcmNotifications();
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child:  Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 60,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    Navigator.pop(context);
                                    // Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: 32,
                                    width: 32,
                                    padding: EdgeInsets.all(6),
                                    color: Colors.transparent,
                                      child: SvgPicture.asset("assets/icons/arrowback.svg")),
                                ),
                                SizedBox(width: 5,),

                                Text(
                                  "Delete Notification",
                                  style: AppTextStyle().textColor29292916w500,
                                ),
                                Spacer(),
                                selectedItems.isEmpty ?
                                    SizedBox() :
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectAll = !selectAll;

                                        if (selectAll) {
                                          selectedItems.clear();
                                          selectedItems.addAll(fcmNotification.map((item) => item.id!));
                                        } else {
                                          selectedItems.clear();
                                        }
                                      });
                                    },
                                  behavior: HitTestBehavior.translucent,
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    padding: EdgeInsets.all(10),
                                      child: Image.asset(
                                        selectAll ?
                                            "assets/icons/remove-button-svgrepo-com.png":
                                        "assets/icons/selectallicon.png",
                                        height: 24,
                                        width: 24,)),
                                ),
                                SizedBox(width: 1,),
                                selectedItems.isEmpty
                                    ? SizedBox()
                                    :
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                        onTap: () {
                                          setState(() {
                                            show = !show;
                                          });
                                          Timer timer = Timer(Duration(seconds: 2), () {
                                            setState(() {
                                              show = false;
                                            });
                                          });
                                          setState(() {
                                            loading = true;
                                          });
                                          // for (var v in selectedItems) {
                                          // List<String> stringIds = tagsList.map((id) => id.toString()).toList();
                                          fcmNotificationDeleteApi(
                                                  id:
                                                  selectedItems)
                                                .then((value) async {
                                              print("check selected items${selectedItems.toString()}");
                                              if (value['error'] == false) {
                                                setState(() {
                                                  isLoading ? Loading() :getFcmNotifications();
                                                });
                                                setState(() {
                                                  fcmNotification
                                                      .removeWhere((element) =>
                                                          element.id == selectedItems.toString());
                                                });
                                                Fluttertoast.showToast(
                                                    msg: value['message']);
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: value['message']);
                                              }
                                              setState(() {
                                                isLoading = false;
                                                selectedItems.clear();
                                              });
                                            });
                                          // }
                                        },
                                        child:
                                        show
                                            ? LoadingAnimationWidget.staggeredDotsWave(
                                          size: 30,
                                          color: Colors.black,
                                        ):
                                            // selectedItems.isEmpty ?
                                            //     Text("Delete All",style: TextStyle(color: Colors.black),) :
                                        Container(
                                          width: 40,
                                          height: 40,
                                          // color: Colors.red,
                                          padding: EdgeInsets.all(8),
                                          child: Image.asset(
                                              'assets/icons/trash-svgrepo-com.png',
                                          color: Colors.black,),
                                        ),
                                      ),
                                    ],
                                  ),
                            fcmNotification.isEmpty
                                ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 100),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                                  child:
                                  Image.asset("assets/images/empty activity.png"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 60, right: 60, top: 24),
                                  child: Text(
                                    "No notifications yet",
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(height: 40),
                              ],
                            )
                                :
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Center(
                                child: Text(
                                  "Tap and hold notification to delete",
                                  textAlign: TextAlign.center,
                                  style: AppTextStyle().textColor70707012w400,
                                ),
                              ),
                            ),
                            SizedBox(height: 16),

                            ListView.separated(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: fcmNotification.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (_, i) {
                                return GestureDetector(
                                  onLongPress: () {
                                    if (selectedItems.isEmpty) {
                                      setState(() {
                                        selectedItems
                                            .add(fcmNotification[i].id!);
                                      });
                                    }
                                  },
                                  onTap: () {
                                    if (selectedItems.isEmpty) {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             selectedItems()));
                                    } else {
                                      if (selectedItems.contains(
                                          fcmNotification[i].id!)) {
                                        setState(() {
                                          selectedItems.remove(
                                              fcmNotification[i].id!);
                                        });
                                      } else {
                                        setState(() {
                                          selectedItems.add(
                                              fcmNotification[i].id!);
                                        });
                                      }
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color: selectedItems.contains(
                                              fcmNotification[i].id!)
                                              ? Colors.redAccent
                                              : ColorSelect.colorF7E641),
                                      color: Colors.grey.withOpacity(0.02),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.grey.shade200,
                                            ),
                                            clipBehavior: Clip.hardEdge,
                                            child: CachedNetworkImage(
                                              imageUrl: fcmNotification
                                                   [i].sendBy!.photo
                                                      .toString()
                                                      .contains('http')
                                                  ? fcmNotification
                                                  [i].sendBy!.photo
                                                      .toString()
                                                  : baseUrl +
                                                  fcmNotification[i]
                                                       .sendBy!.photo
                                                          .toString(),
                                              fit: BoxFit.cover,
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                              progressIndicatorBuilder:
                                                  (a, b, c) => Opacity(
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
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                            flex: 4,
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  width: 280,
                                                  child: Text(
                                                    fcmNotification
                                                        [i].message
                                                        .toString(),
                                                    maxLines: 4,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            )),
                                        Expanded(
                                          child: fcmNotification
                                             [i].product ==
                                                  null
                                              ? SizedBox()
                                              : Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    color: Colors.grey.shade200,
                                                  ),
                                                  clipBehavior: Clip.hardEdge,
                                                  child: CachedNetworkImage(
                                                    imageUrl: fcmNotification
                                                     [i].product!.photo
                                                        .toString(),
                                                    fit: BoxFit.cover,
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                    progressIndicatorBuilder:
                                                        (a, b, c) => Opacity(
                                                      opacity: 0.3,
                                                      child: Shimmer.fromColors(
                                                        baseColor:
                                                            Colors.black12,
                                                        highlightColor:
                                                            Colors.white,
                                                        child: Container(
                                                          width: 50,
                                                          height: 50,
                                                          //margin: EdgeInsets.symmetric(horizontal: 24),
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  shape: BoxShape
                                                                      .circle),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                            ),
                                         ],
                                     ),
                                   ),
                                 );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) => SizedBox(
                                height: 16,
                              ),
                            ),
                            // selectedItems.isNotEmpty ?
                            // GestureDetector(
                            //   onTap: () {
                            //     setState(() {
                            //       selectAll = !selectAll;
                            //
                            //       if (selectAll) {
                            //         selectedItems.clear();
                            //         selectedItems.addAll(fcmNotification.map((item) => item.id!));
                            //       } else {
                            //         selectedItems.clear();
                            //       }
                            //     });
                            //   },
                            //   child: Container(
                            //     color: ColorSelect.colorFCF5B6,
                            //       padding: EdgeInsets.all(16),
                            //       child: Text(selectAll ? "Deselect All" : "Select All"),
                            //   ),
                            // )

                            SizedBox(height: 24),
                          ],
                        ),
                      ),
              ),
            ),
    );
  }
}
