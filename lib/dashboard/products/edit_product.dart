import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/api/user_apis/products_api.dart';
import 'package:swishlist/buttons/light_yellow.dart';
import 'package:swishlist/constants/globals/globals.dart';
import 'package:swishlist/constants/urls.dart';
import 'package:swishlist/models/product_type_model.dart';

import '../../constants/color.dart';

class EditProduct extends StatefulWidget {
  final ProductTypeModel? model;
  final String image;
  final String id;

  // final LoginResponse response;
  const EditProduct({
    Key? key,
    this.model,
    required this.image,
    required this.id,
    /*required this.response*/
  }) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final titleController = TextEditingController();
  final productLinkController = TextEditingController();
  final priceController = TextEditingController();
  final dateController = TextEditingController();
  final productTypeController = TextEditingController();
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // File imageFile = File("");
  File pickedImage = File("");
  final ImagePicker _imgPicker = ImagePicker();
  String networkImage = '';
  String dateFormat = '';

  clearImage() {
    setState(() {
      pickedImage = File('');
    });
  }

  bool show = false;

  @override
  void initState() {
    clearImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldUnFocusOnTap(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(children: [
            Text(
              "Products",
              style: AppTextStyle().textColor29292916w500,
            ),
          ]),
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: InkWell(
                onTap: () {
                  int count = 0;
                  Navigator.of(context).popUntil((_) => count++ >= 3);
                  // Navigator.pop(context);
                },
                child: Image.asset('assets/images/Vector190.png')),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Edit Product",
                    style: AppTextStyle().textColor29292924w700,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Fill the details to edit product.",
                    style: AppTextStyle().textColor70707014w400,
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 246.h,
                        width: 1.sw,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1,
                            color: ColorSelect.colorA3A3A3,
                          ),
                        ),
                        child:
                            // pickedImage.path.isEmpty
                            //     ? Center(
                            //         child: GestureDetector(
                            //             onTap: () async {
                            //               XFile? v = await _imgPicker.pickImage(
                            //                   source: ImageSource.gallery);
                            //               if (v != null) {
                            //                 setState(
                            //                   () {
                            //                     pickedImage = File(v.path);
                            //                   },
                            //                 );
                            //               }
                            //               print(pickedImage);
                            //             },
                            //             child: Container(
                            //               height: 44.h,
                            //               width: 144.w,
                            //               decoration: BoxDecoration(
                            //                 borderRadius: BorderRadius.circular(8),
                            //                 border: Border.all(
                            //                   width: 1,
                            //                   color: ColorSelect.colorA3A3A3,
                            //                 ),
                            //               ),
                            //               child: Center(
                            //                 child: Row(
                            //                   children: [
                            //                     SizedBox(width: 24),
                            //                     Image.asset(
                            //                         "assets/images/image-add.png"),
                            //                     SizedBox(width: 10),
                            //                     Text("Add image")
                            //                   ],
                            //                 ),
                            //               ),
                            //             )),
                            //       )
                            //     :
                            pickedImage.path.isEmpty
                                ? CachedNetworkImage(
                                    maxHeightDiskCache: 3000,
                                    maxWidthDiskCache: 300,
                                    imageUrl: widget.image
                                            .toString()
                                            .contains("https")
                                        ? widget.image
                                        : baseUrl + widget.image,

                                    // imageUrl:wantProducts2[i]
                                    //     .photo
                                    //     .toString()
                                    //     .contains("https")
                                    //     ? wantProducts2[i].photo.toString()
                                    //     : baseUrl +
                                    //     wantProducts2[i].photo.toString(),
                                    // imageUrl: (baseUrl+getProducts!.data![i].photo.toString()),
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.error,
                                      size: 40,
                                    ),
                                    progressIndicatorBuilder: (a, b, c) =>
                                        Opacity(
                                      opacity: 0.3,
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.black12,
                                        highlightColor: Colors.white,
                                        child: Container(
                                          width: 1.sw,
                                          height: 246,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      ColorSelect.colorE0E0E0,
                                                  width: 1),
                                              color: ColorSelect.colorFFFFFF,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                        ),
                                      ),
                                    ),
                                  )
                                : Image.file(
                                    pickedImage,
                                    width: 1.sw,
                                    // height: 420,
                                    fit: BoxFit.cover,
                                  ),
                        //     Container(
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(8),
                        //   ),
                        //   clipBehavior: Clip.hardEdge,
                        //   child: Image.asset(widget.image),
                        //   // child: Image.file(
                        //   //   pickedImage,
                        //   //   width: 1.sw,
                        //   //   height: 420,
                        //   //   fit: BoxFit.cover,
                        //   // ),
                        // ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            clearImage();
                            setState(() {
                              // pickedImage = '' as String;
                            });
                          },
                          child: AnimatedContainer(
                            margin: EdgeInsets.only(right: 45),
                            duration: Duration(microseconds: 300),
                            height: pickedImage.path.isEmpty ? 0 : 32,
                            width: pickedImage.path.isEmpty ? 0 : 32,
                            decoration: BoxDecoration(
                                color: ColorSelect.colorF7E641,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/icons/iconcross.png'))),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () async {
                            XFile? v = await _imgPicker.pickImage(
                                imageQuality: 40, source: ImageSource.gallery);
                            if (v != null) {
                              setState(
                                () {
                                  pickedImage = File(v.path);
                                },
                              );
                            }
                            print(pickedImage);
                          },
                          child: Container(
                            height: 32,
                            width: 32,
                            padding: EdgeInsets.all(9),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: ColorSelect.colorF7E641,
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              'assets/icons/Vectoredit.svg',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
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
                              onChanged: (v) {
                                setState(() {});
                              },
                              controller: titleController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Title of the product*",
                                  hintStyle:
                                      AppTextStyle().textColor70707014w400),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
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
                              onChanged: (v) {
                                setState(() {});
                              },
                              // validator: (website) {
                              //   String pattern = 'http';
                              //   RegExp regExp = RegExp(pattern);
                              //   if (website!.isEmpty) {
                              //     return "Please enter your website";
                              //   } else if (!(regExp.hasMatch(website))) {
                              //     return "Website Url must be started from www";
                              //   } else {
                              //     return null;
                              //   }
                              // },
                              controller: productLinkController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Product Link",
                                  hintStyle:
                                      AppTextStyle().textColor70707014w400),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
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
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(14),
                              ],
                              onChanged: (v) {
                                setState(() {});
                              },
                              controller: priceController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "\$ Price",
                                  hintStyle:
                                      AppTextStyle().textColor70707014w400),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
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
                              onChanged: (v) {
                                setState(() {});
                              },
                              controller: productTypeController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Type",
                                  hintStyle:
                                      AppTextStyle().textColor70707014w400),
                              onTap: () {
                                showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          topLeft: Radius.circular(20)),
                                    ),
                                    context: context,
                                    builder: (context) =>
                                        ProductTypeBottomSheet(
                                          productType:
                                              productTypeController.text,
                                          onPop: (val) {
                                            setState(() {
                                              productTypeController.text = val;
                                            });
                                          },
                                        ));
                              },
                              readOnly: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
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
                              onChanged: (v) {
                                setState(() {});
                              },
                              controller: dateController,
                              keyboardType: TextInputType.text,
                              readOnly: true,
                              onTap: () {
                                setState(() async {
                                  var datePicked = await showRoundedDatePicker(
                                    height: 250,
                                    context: context,
                                    styleDatePicker:
                                        MaterialRoundedDatePickerStyle(
                                      paddingDatePicker:
                                          EdgeInsets.only(left: 10, right: 10),
                                      textStyleButtonPositive: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                      textStyleButtonNegative: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    theme: ThemeData(
                                        primarySwatch: Colors.yellow,
                                        textTheme: TextTheme()),
                                    initialDate: DateTime.now(),
                                    firstDate:
                                        DateTime(DateTime.now().year - 10),
                                    lastDate:
                                        DateTime(DateTime.now().year + 10),
                                    borderRadius: 16,
                                  );

                                  setState(() {
                                    dateController.text =
                                        DateFormat.yMMMd().format(datePicked!);
                                    dateFormat = DateFormat('yyyy-MM-dd')
                                        .format(datePicked);
                                  });
                                });
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Date",
                                  hintStyle:
                                      AppTextStyle().textColor70707014w400,
                                  suffixIcon: Image.asset(
                                      "assets/images/calendarimg.png")),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 56),
                  SizedBox(
                    width: 328.w,
                    height: 52.h,
                    child: titleController.text.isEmpty ||
                            productLinkController.text.isEmpty ||
                            priceController.text.isEmpty ||
                            productTypeController.text.isEmpty ||
                            dateFormat.isEmpty
                        ? LightYellowButtonWithText(
                            backgroundColor: MaterialStateProperty.all(
                                ColorSelect.colorFCF5B6),
                            textStyleColor: ColorSelect.colorB5B07A,
                            onTap: () {
                              if (titleController.text.isNotEmpty ||
                                  productLinkController.text.isNotEmpty ||
                                  priceController.text.isNotEmpty ||
                                  productTypeController.text.isNotEmpty ||
                                  dateFormat.isEmpty) {
                                if (titleController.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Please add product title");
                                } else if (productLinkController.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Please add product link");
                                } else if (priceController.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Please product price");
                                } else if (productTypeController.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Please add product type");
                                } else if (dateFormat.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Please pick date");
                                }
                              } else {
                                setState(() {
                                  Fluttertoast.showToast(
                                      msg: "Please add all details");
                                });
                              }
                            },
                            title: 'Please add all details')
                        : show
                            ? LoadingLightYellowButton()
                            : LightYellowButtonWithText(
                                onTap: () {
                                  setState(() {
                                    show = !show;
                                  });
                                  Timer timer = Timer(Duration(seconds: 3), () {
                                    setState(() {
                                      show = false;
                                    });
                                  });
                                  if (productLinkController.text
                                      .contains("https")) {
                                    updateProducts(
                                            type: productTypeController.text ==
                                                    'have'
                                                ? 'have'
                                                : productTypeController.text ==
                                                        'want'
                                                    ? 'want'
                                                    : 'dont_want',
                                            name: titleController.text,
                                            link: productLinkController.text,
                                            price: priceController.text,
                                            purchaseDate: dateFormat,
                                            privacyStatus: 'public',
                                            photo: pickedImage.isAbsolute
                                                ? pickedImage.path
                                                : '',
                                            id: widget.id,
                                            photoUrl: pickedImage.path.isEmpty
                                                ? widget.image
                                                : ' ')
                                        .then((value) {
                                      if (value['status'] == true) {
                                        Navigator.of(context)
                                          ..pop()
                                          ..pop()
                                          ..pop();
                                        Fluttertoast.showToast(
                                            msg: value['message']);
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: value['message']);
                                      }
                                    });
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "please enter a valid link");
                                  }
                                },
                                backgroundColor: MaterialStateProperty.all(
                                    ColorSelect.colorF7E641),
                                textStyleColor: Colors.black,
                                title: 'Save',
                              ),
                  ),
                  SizedBox(height: 24)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProductTypeBottomSheet extends StatefulWidget {
  final String productType;
  final Function(String) onPop;
  const ProductTypeBottomSheet(
      {Key? key, required this.productType, required this.onPop})
      : super(key: key);

  @override
  State<ProductTypeBottomSheet> createState() => _ProductTypeBottomSheet();
}

