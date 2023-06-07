import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/api/user_apis/products_api.dart';
import 'package:swishlist/dashboard/products/productAdded.dart';
import 'package:swishlist/dashboard/products/productdetail.dart';
import 'package:swishlist/dashboard/products/widget/manuallyaddbottomsheetwidget.dart';
import 'package:swishlist/dashboard/products/widget/popmenu.dart';
import 'package:swishlist/dashboard/products/widget/search_filter.dart';
import 'package:swishlist/models/activity_model.dart';

import '../../api/user_apis/friends_api.dart';
import '../../buttons/yellow_button.dart';
import '../../constants/color.dart';
import '../../constants/globals/loading.dart';
import '../../constants/urls.dart';
import '../../models/friend_product_model.dart';
import '../../models/product_type_model.dart';

class FriendDonWantProducts extends StatefulWidget {
  final String friendId;
  final String friendName;
  // final bool isUser;
  const
  FriendDonWantProducts({Key? key, required this.friendId, required this.friendName,/* required this.isUser*/}) : super(key: key);

  @override
  State<FriendDonWantProducts> createState() => _FriendDonWantProductsState();
}

class _FriendDonWantProductsState extends State<FriendDonWantProducts> {

  @override
  void initState() {
    getProducts();
    super.initState();
  }



  bool loading = false;
  bool isLoading = false;
  FriendProductModel? products;
  // List <FriendProductModel> haveProducts2 = [];

  getProducts() {
    isLoading = true;
    var resp = getFriendProductsApi(friendId: widget.friendId);
    resp.then((value) {
      if (value['status'] == true) {
        setState(() {
          products = FriendProductModel.fromJson(value);
          isLoading = false;
        });
      } else {
        isLoading = false;
        setState(() {
        });
      }
      // haveProducts2.clear();
    });
  }


  int selected = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSelect.colorE5F3E2,
      appBar: AppBar(
        backgroundColor: ColorSelect.colorE5F3E2,
        elevation: 0,
        centerTitle: false,
        titleSpacing: 0,
        title: Row(
          children: [
            Text(
              "Products",
              style: AppTextStyle().textColor29292916w500,
            ),
            Spacer(),
          ],
        ),

        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset('assets/images/Vector190.png')
        ),
      ),
      /*bottomSheet: Container(),*/
      body:isLoading? Loading(): Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        /*  widget.isUser ? "I want" : */"${widget.friendName} Wants",
                        maxLines: 2,
                        style: AppTextStyle().textColor29292924w700
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 28),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    left: 16,
                    top: 36,
                    right: 16,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(24),
                          topLeft: Radius.circular(24))),
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            // Row(
                            //   children: [
                            //     Text(
                            //       '${products!.data!.length.toString()} Products',
                            //       // "6 Products",
                            //       style: AppTextStyle().textColor70707012w500,
                            //     ),
                            //   ],
                            // ),
                            ListView.builder(
                              padding: EdgeInsets.only(bottom: 30),
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: products!.data!.dontWant!.length,
                              // itemCount: 6,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 16),
                                  child: GestureDetector(
                                    onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetail(
                                                      name: products!.data!.dontWant![i].name.toString(),
                                                      price:products!.data!.dontWant![i].price.toString(),
                                                      link: products!.data!.dontWant![i].link.toString(),
                                                      image: baseUrl+products!.data!.dontWant![i].photo.toString(),
                                                      purchaseDate: products!.data!.dontWant![i].purchasedDate.toString(),
                                                      id: products!.data!.dontWant![i].id.toString(),
                                                      type: products!.data!.dontWant![i].type.toString(),
                                                    )));
                                    },
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Stack(children: [
                                                Container(
                                                  height: 86,
                                                  width: 86,
                                                  clipBehavior: Clip.hardEdge,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(8),
                                                    border: Border.all(
                                                      width: 1,
                                                      color: /*selectedItems.contains(products!.data!.dontWant![i].id!)
                                                          ? ColorSelect.colorF7E641*/
                                                           ColorSelect.colorE0E0E0,
                                                    ),
                                                  ),
                                                  child: CachedNetworkImage(
                                                    // imageUrl: (baseUrl+wantProduct2[i].photo.toString()),
                                                    imageUrl: products!.data!.dontWant![i].photo.toString().contains("https") ?
                                                    products!.data!.dontWant![i].photo.toString() :
                                                    baseUrl+products!.data!.dontWant![i].photo.toString(),
                                                    fit: BoxFit.cover,
                                                    errorWidget: (context, url, error) =>
                                                        Icon(Icons.error,size: 40,),
                                                    progressIndicatorBuilder:  (a,b,c) =>
                                                        Opacity(
                                                          opacity: 0.3,
                                                          child: Shimmer.fromColors(
                                                            baseColor: Colors.black12,
                                                            highlightColor: Colors.white,
                                                            child: Container(
                                                              width: 173,
                                                              height: 129,
                                                              decoration: BoxDecoration(
                                                                  border:
                                                                  Border.all(color: ColorSelect.colorE0E0E0, width: 1),
                                                                  color: ColorSelect.colorFFFFFF,
                                                                  borderRadius: BorderRadius.circular(12)),
                                                            ),
                                                          ),
                                                        ),
                                                  ),
                                                  // child: Center(
                                                  //     child: Image.asset(
                                                  //         "assets/images/image10.png")),
                                                ),
                                              ]),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 16),
                                                    child: SizedBox(
                                                      width: 230.w,
                                                      child: Text(
                                                        products!.data!.dontWant![i].name.toString(),
                                                        // "RESPAWN 110 Racing Style Gaming Chair, Reclining Ergonomic Chair with Footrest...",
                                                        overflow:
                                                        TextOverflow.ellipsis,
                                                        maxLines: 2,
                                                        style: AppTextStyle()
                                                            .textColor29292912w400,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 16),
                                                    child: Text(
                                                      '\$ ${products!.data!.dontWant![i].price.toString()}',
                                                      // "47.99",
                                                      style: AppTextStyle()
                                                          .textColor29292914w500,
                                                    ),
                                                  ),
                                                  SizedBox(height: 4,),
                                                  Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 16),
                                                    child: Row(
                                                      children: [
                                                        Image.asset(
                                                            "assets/images/image46.png"),
                                                        SizedBox(
                                                          width: 6,
                                                        ),
                                                        Container(
                                                          height: 5,
                                                          width: 5,
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: ColorSelect
                                                                  .color707070),
                                                        ),
                                                        SizedBox(
                                                          width: 6,
                                                        ),
                                                        Text(
                                                            DateTime.now()
                                                                .difference(
                                                                DateTime.parse(
                                                                    products!.data!.dontWant![i].createdAt.toString()))
                                                                .inMinutes <=
                                                                59
                                                                ? "${DateTime.now().difference(
                                                                DateTime.parse( products!.data!.dontWant![i].createdAt.toString())).inMinutes} min ago"
                                                                : DateTime.now()
                                                                .difference(DateTime
                                                                .parse( products!.data!.dontWant![i].createdAt.toString()))
                                                                .inHours <=
                                                                23
                                                                ? "${DateTime.now().difference(
                                                                DateTime.parse( products!.data!.dontWant![i].createdAt.toString())).inHours} hr ago"
                                                                : "${DateTime.now().difference(
                                                                DateTime.parse( products!.data!.dontWant![i].createdAt.toString())).inDays} days ago"),
                                                        // Text(
                                                        //   DateTime.now().difference(DateTime.parse(
                                                        //       wantProduct2[i].purchasedDate.
                                                        //       toString()
                                                        //   )).inMinutes <=
                                                        //     59
                                                        //       ? "${DateTime.now().difference(DateTime.parse(
                                                        //       wantProduct2[i].purchasedDate.
                                                        //   toString())).inMinutes
                                                        //   } min ago" :
                                                        //   DateTime.now().difference(DateTime.parse(
                                                        //       wantProduct2[i].purchasedDate.
                                                        //       toString()
                                                        //   )).inHours <=
                                                        //       23?
                                                        //   "${DateTime.now().difference(DateTime.parse(
                                                        //       wantProduct2[i].purchasedDate.toString())).inHours} hour ago"
                                                        //       :
                                                        //   "${DateTime.now().difference(DateTime.parse(
                                                        //       wantProduct2[i].purchasedDate.toString())).inDays} day ago"
                                                        // ),
                                                        // Text(
                                                        //   "Today",
                                                        //   style: AppTextStyle()
                                                        //       .textColor70707012w400,
                                                        // )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      if (isLoading) Loading()
                    ],
                  ),
                ),
              ),
            ],
          ),
          if(loading) Loading()
        ],
      ),
    );
  }
}


