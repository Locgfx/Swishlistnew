import 'package:flutter/material.dart';

import '../../constants/color.dart';
import '../products/widget/popmenu.dart';
import '../products/widget/product_add_widget.dart';

class FriendWants extends StatefulWidget {
  const FriendWants({Key? key}) : super(key: key);

  @override
  State<FriendWants> createState() => _FriendWantsState();
}

class _FriendWantsState extends State<FriendWants> {
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
      backgroundColor: ColorSelect.colorE5F3E2,
      appBar: AppBar(
        backgroundColor: ColorSelect.colorE5F3E2,
        elevation: 0,
        title: Row(children: [
          Text(
            "Products",
            style: AppTextStyle().textColor29292916w500,
          ),
          Spacer(),
          GestureDetector(
            onTap: () {},
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                color: Colors.transparent,
                child: Image.asset("assets/images/filter06.png")),
          ),
          //MyOptionsDialog(),
          MyOptionsDialoglist(onTap: () {  },),
          SizedBox(width: 16),
        ]),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              }, child: Image.asset('assets/images/Vector190.png')),
        ),
      ),
      /*bottomSheet: Container(),*/
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Creed wants",
                    style: AppTextStyle().textColor29292924w700,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 16,
                top: 36,
                right: 16,
                bottom: 16,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(24),
                      topLeft: Radius.circular(24))),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "9 Products",
                        style: AppTextStyle().textColor70707012w500,
                      ),
                    ],
                  ),
                  ProductListWidget(selectedItems: selectedItems),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
