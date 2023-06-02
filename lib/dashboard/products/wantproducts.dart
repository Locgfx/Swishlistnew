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

import '../../buttons/yellow_button.dart';
import '../../constants/color.dart';
import '../../constants/globals/loading.dart';
import '../../constants/urls.dart';
import '../../models/product_type_model.dart';

class WantProducts extends StatefulWidget {
  final bool isUser;
  const
  WantProducts({Key? key, required this.isUser}) : super(key: key);

  @override
  State<WantProducts> createState() => _WantProductsState();
}

class _WantProductsState extends State<WantProducts> {
/*  List imageList = [
    "assets/images/image10.png",
    "assets/images/image12.png",
    "assets/images/image10.png",
    "assets/images/image12.png",
  ];
  List itemNameList = [
    "RESPAWN 110 Racing Style Gaming Chair, Reclining Ergonomic Chair with Footrest...",
    "Samsung Galaxy Tab A8 Android Tablet, 10.5” LCD Scre...",
    "RESPAWN 110 Racing Style Gaming Chair, Reclining Ergonomic Chair with Footrest...",
    "Samsung Galaxy Tab A8 Android Tablet, 10.5” LCD Scre...",
  ];
  List itemPrice = ["47.99", "1247.99", "47.99", "1247.99"];*/
  @override
  void initState() {
    getWantProduct();
    super.initState();
  }


  List<int> selectedItems = [];
  bool loading = false;
  bool isLoading = false;
  List<ProductTypeModel> wantProduct = [];
  List<ProductTypeModel> wantProduct2 = [];

