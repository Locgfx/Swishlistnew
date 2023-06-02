import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/dashboard/friends/chatpage.dart';
import 'package:swishlist/dashboard/friends/profile_chat.dart';
import 'package:swishlist/dashboard/friends/widget/appbar_icon.dart';
import 'package:swishlist/dashboard/products/productadd.dart';
import 'package:swishlist/dashboard/products/productdontwant.dart';
import 'package:swishlist/profile_page/widgets/popup_menu_widget.dart';

import '../../api/user_apis/friends_api.dart';
import '../../constants/urls.dart';
import '../../models/add_friend_model.dart';
import '../products/products_page.dart';
import '../products/wantproducts.dart';
import 'friend_profile.dart';
import 'friends_notifications.dart';

class FriendProduct extends StatefulWidget {
  final String friendName;
  final String friendUserName;
  final String friendId;
  final String friendPhoto;
  final String id;

  const FriendProduct({
    Key? key,
    required this.friendName,
    required this.friendUserName,
    required this.friendId,
    required this.friendPhoto,
    required this.id,

  }) : super(key: key);

  @override
  State<FriendProduct> createState() => _FriendProductState();
}

class _FriendProductState extends State<FriendProduct> {
  List imageList = ["assets/images/image11.png", "assets/images/image10.png"];
  List itemNameList = [
    "MorePro Fitness Tracker, Heart Rate Monitor Blood Pressure ...",
    "RESPAWN 110 Racing Style Gaming Chair, Reclining Ergon..."
  ];
  List itemPrice = ["87.29", "127.99"];
  List popList = ['Send Profile', 'Notification', 'Block', 'Unfriend'];


