import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swishlist/api/etsy_apis/all_listing_apis.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../api/user_apis/etsy_product_add.dart';
import '../../api/user_apis/products_api.dart';
import '../../buttons/light_yellow.dart';
import '../../buttons/yellow_button.dart';
import '../../constants/color.dart';
import '../../constants/decoration.dart';
import '../../constants/globals/loading.dart';
import '../../models/etsy_image_model.dart';
import '../../models/etsy_listing_model.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import '../../models/etsy_load_more_model.dart';
import '../../models/etsy_search_model.dart';
import '../../profile_page/widgets/date_picker.dart';
import '../products/manuallyadd.dart';

import 'etsy_products_details.dart';

class AllEtsyProducts extends StatefulWidget {
  const AllEtsyProducts({Key? key}) : super(key: key);

  @override
  State<AllEtsyProducts> createState() => _AllEtsyProductsState();
}

class _AllEtsyProductsState extends State<AllEtsyProducts> {
  @override
  void initState() {
    getAllListing();
    // getAllListingImages();
    // loadMore();
    getSearch();
    super.initState();
  }

  bool isLoading = false;
  // EtsyListingModel? etsyProducts;
  // List<EtsyListingModel> etsyProducts = [];
  // List<EtsyImageModel> etsyImage = [];
  // List<SingleImageEtsyModel> singleImage = [];

  getAllListing() {
    isLoading = true;
    var resp = allEtsyListingApi(page: '0');
    resp.then((value) {
      setState(() {
       // etsyProducts = EtsyListingModel.fromJson(value);
        scrollLength = value["results"].length;
        for (var v in value['results']) {
          friendList.add(EtsyLoadMoreModel.fromJson(v));
          isLoading = false;
        }
      });
    });
  }

  int scroll = 0;
  int scrollLength = 0;
  // List<EtsyLoadMoreModel> etsy = [];

  loadMore() {
    scroll++;
    final resp = allEtsyListingApi(page: scroll.toString());
    resp.then((value) {
      setState(() {
        scrollLength = value["results"].length;
        for (var v in value['results']) {
          friendList.add(EtsyLoadMoreModel.fromJson(v));
          isLoading = false;
        }
        //_isLoading = false;
      });
    });
  }

  getSearch() {
    final resp = searchEtsyProductApi(search: searchController.text);
    resp.then((value) {
      for (var v in value['results']) {
        searchList.add(EtsySearchModel.fromJson(v));
        isLoading = false;
      }
      print(searchList.toString());
    });

  }
  List<EtsySearchModel> searchList = [];
  List<EtsyLoadMoreModel> friendList = [];
  final searchController = TextEditingController();
  final controller = TextEditingController();
  final dateController = TextEditingController();
  String dateFormat ='';
  final productTypeController = TextEditingController();
  File pickedImage = File("");