  getWantProduct() {
    isLoading = true;
    var resp = getProductsApi();
    resp.then((value) {
      if (value ['status'] == true) {
        setState(() {
          for (var v in value["data"]) {
            wantProduct.add(ProductTypeModel.fromJson(v));
          }
          for (var v in wantProduct){
            if(v.type! == "want") {
              wantProduct2.add(v);
            }
          }
          isLoading = false;
        });
      } else {
        isLoading = false;
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
                    deleteProductsApi(
                        id: v.toString()
                    ).then((value) async {
                      print(selectedItems.toString());
                      if(value['status'] == true) {
                        setState(() {
                          wantProduct2.removeWhere((element) => element.id == v);
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
            child: Container(
              width: 36,
              height: 36,
              color: Colors.transparent,
              child: Image.asset('assets/images/del.png'),
            ),
          ),
          GestureDetector(
            onTap: () {
              Share.share('Link');
            },
            child: Container(
              width: 36,
              height: 36,
              margin: EdgeInsets.only(right: 16,left: 16),
              color: Colors.transparent,
              child: Image.asset('assets/images/send1.png'),
            ),
          ),
          // GestureDetector(
          //     onTap: () {
          //       showDialog(
          //         context: context,
          //         builder: (BuildContext context) => Align(
          //           alignment: Alignment.topRight,
          //           child: Padding(
          //             padding: EdgeInsets.only(right: 16,left: 180),
          //             child: Material(
          //               borderRadius: BorderRadius.circular(16),
          //               child: Container(
          //                 decoration: BoxDecoration(
          //                     color: Colors.transparent,
          //                     border: Border.all(width: 1,color: ColorSelect.colorECEDF0),
          //                     borderRadius: BorderRadius.circular(16)),
          //                 child: SingleChildScrollView(
          //                   child: Column(
          //                     children: [
          //                       ListTile(
          //                         title: GestureDetector(
          //                           onTap: () {
          //                             Navigator.pop(context);
          //                             showModalBottomSheet(
          //                                 context: context,
          //                                 builder: (context) {
          //                                   return SizedBox(
          //                                     height: 326.h,
          //                                     child: Padding(
          //                                       padding: const EdgeInsets.symmetric(horizontal: 16),
          //                                       child: Column(
          //                                         crossAxisAlignment: CrossAxisAlignment.start,
          //                                         children: [
          //                                           SizedBox(
          //                                             height: 32.h,
          //                                           ),
          //                                           Text(
          //                                             "Move to products...",
          //                                             style: AppTextStyle().textColor29292924w700,
          //                                           ),
          //                                           SizedBox(
          //                                             height: 8,
          //                                           ),
          //                                           Text(
          //                                             "Select the list to add this product",
          //                                             style: AppTextStyle().textColor70707012w400,
          //                                           ),
          //                                           SizedBox(
          //                                             height: 28,
          //                                           ),
          //                                           MoveDialog(
          //                                             onPop: (String ) { },
          //                                             type: '',
          //                                           ),
          //                                           // GestureDetector(
          //                                           //   onTap: () {
          //                                           //     setState(() {
          //                                           //       selected = 0;
          //                                           //     });
          //                                           //   },
          //                                           //   child: Container(
          //                                           //     height: 52.h,
          //                                           //     width: 328.w,
          //                                           //     decoration: BoxDecoration(
          //                                           //         borderRadius: BorderRadius.circular(8),
          //                                           //         border:
          //                                           //         Border.all(width: 1, color: ColorSelect.colorA3A3A3)),
          //                                           //     child: Row(
          //                                           //       children: [
          //                                           //         Container(
          //                                           //           width: 24,
          //                                           //           height: 24,
          //                                           //           margin: EdgeInsets.only(left: 16),
          //                                           //           decoration: BoxDecoration(
          //                                           //             color: selected == 0
          //                                           //                 ? ColorSelect.colorF7E641
          //                                           //                 : Colors.transparent,
          //                                           //             shape: BoxShape.circle,
          //                                           //             border: Border.all(
          //                                           //               color: selected == 0
          //                                           //                   ? ColorSelect.colorF7E641
          //                                           //                   : ColorSelect.kAFAFAF,
          //                                           //               width: 2,
          //                                           //             ),
          //                                           //           ),
          //                                           //           child: Center(
          //                                           //             child: Icon(
          //                                           //               Icons.done,
          //                                           //               size: 18,
          //                                           //               color:
          //                                           //               selected == 0 ? Colors.black : Colors.transparent,
          //                                           //             ),
          //                                           //           ),
          //                                           //         ),
          //                                           //         SizedBox(
          //                                           //           width: 8.w,
          //                                           //         ),
          //                                           //         Text(
          //                                           //           "I don’t want",
          //                                           //           style: AppTextStyle().textColor70707014w400,
          //                                           //         ),
          //                                           //         Spacer(),
          //                                           //         Padding(
          //                                           //           padding: const EdgeInsets.only(right: 14),
          //                                           //           child: SvgPicture.asset(
          //                                           //             "assets/icons/likeicon.svg",
          //                                           //             height: 24,
          //                                           //             width: 24,
          //                                           //           ),
          //                                           //         ),
          //                                           //       ],
          //                                           //     ),
          //                                           //   ),
          //                                           // ),
          //                                           // SizedBox(
          //                                           //   height: 12,
          //                                           // ),
          //                                           // GestureDetector(
          //                                           //   onTap: () {
          //                                           //     setState(() {
          //                                           //       selected = 1;
          //                                           //     });
          //                                           //   },
          //                                           //   child: Container(
          //                                           //     height: 52.h,
          //                                           //     width: 328.w,
          //                                           //     decoration: BoxDecoration(
          //                                           //         borderRadius: BorderRadius.circular(8),
          //                                           //         border:
          //                                           //         Border.all(width: 1, color: ColorSelect.colorA3A3A3)),
          //                                           //     child: Row(
          //                                           //       children: [
          //                                           //         Container(
          //                                           //           width: 24,
          //                                           //           height: 24,
          //                                           //           margin: EdgeInsets.only(left: 16),
          //                                           //           decoration: BoxDecoration(
          //                                           //             color: selected == 1
          //                                           //                 ? ColorSelect.colorF7E641
          //                                           //                 : Colors.transparent,
          //                                           //             shape: BoxShape.circle,
          //                                           //             border: Border.all(
          //                                           //               color: selected == 1
          //                                           //                   ? ColorSelect.colorF7E641
          //                                           //                   : ColorSelect.kAFAFAF,
          //                                           //               width: 2,
          //                                           //             ),
          //                                           //           ),
          //                                           //           child: Center(
          //                                           //             child: Icon(
          //                                           //               Icons.done,
          //                                           //               size: 18,
          //                                           //               color:
          //                                           //               selected == 1 ? Colors.black : Colors.transparent,
          //                                           //             ),
          //                                           //           ),
          //                                           //         ),
          //                                           //         SizedBox(
          //                                           //           width: 8.w,
          //                                           //         ),
          //                                           //         Text(
          //                                           //           "I have already",
          //                                           //           style: AppTextStyle().textColor70707014w400,
          //                                           //         ),
          //                                           //         Spacer(),
          //                                           //         Padding(
          //                                           //           padding: const EdgeInsets.only(right: 14),
          //                                           //           child: SvgPicture.asset(
          //                                           //             "assets/icons/bi_stars.svg",
          //                                           //             height: 24,
          //                                           //             width: 24,
          //                                           //           ),
          //                                           //         ),
          //                                           //       ],
          //                                           //     ),
          //                                           //   ),
          //                                           // ),
          //                                           SizedBox(
          //                                             height: 16,
          //                                           ),
          //                                           SizedBox(
          //                                             height: 52.h,
          //                                             width: 88.w,
          //                                             child: YellowButtonWithText(
          //                                                 backgroundColor:
          //                                                 MaterialStateProperty.all(ColorSelect.colorF7E641),
          //                                                 textStyleColor: ColorSelect.colorB5B07A,
          //                                                 onTap: () {
          //                                                   // for (var v in selectedItems) {
          //                                                   //   updateProducts(
          //                                                   //        type: v.t,
          //                                                   //         name: name,
          //                                                   //         link: link,
          //                                                   //         price: price,
          //                                                   //         purchaseDate: purchaseDate,
          //                                                   //         privacyStatus: privacyStatus,
          //                                                   //         photo: photo,
          //                                                   //         id: id,
          //                                                   //   ).then((value) async {
          //                                                   //     print(selectedItems.toString());
          //                                                   //     if(value['status'] == true) {
          //                                                   //       setState(() {
          //                                                   //         wantProduct2.removeWhere((element) => element.id == v);
          //                                                   //       });
          //                                                   //       Fluttertoast.showToast(msg: value['message']);
          //                                                   //     } else {
          //                                                   //       Fluttertoast.showToast(msg: value['message']);
          //                                                   //     }
          //                                                   //     setState(() {
          //                                                   //       loading = false;
          //                                                   //       selectedItems.clear();
          //                                                   //     });
          //                                                   //   });
          //                                                   // }
          //                                                   // updateProducts(
          //                                                   //     type: type.t,
          //                                                   //     name: name,
          //                                                   //     link: link,
          //                                                   //     price: price,
          //                                                   //     purchaseDate: purchaseDate,
          //                                                   //     privacyStatus: privacyStatus,
          //                                                   //     photo: photo,
          //                                                   //     id: id,
          //                                                   // ).then((value) {
          //                                                   //   if(value['status'] == true) {
          //                                                   //     Fluttertoast.showToast(msg: value['message']);
          //                                                   //
          //                                                   //   } else {
          //                                                   //     Fluttertoast.showToast(msg: value['message']);
          //                                                   //   }
          //                                                   // });
          //                                                   Navigator.push(
          //                                                       context,
          //                                                       MaterialPageRoute(
          //                                                           builder: (context) => ProductAdded(name: '', price: '', productImage: '',)));
          //                                                 },
          //                                                 title: 'Move'),
          //                                           )
          //                                         ],
          //                                       ),
          //                                     ),
          //                                   );
          //                                 });
          //
          //                             // setState(() {
          //                             //   Share.share('Share your friend details');
          //                             // });
          //                           },
          //                           child: Text(
          //                             'Move to..',
          //                             style:
          //                             // AppTextStyle().textColorBA505014w500
          //                             AppTextStyle().textColor39393914w500,
          //                           ),
          //                         ),
          //                       ),
          //                       ListTile(
          //                         title: GestureDetector(
          //                           onTap: () {
          //                             // Navigator.push(
          //                             //     context,
          //                             //     MaterialPageRoute(
          //                             //         builder: (context) => FriendNotification()));
          //
          //                           },
          //                           child: Text(
          //                             'Archive',
          //                             style:
          //                             // AppTextStyle().textColorBA505014w500
          //                             AppTextStyle().textColor39393914w500,
          //                           ),
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //                 // margin: EdgeInsets.only(
          //                 //     right: 10,
          //                 //     top: 10,
          //                 //     left: 60,
          //                 //     bottom: 6004
          //                 // ),
          //                 // ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //     child: Container(
          //         margin: EdgeInsets.only(left: 16),
          //         height: 25,
          //         width: 25,
          //         child: Image.asset('assets/images/4xdot.png')))
          // MyOptionsDialog(),
        ],
        leading: InkWell(
          onTap: () {
            selectedItems.isEmpty
                ? Navigator.pop(context)
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
      body: Stack(
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
                                return ManuallyAddBottomSheetWidget();
                              });
                          /* Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDataList()));*/
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                  '${wantProduct2.length.toString()} Products',
                                  // "6 Products",
                                  style: AppTextStyle().textColor70707012w500,
                                ),
                              ],
                            ),
                            ListView.builder(
                              padding: EdgeInsets.only(bottom: 30),
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: wantProduct2.length,
                                // itemCount: 6,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, i) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: GestureDetector(
                                      onLongPress: () {
                                        if (selectedItems.isEmpty) {
                                          setState(() {
                                            selectedItems.add(wantProduct2[i].id!);
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
                                                        name: wantProduct2[i].name.toString(),
                                                        price:wantProduct2[i].price.toString(),
                                                        link: wantProduct2[i].link.toString(),
                                                        image: baseUrl+wantProduct2[i].photo.toString(),
                                                        purchaseDate: wantProduct2[i].purchasedDate.toString(),
                                                        id: wantProduct2[i].id.toString(),
                                                        type: wantProduct2[i].type.toString(),
                                                      )));
                                          print(wantProduct2[i].photo.toString());
                                        } else {
                                          if (selectedItems.contains(wantProduct2[i].id!)) {
                                            setState(() {
                                              selectedItems.remove(wantProduct2[i].id!);
                                            });
                                          } else {
                                            setState(() {
                                              selectedItems.add(wantProduct2[i].id!);
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
                                                    clipBehavior: Clip.hardEdge,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(8),
                                                      border: Border.all(
                                                        width: 1,
                                                        color: selectedItems.contains(wantProduct2[i].id!)
                                                            ? ColorSelect.colorF7E641
                                                            : ColorSelect.colorE0E0E0,
                                                      ),
                                                    ),
                                                    child: CachedNetworkImage(
                                                      // imageUrl: (baseUrl+wantProduct2[i].photo.toString()),
                                                      imageUrl: wantProduct2[i].photo.toString().contains("https") ?
                                                      wantProduct2[i].photo.toString() :
                                                      baseUrl+wantProduct2[i].photo.toString(),
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
                                                  Positioned(
                                                    bottom: 0,
                                                    right: 0,
                                                    child: selectedItems.contains(wantProduct2[i].id!)
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
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 16),
                                                      child: SizedBox(
                                                        width: 230.w,
                                                        child: Text(
                                                          wantProduct2[i].name.toString(),
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
                                                        '\$ ${wantProduct2[i].price.toString()}',
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
                                                                      wantProduct2[i].createdAt.toString()))
                                                                  .inMinutes <=
                                                                  59
                                                                  ? "${DateTime.now().difference(
                                                                  DateTime.parse( wantProduct2[i].createdAt.toString())).inMinutes} min ago"
                                                                  : DateTime.now()
                                                                  .difference(DateTime
                                                                  .parse( wantProduct2[i].createdAt.toString()))
                                                                  .inHours <=
                                                                  23
                                                                  ? "${DateTime.now().difference(
                                                                  DateTime.parse( wantProduct2[i].createdAt.toString())).inHours} hr ago"
                                                                  : "${DateTime.now().difference(
                                                                  DateTime.parse( wantProduct2[i].createdAt.toString())).inDays} days ago"),
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
