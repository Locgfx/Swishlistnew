


import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:swishlist/buttons/light_yellow.dart';
import 'package:swishlist/dashboard/dashboard.dart';
import 'package:swishlist/dashboard/products/productAdded.dart';
import 'package:swishlist/models/product_model.dart';
import 'package:swishlist/models/product_type_model.dart';
import 'dart:io';
import '../../api/user_apis/products_api.dart';
import '../../constants/color.dart';
import '../../models/ProductStoreMode.dart';
import '../../models/login_models.dart';
import '../../profile_page/privacy.dart';
import '../../profile_page/widgets/date_picker.dart';

class ManuallyAdd extends StatefulWidget {
  final ProductTypeModel? model;
  // final LoginResponse response;
  const ManuallyAdd({Key? key,  this.model, /*required this.response*/}) : super(key: key);

  @override
  State<ManuallyAdd> createState() => _ManuallyAddState();
}

class _ManuallyAddState extends State<ManuallyAdd> {
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
  String dateFormat ='';

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





  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Image.asset('assets/images/Vector190.png')
          ),
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
                SizedBox(height: 8,),
                Text(
                  "Fill the details of product you own already.",
                  style: AppTextStyle().textColor70707014w400,
                ),
                SizedBox(height: 28,),
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
                      child:  pickedImage.path.isEmpty ? Center(
                        child: GestureDetector(
                            onTap: () async {
                              XFile? v = await _imgPicker.pickImage(
                                  source: ImageSource.gallery
                              );
                              if (v != null) {
                                setState(() {
                                  pickedImage = File(v.path);
                                },);
                              }
                              print(pickedImage);
                            },
                            child:  Container(
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
                                    Image.asset("assets/images/image-add.png"),
                                    SizedBox(width: 10),
                                    Text("Add image")
                                  ],
                                ),
                              ),
                            )

                        ),
                      ): Container(
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
                        onTap: (){
                          clearImage();
                          setState(() {
                            // pickedImage = '' as String;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(microseconds: 300),
                          height: pickedImage.path.isEmpty ?0:32,
                          width: pickedImage.path.isEmpty ?0:32,
                          decoration: BoxDecoration(
                              color: ColorSelect.colorF7E641,
                              shape: BoxShape.circle,
                              image: DecorationImage(image: AssetImage('assets/icons/iconcross.png'))
                          ),
                        ),
                      ),
                    ),
                    // Positioned(
                    //   top: 60,
                    //   bottom: 60,
                    //   left: 10,
                    //   right: 10,
                    //   child: Center(
                    //     child: GestureDetector(
                    //       onTap: () async {
                    //         XFile? v = await _imgPicker.pickImage(
                    //             source: ImageSource.gallery
                    //         );
                    //         if (v != null) {
                    //           setState(() {
                    //             pickedImage = File(v.path);
                    //           },);
                    //         }
                    //         print(pickedImage);
                    //       },
                    //       child:  Container(
                    //         height: 44.h,
                    //         width: 144.w,
                    //         decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(8),
                    //             border: Border.all(
                    //                 width: 1,
                    //                 color: ColorSelect.colorA3A3A3,
                    //             ),
                    //         ),
                    //         child: Center(
                    //           child: Row(
                    //             children: [
                    //               SizedBox(width: 24),
                    //               Image.asset("assets/images/image-add.png"),
                    //               SizedBox(width: 10),
                    //               Text("Add image")
                    //             ],
                    //           ),
                    //         ),
                    //       )
                    //       // Stack(
                    //       //   children: [
                    //       //     Container(
                    //       //       height: 246.h,
                    //       //       width: 328.w,
                    //       //       clipBehavior:Clip.hardEdge,
                    //       //       decoration: BoxDecoration(
                    //       //         borderRadius: BorderRadius.circular(8),
                    //       //         border: Border.all(
                    //       //           width: 2,
                    //       //           color: ColorSelect.colorA3A3A3,
                    //       //         ),
                    //       //       ),
                    //       //       child: Image.file(
                    //       //         pickedImage,
                    //       //         width: 1.sw,
                    //       //         height: 420,
                    //       //         fit: BoxFit.contain,
                    //       //       ),
                    //       //     ),
                    //       //     Positioned(
                    //       //       right: 0,
                    //       //       top: 0,
                    //       //       child: Container(
                    //       //         height: 32,
                    //       //         width: 32,
                    //       //         decoration: BoxDecoration(
                    //       //           color: ColorSelect.colorF7E641,
                    //       //           shape: BoxShape.circle,
                    //       //           image: DecorationImage(image: AssetImage('assets/icons/iconcross.png'))
                    //       //         ),
                    //       //       ),
                    //       //     ),
                    //       //   ],
                    //       // ),
                    //     ),
                    //   ),
                    // ),
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
                                hintStyle: AppTextStyle().textColor70707014w400
                            ),
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
                              setState(() {
                              });
                            },
                            controller: priceController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Price",
                                hintStyle: AppTextStyle().textColor70707014w400
                            ),
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
                              setState(() {
                              });
                            },
                            controller: productTypeController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Type",
                                hintStyle: AppTextStyle().textColor70707014w400
                            ),
                            onTap: () {
                              showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                  ),
                                  context: context,
                                  builder: (context) => ProductTypeBottomSheet(
                                    productType: productTypeController.text,
                                    onPop: (val) {
                                      setState(() {
                                        productTypeController.text = val;
                                      });
                                    },
                                  ));
                            },
                            readOnly:true,
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
                      color: ColorSelect.colorEDEDF1
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onChanged: (v) {
                              setState(() {

                              });
                            },
                            controller: dateController,
                            keyboardType: TextInputType.text,
                            readOnly: true,
                            onTap: ()  {
                             setState(() async {
                               DateTime? pickedDate = await showDialog(
                                 context: context,
                                 builder: (_) => DatePickerWidget(onPop: (date) {
                                   dateController.text=DateFormat.yMMMd().format(date);
                                   dateFormat = DateFormat('yyyy-MM-dd').format(date) ;
                                 }, maximumDate: 2023,
                                 ),
                               );
                             });
                              //
                              // DateTime? pickedDate = await showDatePicker(
                              //     context: context,
                              //     initialDate: DateTime.now(),
                              //     firstDate: DateTime(1950),
                              //     //DateTime.now() - not to allow to choose before today.
                              //     lastDate: DateTime(2100));
                              //
                              // if (pickedDate != null) {
                              //   print(
                              //       pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              //   String formattedDate =
                              //   DateFormat('yyyy-MM-dd').format(pickedDate);
                              //   print(
                              //       formattedDate); //formatted date output using intl package =>  2021-03-16
                              //   setState(() {
                              //     dateController.text =
                              //         formattedDate; //set output date to TextField value.
                              //   });
                              // } else {}
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Date Purchased",
                                hintStyle: AppTextStyle().textColor70707014w400,
                                suffixIcon:
                                Image.asset("assets/images/calendarimg.png")),
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
                  child:  isLoading ? Center(
                    child: LoadingAnimationWidget.waveDots(
                      size: 40,
                      color: ColorSelect.colorF7E641,
                    ),
                  ):
                  LightYellowButtonWithText(
                    onTap: () {
                      if(formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        if (networkImage.isNotEmpty ||
                            pickedImage.isAbsolute) {
                            productStoreApi(
                                type: productTypeController.text,
                                name: titleController.text,
                                link: productLinkController.text,
                                price: priceController.text,
                                purchaseDate: dateFormat,
                                privacyStatus: 'public',
                                photo: pickedImage.isAbsolute
                                    ?  pickedImage.path
                                    : '').then((value) async {
                            if(value['status'] == true) {
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.push(context, MaterialPageRoute(builder: (_) =>ProductAdded(
                                name: titleController.text,
                                price: priceController.text,
                                productImage: pickedImage.toString(),
                                )));
                              Fluttertoast.showToast(
                                  msg:value['message']);
                            } else {
                              Fluttertoast.showToast(
                                  msg:value['message']);
                            }},
                            );
                        }
                      }
                    },
                    backgroundColor:(
                        titleController.text.isNotEmpty &&
                        productLinkController.text.isNotEmpty ||
                        priceController.text.isNotEmpty
                      ) ? MaterialStateProperty.all(ColorSelect.colorF7E641)
                        : MaterialStateProperty.all(ColorSelect.colorFCF5B6),
                    textStyleColor: titleController.text.isNotEmpty &&
                        productLinkController.text.isNotEmpty ||
                        priceController.text.isNotEmpty ?
                      Colors.black :
                      ColorSelect.colorB5B07A,
                    title: 'Add',
                  ),
                ),
                SizedBox(height: 24)
              ],
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
                        color: _gIndex == 0 ? ColorSelect.colorF7E641 : Colors.transparent,
                      ),
                      child: Center(
                          child: Text(
                            'have',
                            // style: _gIndex == 0
                            //     ? textColorF7E64114w400
                            //     : ColorSelect.colorF7E641
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
                      widget.onPop("dont_want");
                    }),
                    child: Container(
                      height: 44.h,
                      width: 78.w,
                      decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(5)),
                        color: _gIndex == 1 ? ColorSelect.colorF7E641 : Colors.transparent,
                      ),
                      child: Center(
                          child: Text(
                            'dont want',
                            // style: _gIndex == 1
                            //     ? kManRope_500_16_white
                            //     : kManRope_500_16_626A6A,
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
                        color: _gIndex == 2 ? ColorSelect.colorF7E641 : Colors.transparent,
                      ),
                      child: Center(
                          child: Text(
                            'want',
                            // style: _gIndex == 2
                            //     ? kManRope_500_16_white
                            //     : kManRope_500_16_626A6A,
                          )),
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
    } else if (widget.productType == "dont_want") {
      _gIndex = 1;
    } else {
      _gIndex = 2;
    }
    super.initState();
  }
}