class _ProductTypeBottomSheet extends State<ProductTypeBottomSheet> {
  int _gIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        // height: 259.h,
        child: Column(
          children: [
            Container(
              height: 71.h,
              decoration: const BoxDecoration(
                color: ColorSelect.colorF7E641,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Center(
                child: Text(
                  'Select Product Type',
                  // style: kManRope_700_20_white,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20.h),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => setState(() {
                      _gIndex = 0;
                      Navigator.of(context).pop();
                      widget.onPop("have");
                    }),
                    child: Container(
                      height: 44.h,
                      width: 78.w,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        color: _gIndex == 0
                            ? ColorSelect.colorF7E641
                            : Colors.transparent,
                      ),
                      child: Center(
                          child: Text(
                        'have',
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  GestureDetector(
                    onTap: () => setState(() {
                      _gIndex = 1;
                      Navigator.of(context).pop();
                      widget.onPop("dont want");
                    }),
                    child: Container(
                      height: 44.h,
                      width: 78.w,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        color: _gIndex == 1
                            ? ColorSelect.colorF7E641
                            : Colors.transparent,
                      ),
                      child: Center(
                          child: Text(
                        'dont want',
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  GestureDetector(
                    onTap: () => setState(() {
                      _gIndex = 2;
                      Navigator.of(context).pop();
                      widget.onPop("want");
                    }),
                    child: Container(
                      height: 44.h,
                      width: 78.w,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        color: _gIndex == 2
                            ? ColorSelect.colorF7E641
                            : Colors.transparent,
                      ),
                      child: Center(
                        child: Text('want'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    if (widget.productType == "have") {
      _gIndex = 0;
    } else if (widget.productType == "dont want") {
      _gIndex = 1;
    } else {
      _gIndex = 2;
    }
    super.initState();
  }
}
