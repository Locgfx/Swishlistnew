import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/api/etsy_apis/all_listing_apis.dart';
import 'package:swishlist/constants/globals/globals.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../api/etsy_apis/etsy_listingid_api.dart';
import '../../constants/color.dart';
import '../../constants/decoration.dart';
import '../../constants/globals/loading.dart';
import '../../models/etsy_listingid_model.dart';
import 'etsy_products_details.dart';

class HomeEtsyProducts extends StatefulWidget {
  const HomeEtsyProducts({Key? key}) : super(key: key);

  @override
  State<HomeEtsyProducts> createState() => _HomeEtsyProductsState();
}

class _HomeEtsyProductsState extends State<HomeEtsyProducts> {
  @override
  void initState() {
    getAllListing();
    super.initState();
  }

  bool isLoading = false;
  List<int> productId = [];
  int scroll = 25;
  int searchScroll = 25;
  int scrollLength = 0;
  int searchLength = 0;
  List<EtsyListingIdModel> listings = [];
  List<int> searchId = [];
  List<EtsyListingIdModel> searchListings = [];
  List<EtsyListingIdModel> matches = <EtsyListingIdModel>[];
  bool loading = false;
  bool searchLoading = false;

  getAllListing() {
    isLoading = true;
    var resp = allEtsyListingApi(page: '0');
    productId.clear();
    resp.then((value) {
      setState(() {
        scrollLength = value["results"].length;
        for (var v in value['results']) {
          productId.add(v['listing_id']);
          isLoading = false;
          print(productId);
        }
        getListingId();
      });
    });
  }

