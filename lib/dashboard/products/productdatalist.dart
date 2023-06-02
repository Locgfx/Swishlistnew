import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swishlist/dashboard/products/widget/popmenu.dart';

import '../../constants/color.dart';

class ProductDataList extends StatefulWidget {
  const ProductDataList({Key? key}) : super(key: key);

  @override
  State<ProductDataList> createState() => _ProductDataListState();
}

class _ProductDataListState extends State<ProductDataList> {
  List imageList = [
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
  List itemPrice = ["47.99", "1247.99", "47.99", "1247.99"];
  List<int> selectedItems = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSelect.color9E9E9E,
        elevation: 0,
        title: Row(children: [
          Text(
            "Products",
            style: AppTextStyle().textColor29292916w500,
          ),
          Spacer(),
          Image.asset("assets/images/filter06.png"),
          SizedBox(
            width: 20,
          ),
          MyOptionsDialog(),
          //MyOptionsDialoglist(),
          SizedBox(
            width: 16,
          ),
        ]),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: InkWell(
              onTap: () {}, child: Image.asset('assets/images/Vector190.png')),
        ),
      ),
      /*bottomSheet: Container(),*/
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              ListView.builder(
                  itemCount: 6,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: GestureDetector(
                        onTap: () {
                          /*Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductDetail()));
                                log("hello");*/
                          print("hello");
                          print(selectedItems);
                          /* setState(() {
                                  selectedItems.add(i);
                                  */ /*if (selectedItems.contains(i)) {
                                    selectedItems.remove(i);
                                  } else {
                                    selectedItems.add(i);
                                  }*/ /*
                                  log("hello");
                                  print(selectedItems);
                                });*/
                        },
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Stack(children: [
                                      Container(
                                        height: 86,
                                        width: 86,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                width: 1,
                                                color: selectedItems.contains(i)
                                                    ? ColorSelect.colorF7E641
                                                    : ColorSelect.colorE0E0E0)),
                                        child: Center(
                                            child: Image.asset(
                                                "assets/images/image10.png")),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: selectedItems.contains(i)
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
                                          padding:
                                              const EdgeInsets.only(left: 16),
                                          child: SizedBox(
                                            width: 230.w,
                                            child: Text(
                                              "RESPAWN 110 Racing Style Gaming Chair, Reclining Ergonomic Chair with Footrest...",
                                              overflow: TextOverflow.ellipsis,
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
                                              const EdgeInsets.only(left: 16),
                                          child: Text(
                                            "47.99",
                                            style: AppTextStyle()
                                                .textColor29292914w500,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 16),
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
                                                "Today",
                                                style: AppTextStyle()
                                                    .textColor70707012w400,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
