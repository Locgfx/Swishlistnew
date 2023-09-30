import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/api/user_apis/products_api.dart';
import 'package:swishlist/constants/globals/loading.dart';
import 'package:swishlist/dashboard/products/productdetail.dart';
import 'package:swishlist/dashboard/products/widget/manuallyaddbottomsheetwidget.dart';
import 'package:swishlist/models/product_model.dart';

import '../../constants/color.dart';
import '../../constants/urls.dart';
import '../../models/product_type_model.dart';

class Productdontwant extends StatefulWidget {
  final bool isUser;
  const Productdontwant({
    Key? key,
    required this.isUser,
  }) : super(key: key);

  @override
  State<Productdontwant> createState() => _ProductdontwantState();
}

class _ProductdontwantState extends State<Productdontwant> {
  @override
  void initState() {
    getNotWantProducts();
    super.initState();
  }

  List<int> selectedItems = [];
  bool loading = false;
  bool isLoading = false;
  GetProductModel? getProducts;

  List<ProductTypeModel> notWantOne = [];
  List<ProductTypeModel> notWantTwo = [];

  getNotWantProducts() {
    isLoading = true;
    var resp = getProductsApi();
    resp.then((value) {
      if (value['status'] == true) {
        setState(() {
          for (var v in value["data"]) {
            notWantOne.add(ProductTypeModel.fromJson(v));
          }
          for (var v in notWantOne) {
            if (v.type! == "dont_want") {
              notWantTwo.add(v);
            }
          }
          isLoading = false;
        });
      } else {
        isLoading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSelect.colorF3E2E2,
      appBar: AppBar(
        backgroundColor: ColorSelect.colorF3E2E2,
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          children: [
            Text(
              "${selectedItems.isEmpty ? '' : selectedItems.length} ${selectedItems.isEmpty ? 'Products' : selectedItems.length == 1 ? 'Product' : 'Products'}",
              style: AppTextStyle().textColor29292916w500,
            ),
            Spacer(),
            if (selectedItems.isEmpty)
              SizedBox(
                width: 20,
              ),
          ],
        ),
        actions: selectedItems.isEmpty
            ? []
            : [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      // selectedItems.clear();
                    });
                    setState(() {
                      loading = true;
                    });
                    for (var v in selectedItems) {
                      deleteProductsApi(id: v.toString()).then((value) async {
                        print(selectedItems.toString());
                        if (value['status'] == true) {
                          setState(() {
                            notWantTwo
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
                      // }
                    }
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    color: Colors.transparent,
                    child: Image.asset('assets/images/del.png'),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Share.share(notWantTwo[0].link.toString());
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    margin: EdgeInsets.only(right: 16, left: 16),
                    color: Colors.transparent,
                    child: Image.asset('assets/images/send1.png'),
                  ),
                ),
                // MyOptionsDialog(),
              ],
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset('assets/images/Vector190.png')),
      ),
      /*bottomSheet: Container(),*/
      body: Column(
        children: [
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.isUser ? "I don't want" : 'Friend Name don\'t Wants',
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
                            return ManuallyAddBottomSheetWidget(
                              productType: 'dont_want', /*model: widget.model,*/
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
                  isLoading
                      ? Loading()
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "${notWantTwo.length.toString()} Products",
                                    // "6 Products",
                                    style: AppTextStyle().textColor70707012w500,
                                  ),
                                ],
                              ),
                              notWantTwo.isEmpty
                                  ? Center(
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
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: notWantTwo.length,
                                      // itemCount: 6,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, i) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 16),
                                          child: GestureDetector(
                                            onLongPress: () {
                                              if (selectedItems.isEmpty) {
                                                setState(() {
                                                  selectedItems
                                                      .add(notWantTwo[i].id!);
                                                });
                                              }
                                            },
                                            onTap: () {
                                              if (selectedItems.isEmpty) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ProductDetail(
                                                              name: notWantTwo[
                                                                      i]
                                                                  .name
                                                                  .toString(),
                                                              price: notWantTwo[
                                                                      i]
                                                                  .price
                                                                  .toString(),
                                                              link: notWantTwo[
                                                                      i]
                                                                  .link
                                                                  .toString(),
                                                              image: baseUrl +
                                                                  notWantTwo[i]
                                                                      .photo
                                                                      .toString(),
                                                              purchaseDate:
                                                                  notWantTwo[i]
                                                                      .purchasedDate
                                                                      .toString(),
                                                              id: notWantTwo[i]
                                                                  .id
                                                                  .toString(),
                                                              type: notWantTwo[
                                                                      i]
                                                                  .type
                                                                  .toString(),
                                                            )));
                                              } else {
                                                if (selectedItems.contains(
                                                    notWantTwo[i].id!)) {
                                                  setState(() {
                                                    selectedItems.remove(
                                                        notWantTwo[i].id!);
                                                  });
                                                } else {
                                                  setState(() {
                                                    selectedItems
                                                        .add(notWantTwo[i].id!);
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
                                                                          notWantTwo[i]
                                                                              .id!)
                                                                  ? ColorSelect
                                                                      .colorF7E641
                                                                  : ColorSelect
                                                                      .colorE0E0E0,
                                                            ),
                                                          ),
                                                          child:
                                                              CachedNetworkImage(
                                                            // imageUrl: (baseUrl+notWantTwo[i].photo.toString()),
                                                            imageUrl: notWantTwo[
                                                                        i]
                                                                    .photo
                                                                    .toString()
                                                                    .contains(
                                                                        "https")
                                                                ? notWantTwo[i]
                                                                    .photo
                                                                    .toString()
                                                                : baseUrl +
                                                                    notWantTwo[
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
                                                          // child: Center(
                                                          //     child: Image.asset(
                                                          //         "assets/images/image10.png")),
                                                        ),
                                                        Positioned(
                                                          bottom: 0,
                                                          right: 0,
                                                          child: selectedItems
                                                                  .contains(
                                                                      notWantTwo[
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
                                                                notWantTwo[i]
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
                                                              'USD ${notWantTwo[i].price.toString()}',
                                                              // notWantTwo[i].price.toString(),
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
                                                                            .difference(DateTime.parse(notWantTwo[i]
                                                                                .createdAt
                                                                                .toString()))
                                                                            .inMinutes <=
                                                                        59
                                                                    ? "${DateTime.now().difference(DateTime.parse(notWantTwo[i].createdAt.toString())).inMinutes} min ago"
                                                                    : DateTime.now().difference(DateTime.parse(notWantTwo[i].createdAt.toString())).inHours <=
                                                                            23
                                                                        ? "${DateTime.now().difference(DateTime.parse(notWantTwo[i].createdAt.toString())).inHours} hr ago"
                                                                        : "${DateTime.now().difference(DateTime.parse(notWantTwo[i].createdAt.toString())).inDays} days ago"),
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
                  if (loading) Loading()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
