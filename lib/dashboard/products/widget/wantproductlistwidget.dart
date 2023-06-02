import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../buttons/light_yellow.dart';
import '../../../constants/color.dart';
import '../../../models/login_models.dart';
import '../productAdded.dart';

class WantProductBottomSheetWidget extends StatefulWidget {



  const WantProductBottomSheetWidget({
    Key? key,

  }) : super(key: key);

  @override
  State<WantProductBottomSheetWidget> createState() => _WantProductBottomSheetWidgetState();
}

class _WantProductBottomSheetWidgetState extends State<WantProductBottomSheetWidget> {


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 138.w,
              height: 44.h,
              margin: EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Add manually",
                    style: AppTextStyle().textcolor27272714w500,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                    child: SvgPicture.asset(
                      "assets/icons/Vector175.svg",
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 1.sw,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 32,
                    ),
                    Text(
                      "Enter Link URL",
                      style: AppTextStyle().textColor29292924w700,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Paste an amazon or etsy URL link to add a wanted product.",
                      style: AppTextStyle().textColor70707012w400,
                    ),
                    SizedBox(
                      height: 28,
                    ),
                    Container(
                      width: 328.w,
                      height: 52.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: ColorSelect.colorEDEDF1),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Amazon or Etsy link"),
                                keyboardType: TextInputType.text,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: 52.h,
                      width: 88.w,
                      child: LightYellowButtonWithText(
                          backgroundColor: MaterialStateProperty.all(
                              ColorSelect.colorFCF5B6),
                          textStyleColor: ColorSelect.colorB5B07A,
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductAdded(name: '', price: '', productImage: '',)));
                          },
                          title: 'Add'),
                    ),
                    SizedBox(
                      height: 32,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