  Future<void> launchUrlStart({required String url}) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }


  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Column(
        children: [
          Row(
            children: [
              Text(
                "All Etsy Products",
                style: AppTextStyle().textColor29292916w500,
              ),
              Spacer(),
              Container(
                width: 150,
                color: Colors.transparent,
                child:TextFormField(
                  onChanged: (val) {
                    setState(() {});
                    // print(friendList);
                    // print(searchController.text);
                    // // print(friendList.title);
                    // for (var v in friendList) {
                    //   if(v.title! == val) {
                    //     if(searchList.contains(v)) {
                    //
                    //     } else {
                    //       searchList.add(v);
                    //     }
                    //   }
                    // }
                    // final suggestions = friendList.where((element) =>
                    // element.title == searchController.text).toList();
                    // print(suggestions);
                    // setState(() {
                    //
                    //   // final suggestions = friendList.where((element) =>
                    //   // element.title == searchController.text).toList();
                    //   // print(suggestions);
                    //   searchList = suggestions;
                    //   print(searchList.toString());
                    //   if(searchController.text.isEmpty) {
                    //     searchList.clear();
                    //   }
                    // });
                  },
                  controller: searchController,
                  cursorColor: ColorSelect.colorF7E641,
                  decoration: AppTFDecoration(
                      hint: 'Enter Product Title').decoration(),
                  //keyboardType: TextInputType.phone,
                ),
              )
            ],
          ),
        ],
      ),
      // leadingWidth: 40,
      // leading: Padding(
      //   padding: const EdgeInsets.only(left: 20),
      //   child: InkWell(
      //     onTap: () {
      //       Navigator.pop(context);
      //     },
      //     child: SvgPicture.asset(
      //       "assets/icons/arrowback.svg",
      //     ),
      //   ),
      // ),
    ),
      body: isLoading ? Loading() : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child:  LazyLoadScrollView(
          isLoading: isLoading,
          onEndOfPage: () {
            // print(scrollLength);
            if (scrollLength >= 25) {
              loadMore();
            }
          },
        child:   ListView.separated(
          padding: EdgeInsets.only(top: 16,bottom: 200),
          itemCount: friendList/*.*//*where((element) => element.title!.contains(
              searchController.text)).*/.length + 1,
          shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context,i) {
            if (i < friendList.length ) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      GestureDetector(
                        onTap : () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => EtsyProductDetails(
                                productTitle: friendList[i].title.toString(),
                                productPrice: friendList[i].price!.amount.toString(),
                                productDescription: friendList[i].description.toString(),
                                productId: friendList[i].listingId.toString(),
                                productUrl: friendList[i].url.toString(),

                              )));
                        },
                        child: Container(
                          width: 1.sw,
                          padding: EdgeInsets.all(30),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                              border:
                              Border.all(color: ColorSelect.colorE0E0E0, width: 1),
                              color: ColorSelect.colorFFFFFF,
                              borderRadius: BorderRadius.circular(12)),
                          child: SvgPicture.asset("assets/images/etsy.svg",fit: BoxFit.contain),
                        ),
                      ),
                      Positioned(
                        top:10,
                        right:10,
                        child: GestureDetector(
                          onTap: () async {
                            print(friendList[i].url);
                            await Clipboard.setData(
                                ClipboardData(text: friendList[i].url)
                            );
                          },
                          child: Icon(
                            Icons.copy_rounded,
                            size: 25,
                          ),
                        ),
                      ),
                      Positioned(
                        top:10,
                        right:45,
                        child: GestureDetector(
                          onTap:() {
                            setState(() {
                              Share.share(friendList[i].url.toString());
                            });

                          },
                          child: Icon(
                            Icons.share,
                            size: 25,),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    friendList[i].title.toString(),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    style: AppTextStyle().textColor29292912w500,
                  ),
                  SizedBox(height: 10),
                  Text(
                    ' \$ ${friendList[i].price!.amount.toString()}',
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    style: AppTextStyle().textColor29292912w500,
                  ),
                  SizedBox(height: 10),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        // height: 52.h,
                        // width: 88.w,

                        child: LightYellowButtonWithText(
                            backgroundColor:
                            MaterialStateProperty.all(ColorSelect.colorF7E641),
                            textStyleColor: ColorSelect.color292929,
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => EtsyProductDetails(
                                    productTitle: friendList[i].title.toString(),
                                    productPrice: friendList[i].price!.amount.toString(),
                                    productDescription: friendList[i].description.toString(),
                                    productId: friendList[i].listingId.toString(),
                                    productUrl: friendList[i].url.toString(),
                                  )));

                            },
                            title: 'View Details'),
                      ),

                      GestureDetector(
                        onTap: ()  {
                          launchUrlStart(url: friendList[i].url.toString() );
                        },
                          child: Text('View in website',
                          style: AppTextStyle().textColor29292916w500,)
                      ),
                    ],
                  ),
                ],
              );
            } else if (scrollLength >= 25 && isLoading) {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  size: 70, color: ColorSelect.colorF7E641,
                ),
              );

            } else if( scrollLength <10) {
              return SizedBox.shrink();
            } else {
              return Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  size: 70, color: ColorSelect.colorF7E641,
                ),
              );
            }
          }, separatorBuilder: (BuildContext context, int index) => SizedBox(height: 16,),
        ),
        )
     // :
     //  ListView.separated(
     //    padding: EdgeInsets.only(top: 16,bottom: 200),
     //    itemCount: searchList.length ,
     //    shrinkWrap: true,
     //    // physics: NeverScrollableScrollPhysics(),
     //    itemBuilder: (context,i) {
     //        return Column(
     //          crossAxisAlignment: CrossAxisAlignment.start,
     //          children: [
     //            Stack(
     //              children: [
     //                GestureDetector(
     //                  onTap : () {
     //                    Navigator.push(context,
     //                        MaterialPageRoute(builder: (context) => EtsyProductDetails(
     //                          productTitle: searchList[i].title.toString(),
     //                          productPrice: searchList[i].price!.amount.toString(),
     //                          productDescription: searchList[i].description.toString(),
     //                          productId: searchList[i].listingId.toString(),
     //                          productUrl: searchList[i].url.toString(),
     //
     //                        )));
     //                  },
     //                  child: Container(
     //                    width: 1.sw,
     //                    padding: EdgeInsets.all(30),
     //                    clipBehavior: Clip.hardEdge,
     //                    decoration: BoxDecoration(
     //                        border:
     //                        Border.all(color: ColorSelect.colorE0E0E0, width: 1),
     //                        color: ColorSelect.colorFFFFFF,
     //                        borderRadius: BorderRadius.circular(12)),
     //                    child: SvgPicture.asset("assets/images/etsy.svg",fit: BoxFit.contain),
     //                  ),
     //                ),
     //                Positioned(
     //                  top:10,
     //                  right:10,
     //                  child: GestureDetector(
     //                    onTap: () async {
     //                      print(searchList[i].url);
     //                      await Clipboard.setData(
     //                          ClipboardData(text: searchList[i].url)
     //                      );
     //                    },
     //                    child: Icon(
     //                      Icons.copy_rounded,
     //                      size: 25,
     //                    ),
     //                  ),
     //                ),
     //                Positioned(
     //                  top:10,
     //                  right:40,
     //                  child: GestureDetector(
     //                    onTap:() {
     //                      setState(() {
     //                        Share.share(searchList[i].url.toString());
     //                      });
     //
     //                    },
     //                    child: Icon(
     //                      Icons.share,
     //                      size: 25,),
     //                  ),
     //                )
     //              ],
     //            ),
     //            SizedBox(height: 10),
     //            Text(
     //              searchList[i].title.toString(),
     //              overflow: TextOverflow.ellipsis,
     //              textAlign: TextAlign.left,
     //              maxLines: 2,
     //              style: AppTextStyle().textColor29292912w500,
     //            ),
     //            SizedBox(height: 10),
     //            Text(
     //              ' \$ ${searchList[i].price!.amount.toString()}',
     //              overflow: TextOverflow.ellipsis,
     //              textAlign: TextAlign.left,
     //              maxLines: 2,
     //              style: AppTextStyle().textColor29292912w500,
     //            ),
     //            SizedBox(height: 10),
     //            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
     //              children: [
     //                SizedBox(
     //                  // height: 52.h,
     //                  // width: 88.w,
     //
     //                  child: LightYellowButtonWithText(
     //                      backgroundColor:
     //                      MaterialStateProperty.all(ColorSelect.colorF7E641),
     //                      textStyleColor: ColorSelect.color292929,
     //                      onTap: () {
     //                        Navigator.push(context,
     //                            MaterialPageRoute(builder: (context) => EtsyProductDetails(
     //                              productTitle: searchList[i].title.toString(),
     //                              productPrice: searchList[i].price!.amount.toString(),
     //                              productDescription: searchList[i].description.toString(),
     //                              productId: searchList[i].listingId.toString(),
     //                              productUrl: searchList[i].url.toString(),
     //                            )));
     //
     //                      },
     //                      title: 'View Details'),),
     //
     //                GestureDetector(
     //                    onTap: ()  {
     //                      launchUrlStart(url: searchList[i].url.toString() );
     //                    },
     //                    child: Text('View in website',
     //                      style: AppTextStyle().textColor29292916w500,))
     //              ],
     //            ),
     //          ],
     //        );
     //    }, separatorBuilder: (BuildContext context, int index) => SizedBox(height: 16,),
     //  )

    ),
    );
  }
}