  @override
  void initState() {
    print(widget.friendId);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned(
              top: 250.h,
              left: 0,
              child: Image.asset("assets/images/Rectangle356.png")),
          Positioned(
              top: 500.h,
              left: 0,
              child: Image.asset("assets/images/Rectangle3564.png")),
          Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Row(
                children: [
                  Text(
                    widget.friendUserName,
                    // "AndyAngie3260",
                    style: AppTextStyle().textColor39393916w500,
                  ),
                  Spacer(),
                  AppBarIcon(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProfileChatPage(
                              friendId: widget.friendId,
                              name: widget.friendName,
                              friendImage: widget.friendPhoto,
                              selectedItems: [],),
                          ),
                        );
                      },
                      iconName: '4xchat'),
                  Container(
                    height: 24,
                    width: 24,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: 16,left: 180),
                              child: Material(
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                      border: Border.all(width: 1,color: ColorSelect.colorECEDF0),
                                      borderRadius: BorderRadius.circular(16)),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                      ListTile(
                                        title: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              Share.share('Share your friend details');
                                            });
                                            },
                                          child: Text(
                                            'Send Profile',
                                            style:
                                            // AppTextStyle().textColorBA505014w500
                                            AppTextStyle().textColor39393914w500,
                                                        ),
                                                      ),
                                                    ),
                                ListTile(
                                                  title: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => FriendNotification()));

                                                    },
                                                    child: Text(
                                                        'Notification',
                                                        style:
                                                        // AppTextStyle().textColorBA505014w500
                                                       AppTextStyle().textColor39393914w500,
                                                    ),
                                                  ),
                                                ),
                                        ListTile(
                                          title: GestureDetector(
                                            onTap: () {
                                              deleteFriendApi(
                                                                          id: widget.id).then((value) {
                                                                        if(value['status'] == true) {
                                                                          Fluttertoast.showToast(msg: value['message']);
                                                                          Navigator.pop(context);
                                                                          Navigator.pop(context);
                                                                        } else {
                                                                          Fluttertoast.showToast(msg: value['message']);
                                                                        }
                                                                      });

                                            },
                                            child: Text(
                                              'Unfriend',
                                              style:
                                              // AppTextStyle().textColorBA505014w500
                                              AppTextStyle().textColor39393914w500,
                                            ),
                                          ),
                                        ),


                                      ],
                                    ),
                                  ),
                                  // margin: EdgeInsets.only(
                                  //     right: 10,
                                  //     top: 10,
                                  //     left: 60,
                                  //     bottom: 6004
                                  // ),
                                  // ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                        child: Image.asset("assets/images/4xdot.png")),
                  )
                  // Popupmen(
                  //   menuList: [
                  //     // for (int i = 0; i < 4; i++)
                  //       PopupMenuItem(
                  //           child: Column(
                  //             children: [
                  //               ListTile(
                  //                 title: GestureDetector(
                  //                   onTap: () {},
                  //                   child: Text(
                  //                       'Send Profile',
                  //                       style:
                  //                       // AppTextStyle().textColorBA505014w500
                  //                      AppTextStyle().textColor39393914w500,
                  //                   ),
                  //                 ),
                  //               ),
                  //               ListTile(
                  //                 title: GestureDetector(
                  //                   onTap: () {},
                  //                   child: Text(
                  //                       'Notification',
                  //                       style:
                  //                       // AppTextStyle().textColorBA505014w500
                  //                      AppTextStyle().textColor39393914w500,
                  //                   ),
                  //                 ),
                  //               ),
                  //               ListTile(
                  //                 title: GestureDetector(
                  //                   onTap: () {
                  //                     deleteFriendApi(
                  //                         id: widget.id).then((value) {
                  //                       if(value['status'] == true) {
                  //                         Fluttertoast.showToast(msg: value['message']);
                  //                         Navigator.pop(context);
                  //                         Navigator.pop(context);
                  //                       } else {
                  //                         Fluttertoast.showToast(msg: value['message']);
                  //                       }
                  //                     });
                  //                   },
                  //                   child: Text(
                  //                       'Unfriend',
                  //                       style:
                  //                       // AppTextStyle().textColorBA505014w500
                  //                     AppTextStyle().textColor39393914w500,
                  //                   ),
                  //                 ),
                  //               ),
                  //               // ListTile(
                  //               //   title: GestureDetector(
                  //               //     onTap: () {},
                  //               //     child: Text(
                  //               //         'Send Profile',
                  //               //         style:
                  //               //         // AppTextStyle().textColorBA505014w500
                  //               //        AppTextStyle().textColor39393914w500,
                  //               //     ),
                  //               //   ),
                  //               // )
                  //             ],
                  //           )
                  //       ),
                  //   ],
                  //   icon: AppBarIcon(onTap: () {}, iconName: 'Vector'),
                  // ),
                  /*AppBarIcon(onTap: () {}, iconName: 'Vector'),*/
                ],
              ),
              leading: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset('assets/images/Vector190.png')),
              ),
            ),
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Stack(
                      clipBehavior: Clip.hardEdge,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            "assets/images/Rectangle1112.png",
                            height: 80,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => FriendProfile(friendId: widget.friendId,
                                 /* friendId: widget.friendId,
                                  friendName: widget.friendName,
                                  friendUserName: widget.friendUserName,*/
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: 1.sw,
                            padding: EdgeInsets.all(16),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    width: 1, color: ColorSelect.colorA3A3A3)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 48,
                                        height: 48,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey,
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: widget.friendPhoto,
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
                                                    width: 48,
                                                    height: 48,
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
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          widget.friendName,
                                          // 'Friend Name',
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTextStyle()
                                              .textColor29292916w500r,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Profile',
                                      style:
                                          AppTextStyle().textColor70707014w400,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Colors.black,
                                        size: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${widget.friendUserName} want',
                            // 'Friend Name wants',
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle().textColor29292920w700,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => WantProducts(
                                  isUser: false,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 10,
                                top: 10,
                                bottom: 10
                            ),
                            color: Colors.transparent,
                            child: Text(
                              'View All',
                              style: AppTextStyle().textColor29292914w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    height: 220,
                    child: IWantProductListWidget(
                      imageList: imageList,
                      itemNameList: itemNameList,
                      itemPrice: itemPrice,
                    ),
                  ),
                  SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${widget.friendUserName} does not want',
                            // 'Friend Name does not want',
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle().textColor29292920w700,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Productdontwant(
                                  isUser: false,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding:
                                EdgeInsets.only(left: 10, top: 10, bottom: 10),
                            color: Colors.transparent,
                            child: Text(
                              'View All',
                              style: AppTextStyle().textColor29292914w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    height: 220,
                    child: IWantProductListWidget(
                      imageList: imageList,
                      itemNameList: itemNameList,
                      itemPrice: itemPrice,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
