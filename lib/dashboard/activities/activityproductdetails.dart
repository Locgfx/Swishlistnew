import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants/color.dart';
import '../products/widget/product_widget.dart';

class ActivityProductDetails extends StatefulWidget {
  const ActivityProductDetails({Key? key}) : super(key: key);

  @override
  State<ActivityProductDetails> createState() => _ActivityProductDetailsState();
}

class _ActivityProductDetailsState extends State<ActivityProductDetails> {
  bool _switchValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: ColorSelect.colorFFFFFF,
        elevation: 0,
        title: Row(children: [
          Text(
            "Product details",
            style: AppTextStyle().textColor29292916w500,
          ),
          Spacer(),
          Image.asset(
            "assets/images/Vectorsend.png",
            height: 24,
            width: 20,
          ),
          SizedBox(
            width: 32,
          ),
          Image.asset("assets/images/Vectorplus.png"),
          SizedBox(
            width: 32,
          ),
          InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return ProductForBottomSheetWidget();
                    });
              },
              child: Image.asset("assets/images/Vector.png")),
          SizedBox(
            width: 16,
          ),
        ]),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset('assets/images/Vector190.png')),
        ),
      ),
      backgroundColor: ColorSelect.colorFFFFFF,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(
                height: 16.h,
              ),
              Text(
                "RESPAWN 110 Racing Style Gaming Chair, Reclining Ergonomic Chair with Footrest, in Green",
                style: AppTextStyle().textColor29292916w500,
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                children: [
                  Text(
                    "47.99",
                    style: AppTextStyle().textColor29292924w700,
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ColorSelect.colorF7E641,
                    ),
                    width: 140.w,
                    height: 52.h,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10, left: 28),
                              child: Text(
                                "View on",
                                style: AppTextStyle().textcolor3F3F3F12w500,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 28, top: 4),
                              child:
                                  Image.asset('assets/images/amazonimage.png'),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: SvgPicture.asset(
                            "assets/icons/arrowimage.svg",
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                width: 328.w,
                height: 246.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(color: ColorSelect.colorE0E0E0, width: 1)),
                child: Center(
                  child: Image.asset(
                    "assets/images/image10.png",
                    width: 118,
                    height: 200,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text(
                    "12 June, 2022",
                    style: AppTextStyle().textColor70707012w400,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Container(
                    height: 2.h,
                    width: 2.w,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: ColorSelect.color707070),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  SvgPicture.asset("assets/icons/eyeicons.svg"),
                  SizedBox(
                    width: 6.w,
                  ),
                  Text(
                    "4",
                    style: AppTextStyle().textColor70707012w400,
                  )
                ],
              ),
              SizedBox(
                height: 22,
              ),
              Container(
                height: 52.h,
                width: 328.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorSelect.colorEBF6E9),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12, top: 10, bottom: 10, right: 4),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            AssetImage('assets/images/Rectangle1072.png'),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Someone wants this",
                          style: AppTextStyle().textcolor4B955714w400,
                        ),
                        Text(
                          "“I really like it”",
                          style: AppTextStyle().textColor29292914w400,
                        )
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 18),
                      child: Text(
                        "2 days",
                        style: AppTextStyle().robotocolor78787812w400,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
