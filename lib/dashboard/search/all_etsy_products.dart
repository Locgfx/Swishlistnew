import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/api/etsy_apis/all_listing_apis.dart';
import 'package:swishlist/constants/globals/globals.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../api/etsy_apis/etsy_images_api.dart';
import '../../api/etsy_apis/etsy_listingid_api.dart';
import '../../buttons/light_yellow.dart';
import '../../constants/color.dart';
import '../../constants/decoration.dart';
import '../../constants/globals/loading.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import '../../models/etsy_image_model.dart';
import '../../models/etsy_listingid_model.dart';
import '../../models/etsy_load_more_model.dart';
import '../../models/etsy_product_image_model.dart';
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
  List<int> productId = [];
  int scroll = 0;
  int scrollLength = 0;
  List<EtsyListingIdModel> listings = [];
  List<int> searchId = [];
  List<EtsyListingIdModel> searchListings = [];
  List<EtsyListingIdModel> matches = <EtsyListingIdModel>[];

  getAllListing() {
    isLoading = true;
    var resp = allEtsyListingApi(page: '0');
    productId.clear();
    resp.then((value) {
      setState(() {
        scrollLength = value["results"].length;
        for (var v in value['results']) {
          // friendList.add(EtsyLoadMoreModel.fromJson(v));
          productId.add(v['listing_id']);
          isLoading = false;
          // print(productId);
        }
        // print(productId);
        getListingId();
        //  for(var v in friendList) {
        //   getListingId(v.listingId);
        // }
      });
    });
  }

  loadMore() {
    scroll++;
    final resp = allEtsyListingApi(page: scroll.toString());
    resp.then((value) {
      productId.clear();
      setState(() {
        scrollLength = value["results"].length;
        for (var v in value['results']) {
          productId.add(v['listing_id']);
          // friendList.add(EtsyLoadMoreModel.fromJson(v));
          isLoading = false;
        }
        // print("$productId loadmore");
        // print(value);
        getListingId();
        /*  for(var v in friendList) {
          getListingId(v.listingId);
        }*/
        //_isLoading = false;
      });
    });
  }

  getListingId() {
    var resp = getListingByListingIds(listingId: productId.join(","));
    resp.then((value) {
      setState(() {
        for (var v in value['results']) {
          listings.add(EtsyListingIdModel.fromJson(v));
          isLoading = false;
        }
        isLoading = false;
      });
    });
  }

  getSearch() {
    final resp = searchEtsyProductApi(search: searchController.text,);
    // searchId.clear();
    resp.then((value) {
      searchId.clear();
      setState(() {
        scrollLength = value["results"].length;
        for (var v in value['results']) {
          searchId.add(v['listing_id']);

          isLoading = false;
        }
        print(searchId);
        getSearchId();

      });
    });
  }
  // searchLoadMore() {
  //   scroll++;
  //   final resp = searchEtsyProductApi(page: scroll.toString(), search: searchController.text);
  //   resp.then((value) {
  //     print(searchController.text);
  //     searchId.clear();
  //     setState(() {
  //       scrollLength = value["results"].length;
  //       for (var v in value['results']) {
  //         searchId.add(v['listing_id']);
  //         // friendList.add(EtsyLoadMoreModel.fromJson(v));
  //         isLoading = false;
  //       }
  //       // print("$productId loadmore");
  //       // print(value);
  //       getListingId();
  //       /*  for(var v in friendList) {
  //         getListingId(v.listingId);
  //       }*/
  //       //_isLoading = false;
  //     });
  //   });
  // }

  getSearchId() {
    var resp = getListingByListingIds(listingId: searchId.join(","));
    resp.then((value) {
      searchListings.clear();
      setState(() {
        for (var v in value['results']) {
          searchListings.add(EtsyListingIdModel.fromJson(v));
          isLoading = false;
        }
        isLoading = false;
      });
    });
  }

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: ColorSelect.colorF7E641,
        backgroundColor: ColorSelect.colorFFFFFF,
        elevation: 0,
        title: Row(
          children: [
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
      ),
      body: isLoading
          ? Loading()
          : Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 75),
                  child: searchController.text.isEmpty
                      ? LazyLoadScrollView(
                          isLoading: isLoading,
                          scrollDirection: Axis.vertical,
                          onEndOfPage: () {
                            if (scrollLength >= 25) {
                              loadMore();
                            }
                          },
                          child: Scrollbar(
                            child: GridView.builder(
                              padding: EdgeInsets.only(bottom: 24),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 10.0,
                                      mainAxisExtent: 300
                                  ),
                              itemCount: listings.length + 1,
                              itemBuilder: (_, i) {
                                if (i < listings.length) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EtsyProductDetails(
                                            productTitle:
                                                listings[i].title.toString(),
                                            productPrice: listings[i]
                                                .price!
                                                .amount
                                                .toString(),
                                            productDescription: listings[i]
                                                .description
                                                .toString(),
                                            productId: listings[i]
                                                .listingId
                                                .toString(),
                                            productUrl:
                                            listings[i].url.toString(),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                       border: Border.all(width: 1,color:  ColorSelect.colorF7E641)
                                      ),

                                      child: Column(
                                        children: [
                                          Container(
                                            height: 200,
                                            clipBehavior: Clip.hardEdge,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(16.0),
                                                        topRight: Radius.circular(16.0),
                                                      )
                                            ),
                                            child: CachedNetworkImage(
                                                      imageUrl: listings[i]
                                                          .images![0]
                                                          .url570xN
                                                          .toString(),
                                                      fit: BoxFit.cover,
                                                      errorWidget:
                                                          (context, url, error) => Icon(
                                                        Icons.error,
                                                        size: 40,
                                                      ),
                                                      progressIndicatorBuilder:
                                                          (a, b, c) => Opacity(
                                                        opacity: 0.3,
                                                        child: Shimmer.fromColors(
                                                          baseColor: Colors.black12,
                                                          highlightColor: Colors.white,
                                                          child: Container(
                                                            width: 173,
                                                            height: 129,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: ColorSelect
                                                                        .colorE0E0E0,
                                                                    width: 1),
                                                                color: ColorSelect
                                                                    .colorFFFFFF,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(12)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.all(8),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                              Text(
                                                listings[i]
                                                    .title
                                                    .toString(),
                                                overflow:
                                                TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                maxLines: 2,
                                                style: AppTextStyle().textColor29292914w400,
                                                        ),
                                                const SizedBox(
                                                  height: 8.0,
                                                        ),
                                                Text(
                                                  ' \$ ${listings[i].price!.amount.toString()}',
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                          style: AppTextStyle()
                                                              .textColor29292912w500,
                                                        ),
                                              ],
                                            ),

                                          )
                                        ],

                                      ),
                                    ),
                                    // child: Column(
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.start,
                                    //   children: [
                                    //     Container(
                                    //      /* borderRadius:
                                    //           const BorderRadius.only(
                                    //         topLeft: Radius.circular(16.0),
                                    //         topRight: Radius.circular(16.0),
                                    //       ),*/
                                    //       child: CachedNetworkImage(
                                    //         // imageUrl: (baseUrl+haveProducts2[i].photo.toString()),
                                    //         imageUrl: listings[i]
                                    //             .images![0]
                                    //             .url570xN
                                    //             .toString(),
                                    //         fit: BoxFit.cover,
                                    //         errorWidget:
                                    //             (context, url, error) => Icon(
                                    //           Icons.error,
                                    //           size: 40,
                                    //         ),
                                    //         progressIndicatorBuilder:
                                    //             (a, b, c) => Opacity(
                                    //           opacity: 0.3,
                                    //           child: Shimmer.fromColors(
                                    //             baseColor: Colors.black12,
                                    //             highlightColor: Colors.white,
                                    //             child: Container(
                                    //               width: 173,
                                    //               height: 129,
                                    //               decoration: BoxDecoration(
                                    //                   border: Border.all(
                                    //                       color: ColorSelect
                                    //                           .colorE0E0E0,
                                    //                       width: 1),
                                    //                   color: ColorSelect
                                    //                       .colorFFFFFF,
                                    //                   borderRadius:
                                    //                       BorderRadius
                                    //                           .circular(12)),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       ),
                                    //   /*   child: SvgPicture.asset(
                                    //      "assets/images/etsy.svg",
                                    //       height: 170,
                                    //       width: double.infinity,
                                    //       fit: BoxFit.cover,
                                    //       ),*/
                                    //     ),
                                    //     Padding(
                                    //       padding: const EdgeInsets.all(8.0),
                                    //       child: Column(
                                    //         crossAxisAlignment:
                                    //             CrossAxisAlignment.start,
                                    //         children: [
                                    //           Text(
                                    //             listings[i]
                                    //                 .title
                                    //                 .toString(),
                                    //             overflow:
                                    //                 TextOverflow.ellipsis,
                                    //             textAlign: TextAlign.left,
                                    //             maxLines: 5,
                                    //             style: AppTextStyle()
                                    //                 .textColor29292912w500,
                                    //           ),
                                    //           const SizedBox(
                                    //             height: 8.0,
                                    //           ),
                                    //           Text(
                                    //             ' \$ ${listings[i].price!.amount.toString()}',
                                    //             overflow:
                                    //                 TextOverflow.ellipsis,
                                    //             style: AppTextStyle()
                                    //                 .textColor29292912w500,
                                    //           ),
                                    //           const SizedBox(
                                    //             height: 8.0,
                                    //           ),
                                    //         ],
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                  );
                                } else if (scrollLength >= 25 && isLoading) {
                                  return Center(
                                    child: LoadingAnimationWidget
                                        .staggeredDotsWave(
                                      size: 70,
                                      color: ColorSelect.colorF7E641,
                                    ),
                                  );
                                } else if (scrollLength < 25) {
                                  return SizedBox.shrink();
                                } else {
                                  return Center(
                                    child: LoadingAnimationWidget
                                        .staggeredDotsWave(
                                      size: 70,
                                      color: ColorSelect.colorF7E641,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          // child: ListView.separated(
                          //   padding: EdgeInsets.only(top: 16,bottom: 200),
                          //   itemCount: listings.length + 1,
                          //   shrinkWrap: true,
                          //   // physics: NeverScrollableScrollPhysics(),
                          //   itemBuilder: (context,i) {
                          //     if (i < listings.length ) {
                          //       return Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           Stack(
                          //             children: [
                          //               GestureDetector(
                          //                 onTap : () {
                          //                   Navigator.push(context,
                          //                       MaterialPageRoute(builder: (context) => EtsyProductDetails(
                          //                         productTitle: listings[i].title.toString(),
                          //                         productPrice: listings[i].price!.amount.toString(),
                          //                         productDescription: listings[i].description.toString(),
                          //                         productId: listings[i].listingId.toString(),
                          //                         productUrl: listings[i].url.toString(),
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
                          //                     print(listings[i].url);
                          //                     await Clipboard.setData(
                          //                         ClipboardData(text: listings[i].url.toString())
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
                          //                       Share.share(listings[i].url.toString());
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
                          //             listings[i].title.toString(),
                          //             overflow: TextOverflow.ellipsis,
                          //             textAlign: TextAlign.left,
                          //             maxLines: 2,
                          //             style: AppTextStyle().textColor29292912w500,
                          //           ),
                          //           SizedBox(height: 10),
                          //           Text(
                          //             ' \$ ${listings[i].price!.amount.toString()}',
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
                          //                             productTitle: listings[i].title.toString(),
                          //                             productPrice: listings[i].price!.amount.toString(),
                          //                             productDescription: listings[i].description.toString(),
                          //                             productId: listings[i].listingId.toString(),
                          //                             productUrl: listings[i].url.toString(),
                          //                           ),
                          //                           ),
                          //                       );
                          //                     },
                          //                     title: 'View Details'),
                          //               ),
                          //
                          //               GestureDetector(
                          //                 onTap: ()  {
                          //                   launchUrlStart(url: listings[i].url.toString() );
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
                        )
                      :
                  Scrollbar(
                    child: GridView.builder(
                      padding: EdgeInsets.only(bottom: 24),
                      shrinkWrap: true,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          mainAxisExtent: 300
                      ),
                      itemCount: searchListings.length ,
                      itemBuilder: (_, i) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EtsyProductDetails(
                                        productTitle:
                                        searchListings[i].title.toString(),
                                        productPrice: searchListings[i]
                                            .price!
                                            .amount
                                            .toString(),
                                        productDescription: searchListings[i]
                                            .description
                                            .toString(),
                                        productId: searchListings[i]
                                            .listingId
                                            .toString(),
                                        productUrl:
                                        searchListings[i].url.toString(),
                                      ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(width: 1,color:  ColorSelect.colorF7E641)
                              ),

                              child: Column(
                                children: [
                                  Container(
                                    height: 200,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16.0),
                                          topRight: Radius.circular(16.0),
                                        )
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: searchListings[i]
                                          .images![0]
                                          .url570xN
                                          .toString(),
                                      fit: BoxFit.cover,
                                      errorWidget:
                                          (context, url, error) => Icon(
                                        Icons.error,
                                        size: 40,
                                      ),
                                      progressIndicatorBuilder:
                                          (a, b, c) => Opacity(
                                        opacity: 0.3,
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.black12,
                                          highlightColor: Colors.white,
                                          child: Container(
                                            width: 173,
                                            height: 129,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: ColorSelect
                                                        .colorE0E0E0,
                                                    width: 1),
                                                color: ColorSelect
                                                    .colorFFFFFF,
                                                borderRadius:
                                                BorderRadius
                                                    .circular(12)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          searchListings[i]
                                              .title
                                              .toString(),
                                          overflow:
                                          TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          maxLines: 2,
                                          style: AppTextStyle().textColor29292914w400,
                                        ),
                                        const SizedBox(
                                          height: 8.0,
                                        ),
                                        Text(
                                          ' \$ ${searchListings[i].price!.amount.toString()}',
                                          overflow:
                                          TextOverflow.ellipsis,
                                          style: AppTextStyle()
                                              .textColor29292912w500,
                                        ),
                                      ],
                                    ),

                                  )
                                ],

                              ),
                            ),
                          );
                      },
                    ),
                  ),

                  // GridView.builder(
                  //   padding: EdgeInsets.only(bottom: 24),
                  //   shrinkWrap: true,
                  //   gridDelegate:
                  //   const SliverGridDelegateWithFixedCrossAxisCount(
                  //       crossAxisCount: 2,
                  //       crossAxisSpacing: 10.0,
                  //       mainAxisSpacing: 10.0,
                  //       mainAxisExtent: 300
                  //   ),
                  //   itemCount: searchListings.length,
                  //   itemBuilder: (_, i) {
                  //       return GestureDetector(
                  //         onTap: () {
                  //           Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //               builder: (context) =>
                  //                   EtsyProductDetails(
                  //                     productTitle:
                  //                     searchListings[i].title.toString(),
                  //                     productPrice: searchListings[i]
                  //                         .price!
                  //                         .amount
                  //                         .toString(),
                  //                     productDescription: searchListings[i]
                  //                         .description
                  //                         .toString(),
                  //                     productId: searchListings[i]
                  //                         .listingId
                  //                         .toString(),
                  //                     productUrl:
                  //                     searchListings[i].url.toString(),
                  //                   ),
                  //             ),
                  //           );
                  //         },
                  //         child: Container(
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(16),
                  //               border: Border.all(width: 1,color:  ColorSelect.colorF7E641)
                  //           ),
                  //
                  //           child: Column(
                  //             children: [
                  //               Container(
                  //                 height: 200,
                  //                 clipBehavior: Clip.hardEdge,
                  //                 decoration: BoxDecoration(
                  //                     borderRadius: BorderRadius.only(
                  //                       topLeft: Radius.circular(16.0),
                  //                       topRight: Radius.circular(16.0),
                  //                     )
                  //                 ),
                  //                 child: CachedNetworkImage(
                  //                   imageUrl: searchListings[i]
                  //                       .images![0]
                  //                       .url570xN
                  //                       .toString(),
                  //                   fit: BoxFit.cover,
                  //                   errorWidget:
                  //                       (context, url, error) => Icon(
                  //                     Icons.error,
                  //                     size: 40,
                  //                   ),
                  //                   progressIndicatorBuilder:
                  //                       (a, b, c) => Opacity(
                  //                     opacity: 0.3,
                  //                     child: Shimmer.fromColors(
                  //                       baseColor: Colors.black12,
                  //                       highlightColor: Colors.white,
                  //                       child: Container(
                  //                         width: 173,
                  //                         height: 129,
                  //                         decoration: BoxDecoration(
                  //                             border: Border.all(
                  //                                 color: ColorSelect
                  //                                     .colorE0E0E0,
                  //                                 width: 1),
                  //                             color: ColorSelect
                  //                                 .colorFFFFFF,
                  //                             borderRadius:
                  //                             BorderRadius
                  //                                 .circular(12)),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //               Container(
                  //                 margin: EdgeInsets.all(8),
                  //                 child: Column(
                  //                   crossAxisAlignment: CrossAxisAlignment.start,
                  //                   children: [
                  //                     Text(
                  //                       searchListings[i]
                  //                           .title
                  //                           .toString(),
                  //                       overflow:
                  //                       TextOverflow.ellipsis,
                  //                       textAlign: TextAlign.left,
                  //                       maxLines: 3,
                  //                       style: AppTextStyle()
                  //                           .textColor29292912w500,
                  //                     ),
                  //                     const SizedBox(
                  //                       height: 8.0,
                  //                     ),
                  //                     Text(
                  //                       ' \$ ${searchListings[i].price!.amount.toString()}',
                  //                       overflow:
                  //                       TextOverflow.ellipsis,
                  //                       style: AppTextStyle()
                  //                           .textColor29292912w500,
                  //                     ),
                  //
                  //                   ],
                  //                 ),
                  //
                  //               )
                  //             ],
                  //
                  //           ),
                  //         ),
                  //         // child: Column(
                  //         //   crossAxisAlignment:
                  //         //       CrossAxisAlignment.start,
                  //         //   children: [
                  //         //     Container(
                  //         //      /* borderRadius:
                  //         //           const BorderRadius.only(
                  //         //         topLeft: Radius.circular(16.0),
                  //         //         topRight: Radius.circular(16.0),
                  //         //       ),*/
                  //         //       child: CachedNetworkImage(
                  //         //         // imageUrl: (baseUrl+haveProducts2[i].photo.toString()),
                  //         //         imageUrl: listings[i]
                  //         //             .images![0]
                  //         //             .url570xN
                  //         //             .toString(),
                  //         //         fit: BoxFit.cover,
                  //         //         errorWidget:
                  //         //             (context, url, error) => Icon(
                  //         //           Icons.error,
                  //         //           size: 40,
                  //         //         ),
                  //         //         progressIndicatorBuilder:
                  //         //             (a, b, c) => Opacity(
                  //         //           opacity: 0.3,
                  //         //           child: Shimmer.fromColors(
                  //         //             baseColor: Colors.black12,
                  //         //             highlightColor: Colors.white,
                  //         //             child: Container(
                  //         //               width: 173,
                  //         //               height: 129,
                  //         //               decoration: BoxDecoration(
                  //         //                   border: Border.all(
                  //         //                       color: ColorSelect
                  //         //                           .colorE0E0E0,
                  //         //                       width: 1),
                  //         //                   color: ColorSelect
                  //         //                       .colorFFFFFF,
                  //         //                   borderRadius:
                  //         //                       BorderRadius
                  //         //                           .circular(12)),
                  //         //             ),
                  //         //           ),
                  //         //         ),
                  //         //       ),
                  //         //   /*   child: SvgPicture.asset(
                  //         //      "assets/images/etsy.svg",
                  //         //       height: 170,
                  //         //       width: double.infinity,
                  //         //       fit: BoxFit.cover,
                  //         //       ),*/
                  //         //     ),
                  //         //     Padding(
                  //         //       padding: const EdgeInsets.all(8.0),
                  //         //       child: Column(
                  //         //         crossAxisAlignment:
                  //         //             CrossAxisAlignment.start,
                  //         //         children: [
                  //         //           Text(
                  //         //             listings[i]
                  //         //                 .title
                  //         //                 .toString(),
                  //         //             overflow:
                  //         //                 TextOverflow.ellipsis,
                  //         //             textAlign: TextAlign.left,
                  //         //             maxLines: 5,
                  //         //             style: AppTextStyle()
                  //         //                 .textColor29292912w500,
                  //         //           ),
                  //         //           const SizedBox(
                  //         //             height: 8.0,
                  //         //           ),
                  //         //           Text(
                  //         //             ' \$ ${listings[i].price!.amount.toString()}',
                  //         //             overflow:
                  //         //                 TextOverflow.ellipsis,
                  //         //             style: AppTextStyle()
                  //         //                 .textColor29292912w500,
                  //         //           ),
                  //         //           const SizedBox(
                  //         //             height: 8.0,
                  //         //           ),
                  //         //         ],
                  //         //       ),
                  //         //     ),
                  //         //   ],
                  //         // ),
                  //       );
                  //
                  //   },
                  // ),

                  /*GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12.0,
                            mainAxisSpacing: 12.0,
                            mainAxisExtent: 310,
                          ),
                          itemCount: searchListings.length,
                          itemBuilder: (_, i) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EtsyProductDetails(
                                      productTitle:
                                      searchListings[i].title.toString(),
                                      productPrice: listings[i]
                                          .price!
                                          .amount
                                          .toString(),
                                      productDescription:
                                      searchListings[i].description.toString(),
                                      productId:
                                      searchListings[i].listingId.toString(),
                                      productUrl: listings[i].url.toString(),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            searchList[i].title.toString(),
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            maxLines: 5,
                                            style: AppTextStyle()
                                                .textColor29292912w500,
                                          ),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          Text(
                                            ' \$ ${searchList[i].price!.amount.toString()}',
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyle()
                                                .textColor29292912w500,
                                          ),
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
                        ),*/

                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 16),
                  width: 1.sw,
                  decoration: BoxDecoration(
                    color: ColorSelect.colorFFFFFF,
                    // color: ColorSelect.colorF7E641,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20)),
                  ),
                  child: TextFormField(
                    onChanged: (val) {
                      setState(() {
                        if (searchController.text.isNotEmpty) {
                          getSearch();
                        } else {
                          setState(() {
                            searchListings.clear();
                            matches.clear();
                          });
                        }
                      });
                    },
                    controller: searchController,
                    cursorColor: ColorSelect.colorF7E641,
                    decoration: AppTFWithIconDecoration(
                        hint: 'Enter Product Tags',
                        icon: GestureDetector(
                            onTap: () {},
                            child: Image.asset('assets/images/search 03.png',height: 25,)),

                        )
                        .decoration(),
                    //keyboardType: TextInputType.phone,
                  ),
                )
              ],
            ),
    );
  }
}
