import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/dashboard/search/all_etsy_products.dart';
import 'package:swishlist/dashboard/search/search_product.dart';

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
