import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:swishlist/models/login_models.dart';

import '../../../constants/color.dart';
import '../productdetail.dart';

class ProductListWidget extends StatelessWidget {
  final LoginResponse response;
  const ProductListWidget({
    Key? key,
    required this.selectedItems,
    required this.response,
  }) : super(key: key);

  final List<int> selectedItems;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 6,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductDetail(
                              name: '',
                              price: '',
                              link: '',
                              image: '',
                              purchaseDate: '',
                              id: '',
                              type: '',
                              response: response,
                            )));
                log("hello");
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
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    width: 1,
                                    color: selectedItems.contains(i)
                                        ? ColorSelect.colorF7E641
                                        : ColorSelect.colorE0E0E0)),
                            child: Center(
                                child:
                                    Image.asset("assets/images/image10.png")),
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: SizedBox(
                                  // width: 230.w,
                                  child: Text(
                                    "RESPAWN 110 Racing Style Gaming Chair, Reclining Ergonomic Chair with Footrest...",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: AppTextStyle().textColor29292912w400,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  "47.99",
                                  style: AppTextStyle().textColor29292914w500,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Row(
                                  children: [
                                    Image.asset("assets/images/image46.png"),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Container(
                                      height: 5,
                                      width: 5,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: ColorSelect.color707070),
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Text(
                                      "Today",
                                      style:
                                          AppTextStyle().textColor70707012w400,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
