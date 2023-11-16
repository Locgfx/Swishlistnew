import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/constants/globals/loading.dart';
import 'package:swishlist/constants/urls.dart';

import '../../api/fcm_notiifcations/fcm_notification_apis.dart';
import '../../constants/color.dart';
import '../../models/fcm_notification_model/fcm_notification_model.dart';

class FcmNotificationDelete extends StatefulWidget {
  const FcmNotificationDelete({
    Key? key,
  }) : super(key: key);

  @override
  State<FcmNotificationDelete> createState() => _FcmNotificationDeleteState();
}

class _FcmNotificationDeleteState extends State<FcmNotificationDelete> {
  bool isLoading = false;
  FcmNotificationModel fcmnotification = FcmNotificationModel();
  // List<FcmNotificationModel> fcmnotification = [];
  getFcmNotifications() {
    isLoading = true;
    // friendList.clear();
    var resp = fcmNotificationApi();
    resp.then((value) {
      if (mounted) {
        if (value['status'] == true) {
          setState(() {
            fcmnotification = FcmNotificationModel.fromJson(value);
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });

          // isLoading = false;
        }
      }
    });
  }

  List<int> selectedItems = [];
  bool loading = false;
  bool show = false;

  @override
  void initState() {
    getFcmNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text(
          "Delete Notifications",
          style: AppTextStyle().textColor29292916w500,
        ),
        actions: [
          selectedItems.isEmpty
              ? SizedBox()
              : GestureDetector(
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
                    for (var v in selectedItems) {
                      fcmNotificationDeleteApi(id: v.toString())
                          .then((value) async {
                        print(v);
                        print(selectedItems.toString());
                        if (value['status'] == true) {
                          setState(() {
                            fcmnotification.data!
                                .removeWhere((element) => element.id == v);
                          });
                          Fluttertoast.showToast(msg: value['message']);
                        } else {
                          Fluttertoast.showToast(msg: value['message']);
                        }
                        setState(() {
                          isLoading = false;
                          selectedItems.clear();
                        });
                      });
                    }
                  },
                  child: show
                      ? Center(
                          child: Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: LoadingAnimationWidget.staggeredDotsWave(
                                size: 30,
                                color: Colors.black.withOpacity(0.70),
                              )),
                        )
                      : Container(
                          margin: EdgeInsets.only(right: 16),
                          width: 36,
                          height: 36,
                          child: Image.asset('assets/images/del.png'),
                        ),
                ),
        ],
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
                child: fcmnotification.data!.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 60, left: 60, right: 60, bottom: 16),
                              child: Image.asset(
                                "assets/images/empty activity.png",
                              ),
                            ),
                            Text(
                              "No notifications yet",
                            ),
                            SizedBox(height: 40),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 16,
                            ),
                            // Row(
                            //   children: [
                            //
                            //
                            //     selectedItems.isEmpty
                            //         ? SizedBox()
                            //         : GestureDetector(
                            //             onTap: () {
                            //               setState(() {
                            //                 loading = true;
                            //               });
                            //               for (var v in selectedItems) {
                            //                 fcmNotificationDeleteApi(
                            //                         id: v.toString())
                            //                     .then((value) async {
                            //                   print(v);
                            //                   print(selectedItems.toString());
                            //                   if (value['status'] == true) {
                            //                     setState(() {
                            //                       fcmnotification.data!
                            //                           .removeWhere((element) =>
                            //                               element.id == v);
                            //                     });
                            //                     Fluttertoast.showToast(
                            //                         msg: value['message']);
                            //                   } else {
                            //                     Fluttertoast.showToast(
                            //                         msg: value['message']);
                            //                   }
                            //                   setState(() {
                            //                     isLoading = false;
                            //                     selectedItems.clear();
                            //                   });
                            //                 });
                            //               }
                            //             },
                            //             child: Container(
                            //               width: 36,
                            //               height: 36,
                            //               child: Image.asset(
                            //                   'assets/images/del.png'),
                            //             ),
                            //           ),
                            //   ],
                            // ),
                            // Text(
                            //   "hold item to delete",
                            //   style: TextStyle(fontSize: 10),
                            // ),
                            Center(
                              child: Text(
                                "Tap and hold notification to delete",
                                textAlign: TextAlign.center,
                                style: AppTextStyle().textColor70707012w400,
                              ),
                            ),

                            SizedBox(height: 16),

                            ListView.separated(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: fcmnotification.data!.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (_, i) {
                                return GestureDetector(
                                  onLongPress: () {
                                    if (selectedItems.isEmpty) {
                                      setState(() {
                                        selectedItems
                                            .add(fcmnotification.data![i].id!);
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
                                          fcmnotification.data![i].id!)) {
                                        setState(() {
                                          selectedItems.remove(
                                              fcmnotification.data![i].id!);
                                        });
                                      } else {
                                        setState(() {
                                          selectedItems.add(
                                              fcmnotification.data![i].id!);
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
                                                  fcmnotification.data![i].id!)
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
                                              imageUrl: fcmnotification
                                                      .data![i].sendBy!.photo
                                                      .toString()
                                                      .contains('http')
                                                  ? fcmnotification
                                                      .data![i].sendBy!.photo
                                                      .toString()
                                                  : baseUrl +
                                                      fcmnotification.data![i]
                                                          .sendBy!.photo
                                                          .toString(),
                                              fit: BoxFit.cover,
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Image.asset(
                                                      "assets/icons/userico.jpg"),
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
                                                    fcmnotification
                                                        .data![i].message
                                                        .toString(),
                                                    maxLines: 4,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            )),
                                        Expanded(
                                          child: fcmnotification
                                                      .data![i].product ==
                                                  null
                                              ? SizedBox()
                                              : Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    color: Colors.transparent,
                                                  ),
                                                  clipBehavior: Clip.hardEdge,
                                                  child: CachedNetworkImage(
                                                    imageUrl: fcmnotification
                                                        .data![i].product!.photo
                                                        .toString(),
                                                    fit: BoxFit.cover,
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        Image.asset(
                                                            'assets/icons/logoswishlist.png'),
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
                                        )
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
                            SizedBox(height: 24),
                          ],
                        ),
                      ),
              ),
            ),
    );
  }
}