  loadMore() {
    scroll = scroll + 25;
    final resp = allEtsyListingApi(page: scroll.toString());
    resp.then((value) {
      productId.clear();
      setState(() {
        scrollLength = value["results"].length;
        for (var v in value['results']) {
          productId.add(v['listing_id']);
          isLoading = false;
        }
        print("$productId loadmore");
        getListingId();
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
    final resp = searchEtsyProductApi(
      search: searchController.text,
      page: '0',
    );
    resp.then((value) {
      searchId.clear();
      setState(() {
        searchLength = value["results"].length;
        for (var v in value['results']) {
          searchId.add(v['listing_id']);
          searchLoading = false;
        }
        getSearchId();
      });
    });
  }

  searchLoadMore() {
    searchScroll = searchScroll + 25;
    final resp = searchEtsyProductApi(
        page: searchScroll.toString(), search: searchController.text);
    resp.then((value) {
      searchId.clear();
      setState(() {
        searchLength = value["results"].length;
        for (var v in value['results']) {
          searchId.add(v['listing_id']);
          searchLoading = false;
        }
        getSearchId();
      });
    });
  }

  getSearchId() {
    searchLoading = true;
    var resp = getListingByListingIds(listingId: searchId.join(","));
    resp.then((value) {
      // searchListings.clear();
      setState(() {
        for (var v in value['results']) {
          searchListings.add(EtsyListingIdModel.fromJson(v));
          loading = false;
        }
        loading = false;
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
    return TextFieldUnFocusOnTap(
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: ColorSelect.colorF7E641,
          backgroundColor: ColorSelect.colorFFFFFF,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Text(
                "Etsy Product",
                style: AppTextStyle().textColor29292916w500,
              ),
            ],
          ),
          // leading: Padding(
          //   padding: const EdgeInsets.only(left: 20),
          //   child: InkWell(
          //       onTap: () {
          //         Navigator.pop(context);
          //       },
          //       child: Image.asset('assets/images/Vector190.png')),
          // ),
        ),
        body: isLoading
            ? Loading()
            : Stack(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 105),
                    child: searchController.text.isEmpty
                        ? LazyLoadScrollView(
                            isLoading: isLoading,
                            scrollDirection: Axis.vertical,
                            onEndOfPage: () {
                              if (scrollLength >= 25) {
                                loadMore();
                              }
                            },
                            child: RefreshIndicator(
                              displacement: 500,
                              backgroundColor: Colors.white,
                              color: ColorSelect.colorF7E641,
                              strokeWidth: 3,
                              onRefresh: () {
                                setState(() {
                                  isLoading = true;
                                });
                                return getListingId();
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
                                          mainAxisExtent: 300),
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
                                                productTitle: listings[i]
                                                    .title
                                                    .toString(),
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
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              border: Border.all(
                                                  width: 1,
                                                  color:
                                                      ColorSelect.colorF7E641)),
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 200,
                                                clipBehavior: Clip.hardEdge,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(16.0),
                                                  topRight:
                                                      Radius.circular(16.0),
                                                )),
                                                child: CachedNetworkImage(
                                                  imageUrl: listings[i]
                                                      .images![0]
                                                      .url570xN
                                                      .toString(),
                                                  fit: BoxFit.cover,
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(
                                                    Icons.error,
                                                    size: 40,
                                                  ),
                                                  progressIndicatorBuilder:
                                                      (a, b, c) => Opacity(
                                                    opacity: 0.3,
                                                    child: Shimmer.fromColors(
                                                      baseColor: Colors.black12,
                                                      highlightColor:
                                                          Colors.white,
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
                                                                    .circular(
                                                                        12)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.all(8),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      listings[i]
                                                          .title
                                                          .toString(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textAlign: TextAlign.left,
                                                      maxLines: 2,
                                                      style: AppTextStyle()
                                                          .textColor29292914w400,
                                                    ),
                                                    const SizedBox(
                                                      height: 8.0,
                                                    ),
                                                    Text(
                                                      ' USD ${listings[i].price!.amount.toString()}',
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
                                    } else if (scrollLength >= 25 &&
                                        isLoading) {
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
                            ),
                          )
                        : loading
                            ? Center(
                                child: LoadingAnimationWidget.staggeredDotsWave(
                                  size: 70,
                                  color: ColorSelect.colorF7E641,
                                ),
                              )
                            : LazyLoadScrollView(
                                isLoading: isLoading,
                                scrollDirection: Axis.vertical,
                                onEndOfPage: () {
                                  if (searchLength >= 25) {
                                    searchLoadMore();
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
                                            mainAxisExtent: 300),
                                    itemCount: searchListings.length + 1,
                                    itemBuilder: (_, i) {
                                      if (i < searchListings.length) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    EtsyProductDetails(
                                                  productTitle:
                                                      searchListings[i]
                                                          .title
                                                          .toString(),
                                                  productPrice:
                                                      searchListings[i]
                                                          .price!
                                                          .amount
                                                          .toString(),
                                                  productDescription:
                                                      searchListings[i]
                                                          .description
                                                          .toString(),
                                                  productId: searchListings[i]
                                                      .listingId
                                                      .toString(),
                                                  productUrl: searchListings[i]
                                                      .url
                                                      .toString(),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                border: Border.all(
                                                    width: 1,
                                                    color: ColorSelect
                                                        .colorF7E641)),
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 200,
                                                  clipBehavior: Clip.hardEdge,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(16.0),
                                                    topRight:
                                                        Radius.circular(16.0),
                                                  )),
                                                  child: CachedNetworkImage(
                                                    imageUrl: searchListings[i]
                                                        .images![0]
                                                        .url570xN
                                                        .toString(),
                                                    fit: BoxFit.cover,
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(
                                                      Icons.error,
                                                      size: 40,
                                                    ),
                                                    progressIndicatorBuilder:
                                                        (a, b, c) => Opacity(
                                                      opacity: 0.3,
                                                      child: Shimmer.fromColors(
                                                        baseColor:
                                                            Colors.black12,
                                                        highlightColor:
                                                            Colors.white,
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
                                                                      .circular(
                                                                          12)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.all(8),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        searchListings[i]
                                                            .title
                                                            .toString(),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        textAlign:
                                                            TextAlign.left,
                                                        maxLines: 2,
                                                        style: AppTextStyle()
                                                            .textColor29292914w400,
                                                      ),
                                                      const SizedBox(
                                                        height: 8.0,
                                                      ),
                                                      Text(
                                                        ' \$ ${searchListings[i].price!.amount.toString()}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                      } else if (searchLength >= 25 &&
                                          searchLoading) {
                                        return Center(
                                          child: LoadingAnimationWidget
                                              .staggeredDotsWave(
                                            size: 70,
                                            color: ColorSelect.colorF7E641,
                                          ),
                                        );
                                      } else if (searchLength < 25) {
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
                              ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 16, right: 16, top: 10, bottom: 16),
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
                        // setState(() {
                        //   if (searchController.text.isNotEmpty) {
                        //     searchListings.clear();
                        //     matches.clear();
                        //     getSearch();
                        //   } else {
                        //     setState(() {
                        //       searchListings.clear();
                        //       matches.clear();
                        //     });
                        //   }
                        // });
                      },
                      onFieldSubmitted: (val) {
                        if (searchController.text.isNotEmpty) {
                          searchListings.clear();
                          matches.clear();
                          setState(() {
                            searchLoading ? Loading() : getSearch();
                          });
                          getSearch();
                        } else {
                          setState(() {
                            searchListings.clear();
                            matches.clear();
                          });
                        }
                      },
                      controller: searchController,
                      cursorColor: ColorSelect.colorF7E641,
                      decoration: AppTFWithIconDecoration(
                        hint: 'Enter product and tap search icon',
                        icon: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              if (searchController.text.isNotEmpty) {
                                searchListings.clear();
                                matches.clear();
                                setState(() {
                                  searchLoading ? Loading() : getSearch();
                                });
                                getSearch();
                              } else {
                                setState(() {
                                  searchListings.clear();
                                  matches.clear();
                                });
                              }
                            },
                            child: Container(
                                padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  'assets/images/search 03.png',
                                ))),
                      ).decoration(),
                      //keyboardType: TextInputType.phone,
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
