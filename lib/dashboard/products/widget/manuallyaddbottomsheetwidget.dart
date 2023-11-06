import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../buttons/light_yellow.dart';
import '../../../constants/color.dart';
import '../../search/all_etsy_products.dart';
import '../manuallyadd.dart';
import '../productAdded.dart';
import 'link_product_add.dart';

class ManuallyAddBottomSheetWidget extends StatefulWidget {
  final String productType;
  ManuallyAddBottomSheetWidget({
    Key? key,
    required this.productType,
  }) : super(key: key);

  @override
  State<ManuallyAddBottomSheetWidget> createState() =>
      _ManuallyAddBottomSheetWidgetState();
}

class _ManuallyAddBottomSheetWidgetState
    extends State<ManuallyAddBottomSheetWidget> {
  final productLinkController = TextEditingController();

  final form = GlobalKey<FormState>();

  // ProductTypeModel? model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Form(
          key: form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // GestureDetector(
              //   onTap: () {
              //     Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => ManuallyAdd()));
              //   },
              //   child: Container(
              //     width: 138.w,
              //     height: 44.h,
              //     margin: EdgeInsets.only(right: 16),
              //     decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.circular(8)),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Text(
              //           "Add manually",
              //           style: AppTextStyle().textcolor27272714w500,
              //         ),
              //         SizedBox(
              //           width: 4,
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.symmetric(
              //               horizontal: 10, vertical: 7),
              //           child: SvgPicture.asset(
              //             "assets/icons/Vector175.svg",
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
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
                        height: 16,
                      ),
                      Container(
                        width: 328.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: ColorSelect.colorEDEDF1),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  validator: (website) {
                                    String pattern = 'http';
                                    RegExp regExp = RegExp(pattern);
                                    if (website!.isEmpty) {
                                      return "Please enter your website";
                                    } else if (!(regExp.hasMatch(website))) {
                                      return "Website Url must be started from www";
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Add Product link"),
                                  keyboardType: TextInputType.text,
                                  controller: productLinkController,
                                  onChanged: (v) {
                                    setState(() {});
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          productLinkController.text.isNotEmpty
                              ? SizedBox(
                                  height: 40.h,
                                  width: 88.w,
                                  child: LightYellowButtonWithText(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              ColorSelect.colorF7E641),
                                      textStyleColor: Colors.black,
                                      onTap: () {
                                        if (form.currentState!.validate()) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LinkProductAdd(
                                                        productLink:
                                                            productLinkController
                                                                .text,
                                                        productType:
                                                            widget.productType,
                                                      )));
                                        }
                                        /* Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductAdded(name: '', price: '', productImage: ''),
                                      ),
                                  );*/
                                      },
                                      title: 'Add'),
                                )
                              : SizedBox(
                                  height: 40.h,
                                  width: 88.w,
                                  child: LightYellowButtonWithText(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              ColorSelect.colorFCF5B6),
                                      textStyleColor: ColorSelect.colorB5B07A,
                                      onTap: () {
                                        /* Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductAdded(name: '', price: '', productImage: ''),
                                      ),
                                  );*/
                                      },
                                      title: 'Add'),
                                ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "or",
                            style: AppTextStyle().textColor70707012w400,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => AllEtsyProducts()));
                            },
                            child: Container(
                              height: 40.h,
                              width: 120.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: ColorSelect.colorA3A3A3,
                                      width: 1)),
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
                      ),
                      SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EtsyAddBottomSheetWidget extends StatefulWidget {
  // final ProductTypeModel model;
  EtsyAddBottomSheetWidget({
    Key? key,
    /*required this.model,*/
  }) : super(key: key);

  @override
  State<EtsyAddBottomSheetWidget> createState() =>
      _EtsyAddBottomSheetWidgetState();
}

class _EtsyAddBottomSheetWidgetState extends State<EtsyAddBottomSheetWidget> {
  final controller = TextEditingController();
  // ProductTypeModel? model;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ManuallyAdd()));
              },
              child: Container(
                width: 138.w,
                height: 44.h,
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 7),
                      child: SvgPicture.asset(
                        "assets/icons/Vector175.svg",
                      ),
                    ),
                  ],
                ),
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
                                controller: controller,
                                onChanged: (v) {
                                  setState(() {});
                                },
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
                          backgroundColor: (controller.text.isNotEmpty)
                              ? MaterialStateProperty.all(
                                  ColorSelect.colorF7E641)
                              : MaterialStateProperty.all(
                                  ColorSelect.colorFCF5B6),
                          textStyleColor: (controller.text.isNotEmpty)
                              ? Colors.black
                              : ColorSelect.colorB5B07A,
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductAdded(
                                        name: '',
                                        price: '',
                                        productImage: '')));
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
