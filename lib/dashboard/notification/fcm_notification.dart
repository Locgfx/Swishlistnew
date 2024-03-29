import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                                  builder: (_) => FcmNotificationDelete(),
                                ),
                              );
                            },
                            child: Container(
                              width: 36,
                              height: 36,
                              child: Image.asset('assets/images/del.png'),
                            ),
                          ),
                        ],
                      ),
                      fcmnotification.data!.isEmpty ||
                              fcmnotification.data == null
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
                                    width: 1.sw,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: fcmnotification
                                                      .data![i].product ==
                                                  null
                                              ? fcmnotification.data![i].title!
                                                      .contains(
                                                          'Family Member Request')
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (_) =>
                                                                ManageFamilyMembers(),
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
                                                                      65,
                                                                  maxHeightDiskCache:
                                                                      65,
                                                                  imageUrl: fcmnotification
                                                                          .data![
                                                                              i]
                                                                          .sendBy!
                                                                          .photo
                                                                          .toString()
                                                                          .contains(
                                                                              'http')
                                                                      ? fcmnotification
                                                                          .data![
                                                                              i]
                                                                          .sendBy!
                                                                          .photo
                                                                          .toString()
                                                                      : baseUrl +
                                                                          fcmnotification
                                                                              .data![i]
                                                                              .sendBy!
                                                                              .photo
                                                                              .toString(),
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
                                                                fcmnotification
                                                                    .data![i]
                                                                    .message
                                                                    .toString(),
                                                                maxLines: 4,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : fcmnotification
                                                          .data![i].title!
                                                          .contains('Hey')
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
                                                                      fcmnotification
                                                                          .data![
                                                                              i]
                                                                          .sendBy!
                                                                          .name
                                                                          .toString(),
                                                                  friendUserName:
                                                                      fcmnotification
                                                                          .data![
                                                                              i]
                                                                          .sendBy!
                                                                          .name
                                                                          .toString(),
                                                                  friendId: fcmnotification
                                                                      .data![i]
                                                                      .sendBy!
                                                                      .id
                                                                      .toString(),
                                                                  friendPhoto:
                                                                      fcmnotification
                                                                          .data![
                                                                              i]
                                                                          .sendBy!
                                                                          .photo
                                                                          .toString(),
                                                                  id: fcmnotification
                                                                      .data![i]
                                                                      .sendBy!
                                                                      .id
                                                                      .toString(),
                                                                  /* id: searchList[i].id.toString(),*/
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
                                                                          65,
                                                                      maxHeightDiskCache:
                                                                          65,
                                                                      imageUrl: fcmnotification
                                                                              .data![
                                                                                  i]
                                                                              .sendBy!
                                                                              .photo
                                                                              .toString()
                                                                              .contains(
                                                                                  'http')
                                                                          ? fcmnotification
                                                                              .data![
                                                                                  i]
                                                                              .sendBy!
                                                                              .photo
                                                                              .toString()
                                                                          : baseUrl +
                                                                              fcmnotification.data![i].sendBy!.photo.toString(),
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
                                                                        fcmnotification
                                                                            .data![i]
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
                                                                          65,
                                                                      maxHeightDiskCache:
                                                                          65,
                                                                      imageUrl: fcmnotification
                                                                              .data![
                                                                                  i]
                                                                              .sendBy!
                                                                              .photo
                                                                              .toString()
                                                                              .contains(
                                                                                  'http')
                                                                          ? fcmnotification
                                                                              .data![
                                                                                  i]
                                                                              .sendBy!
                                                                              .photo
                                                                              .toString()
                                                                          : baseUrl +
                                                                              fcmnotification.data![i].sendBy!.photo.toString(),
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
                                                                        fcmnotification
                                                                            .data![i]
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
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                              : GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            FriendProductDetail(
                                                          name: fcmnotification
                                                              .data![i]
                                                              .product!
                                                              .name
                                                              .toString(),
                                                          price: fcmnotification
                                                              .data![i]
                                                              .product!
                                                              .price
                                                              .toString(),
                                                          link: fcmnotification
                                                              .data![i]
                                                              .product!
                                                              .link
                                                              .toString(),
                                                          image: fcmnotification
                                                              .data![i]
                                                              .product!
                                                              .photo
                                                              .toString(),
                                                          purchaseDate:
                                                              fcmnotification
                                                                  .data![i]
                                                                  .product!
                                                                  .purchasedDate
                                                                  .toString(),
                                                          id: '',
                                                          type: fcmnotification
                                                              .data![i]
                                                              .product!
                                                              .type
                                                              .toString(),
                                                          response:
                                                              widget.response,
                                                          productId:
                                                              fcmnotification
                                                                  .data![i]
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
                                                                  65,
                                                              maxHeightDiskCache:
                                                                  65,
                                                              imageUrl: fcmnotification
                                                                      .data![i]
                                                                      .sendBy!
                                                                      .photo
                                                                      .toString()
                                                                      .contains(
                                                                          'http')
                                                                  ? fcmnotification
                                                                      .data![i]
                                                                      .sendBy!
                                                                      .photo
                                                                      .toString()
                                                                  : baseUrl +
                                                                      fcmnotification
                                                                          .data![
                                                                              i]
                                                                          .sendBy!
                                                                          .photo
                                                                          .toString(),
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
                                                              fcmnotification
                                                                  .data![i]
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
                                                                  65,
                                                              maxHeightDiskCache:
                                                                  65,
                                                              imageUrl: fcmnotification
                                                                      .data![i]
                                                                      .product!
                                                                      .photo
                                                                      .toString()
                                                                      .contains(
                                                                          'http')
                                                                  ? fcmnotification
                                                                      .data![i]
                                                                      .product!
                                                                      .photo
                                                                      .toString()
                                                                  : baseUrl +
                                                                      fcmnotification
                                                                          .data![
                                                                              i]
                                                                          .product!
                                                                          .photo
                                                                          .toString(),
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
                                                        )
                                                      ],
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
                            )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
