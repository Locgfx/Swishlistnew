import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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



  List< FcmNotificationModel> fcmnotification = [];
  getFcmNotifications(){
    isLoading = true;
    var resp = fcmNotificationApi();
    resp.then((value) {
      if(value['error'] == false){
        setState(() {
          for(var v in value['data']){
            fcmnotification.add(FcmNotificationModel.fromJson(v));
          }

          isLoading = false;
        });
      }else{
        setState(() {
          isLoading = false;
        });
      }
    });
  }



  List<int> selectedItems = [];
  bool loading = false;

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
                child: fcmnotification.isEmpty
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
                            child: Row(
                              children: [
                                Text(
                                  "No notifications yet",
                                  maxLines: 2,
                                  style: AppTextStyle().roboto29292914w500,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 40),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 60,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Delete Notification",
                                  style: AppTextStyle().textColor29292920w500,
                                ),
                                Spacer(),
                                selectedItems.isEmpty
                                    ? SizedBox()
                                    : GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            loading = true;
                                          });
                                          /*for (var v in selectedItems) {
                                            fcmNotificationDeleteApi(
                                                    id: v.toString())
                                                .then((value) async {
                                              print(v);
                                              print(selectedItems.toString());
                                              if (value['status'] == true) {
                                                setState(() {
                                                  fcmnotification.data!
                                                      .removeWhere((element) =>
                                                          element.id == v);
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
                                          }*/
                                        },
                                        child: Container(
                                          width: 36,
                                          height: 36,
                                          child: Image.asset(
                                              'assets/images/del.png'),
                                        ),
                                      ),
                              ],
                            ),
                            // Text(
                            //   "hold item to delete",
                            //   style: TextStyle(fontSize: 10),
                            // ),
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
                              itemCount: fcmnotification.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (_, i) {
                                return GestureDetector(
                                  onLongPress: () {
                                    if (selectedItems.isEmpty) {
                                      setState(() {
                                        selectedItems
                                            .add(fcmnotification[i].data![i].id!);
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
                                          fcmnotification[i].data![i].id!)) {
                                        setState(() {
                                          selectedItems.remove(
                                              fcmnotification[i].data![i].id!);
                                        });
                                      } else {
                                        setState(() {
                                          selectedItems.add(
                                              fcmnotification[i].data![i].id!);
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
                                                  fcmnotification[i].data![i].id!)
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
                                                      [i].data![i].sendBy!.photo
                                                      .toString()
                                                      .contains('http')
                                                  ? fcmnotification
                                                      [i].data![i].sendBy!.photo
                                                      .toString()
                                                  : baseUrl +
                                                      fcmnotification[i]
                                                          .data![i].sendBy!.photo
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
                                                    fcmnotification
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
                                          child: fcmnotification
                                                      [i].data![i].product ==
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
                                                    imageUrl: fcmnotification
                                                        [i].data![i].product!.photo
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
