import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/constants/urls.dart';
import 'package:swishlist/dashboard/products/edit_product.dart';
import 'package:swishlist/new_screens/tabs_screen/family_list.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../api/user_apis/friends_api.dart';
import '../../api/user_apis/products_api.dart';
import '../../buttons/red_button.dart';
import '../../buttons/white_button.dart';
import '../../constants/color.dart';
import '../../models/add_friend_model.dart';
import '../../models/login_models.dart';
import '../../new_screens/tabs_screen/friend_list.dart';

class ProductDetail extends StatefulWidget {
  final String name;
  final String price;
  final String link;
  final String image;
  final String purchaseDate;
  final String id;
  final String type;
  final LoginResponse response;
  final String productId;
  // final String id;
  const ProductDetail({
    Key? key,
    required this.name,
    required this.price,
    required this.link,
    required this.image,
    required this.purchaseDate,
    required this.id,
    required this.type,
    required this.response,
    required this.productId,
    // required this.id
  }) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getFriends();
    super.initState();
  }

  int pageIndex = 0;
  int selectedIndex = 0;

  bool seenBy = false;
  final textController = TextEditingController();
  final privacyController = TextEditingController();

  Future<void> launchUrlStart({required String url}) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  FriendModel friendList = FriendModel();
  bool isLoading = false;
  getFriends() {
    isLoading = true;
    // friendList.clear();
    var resp = getFriendsApi();
    resp.then((value) {
      if (mounted) {
        if (value['status'] == true) {
          setState(() {
            friendList = FriendModel.fromJson(value);
            // for (var v in value) {
            //   friendList.add(ModelFriend.fromJson(v));
            // }
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

  @override
  Widget build(BuildContext context) {
    double price = double.tryParse(widget.price) ?? 0.0;
    double normalizedPercent = price / 100.0;
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          backgroundColor: ColorSelect.colorFFFFFF,
          elevation: 0,
          title: Row(children: [
            Text(
              "Product ",
              style: AppTextStyle().textColor29292916w500,
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(builder:
                          (BuildContext context, StateSetter setState) {
                        return Container(
                          decoration: BoxDecoration(
                            color: ColorSelect.colorFFFFFF,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Container(
                                    width: 48.w,
                                    height: 4.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: ColorSelect.colorDCDCDC),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Send to",
                                            style: AppTextStyle()
                                                .textColor29292920w500,
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap: () {
                                          selectedIndex = pageIndex = 0;
                                          _pageController.jumpToPage(
                                            pageIndex,
                                          );
                                          pageIndex = 0;
                                          setState(() {});
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: pageIndex == 0
                                                ? ColorSelect.colorF7E641
                                                : Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Friends",
                                                style: AppTextStyle()
                                                    .textColor29292912w500
                                                    .copyWith(
                                                        color: pageIndex == 0
                                                            ? Color(0xff292929)
                                                            : Color(
                                                                0xff707070))),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            selectedIndex = pageIndex = 1;
                                            _pageController.jumpToPage(
                                              pageIndex,
                                            );
                                            pageIndex = 1;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: pageIndex == 1
                                                ? ColorSelect.colorF7E641
                                                : Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text("Family",
                                                style: AppTextStyle()
                                                    .textColor29292912w500
                                                    .copyWith(
                                                        color: pageIndex == 1
                                                            ? Color(0xff292929)
                                                            : Color(
                                                                0xff707070))),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  SizedBox(
                                    height: 600,
                                    child: PageView(
                                      controller: _pageController,
                                      onPageChanged: (page) {
                                        setState(
                                          () {
                                            pageIndex = page;
                                          },
                                        );
                                      },
                                      children: [
                                        FriendList(
                                          productId: widget.productId,
                                        ),
                                        FamilyList(
                                          productId2: widget.productId,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                    });
                // Share.share(widget.link);
              },
              child: Container(
                height: 32,
                width: 32,
                padding: EdgeInsets.all(4),
                child: Image.asset(
                  "assets/images/Vectorsend.png",
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 32.h,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => EditProduct(
                                          image: widget.image,
                                          id: widget.productId,
                                        ),
                                      ),
                                    );
                                    // showModalBottomSheet(
                                    //   context: context,
                                    //   builder: (context) {
                                    //     return Container(
                                    //       height: 338.h,
                                    //       child: Padding(
                                    //         padding: const EdgeInsets.symmetric(
                                    //             horizontal: 16),
                                    //         child: Column(
                                    //           crossAxisAlignment:
                                    //               CrossAxisAlignment.start,
                                    //           children: [
                                    //             SizedBox(
                                    //               height: 32.h,
                                    //             ),
                                    //             Text(
                                    //               "Edit Title",
                                    //               style: AppTextStyle()
                                    //                   .textColor3D3D3D24w700,
                                    //             ),
                                    //             SizedBox(
                                    //               height: 28.h,
                                    //             ),
                                    //             Container(
                                    //               height: 154.h,
                                    //               width: 328.w,
                                    //               decoration: BoxDecoration(
                                    //                   borderRadius:
                                    //                       BorderRadius.circular(
                                    //                           8),
                                    //                   color: ColorSelect
                                    //                       .colorFEFCF6,
                                    //                   border: Border.all(
                                    //                       color: ColorSelect
                                    //                           .colorF7E641)),
                                    //               child: Padding(
                                    //                 padding: const EdgeInsets
                                    //                     .symmetric(
                                    //                     horizontal: 12,
                                    //                     vertical: 16),
                                    //                 child: Column(
                                    //                   children: [
                                    //                     TextFormField(
                                    //                       controller:
                                    //                           textController,
                                    //                       onChanged: (v) {
                                    //                         setState(() {});
                                    //                       },
                                    //                       // controller: moviesController,
                                    //                       cursorColor:
                                    //                           ColorSelect
                                    //                               .colorF7E641,
                                    //                       decoration:
                                    //                           InputDecoration(
                                    //                         border: InputBorder
                                    //                             .none,
                                    //                         focusedBorder:
                                    //                             InputBorder
                                    //                                 .none,
                                    //                         enabledBorder:
                                    //                             InputBorder
                                    //                                 .none,
                                    //                         errorBorder:
                                    //                             InputBorder
                                    //                                 .none,
                                    //                         disabledBorder:
                                    //                             InputBorder
                                    //                                 .none,
                                    //                       ), //keyboardType: TextInputType.phone,
                                    //                     )
                                    //                   ],
                                    //                 ),
                                    //               ),
                                    //             ),
                                    //             SizedBox(
                                    //               height: 16.h,
                                    //             ),
                                    //             SizedBox(
                                    //               width: 87.w,
                                    //               height: 48.h,
                                    //               child: YellowButtonWithText(
                                    //                   backgroundColor:
                                    //                       MaterialStateProperty
                                    //                           .all(ColorSelect
                                    //                               .colorF7E641),
                                    //                   textStyleColor:
                                    //                       ColorSelect
                                    //                           .color292929,
                                    //                   onTap: () {
                                    //                     updateProducts(
                                    //                             type:
                                    //                                 widget.type,
                                    //                             name:
                                    //                                 textController
                                    //                                     .text,
                                    //                             link:
                                    //                                 widget.link,
                                    //                             price: widget
                                    //                                 .price,
                                    //                             purchaseDate: widget
                                    //                                 .purchaseDate,
                                    //                             privacyStatus:
                                    //                                 'public',
                                    //                             photo: '',
                                    //                             id: widget.id,
                                    //                             photoUrl: widget
                                    //                                 .image)
                                    //                         .then((value) {
                                    //                       if (value['status'] ==
                                    //                           true) {
                                    //                         Navigator.of(
                                    //                             context)
                                    //                           ..pop()
                                    //                           ..pop()
                                    //                           ..pop();
                                    //                         Fluttertoast.showToast(
                                    //                             msg: value[
                                    //                                 'message']);
                                    //                       } else {
                                    //                         Fluttertoast.showToast(
                                    //                             msg: value[
                                    //                                 'message']);
                                    //                       }
                                    //                     });
                                    //                   },
                                    //                   title: 'Save'),
                                    //             )
                                    //           ],
                                    //         ),
                                    //       ),
                                    //     );
                                    //   },
                                    // );
                                  },
                                  child: Container(
                                    height: 40.h,
                                    width: 328.w,
                                    color: Colors.transparent,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: SvgPicture.asset(
                                              "assets/icons/edittitle.svg"),
                                        ),
                                        Text(
                                          "Edit Product",
                                          style: AppTextStyle()
                                              .textColor39393914w500,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Share.share(widget.link);
                                  },
                                  child: Container(
                                    height: 40.h,
                                    width: 328.w,
                                    color: Colors.transparent,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 32,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: SvgPicture.asset(
                                              "assets/icons/shareimage.svg"),
                                        ),
                                        Text(
                                          "Share externally",
                                          style: AppTextStyle()
                                              .textColor39393914w500,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            insetPadding: EdgeInsets.only(
                                                left: 20, right: 20),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            elevation: 0,
                                            backgroundColor: Colors.white,
                                            content: SizedBox(
                                              width: 1.sw,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "Delete this product?",
                                                      style: AppTextStyle()
                                                          .textColor29292918w500,
                                                    ),
                                                    SizedBox(
                                                      height: 8.h,
                                                    ),
                                                    Text(
                                                      "This product with will be permanently deleted",
                                                      style: AppTextStyle()
                                                          .textcolor82828212w400,
                                                    ),
                                                    SizedBox(
                                                      height: 44.h,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: SizedBox(
                                                            height: 52,
                                                            child:
                                                                WhiteButtonWithText(
                                                                    backgroundColor:
                                                                        MaterialStateProperty.all(Colors
                                                                            .white),
                                                                    textStyleColor:
                                                                        ColorSelect
                                                                            .color292929,
                                                                    onTap: () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    title:
                                                                        'Cancel'),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 12.w,
                                                        ),
                                                        Expanded(
                                                          child: SizedBox(
                                                            height: 52,
                                                            child:
                                                                RedButtonWithText(
                                                              backgroundColor:
                                                                  MaterialStateProperty.all(
                                                                      ColorSelect
                                                                          .colorCE5252),
                                                              textStyleColor:
                                                                  ColorSelect
                                                                      .colorFFFFFF,
                                                              image: Image.asset(
                                                                  "assets/images/trashdel.png"),
                                                              onTap: () {
                                                                deleteProductsApi(
                                                                        id: widget
                                                                            .id)
                                                                    .then(
                                                                        (value) {
                                                                  if (value[
                                                                          'status'] ==
                                                                      true) {
                                                                    // Navigator
                                                                    //     .pushReplacement(
                                                                    //   context,
                                                                    //   MaterialPageRoute(
                                                                    //     builder:
                                                                    //         (context) =>
                                                                    //             WantProducts(
                                                                    //       isUser:
                                                                    //           true,
                                                                    //       response:
                                                                    //           widget.response,
                                                                    //     ),
                                                                    //   ),
                                                                    // );
                                                                    Navigator.of(
                                                                        context)
                                                                      ..pop()
                                                                      ..pop()
                                                                      ..pop();
                                                                    Fluttertoast
                                                                        .showToast(
                                                                            msg:
                                                                                value['message']);
                                                                  } else {
                                                                    Fluttertoast
                                                                        .showToast(
                                                                            msg:
                                                                                value['message']);
                                                                  }
                                                                });
                                                              },
                                                              title: 'Delete',
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                          // return DialogWidget();
                                        });
                                  },
                                  child: Container(
                                    height: 40.h,
                                    width: 328.w,
                                    color: Colors.transparent,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 32,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: SvgPicture.asset(
                                              "assets/icons/trash1.svg"),
                                        ),
                                        Text(
                                          "Delete",
                                          style: AppTextStyle()
                                              .textcolorCE535314w500,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: Container(
                    padding: EdgeInsets.all(4),
                    color: Colors.transparent,
                    height: 32,
                    width: 32,
                    child: Image.asset("assets/images/4xdot.png"))),
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
        backgroundColor: ColorSelect.colorFFFFFF,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16.h,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.name,
                    // "RESPAWN 110 Racing Style Gaming Chair, Reclining Ergonomic Chair with Footrest, in Green",
                    style: AppTextStyle().textColor29292916w500,
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
                Row(
                  children: [
                    Text(
                      // widget.price,
                      widget.link.contains("etsy")
                          ? '\$ ${normalizedPercent.toStringAsFixed(2)}'
                          : '\$ ${widget.price}',

                      // '\$ ${normalizedPercent.toString()}',
                      // "ckmmkc",
                      // normalizedPercent.toString(),
                      // "47.99",
                      style: AppTextStyle().textColor29292924w700,
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 20.h),
                Container(
                    width: 1.sw,
                    height: 246,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: ColorSelect.colorE0E0E0, width: 1)),
                    child: CachedNetworkImage(
                      imageUrl: widget.image.toString().contains("https")
                          ? widget.image
                          : baseUrl + widget.image,

                      // imageUrl:wantProducts2[i]
                      //     .photo
                      //     .toString()
                      //     .contains("https")
                      //     ? wantProducts2[i].photo.toString()
                      //     : baseUrl +
                      //     wantProducts2[i].photo.toString(),
                      // imageUrl: (baseUrl+getProducts!.data![i].photo.toString()),
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                        size: 40,
                      ),
                      progressIndicatorBuilder: (a, b, c) => Opacity(
                        opacity: 0.3,
                        child: Shimmer.fromColors(
                          baseColor: Colors.black12,
                          highlightColor: Colors.white,
                          child: Container(
                            width: 1.sw,
                            height: 246,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorSelect.colorE0E0E0, width: 1),
                                color: ColorSelect.colorFFFFFF,
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 10.h,
                ),
                /* Row(
                  children: [
                    Text(
                      'Purchase date :  ${widget.purchaseDate}',
                      // "12 June, 2022",
                      style: AppTextStyle().textColor70707012w400,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                  ],
                ),*/
                SizedBox(
                  height: 10,
                ),
                /*  Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      launchUrlStart(url: widget.link.toString() );
                    },
                    child: Text(
                      widget.link.toString(),
                      // "12 June, 2022",
                        style: AppTextStyle().textColor29292916w500,
                    ),
                  ),
                ),*/
                GestureDetector(
                  onTap: () {
                    launchUrlStart(url: widget.link.toString());
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 52.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          color: ColorSelect.colorF7E641,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "View on\n website",
                            style: AppTextStyle().textColor29292912w400,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Image.asset(
                            "assets/images/website view icon.png",
                            height: 24,
                            width: 24,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                /*   SizedBox(
                  height: 52.h,
                  width: 88.w,
                  child: LightYellowButtonWithText(
                      backgroundColor:
                      MaterialStateProperty.all(ColorSelect.colorF7E641),
                      textStyleColor:
                      Colors.black,
                      onTap: (){},


                      title: 'Add'),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
