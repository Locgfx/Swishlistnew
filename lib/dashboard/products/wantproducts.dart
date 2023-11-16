import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/api/user_apis/products_api.dart';
import 'package:swishlist/dashboard/dashboard.dart';
import 'package:swishlist/dashboard/products/productdetail.dart';

import '../../constants/color.dart';
import '../../constants/globals/loading.dart';
import '../../constants/urls.dart';
import '../../models/login_models.dart';
import '../../models/product_type_model.dart';
import 'link_product_bottom_sheets/want_product_bottom_sheet.dart';

class WantProducts extends StatefulWidget {
  final LoginResponse response;
  final bool isUser;
  const WantProducts({Key? key, required this.isUser, required this.response})
      : super(key: key);

  @override
  State<WantProducts> createState() => _WantProductsState();
}

class _WantProductsState extends State<WantProducts> {
  @override
  void initState() {
    getWantProducts();
    super.initState();
  }

  List<int> selectedItems = [];
  bool loading = false;
  bool isLoading = false;
  List<ProductTypeModel> wantProducts = [];
  List<ProductTypeModel> wantProducts2 = [];

  getWantProducts() {
    isLoading = true;
    var resp = getProductsApi();
    resp.then((value) {
      wantProducts2.clear();
      wantProducts.clear();
      if (value['status'] == true) {
        setState(() {
          for (var v in value['data']) {
            wantProducts.add(ProductTypeModel.fromJson(v));
          }
          for (var v in wantProducts) {
            if (v.type! == "want") {
              wantProducts2.add(v);
              wantProducts2.removeWhere((element) => element.id == v);
            }
          }
          isLoading = false;
        });
      } else {
        isLoading = false;
        // wantProducts2.clear();
      }
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
              "${selectedItems.isEmpty ? '' : selectedItems.length} ${selectedItems.isEmpty ? 'Products' : selectedItems.length == 1 ? 'Product' : 'Products'}",
              style: AppTextStyle().textColor29292916w500,
            ),
            Spacer(),
            // if (selectedItems.isEmpty)
            // GestureDetector(
            //   onTap: () {
            //     // showModalBottomSheet(
            //     //   backgroundColor: Colors.transparent,
            //     //   context: context,
            //     //   isScrollControlled: true,
            //     //   builder: (_) => SearchFilters(),
            //     // );
            //   },
            //   // child: Container(
            //   //     color: Colors.transparent,
            //   //     child: Image.asset("assets/images/filter06.png")),
            // ),
            if (selectedItems.isEmpty)
              SizedBox(
                width: 20,
              ),
            // MyOptionsDialog(),
            // if (selectedItems.isEmpty) MyOptionsDialoglist(
            //   onTap: () {
            //     isLoading ? Loading() :getWantProduct();
            //
            //
            //   },),
          ],
        ),
        actions: selectedItems.isEmpty
            ? []
            : [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      loading = true;
                    });
                    for (var v in selectedItems) {
                      deleteProductsApi(id: v.toString()).then((value) async {
                        print(selectedItems.toString());
                        if (value['status'] == true) {
                          setState(() {
                            wantProducts2
                                .removeWhere((element) => element.id == v);
                          });
                          Fluttertoast.showToast(msg: value['message']);
                        } else {
                          Fluttertoast.showToast(msg: value['message']);
                        }
                        setState(() {
                          loading = false;
                          selectedItems.clear();
                        });
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Container(
                      width: 36,
                      height: 36,
                      color: Colors.transparent,
                      child: Image.asset('assets/images/del.png'),
                    ),
                  ),
                ),
              ],
        leading: InkWell(
          onTap: () {
            selectedItems.isEmpty
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Dashboard(
                              response: widget.response,
                            )))
                // ? Navigator.pop(context)
                : setState(() {
                    selectedItems.clear();
                  });
          },
          child: selectedItems.isEmpty
              ? Image.asset('assets/images/Vector190.png')
              : Icon(
                  Icons.clear,
                  color: Colors.black,
                ),
        ),
      ),
      /*bottomSheet: Container(),*/
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Stack(
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
                          widget.isUser ? "I want" : 'Friend Name Wants',
                          maxLines: 2,
                          style: AppTextStyle().textColor29292924w700,
                        ),
                      ),
                      Container(
                        width: 86.w,
                        height: 44.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: ColorSelect.colorF7E641),
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return WantProductAddBottomSheetWidget(
                                    productType: 'want',
                                  );
                                });
                          },
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Icon(Icons.add),
                              SizedBox(width: 9),
                              Text(
                                "Add",
                                style: AppTextStyle().textColor29292914w500,
                              )
                            ],
                          ),
                        ),
                      )
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
                              Row(
                                children: [
                                  Text(
                                    '${wantProducts2.length.toString()} Products',
                                    // "6 Products",
                                    style: AppTextStyle().textColor70707012w500,
                                  ),
                                ],
                              ),
                              wantProducts2.isEmpty
                                  ?
                                  // AddProductImage(
                                  //         image: 'assets/images/Asset 1product 1.png',
                                  //         txt: 'Add Product',
                                  //         buttonTxt: 'Add Product',
                                  //         tap: () {},
                                  //         buttonIcon: 'assets/images/plus.png',
                                  //       )
                                  Center(
                                      child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30.0),
                                          child: Image.asset(
                                              'assets/images/Asset 1product 1.png'),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 66, right: 66, top: 24),
                                          child: Text(
                                            "No products yet",
                                            style: AppTextStyle()
                                                .roboto29292914w500,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ))
                                  : ListView.builder(
                                      padding: EdgeInsets.only(bottom: 30),
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: wantProducts2.length,
                                      // itemCount: 6,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, i) {
                                        double price = double.tryParse(
                                                wantProducts2[i]
                                                    .price
                                                    .toString()) ??
                                            0.0;
                                        double normalizedPercent =
                                            price / 100.00;
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 16),
                                          child: GestureDetector(
                                            onLongPress: () {
                                              print(selectedItems);
                                              if (selectedItems.isEmpty) {
                                                setState(() {
                                                  selectedItems.add(
                                                      wantProducts2[i].id!);
                                                });
                                              }
                                            },
                                            onTap: () {
                                              if (selectedItems.isEmpty) {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProductDetail(
                                                              response: widget
                                                                  .response,
                                                              name: wantProducts2[
                                                                      i]
                                                                  .name
                                                                  .toString(),
                                                              price:
                                                                  '${wantProducts2[i].price.toString()}',
                                                              link: wantProducts2[
                                                                      i]
                                                                  .link
                                                                  .toString(),
                                                              image:
                                                                  wantProducts2[
                                                                          i]
                                                                      .photo
                                                                      .toString(),
                                                              purchaseDate:
                                                                  wantProducts2[
                                                                          i]
                                                                      .purchasedDate
                                                                      .toString(),
                                                              id: wantProducts2[
                                                                      i]
                                                                  .id
                                                                  .toString(),
                                                              type: wantProducts2[
                                                                      i]
                                                                  .type
                                                                  .toString(),
                                                              productId:
                                                                  wantProducts2[
                                                                          i]
                                                                      .id
                                                                      .toString(),
                                                            )));
                                                print(wantProducts2[i]
                                                    .photo
                                                    .toString());
                                              } else {
                                                if (selectedItems.contains(
                                                    wantProducts2[i].id!)) {
                                                  setState(() {
                                                    selectedItems.remove(
                                                        wantProducts2[i].id!);
                                                  });
                                                } else {
                                                  setState(() {
                                                    selectedItems.add(
                                                        wantProducts2[i].id!);
                                                  });
                                                }
                                              }
                                              //log("hello");
                                              print("hello");
                                              print(selectedItems);
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
                                                          clipBehavior:
                                                              Clip.hardEdge,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            border: Border.all(
                                                              width: 1,
                                                              color: selectedItems
                                                                      .contains(
                                                                          wantProducts2[i]
                                                                              .id!)
                                                                  ? ColorSelect
                                                                      .colorF7E641
                                                                  : ColorSelect
                                                                      .colorE0E0E0,
                                                            ),
                                                          ),
                                                          child:
                                                              CachedNetworkImage(
                                                            maxHeightDiskCache:
                                                                120,
                                                            maxWidthDiskCache:
                                                                120,
                                                            // imageUrl: (baseUrl+wantProduct2[i].photo.toString()),
                                                            imageUrl: wantProducts2[
                                                                        i]
                                                                    .photo
                                                                    .toString()
                                                                    .contains(
                                                                        "https")
                                                                ? wantProducts2[
                                                                        i]
                                                                    .photo
                                                                    .toString()
                                                                : baseUrl +
                                                                    wantProducts2[
                                                                            i]
                                                                        .photo
                                                                        .toString(),
                                                            fit: BoxFit.cover,
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Icon(
                                                              Icons.error,
                                                              size: 40,
                                                            ),
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
                                                                  width: 173,
                                                                  height: 129,
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                          color: ColorSelect
                                                                              .colorE0E0E0,
                                                                          width:
                                                                              1),
                                                                      color: ColorSelect
                                                                          .colorFFFFFF,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12)),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          bottom: 0,
                                                          right: 0,
                                                          child: selectedItems
                                                                  .contains(
                                                                      wantProducts2[
                                                                              i]
                                                                          .id!)
                                                              ? Image.asset(
                                                                  "assets/images/select.png",
                                                                  height: 28,
                                                                  width: 28,
                                                                )
                                                              : SizedBox(),
                                                        )
                                                      ]),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 16),
                                                            child: SizedBox(
                                                              width: 230.w,
                                                              child: Text(
                                                                wantProducts2[i]
                                                                    .name
                                                                    .toString(),
                                                                // "RESPAWN 110 Racing Style Gaming Chair, Reclining Ergonomic Chair with Footrest...",
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
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
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 16),
                                                            child: Text(
                                                              wantProducts2[i]
                                                                      .link
                                                                      .toString()
                                                                      .contains(
                                                                          "etsy")
                                                                  ? '\$ ${normalizedPercent.toStringAsFixed(2)}'
                                                                  : '\$ ${wantProducts2[i].price.toString()}',
                                                              // '\$ ${wantProducts2[i].price.toString()}',
                                                              // '\$ ${normalizedPercent.toStringAsFixed(2)}',
                                                              // "47.99",
                                                              style: AppTextStyle()
                                                                  .textColor29292914w500,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 4,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
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
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: ColorSelect
                                                                          .color707070),
                                                                ),
                                                                SizedBox(
                                                                  width: 6,
                                                                ),
                                                                Text(DateTime.now()
                                                                            .difference(DateTime.parse(wantProducts2[i]
                                                                                .createdAt
                                                                                .toString()))
                                                                            .inMinutes <=
                                                                        59
                                                                    ? "${DateTime.now().difference(DateTime.parse(wantProducts2[i].createdAt.toString())).inMinutes} min ago"
                                                                    : DateTime.now().difference(DateTime.parse(wantProducts2[i].createdAt.toString())).inHours <=
                                                                            23
                                                                        ? "${DateTime.now().difference(DateTime.parse(wantProducts2[i].createdAt.toString())).inHours} hr ago"
                                                                        : "${DateTime.now().difference(DateTime.parse(wantProducts2[i].createdAt.toString())).inDays} days ago"),
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
            if (loading) Loading()
          ],
        ),
      ),
    );
  }
}

class MoveDialog extends StatefulWidget {
  final Function(String) onPop;
  final String type;
  const MoveDialog({Key? key, required this.onPop, required this.type})
      : super(key: key);

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
                border: Border.all(width: 1, color: ColorSelect.colorA3A3A3)),
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
                      color: _gIndex == 0 ? Colors.black : Colors.transparent,
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
                border: Border.all(width: 1, color: ColorSelect.colorA3A3A3)),
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
                      color: _gIndex == 1 ? Colors.black : Colors.transparent,
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
    }*/
    else {
      _gIndex = 2;
    }
    super.initState();
  }
}
