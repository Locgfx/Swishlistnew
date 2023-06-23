import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/dashboard/search/all_etsy_products.dart';
import 'package:swishlist/dashboard/search/search_product.dart';

import '../../api/etsy_apis/all_listing_apis.dart';
import '../../api/etsy_apis/etsy_listingid_api.dart';
import '../../constants/decoration.dart';
import '../../models/etsy_listingid_model.dart';
import '../../models/etsy_load_more_model.dart';
import '../../profile_page/add_date_events.dart';
import 'etsy_products_details.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  void initState() {
    super.initState();
  }
  final searchController = TextEditingController();
  void clearText() {
    searchController.clear();
  }

  bool isLoading = false;
/*
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
*/

  List<int> searchId = [];
  List<EtsyListingIdModel> searchListings = [];
  List<EtsyListingIdModel> matches = <EtsyListingIdModel>[];

  getSearch() {
    final resp = searchEtsyProductApi(search: searchController.text,);
    // searchId.clear();
    resp.then((value) {
      searchId.clear();
      setState(() {
        for (var v in value['results']) {
          searchId.add(v['listing_id']);

          isLoading = false;
        }
        print(searchId);
        getSearchId();

      });
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/Framesearch.png",
                height: 172,
                width: 119,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Search & add",
                    style: AppTextStyle().textColor29292924w700,
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Find your friends, or search products from your favourite shopping sites.",
                      textAlign: TextAlign.center,
                      style: AppTextStyle().textColor70707012w400,
                    ),
                  )
                ],
              ),
              SizedBox(height: 28),
              Container(
                width: 1.sw,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  // color: ColorSelect.colorF7E641,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (val) {
                        /*  setState(() {
                            if (searchController.text.isNotEmpty) {
                              getSearch(val);
                            } else {
                              setState(() {
                                searchListings.clear();
                                matches.clear();
                              });
                            }
                          });*/
                        },
                        controller: searchController,
                        cursorColor: ColorSelect.colorF7E641,
                        decoration: AppTFWithIconDecoration(
                          hint: 'Enter Product Tags',
                          icon:
                          GestureDetector(
                              onTap: () {

                                  if (searchController.text.isNotEmpty) {
                                    getSearch();
                                  } else {
                                    setState(() {
                                      searchListings.clear();
                                      matches.clear();
                                    });
                                  }

                              },
                              child: Image.asset('assets/images/search 03.png',height: 25,)),

                        )
                            .decoration(),
                        //keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
              ),
              // InkWell(
              //   onTap: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => SearchProduct()));
              //   },
              //   child:  Padding(
              //     padding: const EdgeInsets.only(left: 12),
              //     child: Row(
              //       children: [
              //         Expanded(
              //           child:
              //           TextFormField(
              //             onChanged: (val) {
              //               setState(() {
              //                 if (searchController.text.isNotEmpty) {
              //                   getSearch(val);
              //                 } else {
              //                   setState(() {
              //                     searchListings.clear();
              //                     matches.clear();
              //                   });
              //                 }
              //               });
              //             },
              //             controller: searchController,
              //             cursorColor: ColorSelect.colorF7E641,
              //             decoration: AppTFWithIconDecoration(
              //               hint: 'Enter Product Tags',
              //               icon: SizedBox()
              //               /*searchController.text.isEmpty ?
              //               SizedBox():
              //               GestureDetector(
              //                   onTap: () {
              //                     clearText();
              //                   },
              //                   child: Image.asset('assets/images/Frame 1000002471.png',height: 25,),
              //               ),*/
              //             ).decoration(),
              //             //keyboardType: TextInputType.phone,
              //           ),
              //           // TextFormField(
              //           // onChanged: (val) {
              //           //         setState(() {
              //           //           if (searchController.text.isNotEmpty) {
              //           //             getSearch(val);
              //           //           } else {
              //           //             setState(() {
              //           //               searchListings.clear();
              //           //               matches.clear();
              //           //             });
              //           //           }
              //           //         });
              //           //     },
              //           //   controller: searchController,
              //           //   keyboardType: TextInputType.text,
              //           //   decoration: InputDecoration(
              //           //     border: InputBorder.none,
              //           //     hintText: "Search product",
              //           //     hintStyle: AppTextStyle().textColor70707014w400,
              //           //     suffixIconConstraints: BoxConstraints(
              //           //         maxHeight: 40,maxWidth: 40),
              //           //     suffixIcon: searchController.text.isEmpty ?
              //           //         SizedBox():
              //           //     Padding(
              //           //       padding: const EdgeInsets.only(right: 15.0),
              //           //       child: GestureDetector(
              //           //           onTap: () {
              //           //             clearText();
              //           //           },
              //           //           child: Image.asset(
              //           //             'assets/images/Frame 1000002471.png',height: 25,)),
              //           //     ),
              //           //   ),
              //           // ),
              //         ),
              //       ],
              //     ),
              //   ),
              //   // Container(
              //   //   width: 328.w,
              //   //   height: 52.h,
              //   //   decoration: BoxDecoration(
              //   //       borderRadius: BorderRadius.circular(8),
              //   //       color: ColorSelect.colorEDEDF1),
              //   //   child: Row(
              //   //     children: [
              //   //       SizedBox(
              //   //         width: 16,
              //   //       ),
              //   //       Image.asset("assets/images/Vectorse.png"),
              //   //       SizedBox(
              //   //         width: 16,
              //   //       ),
              //   //       Expanded(
              //   //         child: TextFormField(
              //   //           controller: searchController,
              //   //           onChanged: (val) {
              //   //               setState(() {
              //   //                 if (searchController.text.isNotEmpty) {
              //   //                   getSearch(val);
              //   //                 } else {
              //   //                   setState(() {
              //   //                     searchList.clear();
              //   //                     matches.clear();
              //   //                   });
              //   //                 }
              //   //               });
              //   //           },
              //   //           decoration: InputDecoration(
              //   //               border: InputBorder.none,
              //   //               hintText: "Search etsy product"),
              //   //           keyboardType: TextInputType.text,
              //   //           onFieldSubmitted: (val) {
              //   //             /*showModalBottomSheet(
              //   //                 shape: const RoundedRectangleBorder(
              //   //                 borderRadius: BorderRadius.only(
              //   //                 topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              //   //             ),
              //   //             context: context,
              //   //             builder: (context) => SearchProductBottomSheet());*/
              //   //
              //   //           },
              //   //         ),
              //   //       ),
              //   //     ],
              //   //   ),
              //   // ),
              // ),
              searchController.text.isNotEmpty ?
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: 150,top: 24),
                shrinkWrap: true,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    mainAxisExtent: 300
                ),
                itemCount: searchListings.length,
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
                                  maxLines: 3,
                                  style: AppTextStyle()
                                      .textColor29292912w500,
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

                },
              ):
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 29,
                  ),
                  GestureDetector(
                    onTap: () {
                      /* showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return StoreSheet();
                      });*/
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10, right: 10),
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          // Image.asset("assets/images/comboshape.png"),
                          // SizedBox(
                          //   width: 10,
                          // ),
                          // Text(
                          //   "Stores",
                          //   style: AppTextStyle().textColor29292914w500,
                          // ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Image.asset("assets/images/searchimg.png"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  // SizedBox(
                  //   height: 56,
                  // ),
                  Text(
                    "Top Sites",
                    style: AppTextStyle().textColor766A6A12w400,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      // Container(
                      //   height: 44.h,
                      //   width: 120.w,
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(8),
                      //       border: Border.all(
                      //           color: ColorSelect.colorA3A3A3, width: 1)),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Image.asset("assets/images/amazonimg.png"),
                      //       Text(
                      //         "Amazon",
                      //         style: AppTextStyle().textColor29292914w400,
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(
                      //   width: 12,
                      // ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (_) =>
                              AllEtsyProducts()));
                        },
                        child: Container(
                          height: 44.h,
                          width: 120.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  color: ColorSelect.colorA3A3A3, width: 1)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/etsyimg.png"),
                              Text(
                                "Etsy",
                                style: AppTextStyle().textColor29292914w400,
                              )
                            ],
                          ),
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
  }
}

