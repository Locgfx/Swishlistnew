import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/constants/globals/loading.dart';
import 'package:swishlist/dashboard/products/productdetail.dart';
import 'package:swishlist/dashboard/products/widget/manuallyaddbottomsheetwidget.dart';

import '../../api/user_apis/products_api.dart';
import '../../constants/color.dart';
import '../../constants/urls.dart';
import '../../models/product_model.dart';
import '../../models/product_type_model.dart';

class ProductAlready extends StatefulWidget {
  // final ProductTypeModel model;
  const ProductAlready({
    Key? key,
    /*required this.model*/
  }) : super(key: key);

  @override
  State<ProductAlready> createState() => _ProductAlreadyState();
}

class _ProductAlreadyState extends State<ProductAlready> {
  List<int> selectedItems = [];

  @override
  void initState() {
    getHaveProducts();
    super.initState();
  }

  bool loading = false;
  bool isLoading = false;
  GetProductModel? getProducts;
  List<ProductTypeModel> haveProducts1 = [];
  List<ProductTypeModel> haveProducts2 = [];
  getHaveProducts() {
    isLoading = true;
    var resp = getProductsApi();
    resp.then((value) {
      if (mounted) {
        if (value['status'] == true) {
          setState(() {
            for (var v in value['data']) {
              haveProducts1.add(ProductTypeModel.fromJson(v));
            }
            for (var v in haveProducts1) {
              if (v.type! == "have") {
                haveProducts2.add(v);
              }
            }
            isLoading = false;
          });
        } else {
          isLoading = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSelect.colorEEEEEE,
      appBar: AppBar(
        backgroundColor: ColorSelect.colorEEEEEE,
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          children: [
            Text(
              "${selectedItems.isEmpty ? '' : selectedItems.length} ${selectedItems.isEmpty ? 'Products' : selectedItems.length == 1 ? 'Product' : 'Products'}",
              style: AppTextStyle().textColor29292916w500,
            ),
            Spacer(),
            // if (selectedItems.isEmpty)
            //   GestureDetector(
            //     onTap: () {
            //       showModalBottomSheet(
            //         backgroundColor: Colors.transparent,
            //         context: context,
            //         isScrollControlled: true,
            //         builder: (_) => SearchFilters(),
            //       );
            //     },
            //     child: Container(
            //         color: Colors.transparent,
            //         child: Image.asset("assets/images/filter06.png")),
            //   ),
            if (selectedItems.isEmpty)
              SizedBox(
                width: 20,
              ),
            // MyOptionsDialog(),
            // if (selectedItems.isEmpty) MyOptionsDialoglist(
            //   onTap: () {
            //     isLoading ? Loading() : getHaveProducts();
            //
            // },),
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
                            haveProducts2
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
                    // }
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
                    Share.share(haveProducts2[0].link.toString());
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
      body: Column(
        children: [
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "I already have",
                  style: AppTextStyle().textColor29292924w700,
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
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return ManuallyAddBottomSheetWidget(
                                /*model: widget.model,*/);
                          });
                      /* Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProductDataList()));*/
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.add),
                        SizedBox(
                          width: 9,
                        ),
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
          SizedBox(
            height: 28,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                left: 16,
                top: 36,
                right: 16,
              ),
              height: 1.sh,
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
                                    '${haveProducts2.length.toString()} Products',
                                    style: AppTextStyle().textColor70707012w500,
                                  ),
                                ],
                              ),
                              haveProducts2.isEmpty
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
                                      padding: EdgeInsets.only(bottom: 50),
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: haveProducts2.length,
                                      // itemCount: getProducts!.data!.length,
                                      // itemCount: 6,
                                      shrinkWrap: true,
                                      // scrollDirection: Axis.vertical,
                                      itemBuilder: (context, i) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 16),
                                          child: GestureDetector(
                                            onLongPress: () {
                                              if (selectedItems.isEmpty) {
                                                setState(() {
                                                  selectedItems.add(
                                                      haveProducts2[i].id!);
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
                                                              name: haveProducts2[
                                                                      i]
                                                                  .name
                                                                  .toString(),
                                                              price:
                                                                  haveProducts2[
                                                                          i]
                                                                      .price
                                                                      .toString(),
                                                              link: haveProducts2[
                                                                      i]
                                                                  .link
                                                                  .toString(),
                                                              image: baseUrl +
                                                                  haveProducts2[
                                                                          i]
                                                                      .photo
                                                                      .toString(),
                                                              purchaseDate:
                                                                  haveProducts2[
                                                                          i]
                                                                      .purchasedDate
                                                                      .toString(),
                                                              id: haveProducts2[
                                                                      i]
                                                                  .id
                                                                  .toString(),
                                                              type: haveProducts2[
                                                                      i]
                                                                  .type
                                                                  .toString(),
                                                            )));
                                              } else {
                                                if (selectedItems.contains(
                                                    haveProducts2[i].id!)) {
                                                  setState(() {
                                                    selectedItems.remove(
                                                        haveProducts2[i].id!);
                                                  });
                                                } else {
                                                  setState(() {
                                                    selectedItems.add(
                                                        haveProducts2[i].id!);
                                                  });
                                                }
                                              }
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
                                                                          i)
                                                                  ? ColorSelect
                                                                      .colorF7E641
                                                                  : ColorSelect
                                                                      .colorE0E0E0,
                                                            ),
                                                          ),
                                                          child:
                                                              CachedNetworkImage(
                                                            // imageUrl: (baseUrl+haveProducts2[i].photo.toString()),
                                                            imageUrl: haveProducts2[
                                                                        i]
                                                                    .photo
                                                                    .toString()
                                                                    .contains(
                                                                        "https")
                                                                ? haveProducts2[
                                                                        i]
                                                                    .photo
                                                                    .toString()
                                                                : baseUrl +
                                                                    haveProducts2[
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
                                                          //         "assets/images/image10.png")
                                                          // ),
                                                        ),
                                                        Positioned(
                                                          bottom: 0,
                                                          right: 0,
                                                          child: selectedItems
                                                                  .contains(
                                                                      haveProducts2[
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
                                                                haveProducts2[i]
                                                                    .name
                                                                    .toString(),
                                                                // getProducts!.data![i].name.toString(),
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
                                                              'USD ${haveProducts2[i].price.toString()}',
                                                              // haveProducts2[i].price.toString(),
                                                              // getProducts!.data![i].price.toString(),
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
                                                                            .difference(DateTime.parse(haveProducts2[i]
                                                                                .createdAt
                                                                                .toString()))
                                                                            .inMinutes <=
                                                                        59
                                                                    ? "${DateTime.now().difference(DateTime.parse(haveProducts2[i].createdAt.toString())).inMinutes} min ago"
                                                                    : DateTime.now().difference(DateTime.parse(haveProducts2[i].createdAt.toString())).inHours <=
                                                                            23
                                                                        ? "${DateTime.now().difference(DateTime.parse(haveProducts2[i].createdAt.toString())).inHours} hr ago"
                                                                        : "${DateTime.now().difference(DateTime.parse(haveProducts2[i].createdAt.toString())).inDays} days ago"),
                                                                // Text(
                                                                //   DateTime.now().difference(DateTime.parse(
                                                                //       haveProducts2[i].purchasedDate.toString())).
                                                                //     inMinutes <= 59?
                                                                //      "${DateTime.now().difference(DateTime.parse(
                                                                //     haveProducts2[i].purchasedDate.
                                                                //     toString())).inMinutes} min ago" :
                                                                //       DateTime.now().difference(
                                                                //           DateTime.parse(haveProducts2[i].purchasedDate.toString())).inHours
                                                                //     <= 23? "${DateTime.now().difference(DateTime.parse(
                                                                //             haveProducts2[i].purchasedDate.toString())).inHours
                                                                //      } hours ago" :
                                                                //           "${DateTime.now().difference(DateTime.parse(
                                                                //             haveProducts2[i].purchasedDate.toString())).inDays} days ago"
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
                                      }),
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
