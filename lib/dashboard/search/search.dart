import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/dashboard/search/all_etsy_products.dart';
import 'package:swishlist/dashboard/search/search_product.dart';

import '../../api/etsy_apis/all_listing_apis.dart';
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
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchProduct()));
                },
                child: Container(
                  width: 328.w,
                  height: 52.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ColorSelect.colorEDEDF1),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      Image.asset("assets/images/Vectorse.png"),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search product, username and more"),
                          keyboardType: TextInputType.text,
                          onFieldSubmitted: (val) {
                            showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                            ),
                            context: context,
                            builder: (context) => SearchProductBottomSheet());

                          },
                      /*    onFieldSubmitted: (val){
                            showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                ),
                                context: context,
                                builder: (context) => SingleChildScrollView(
                                  child: Container(
                                    height: 400,
                                    child: Expanded(
                                      child: GridView.builder(
                                        shrinkWrap: true,
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
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                )
                            );
                          },*/
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 29,
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return StoreSheet();
                      });
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
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          // color: k006D77,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
          ),
        ),
        child: GridView.builder(
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
        ),
      ),
    );
  }


}
