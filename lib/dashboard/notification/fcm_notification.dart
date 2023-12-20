import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/constants/globals/loading.dart';
import 'package:swishlist/constants/urls.dart';
import 'package:swishlist/dashboard/friends/new_screens/friend_product_details.dart';

import '../../api/fcm_notiifcations/fcm_notification_apis.dart';
import '../../constants/color.dart';
import '../../expanded/manage_family_members.dart';
import '../../models/fcm_notification_model/fcm_notification_model.dart';
import '../../models/login_models.dart';
import '../friends/friendproduct.dart';
import '../friends/friends_notifications.dart';
import 'fcm_notification_delete.dart';

class FcmNotificationScreen extends StatefulWidget {
  final LoginResponse response;

  const FcmNotificationScreen({Key? key, required this.response})
      : super(key: key);

  @override
  State<FcmNotificationScreen> createState() => _FcmNotificationScreenState();
}

class _FcmNotificationScreenState extends State<FcmNotificationScreen> {
  bool isLoading = false;

  /*FcmNotificationModel fcmnotification = FcmNotificationModel();
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
            print(resp);
          });
        } else {
          setState(() {
            isLoading = false;
          });

          // isLoading = false;
        }
      }
    });
  }*/

  List<FcmNotificationModel> fcmNotification = [];
  bool shouldRefresh = false;
  getFcmNotifications() {
    isLoading = true;
    var resp = fcmNotificationApi();
    resp.then((value) {
      // shouldRefresh = false;
      fcmNotification.clear();
      if (value['error'] == false) {
        setState(() {


          for (var v in value['data']) {

            fcmNotification.add(FcmNotificationModel.fromJson(v));
          }
          fcmNotification.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));

          // Reverse the order to display the latest message at the bottom
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
                child: Padding(
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
                            "Notifications",
                            style: AppTextStyle().textColor29292924w700,
                          ),
                          Spacer(),
                          // selectedItems.isEmpty
                          //     ? SizedBox()
                          //     :
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FcmNotificationDelete(response: widget.response,),
                                ),
                              ); },

                              // onTap: () async {
                              //   // Navigate to ScreenB
                              //   final result = await Navigator.push(
                              //     context,
                              //     MaterialPageRoute(builder: (context) => FcmNotificationDelete(response:  widget.response,)),
                              //   );
                              //
                              //   // Check the result from ScreenB to determine whether to refresh
                              //   if (result != null && result is bool && result) {
                              //     shouldRefresh = true;
                              //   }
                              //
                              //   // If a refresh is needed, call getFcmNotifications()
                              //   if (shouldRefresh) {
                              //     await getFcmNotifications();
                              //   }
                              // },


                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (_) => FcmNotificationDelete(response: widget.response,),
                              //   ),
                              // );
                            // },
                            child: Container(
                              width: 36,
                              height: 36,
                              child: Image.asset('assets/images/del.png'),
                            ),
                          ),
                        ],
                      ),
                      fcmNotification.isEmpty
                          //||
                          // fcmNotification == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 100),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30.0),
                                  child: Image.asset(
                                      "assets/images/empty activity.png"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 60, right: 60, top: 24),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "No notifications yet",
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 40),
                              ],
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              itemCount: fcmNotification.length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (_, i) {
                                return
                                  Container(
                                    width: 1.sw,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: fcmNotification[i].product ==
                                              null
                                              ? fcmNotification[i].message!
                                              .contains(
                                              'family member request')
                                              ? GestureDetector(
                                            // onDoubleTap: () {
                                            //   print(fcmNotification[i].id.toString());
                                            //   fcmNotificationDeleteApi(id:fcmNotification[i].id.toString() ).then((value) {
                                            //     if(value['error'] == false){
                                            //
                                            //       Fluttertoast.showToast(msg: value['message']);
                                            //
                                            //     } else{
                                            //       Fluttertoast.showToast(msg: value['message']);
                                            //     }
                                            //   });
                                            //
                                            // },
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      ManageFamilyMembers(response: widget.response,),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              padding:
                                              EdgeInsets.all(8),
                                              decoration:
                                              BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors
                                                        .yellow),
                                                color: Colors.grey
                                                    .withOpacity(
                                                    0.02),
                                                borderRadius:
                                                BorderRadius
                                                    .circular(10),
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      height: 50,
                                                      width: 50,
                                                      decoration:
                                                      BoxDecoration(
                                                        shape: BoxShape
                                                            .circle,
                                                        color: Colors
                                                            .grey
                                                            .shade200,
                                                      ),
                                                      clipBehavior:
                                                      Clip.hardEdge,
                                                      child:
                                                      CachedNetworkImage(
                                                        maxWidthDiskCache:
                                                        80,
                                                        maxHeightDiskCache:
                                                        80,
                                                        imageUrl: fcmNotification[
                                                        i]
                                                            .sendBy!
                                                            .photo
                                                            .toString(),
                                                        //     fcmNotification[i].sendBy!.photo == null ?
                                                        //         '' :
                                                        // fcmNotification[i]
                                                        //     .sendBy!
                                                        //     .photo
                                                        //     .toString()
                                                        //     .contains(
                                                        //     'http')
                                                        //     ? fcmNotification
                                                        //     [
                                                        // i]
                                                        //     .sendBy!
                                                        //     .photo
                                                        //     .toString()
                                                        //     : newBaseUrl +
                                                        //     fcmNotification
                                                        //         [i]
                                                        //         .sendBy!
                                                        //         .photo
                                                        //         .toString(),
                                                        fit: BoxFit
                                                            .cover,
                                                        errorWidget: (context,
                                                            url,
                                                            error) =>
                                                            Image.asset(
                                                                "assets/icons/userico.jpg"),
                                                        progressIndicatorBuilder:
                                                            (a, b, c) =>
                                                            Opacity(
                                                              opacity:
                                                              0.3,
                                                              child: Shimmer
                                                                  .fromColors(
                                                                baseColor:
                                                                Colors
                                                                    .black12,
                                                                highlightColor:
                                                                Colors
                                                                    .white,
                                                                child:
                                                                Container(
                                                                  width:
                                                                  50,
                                                                  height:
                                                                  50,
                                                                  //margin: EdgeInsets.symmetric(horizontal: 24),
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    color:
                                                                    Colors.white,
                                                                  ),
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
                                                    flex: 5,
                                                    child: Text(
                                                      fcmNotification[i]
                                                          .message
                                                          .toString(),
                                                      maxLines: 4,
                                                      overflow:
                                                      TextOverflow
                                                          .ellipsis,
                                                    ),
                                                  ),
                                                  // Expanded(
                                                  //     child: Container(
                                                  //       padding: EdgeInsets.all(9),
                                                  //
                                                  //       child: Image.asset(
                                                  //         "assets/images/del.png",
                                                  //       ),
                                                  //     ),
                                                  // )
                                                ],
                                              ),
                                            ),
                                          )
                                              : fcmNotification[i].message!
                                              .contains('shared profile with you')
                                              ? GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (context) =>
                                                      FriendProduct(
                                                        response: widget
                                                            .response,
                                                        friendName:
                                                        fcmNotification[
                                                        i]
                                                            .sendBy!
                                                            .name
                                                            .toString(),
                                                        friendUserName:
                                                        fcmNotification[
                                                        i]
                                                            .sendBy!
                                                            .name
                                                            .toString(),
                                                        friendId: fcmNotification[i]
                                                            .sendBy!
                                                            .id
                                                            .toString(),
                                                        friendPhoto:
                                                        fcmNotification[
                                                        i]
                                                            .sendBy!
                                                            .photo
                                                            .toString(),
                                                        // fcmNotification[
                                                        // i]
                                                        //     .sendBy!
                                                        //     .photo
                                                        //     .toString(),
                                                        id: fcmNotification[i]
                                                            .sendBy!
                                                            .id
                                                            .toString(),
                                                      ),
                                                    ),
                                                  );
                                                },
                                            child: Container(
                                              padding:
                                              EdgeInsets.all(
                                                  8),
                                              decoration:
                                              BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors
                                                        .yellow),
                                                color: Colors.grey
                                                    .withOpacity(
                                                    0.02),
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    10),
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child:
                                                    Container(
                                                      height: 50,
                                                      width: 50,
                                                      decoration:
                                                      BoxDecoration(
                                                        shape: BoxShape
                                                            .circle,
                                                        color: Colors
                                                            .grey
                                                            .shade200,
                                                      ),
                                                      clipBehavior:
                                                      Clip.hardEdge,
                                                      child:
                                                      CachedNetworkImage(
                                                        maxWidthDiskCache:
                                                        80,
                                                        maxHeightDiskCache:
                                                        80,
                                                        imageUrl:
                                                        fcmNotification[
                                                        i]
                                                            .sendBy!
                                                            .photo
                                                            .toString(),
                                                        // fcmNotification[
                                                        // i]
                                                        //     .sendBy!
                                                        //     .photo
                                                        //     .toString()
                                                        //     .contains(
                                                        //     'http')
                                                        //     ? fcmNotification[
                                                        // i]
                                                        //     .sendBy!
                                                        //     .photo
                                                        //     .toString()
                                                        //     : baseUrl +
                                                        //     fcmNotification[i].sendBy!.photo.toString(),
                                                        fit: BoxFit
                                                            .cover,
                                                        errorWidget: (context,
                                                            url,
                                                            error) =>
                                                            Image.asset(
                                                                "assets/icons/userico.jpg"),
                                                        progressIndicatorBuilder: (a,
                                                            b,
                                                            c) =>
                                                            Opacity(
                                                              opacity:
                                                              0.3,
                                                              child: Shimmer
                                                                  .fromColors(
                                                                baseColor:
                                                                Colors.black12,
                                                                highlightColor:
                                                                Colors.white,
                                                                child:
                                                                Container(
                                                                  width: 50,
                                                                  height: 50,
                                                                  decoration:
                                                                  BoxDecoration(
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
                                                    flex: 5,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                          fcmNotification[i]
                                                              .message
                                                              .toString(),
                                                          maxLines:
                                                          4,
                                                          overflow:
                                                          TextOverflow.ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // Expanded(
                                                  //   child: Container(
                                                  //     padding: EdgeInsets.all(9),
                                                  //
                                                  //     child: Image.asset(
                                                  //       "assets/images/del.png",
                                                  //     ),
                                                  //   ),
                                                  // )
                                                ],
                                              ),
                                            ),
                                          )
                                              : GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      FriendNotification(),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              padding:
                                              EdgeInsets.all(
                                                  8),
                                              decoration:
                                              BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors
                                                        .yellow),
                                                color: Colors.grey
                                                    .withOpacity(
                                                    0.02),
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    10),
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child:
                                                    Container(
                                                      height: 50,
                                                      width: 50,
                                                      decoration:
                                                      BoxDecoration(
                                                        shape: BoxShape
                                                            .circle,
                                                        color: Colors
                                                            .grey
                                                            .shade200,
                                                      ),
                                                      clipBehavior:
                                                      Clip.hardEdge,
                                                      child:
                                                      CachedNetworkImage(
                                                        maxWidthDiskCache:
                                                        80,
                                                        maxHeightDiskCache:
                                                        80,
                                                        imageUrl:
                                                        fcmNotification[
                                                        i]
                                                            .sendBy!
                                                            .photo
                                                            .toString(),
                                                        //     fcmNotification[i].sendBy!.photo == null ?
                                                        //         '' :
                                                        // fcmNotification[i]
                                                        //     .sendBy!
                                                        //     .photo
                                                        //     .toString()
                                                        //     .contains(
                                                        //     'http')
                                                        //     ? fcmNotification[
                                                        // i]
                                                        //     .sendBy!
                                                        //     .photo
                                                        //     .toString()
                                                        //     : baseUrl +
                                                        //     fcmNotification[i].sendBy!.photo.toString(),
                                                        fit: BoxFit
                                                            .cover,
                                                        errorWidget: (context,
                                                            url,
                                                            error) =>
                                                            Image.asset(
                                                                "assets/icons/userico.jpg"),
                                                        progressIndicatorBuilder: (a,
                                                            b,
                                                            c) =>
                                                            Opacity(
                                                              opacity:
                                                              0.3,
                                                              child: Shimmer
                                                                  .fromColors(
                                                                baseColor:
                                                                Colors.black12,
                                                                highlightColor:
                                                                Colors.white,
                                                                child:
                                                                Container(
                                                                  width:
                                                                  50,
                                                                  height:
                                                                  50,
                                                                  //margin: EdgeInsets.symmetric(horizontal: 24),
                                                                  decoration:
                                                                  BoxDecoration(color: Colors.white, shape: BoxShape.circle),
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
                                                    flex: 5,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                          fcmNotification[i]
                                                              .message
                                                              .toString(),
                                                          maxLines:
                                                          4,
                                                          overflow:
                                                          TextOverflow.ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // Expanded(
                                                  //   child: Container(
                                                  //     padding: EdgeInsets.all(9),
                                                  //
                                                  //     child: Image.asset(
                                                  //       "assets/images/del.png",
                                                  //     ),
                                                  //   ),
                                                  // )
                                                ],
                                              ),
                                            ),
                                          )
                                              : GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                print(fcmNotification[i]
                                                    .product!
                                                    .price
                                                    .toString());
                                              });
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      FriendProductDetail(
                                                        name: fcmNotification[i]
                                                            .product!.name
                                                            .toString(),
                                                        price: fcmNotification[i]
                                                            .product!
                                                            .price
                                                            .toString(),
                                                        link: fcmNotification[i]
                                                            .product!
                                                            .url
                                                            .toString(),
                                                        image: fcmNotification[i]
                                                            .product!
                                                            .photo
                                                            .toString(),
                                                        purchaseDate:
                                                        '',
                                                        id: '',
                                                        type: fcmNotification[i]
                                                            .product!
                                                            .type
                                                            .toString(),
                                                        response:
                                                        widget.response,
                                                        productId:
                                                        fcmNotification[i]
                                                            .product!
                                                            .id
                                                            .toString(),

                                                        /* id: searchList[i].id.toString(),*/
                                                      ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.yellow),
                                                color: Colors.grey
                                                    .withOpacity(0.02),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    10),
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      height: 50,
                                                      width: 50,
                                                      decoration:
                                                      BoxDecoration(
                                                        shape: BoxShape
                                                            .circle,
                                                        color: Colors.grey
                                                            .shade200,
                                                      ),
                                                      clipBehavior:
                                                      Clip.hardEdge,
                                                      child:
                                                      CachedNetworkImage(
                                                        maxWidthDiskCache:
                                                        80,
                                                        maxHeightDiskCache:
                                                        80,
                                                        imageUrl:
                                                        fcmNotification[
                                                        i]
                                                            .sendBy!
                                                            .photo
                                                            .toString(),
                                                        // fcmNotification[i].sendBy!.photo == null ?
                                                        // '' :fcmNotification[i]
                                                        //     .sendBy!
                                                        //     .photo
                                                        //     .toString()
                                                        //     .contains(
                                                        //     'http')
                                                        //     ? fcmNotification[i]
                                                        //     .sendBy!
                                                        //     .photo
                                                        //     .toString()
                                                        //     : baseUrl +
                                                        //     fcmNotification[
                                                        //     i]
                                                        //         .sendBy!
                                                        //         .photo
                                                        //         .toString(),
                                                        fit: BoxFit.cover,
                                                        errorWidget: (context,
                                                            url,
                                                            error) =>
                                                            Image.asset(
                                                                "assets/icons/userico.jpg"),
                                                        progressIndicatorBuilder:
                                                            (a, b, c) =>
                                                            Opacity(
                                                              opacity: 0.3,
                                                              child: Shimmer
                                                                  .fromColors(
                                                                baseColor: Colors
                                                                    .black12,
                                                                highlightColor:
                                                                Colors
                                                                    .white,
                                                                child:
                                                                Container(
                                                                  width: 50,
                                                                  height: 50,
                                                                  //margin: EdgeInsets.symmetric(horizontal: 24),
                                                                  decoration: BoxDecoration(
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
                                                  SizedBox(
                                                    width: 6,
                                                  ),
                                                  Expanded(
                                                    flex: 4,
                                                    child: SizedBox(
                                                      width: 220,
                                                      child: Text(
                                                        fcmNotification[i]
                                                            .message
                                                            .toString(),
                                                        maxLines: 4,
                                                        overflow:
                                                        TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 6,
                                                  ),
                                                  // SizedBox(width: 16),
                                                  Expanded(
                                                    child: Container(
                                                      height: 50,
                                                      width: 50,
                                                      decoration:
                                                      BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            12),
                                                        color: Colors.grey
                                                            .shade200,
                                                      ),
                                                      clipBehavior:
                                                      Clip.hardEdge,
                                                      child:
                                                      CachedNetworkImage(
                                                        maxWidthDiskCache:
                                                        80,
                                                        maxHeightDiskCache:
                                                        80,
                                                        imageUrl:
                                                        fcmNotification[
                                                        i]
                                                            .product!
                                                            .photo
                                                            .toString(),
                                                        // fcmNotification[i]
                                                        //     .product!
                                                        //     .photo
                                                        //     .toString()
                                                        //     .contains(
                                                        //     'http')
                                                        //     ? fcmNotification[i]
                                                        //     .product!
                                                        //     .photo
                                                        //     .toString()
                                                        //     : baseUrl +
                                                        //     fcmNotification[i]
                                                        //         .product!
                                                        //         .photo
                                                        //         .toString(),
                                                        fit: BoxFit.cover,
                                                        errorWidget: (context,
                                                            url,
                                                            error) =>
                                                            Image.asset(
                                                                "assets/icons/userico.jpg"),
                                                        progressIndicatorBuilder:
                                                            (a, b, c) =>
                                                            Opacity(
                                                              opacity: 0.3,
                                                              child: Shimmer
                                                                  .fromColors(
                                                                baseColor: Colors
                                                                    .black12,
                                                                highlightColor:
                                                                Colors
                                                                    .white,
                                                                child:
                                                                Container(
                                                                  width: 50,
                                                                  height: 50,
                                                                  //margin: EdgeInsets.symmetric(horizontal: 24),
                                                                  decoration: BoxDecoration(
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
                                                  // Expanded(
                                                  //   child: Container(
                                                  //     padding: EdgeInsets.all(9),
                                                  //
                                                  //     child: Image.asset(
                                                  //       "assets/images/del.png",
                                                  //     ),
                                                  //   ),
                                                  // )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) => SizedBox(
                                height: 16,
                              ),
                            )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