class StoreSheet extends StatefulWidget {
  const StoreSheet({Key? key}) : super(key: key);

  @override
  State<StoreSheet> createState() => _StoreSheetState();
}

class _StoreSheetState extends State<StoreSheet> {
  bool _switchAmazon = false;
  bool _switchEtsy = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 22),
            Row(
              children: [
                Text(
                  "Stores",
                  style: AppTextStyle().ubuntu29292820w700,
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.close)),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              "Search results from selected stores",
              style: AppTextStyle().textcolor80808012w400,
            ),
            SizedBox(height: 28),
            Row(
              children: [
                Text(
                  "Amazon",
                  style: AppTextStyle().textColor38383814w400,
                ),
                Spacer(),
                Switch(
                  value: _switchAmazon,
                  activeColor: ColorSelect.colorF7E641,
                  activeTrackColor: ColorSelect.colorF6EDCA,
                  inactiveTrackColor: ColorSelect.colorEBEBEB,
                  inactiveThumbColor: ColorSelect.color9F9F9F,
                  onChanged: (value) {
                    setState(() {
                      _switchAmazon = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Etsy",
                  style: AppTextStyle().textColor38383814w400,
                ),
                Spacer(),
                Switch(
                  value: _switchEtsy,
                  activeColor: ColorSelect.colorF7E641,
                  activeTrackColor: ColorSelect.colorF6EDCA,
                  inactiveTrackColor: ColorSelect.colorEBEBEB,
                  inactiveThumbColor: ColorSelect.color9F9F9F,
                  onChanged: (value) {
                    setState(() {
                      _switchEtsy = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 32)
          ],
        ),
      ),
    );
  }
}


class SearchProductBottomSheet extends StatefulWidget {
  const SearchProductBottomSheet(
      {Key? key, })
      : super(key: key);

  @override
  State<SearchProductBottomSheet> createState() => _SearchProductBottomSheet();
}

class _SearchProductBottomSheet extends State<SearchProductBottomSheet> {

  bool isLoading = false;
  List<EtsyLoadMoreModel> matches = <EtsyLoadMoreModel>[];
  List<EtsyLoadMoreModel> searchList = [];
  getSearch(val) {
    final resp = searchEtsyProductApi(search: val, );
    resp.then((value) {
      searchList.clear();
      for (var v in value['results']) {
        searchList.add(EtsyLoadMoreModel.fromJson(v));
        isLoading = false;
        print(searchList);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: ScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        mainAxisExtent: 310,
      ),
      itemCount: searchList.length,
      itemBuilder: (_, i) {
        return Column(
          children: [
            GestureDetector(
              onTap: () {
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
                            ' \$ ${searchList[i].price.toString()}',
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
            ),
          ],
        );
      },
    );
  }


}