class MoveDialog extends StatefulWidget {
  final Function(String) onPop;
  final String type;
  const MoveDialog({Key? key,
    required this.onPop,
    required this.type}) : super(key: key);

  @override
  State<MoveDialog> createState() => _MoveDialogState();
}

class _MoveDialogState extends State<MoveDialog> {
  int _gIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _gIndex = 0;
              widget.onPop("dont_want");
            });
          },
          child: Container(
            height: 52.h,
            width: 328.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border:
                Border.all(width: 1, color: ColorSelect.colorA3A3A3)),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  margin: EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                    color: _gIndex == 0
                        ? ColorSelect.colorF7E641
                        : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _gIndex == 0
                          ? ColorSelect.colorF7E641
                          : ColorSelect.kAFAFAF,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.done,
                      size: 18,
                      color:
                      _gIndex == 0 ? Colors.black : Colors.transparent,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  "I don’t want",
                  style: AppTextStyle().textColor70707014w400,
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: SvgPicture.asset(
                    "assets/icons/likeicon.svg",
                    height: 24,
                    width: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _gIndex = 1;
              widget.onPop("have");
            });
          },
          child: Container(
            height: 52.h,
            width: 328.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border:
                Border.all(width: 1, color: ColorSelect.colorA3A3A3)),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  margin: EdgeInsets.only(left: 16),
                  decoration: BoxDecoration(
                    color: _gIndex == 1
                        ? ColorSelect.colorF7E641
                        : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _gIndex == 1
                          ? ColorSelect.colorF7E641
                          : ColorSelect.kAFAFAF,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.done,
                      size: 18,
                      color:
                      _gIndex == 1 ? Colors.black : Colors.transparent,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  "I have already",
                  style: AppTextStyle().textColor70707014w400,
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: SvgPicture.asset(
                    "assets/icons/bi_stars.svg",
                    height: 24,
                    width: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  @override
  void initState() {
    if (widget.type == "dont_want") {
      _gIndex = 0;
    } /*else if (widget.eventType == "upcoming") {
      _gIndex = 1;
    }*/ else {
      _gIndex = 2;
    }
    super.initState();
  }
}
