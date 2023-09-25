import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:swishlist/constants/globals/globals.dart';

import '../../../api/user_apis/products_api.dart';
import '../../../buttons/light_yellow.dart';
import '../../../constants/color.dart';
import '../../../models/ProductStoreMode.dart';
import '../../../models/product_type_model.dart';
import '../../../profile_page/widgets/date_picker.dart';
import '../manuallyadd.dart';
import '../productAdded.dart';

class LinkProductAdd extends StatefulWidget {
  final String productLink;
  final ProductTypeModel? model;

  // final LoginResponse response;
  const LinkProductAdd({
    Key? key,
    this.model,
    required this.productLink,
  }) : super(key: key);

  @override
  State<LinkProductAdd> createState() => _LinkProductAddState();
}

class _LinkProductAddState extends State<LinkProductAdd> {
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

  @override
  void initState() {
    clearImage();
    super.initState();
  }

  bool show = false;

  ProductStoreModel? respStore;

  @override
  Widget build(BuildContext context) {
    return TextFieldUnFocusOnTap(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              Text(
                "Products",
                style: AppTextStyle().textColor29292916w500,
              ),
            ],
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Navigator.of(context)
                    ..pop()
                    ..pop();
                },
                child: Container(
                    color: Colors.transparent,
                    child: Image.asset('assets/images/Vector190.png'))),
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
                    "Enter product details",
                    style: AppTextStyle().textColor29292924w700,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Fill the details of the product ",
                    style: AppTextStyle().textColor70707014w400,
                  ),
                  SizedBox(
                    height: 28,
                  ),
                  Stack(
                    children: [
                      Container(
                        height: 246.h,
                        width: 328.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            width: 1,
                            color: ColorSelect.colorA3A3A3,
                          ),
                        ),
                        child: pickedImage.path.isEmpty
                            ? Center(
                                child: GestureDetector(
                                    onTap: () async {
                                      XFile? v = await _imgPicker.pickImage(
                                          source: ImageSource.gallery);
                                      if (v != null) {
                                        setState(
                                          () {
                                            pickedImage = File(v.path);
                                          },
                                        );
                                      }
                                    },
                                    child: Container(
                                      height: 44.h,
                                      width: 144.w,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          width: 1,
                                          color: ColorSelect.colorA3A3A3,
                                        ),
                                      ),
                                      child: Center(
                                        child: Row(
                                          children: [
                                            SizedBox(width: 24),
                                            Image.asset(
                                                "assets/images/image-add.png"),
                                            SizedBox(width: 10),
                                            Text("Add image")
                                          ],
                                        ),
                                      ),
                                    )),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: Image.file(
                                  pickedImage,
                                  width: 1.sw,
                                  height: 420,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: GestureDetector(
                          onTap: () {
                            clearImage();
                            setState(() {
                              // pickedImage = '' as String;
                            });
                          },
                          child: AnimatedContainer(
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
                                  hintText: "Title of the product",
                                  hintStyle:
                                      AppTextStyle().textColor70707014w400),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  /*  SizedBox(height: 12),
                  Container(
                    width: 328.w,
                    height: 52.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: ColorSelect.colorEDEDF1
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              onChanged: (v) {
                                setState(() {});
                              },
                              controller: productLinkController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Product Link",
                                  hintStyle: AppTextStyle().textColor70707014w400),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),*/
                  SizedBox(height: 12),
                  // Container(
                  //   height: 52.h,
                  //   width: 328.w,
                  //   margin: EdgeInsets.symmetric(horizontal: 16),
                  //   decoration: BoxDecoration(
                  //       color: ColorSelect.colorEDEDF1,
                  //       borderRadius: BorderRadius.all(Radius.circular(8))),
                  //   child: Row(
                  //     children: [
                  //       SizedBox(
                  //         height: 40.h,
                  //         width: 60,
                  //         child: Center(child: Text('+')),
                  //       ),
                  //       TextFormField(
                  //         controller: priceController,
                  //         onChanged: (val) {
                  //           setState(() {});
                  //         },
                  //         keyboardType: TextInputType.number,
                  //         decoration: InputDecoration(
                  //           contentPadding: EdgeInsets.symmetric(vertical: 24),
                  //           border: InputBorder.none,
                  //           hintText: "Price",
                  //         ),
                  //         textInputAction: TextInputAction.done,
                  //       ),
                  //     ],
                  //   ),
                  // ),
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
                          SizedBox(
                            height: 40.h,
                            child: Center(
                                child: Text('\$',
                                    style:
                                        AppTextStyle().textColor70707014w400)),
                          ),
                          SizedBox(width: 2),
                          Expanded(
                            child: TextFormField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                              ],
                              onChanged: (v) {
                                setState(() {});
                              },
                              controller: priceController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Price",
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
                                hintStyle: AppTextStyle().textColor70707014w400,
                                suffixIconConstraints:
                                    BoxConstraints(maxHeight: 40, maxWidth: 40),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: Image.asset(
                                    'assets/images/down-arrow.png',
                                    height: 25,
                                  ),
                                ),
                              ),
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
                                  DateTime? pickedDate = await showDialog(
                                    context: context,
                                    builder: (_) => DatePickerWidget(
                                      onPop: (date) {
                                        dateController.text =
                                            DateFormat.yMMMd().format(date);
                                        dateFormat = DateFormat('yyyy-MM-dd')
                                            .format(date);
                                      },
                                      maximumDate: 2023,
                                    ),
                                  );
                                });
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText:
                                    "Ideal Purchased date or Purchase date",
                                hintStyle: AppTextStyle().textColor70707014w400,
                                suffixIcon: Image.asset(
                                    "assets/images/calendarimg.png"),
                              ),
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
                    child: show
                        ? LoadingLightYellowButton()
                        : LightYellowButtonWithText(
                            onTap: () {
                              setState(() {
                                show = !show;
                              });
                              Timer timer = Timer(Duration(seconds: 4), () {
                                setState(() {
                                  show = false;
                                });
                              });
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                if (networkImage.isNotEmpty ||
                                    pickedImage.isAbsolute) {
                                  productStoreApi(
                                          type: productTypeController.text,
                                          name: titleController.text,
                                          link: widget.productLink.toString(),
                                          price: priceController.text,
                                          purchaseDate: dateFormat,
                                          privacyStatus: 'public',
                                          photo: pickedImage.isAbsolute
                                              ? pickedImage.path
                                              : '')
                                      .then(
                                    (value) async {
                                      respStore = value;
                                      if (respStore!.status == true) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => ProductAdded(
                                                name: titleController.text,
                                                price: priceController.text,
                                                productImage: respStore!
                                                    .data!.photo
                                                    .toString()),
                                          ),
                                        );
                                        Fluttertoast.showToast(
                                            msg: respStore!.message.toString());
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: respStore!.message.toString());
                                      }
                                    },
                                  );
                                }
                              }
                            },
                            backgroundColor: (titleController.text.isNotEmpty &&
                                        productLinkController.text.isNotEmpty ||
                                    priceController.text.isNotEmpty)
                                ? MaterialStateProperty.all(
                                    ColorSelect.colorF7E641)
                                : MaterialStateProperty.all(
                                    ColorSelect.colorFCF5B6),
                            textStyleColor: titleController.text.isNotEmpty &&
                                        productLinkController.text.isNotEmpty ||
                                    priceController.text.isNotEmpty
                                ? Colors.black
                                : ColorSelect.colorB5B07A,
                            title: 'Add',
                          ),
                  ),
                  SizedBox(height: 40)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
