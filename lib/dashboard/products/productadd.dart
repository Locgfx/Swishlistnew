// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:swishlist/api/user_apis/products_api.dart';
// import 'package:swishlist/dashboard/products/productdetail.dart';
// import 'package:swishlist/dashboard/products/widget/manuallyaddbottomsheetwidget.dart';
// import 'package:swishlist/dashboard/products/widget/popmenu.dart';
// import 'package:swishlist/dashboard/products/widget/search_filter.dart';
// import 'package:swishlist/models/activity_model.dart';
//
// import '../../constants/color.dart';
// import '../../constants/globals/loading.dart';
// import '../../constants/urls.dart';
// import '../../models/product_type_model.dart';
//
// class WantProducts extends StatefulWidget {
//   final bool isUser;
//   const WantProducts({Key? key, required this.isUser}) : super(key: key);
//
//   @override
//   State<WantProducts> createState() => _WantProductsState();
// }
//
// class _WantProductsState extends State<WantProducts> {
// /*  List imageList = [
//     "assets/images/image10.png",
//     "assets/images/image12.png",
//     "assets/images/image10.png",
//     "assets/images/image12.png",
//   ];
//   List itemNameList = [
//     "RESPAWN 110 Racing Style Gaming Chair, Reclining Ergonomic Chair with Footrest...",
//     "Samsung Galaxy Tab A8 Android Tablet, 10.5” LCD Scre...",
//     "RESPAWN 110 Racing Style Gaming Chair, Reclining Ergonomic Chair with Footrest...",
//     "Samsung Galaxy Tab A8 Android Tablet, 10.5” LCD Scre...",
//   ];
//   List itemPrice = ["47.99", "1247.99", "47.99", "1247.99"];*/
//   @override
//   void initState() {
//     getWantProduct();
//     super.initState();
//   }
//
//
//   List<int> selectedItems = [];
//
//   bool isLoading = false;
//   List<ProductTypeModel> wantProduct = [];
//   List<ProductTypeModel> wantProduct2 = [];
//
//   getWantProduct() {
//     isLoading = true;
//      var resp = getProductsApi();
//      resp.then((value) {
//        if (value ['status'] == true) {
//          setState(() {
//            for (var v in value["data"]) {
//              wantProduct.add(ProductTypeModel.fromJson(v));
//            }
//             for (var v in wantProduct){
//               if(v.type! == "want") {
//                 wantProduct2.add(v);
//               }
//             }
//             isLoading = false;
//          });
//        } else {
//          isLoading = false;
//
//        }
//      });
//   }
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorSelect.colorE5F3E2,
//       appBar: AppBar(
//         backgroundColor: ColorSelect.colorE5F3E2,
//         elevation: 0,
//         centerTitle: false,
//         titleSpacing: 0,
//         title: Row(
//           children: [
//             Text(
//               "${selectedItems.isEmpty ? '' : selectedItems.length} ${selectedItems.isEmpty ? 'Products' : selectedItems.length == 1 ? 'Product' : 'Products'}",
//               style: AppTextStyle().textColor29292916w500,
//             ),
//             Spacer(),
//             if (selectedItems.isEmpty)
//               GestureDetector(
//                 onTap: () {
//                   showModalBottomSheet(
//                     backgroundColor: Colors.transparent,
//                     context: context,
//                     isScrollControlled: true,
//                     builder: (_) => SearchFilters(),
//                   );
//                 },
//                 child: Container(
//                     color: Colors.transparent,
//                     child: Image.asset("assets/images/filter06.png")),
//               ),
//             if (selectedItems.isEmpty)
//               SizedBox(
//                 width: 20,
//               ),
//             // MyOptionsDialog(),
//             if (selectedItems.isEmpty) MyOptionsDialoglist(),
//           ],
//         ),
//         actions: selectedItems.isEmpty
//             ? []
//             : [
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedItems.clear();
//                     });
//                   },
//                   child: Container(
//                     width: 36,
//                     height: 36,
//                     color: Colors.transparent,
//                     child: Image.asset('assets/images/del.png'),
//                   ),
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     Share.share('Link');
//                   },
//                   child: Container(
//                     width: 36,
//                     height: 36,
//                     margin: EdgeInsets.only(left: 16),
//                     color: Colors.transparent,
//                     child: Image.asset('assets/images/send1.png'),
//                   ),
//                 ),
//                 MyOptionsDialog(),
//               ],
//         leading: InkWell(
//           onTap: () {
//             selectedItems.isEmpty
//                 ? Navigator.pop(context)
//                 : setState(() {
//                     selectedItems.clear();
//                   });
//           },
//           child: selectedItems.isEmpty
//               ? Image.asset('assets/images/Vector190.png')
//               : Icon(
//                   Icons.clear,
//                   color: Colors.black,
//                 ),
//         ),
//       ),
//       /*bottomSheet: Container(),*/
//       body: Column(
//         children: [
//           SizedBox(height: 16),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     widget.isUser ? "I want" : 'Friend Name Wants',
//                     maxLines: 2,
//                     style: AppTextStyle().textColor29292924w700,
//                   ),
//                 ),
//                 Container(
//                   width: 86.w,
//                   height: 44.h,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: ColorSelect.colorF7E641),
//                   child: InkWell(
//                     onTap: () {
//                       showModalBottomSheet(
//                           backgroundColor: Colors.transparent,
//                           isScrollControlled: true,
//                           context: context,
//                           builder: (context) {
//                             return ManuallyAddBottomSheetWidget();
//                           });
//                       /* Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   ProductDataList()));*/
//                     },
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Icon(Icons.add),
//                         SizedBox(
//                           width: 9,
//                         ),
//                         Text(
//                           "Add",
//                           style: AppTextStyle().textColor29292914w500,
//                         )
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           SizedBox(height: 28),
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.only(
//                 left: 16,
//                 top: 36,
//                 right: 16,
//               ),
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(24),
//                       topLeft: Radius.circular(24))),
//               child: Stack(
//                 children: [
//                   SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             Text(
//                               '${wantProduct2.length.toString()} Products',
//                               // "6 Products",
//                               style: AppTextStyle().textColor70707012w500,
//                             ),
//                           ],
//                         ),
//                         ListView.builder(
//                             physics: NeverScrollableScrollPhysics(),
//                             itemCount: wantProduct2.length,
//                             // itemCount: 6,
//                             shrinkWrap: true,
//                             scrollDirection: Axis.vertical,
//                             itemBuilder: (context, i) {
//                               return Padding(
//                                 padding: const EdgeInsets.only(top: 16),
//                                 child: GestureDetector(
//                                   onLongPress: () {
//                                     if (selectedItems.isEmpty) {
//                                       setState(() {
//                                         selectedItems.add(i);
//                                       });
//                                     }
//                                   },
//                                   onTap: () {
//                                     if (selectedItems.isEmpty) {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (context) =>
//                                                   ProductDetail()));
//                                     } else {
//                                       if (selectedItems.contains(i)) {
//                                         setState(() {
//                                           selectedItems.remove(i);
//                                         });
//                                       } else {
//                                         setState(() {
//                                           selectedItems.add(i);
//                                         });
//                                       }
//                                     }
//                                     //log("hello");
//                                     print("hello");
//                                     print(selectedItems);
//                                   },
//                                   child: Container(
//                                     color: Colors.transparent,
//                                     child: Column(
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Stack(children: [
//                                               Container(
//                                                 height: 86,
//                                                 width: 86,
//                                                 clipBehavior: Clip.hardEdge,
//                                                 decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(8),
//                                                   border: Border.all(
//                                                     width: 1,
//                                                     color: selectedItems.contains(i)
//                                                         ? ColorSelect.colorF7E641
//                                                         : ColorSelect.colorE0E0E0,
//                                                   ),
//                                                 ),
//                                                 child: CachedNetworkImage(
//                                                   imageUrl: (baseUrl+wantProduct2[i].photo.toString()),
//                                                   // imageUrl: (baseUrl+getProducts!.data![i].photo.toString()),
//                                                   fit: BoxFit.cover,
//                                                   errorWidget: (context, url, error) =>
//                                                       Icon(Icons.error,size: 40,),
//                                                   progressIndicatorBuilder:  (a,b,c) =>
//                                                       Opacity(
//                                                         opacity: 0.3,
//                                                         child: Shimmer.fromColors(
//                                                           baseColor: Colors.black12,
//                                                           highlightColor: Colors.white,
//                                                           child: Container(
//                                                             width: 173,
//                                                             height: 129,
//                                                             decoration: BoxDecoration(
//                                                                 border:
//                                                                 Border.all(color: ColorSelect.colorE0E0E0, width: 1),
//                                                                 color: ColorSelect.colorFFFFFF,
//                                                                 borderRadius: BorderRadius.circular(12)),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                 ),
//                                                 // child: Center(
//                                                 //     child: Image.asset(
//                                                 //         "assets/images/image10.png")),
//                                               ),
//                                               Positioned(
//                                                 bottom: 0,
//                                                 right: 0,
//                                                 child: selectedItems.contains(i)
//                                                     ? Image.asset(
//                                                         "assets/images/select.png",
//                                                         height: 28,
//                                                         width: 28,
//                                                       )
//                                                     : SizedBox(),
//                                               )
//                                             ]),
//                                             Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Padding(
//                                                   padding: const EdgeInsets.only(
//                                                       left: 16),
//                                                   child: SizedBox(
//                                                     width: 230.w,
//                                                     child: Text(
//                                                       wantProduct2[i].name.toString(),
//                                                       // "RESPAWN 110 Racing Style Gaming Chair, Reclining Ergonomic Chair with Footrest...",
//                                                       overflow:
//                                                           TextOverflow.ellipsis,
//                                                       maxLines: 2,
//                                                       style: AppTextStyle()
//                                                           .textColor29292912w400,
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 SizedBox(
//                                                   height: 8,
//                                                 ),
//                                                 Padding(
//                                                   padding: const EdgeInsets.only(
//                                                       left: 16),
//                                                   child: Text(
//                                                     wantProduct2[i].price.toString(),
//                                                     // "47.99",
//                                                     style: AppTextStyle()
//                                                         .textColor29292914w500,
//                                                   ),
//                                                 ),
//                                                 SizedBox(
//                                                   height: 4,
//                                                 ),
//                                                 Padding(
//                                                   padding: const EdgeInsets.only(
//                                                       left: 16),
//                                                   child: Row(
//                                                     children: [
//                                                       Image.asset(
//                                                           "assets/images/image46.png"),
//                                                       SizedBox(
//                                                         width: 6,
//                                                       ),
//                                                       Container(
//                                                         height: 5,
//                                                         width: 5,
//                                                         decoration: BoxDecoration(
//                                                             shape: BoxShape.circle,
//                                                             color: ColorSelect
//                                                                 .color707070),
//                                                       ),
//                                                       SizedBox(
//                                                         width: 6,
//                                                       ),
//                                                       Text(
//                                                         "Today",
//                                                         style: AppTextStyle()
//                                                             .textColor70707012w400,
//                                                       )
//                                                     ],
//                                                   ),
//                                                 )
//                                               ],
//                                             )
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             }),
//                       ],
//                     ),
//                   ),
//                   if (isLoading) Loading()
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
