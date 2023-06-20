import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swishlist/api/etsy_apis/all_listing_apis.dart';
import 'package:swishlist/constants/globals/globals.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../api/etsy_apis/etsy_images_api.dart';
import '../../buttons/light_yellow.dart';
import '../../constants/color.dart';
import '../../constants/decoration.dart';
import '../../constants/globals/loading.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import '../../models/etsy_image_model.dart';
import '../../models/etsy_load_more_model.dart';
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
    super.initState();
  }

  bool isLoading = false;


  getAllListing() {
    isLoading = true;
    var resp = allEtsyListingApi(page: '0');
    resp.then((value) {
      setState(() {
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
/*  EtsyImagesModel?  imageModel;
  getImages() {
    isLoading = true;
    var resp = getEtsyImagesApi(listingId: widget.productId);
    resp.then((value) {
      setState(() {
        imageModel = EtsyImagesModel.fromJson(value);
        isLoading = false;
      });
      print(imageModel!.results![0].urlFullxfull.toString());
      // print(object)
    });
  }*/

  List<EtsyLoadMoreModel> matches = <EtsyLoadMoreModel>[];
  List<EtsyLoadMoreModel> searchList = [];
  getSearch(val) {
    final resp = searchEtsyProductApi(search: val);
    resp.then((value) {
      searchList.clear();
      for (var v in value['results']) {
        searchList.add(EtsyLoadMoreModel.fromJson(v));
        isLoading = false;
        print(searchList);
      }
    });
  }

  List<EtsyLoadMoreModel> friendList = [];
  final searchController = TextEditingController();

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
  bool searchField = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: ColorSelect.colorF7E641,
        backgroundColor: ColorSelect.colorFFFFFF,
        elevation: 0,
        title: Row(children: [
          Text(
            "Etsy Product",
            style: AppTextStyle().textColor29292916w500,
          ),
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
      //   actions: [
      //     GestureDetector(
      //       onTap: () {
      //
      //       },
      //       child: searchField ?
      //         Image.asset(
      //         "assets/images/Frame 1000002471.png",
      //           height: 24,
      //           width: 24,
      //
      //       // color: ColorSelect.color292929,
      //   ) :
      // Padding(
      //   padding: const EdgeInsets.only(right: 20.0),
      //   child: Image.asset(
      //       "assets/images/search 03.png",
      //       height: 24,
      //       width: 24,
      //       color: ColorSelect.color292929,
      //   ),
      // ),
      //     ) ,
      //   ],
      ),
    //   appBar: AppBar(
    //   backgroundColor: ColorSelect.colorF7E641,
    //   automaticallyImplyLeading: false,
    //   elevation: 0,
    //   flexibleSpace: Row(
    //     children: [
    //
    //       Container(
    //         padding: EdgeInsets.all(16),
    //         decoration: BoxDecoration(
    //           color: ColorSelect.colorF7E641,
    //         ),
    //         child: Text(
    //           "All Etsy Products",
    //           style: AppTextStyle().textColor29292916w500,
    //         ),
    //       ),
    //     ],
    //   ),
    // ),
      body: isLoading ? Loading() : Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16,right: 16,top: 75),
            child: searchController.text.isEmpty?
            LazyLoadScrollView(
              isLoading: isLoading,
              scrollDirection: Axis.vertical,
              onEndOfPage: () {
                // print(scrollLength);
                if (scrollLength >= 25) {
                  loadMore();
                }
              },
            child: Scrollbar(
              child: GridView.builder(
                padding: EdgeInsets.only(bottom: 24),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                  mainAxisExtent: 310,
                ),
                itemCount: friendList.length + 1,
                itemBuilder: (_, i) {
                  if (i < friendList.length ) {
                   return GestureDetector(
                     onTap: () {
                       Navigator.push(context,
                         MaterialPageRoute(builder: (context) => EtsyProductDetails(
                           productTitle: friendList[i].title.toString(),
                           productPrice: friendList[i].price!.amount.toString(),
                           productDescription: friendList[i].description.toString(),
                           productId: friendList[i].listingId.toString(),
                           productUrl: friendList[i].url.toString(),
                         ),
                         ),
                       );
                     },
                     child: Container(
                      decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(
                        16.0,
          ),
          color: Colors.amberAccent.shade100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              child: SvgPicture.asset(
                "assets/images/etsy.svg",
                height: 170,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      friendList[i].title.toString(),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      maxLines: 5,
                      style: AppTextStyle().textColor29292912w500,
                  ),
                  const SizedBox(
                      height: 8.0,
                  ),
                  Text(
                      ' \$ ${friendList[i].price!.amount.toString()}',
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle().textColor29292912w500,),
                  const SizedBox(
                      height: 8.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
                   );
                   } else if (scrollLength >= 25 && isLoading) {
                     return Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                     size: 70, color: ColorSelect.colorF7E641,
                   ),
                );
             }  else if( scrollLength < 10) {
                 return SizedBox.shrink();
               } else {
                 return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                  size: 70, color: ColorSelect.colorF7E641,
        ),
      );
    }
                },
              ),
            ),
              // child: ListView.separated(
              //   padding: EdgeInsets.only(top: 16,bottom: 200),
              //   itemCount: friendList.length + 1,
              //   shrinkWrap: true,
              //   // physics: NeverScrollableScrollPhysics(),
              //   itemBuilder: (context,i) {
              //     if (i < friendList.length ) {
              //       return Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Stack(
              //             children: [
              //               GestureDetector(
              //                 onTap : () {
              //                   Navigator.push(context,
              //                       MaterialPageRoute(builder: (context) => EtsyProductDetails(
              //                         productTitle: friendList[i].title.toString(),
              //                         productPrice: friendList[i].price!.amount.toString(),
              //                         productDescription: friendList[i].description.toString(),
              //                         productId: friendList[i].listingId.toString(),
              //                         productUrl: friendList[i].url.toString(),
              //                       ),
              //                       ),
              //                   );
              //                 },
              //                 child: Container(
              //                   width: 1.sw,
              //                   padding: EdgeInsets.all(30),
              //                   clipBehavior: Clip.hardEdge,
              //                   decoration: BoxDecoration(
              //                       border:
              //                       Border.all(color: ColorSelect.colorE0E0E0, width: 1),
              //                       color: ColorSelect.colorFFFFFF,
              //                       borderRadius: BorderRadius.circular(12)),
              //                   child: SvgPicture.asset("assets/images/etsy.svg",fit: BoxFit.contain),
              //                 ),
              //               ),
              //               Positioned(
              //                 top:10,
              //                 right:10,
              //                 child: GestureDetector(
              //                   onTap: () async {
              //                     print(friendList[i].url);
              //                     await Clipboard.setData(
              //                         ClipboardData(text: friendList[i].url.toString())
              //                     );
              //                   },
              //                   child: Icon(
              //                     Icons.copy_rounded,
              //                     size: 25,
              //                   ),
              //                 ),
              //               ),
              //               Positioned(
              //                 top:10,
              //                 right:45,
              //                 child: GestureDetector(
              //                   onTap:() {
              //                     setState(() {
              //                       Share.share(friendList[i].url.toString());
              //                     });
              //
              //                   },
              //                   child: Icon(
              //                     Icons.share,
              //                     size: 25,),
              //                 ),
              //               )
              //             ],
              //           ),
              //           SizedBox(height: 10),
              //           Text(
              //             friendList[i].title.toString(),
              //             overflow: TextOverflow.ellipsis,
              //             textAlign: TextAlign.left,
              //             maxLines: 2,
              //             style: AppTextStyle().textColor29292912w500,
              //           ),
              //           SizedBox(height: 10),
              //           Text(
              //             ' \$ ${friendList[i].price!.amount.toString()}',
              //             overflow: TextOverflow.ellipsis,
              //             textAlign: TextAlign.left,
              //             maxLines: 2,
              //             style: AppTextStyle().textColor29292912w500,
              //           ),
              //           SizedBox(height: 10),
              //           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               SizedBox(
              //                 child: LightYellowButtonWithText(
              //                     backgroundColor:
              //                     MaterialStateProperty.all(ColorSelect.colorF7E641),
              //                     textStyleColor: ColorSelect.color292929,
              //                     onTap: () {
              //                       Navigator.push(context,
              //                           MaterialPageRoute(builder: (context) => EtsyProductDetails(
              //                             productTitle: friendList[i].title.toString(),
              //                             productPrice: friendList[i].price!.amount.toString(),
              //                             productDescription: friendList[i].description.toString(),
              //                             productId: friendList[i].listingId.toString(),
              //                             productUrl: friendList[i].url.toString(),
              //                           ),
              //                           ),
              //                       );
              //                     },
              //                     title: 'View Details'),
              //               ),
              //
              //               GestureDetector(
              //                 onTap: ()  {
              //                   launchUrlStart(url: friendList[i].url.toString() );
              //                 },
              //                   child: Text('View in website',
              //                   style: AppTextStyle().textColor29292916w500,)
              //               ),
              //             ],
              //           ),
              //         ],
              //       );
              //     }
              //     else if (scrollLength >= 25 && isLoading) {
              //       return Center(
              //         child: LoadingAnimationWidget.staggeredDotsWave(
              //           size: 70, color: ColorSelect.colorF7E641,
              //         ),
              //       );
              //     } else if( scrollLength < 10) {
              //       return SizedBox.shrink();
              //     } else {
              //       return Center(
              //         child: LoadingAnimationWidget.staggeredDotsWave(
              //           size: 70, color: ColorSelect.colorF7E641,
              //            ),
              //         );
              //       }
              //     }, separatorBuilder: (BuildContext context, int index) => SizedBox(height: 16,),
              //   ),
            ) :
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                mainAxisExtent: 310,
              ),
              itemCount: searchList.length,
              itemBuilder: (_, i) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EtsyProductDetails(
                        productTitle: friendList[i].title.toString(),
                        productPrice: friendList[i].price!.amount.toString(),
                        productDescription: friendList[i].description.toString(),
                        productId: friendList[i].listingId.toString(),
                        productUrl: friendList[i].url.toString(),
                                              ),
                                              ),
                                          );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        16.0,
                      ),
                      color: Colors.amberAccent.shade100,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0),
                          ),
                          child: SvgPicture.asset(
                            "assets/images/etsy.svg",
                            height: 170,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                searchList[i].title.toString(),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                maxLines: 5,
                                style: AppTextStyle().textColor29292912w500,
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                ' \$ ${searchList[i].price!.amount.toString()}',
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle().textColor29292912w500,),
                              const SizedBox(
                                height: 8.0,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
       /*     ListView.separated(
            padding: EdgeInsets.only(top: 16,bottom: 200),
            itemCount: searchList.length ,
            shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context,i) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        TextFieldUnFocusOnTap(
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
                              print(searchList[i].url);
                              await Clipboard.setData(
                                  ClipboardData(text: searchList[i].url.toString())
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
                          right:40,
                          child: GestureDetector(
                            onTap:() {
                              setState(() {
                                Share.share(searchList[i].url.toString());
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
                      searchList[i].title.toString(),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      style: AppTextStyle().textColor29292912w500,
                    ),
                    SizedBox(height: 10),
                    Text(
                      ' \$ ${searchList[i].price!.amount.toString()}',
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      style: AppTextStyle().textColor29292912w500,
                    ),
                    SizedBox(height: 10),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: LightYellowButtonWithText(
                              backgroundColor:
                              MaterialStateProperty.all(ColorSelect.colorF7E641),
                              textStyleColor: ColorSelect.color292929,
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => EtsyProductDetails(
                                      productTitle: searchList[i].title.toString(),
                                      productPrice: searchList[i].price!.amount.toString(),
                                      productDescription: searchList[i].description.toString(),
                                      productId: searchList[i].listingId.toString(),
                                      productUrl: searchList[i].url.toString(),
                                    )));

                              },
                              title: 'View Details'),),

                        GestureDetector(
                            onTap: ()  {
                              launchUrlStart(url: searchList[i].url.toString() );
                            },
                            child: Text('View in website',
                              style: AppTextStyle().textColor29292916w500,))
                      ],
                    ),
                  ],
                );
            }, separatorBuilder: (BuildContext context, int index) => SizedBox(height: 16,),
          )*/

    ),
          Container(
            padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 10,
                bottom: 16
            ),
            width: 1.sw,
            decoration: BoxDecoration(
              color: ColorSelect.colorFFFFFF,
                // color: ColorSelect.colorF7E641,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20)
              ),
            ),
            child:TextFormField(
              onChanged: (val) {
                setState(() {
                  if(searchController.text.isNotEmpty){
                    getSearch(val);
                  } else {
                    setState(() {
                      searchList.clear();
                      matches.clear();
                    });
                  }
                });
              },
              controller: searchController,
              cursorColor: ColorSelect.colorF7E641,
              decoration: AppTFDecoration(
                  hint: 'Enter Product Tags').decoration(),
              //keyboardType: TextInputType.phone,
            ),
          )
        ],
      ),
    );
  }
}
