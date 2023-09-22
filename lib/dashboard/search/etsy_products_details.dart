import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/constants/globals/loading.dart';

import '../../api/etsy_apis/etsy_images_api.dart';
import '../../api/user_apis/etsy_product_add.dart';
import '../../buttons/light_yellow.dart';
import '../../buttons/yellow_button.dart';
import '../../constants/color.dart';
import '../../models/etsy_image_model.dart';
import '../../models/etsy_load_more_model.dart';
import '../../profile_page/widgets/date_picker.dart';
import '../products/manuallyadd.dart';

class EtsyProductDetails extends StatefulWidget {
  final String productId;
  final String productTitle;
  final String productPrice;
  final String productUrl;
  final String productDescription;

  const EtsyProductDetails({
    Key? key,
    required this.productTitle,
    required this.productPrice,
    required this.productDescription,
    required this.productId,
    required this.productUrl,
  }) : super(key: key);

  @override
  State<EtsyProductDetails> createState() => _EtsyProductDetailsState();
}

class _EtsyProductDetailsState extends State<EtsyProductDetails> {
  bool _switchValue = false;
  @override
  void initState() {
    getImages();
    super.initState();
  }

  EtsyImagesModel? imageModel;
  bool isLoading = false;
  EtsyLoadMoreModel? etsyDetails;

  getImages() {
    isLoading = true;
    var resp = getEtsyImagesApi(listingId: widget.productId);
    resp.then((value) {
      setState(() {
        imageModel = EtsyImagesModel.fromJson(value);
        isLoading = false;
      });
      print(imageModel!.results![0].urlFullxfull.toString());
      // print(object)
    });
  }

  final productTypeController = TextEditingController();
  final dateController = TextEditingController();
  String dateFormat = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: ColorSelect.colorFFFFFF,
        elevation: 0,
        title: Row(
          children: [
            Text(
              "Product details",
              style: AppTextStyle().textColor29292916w500,
            ),
          ],
        ),
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
      body: isLoading
          ? Loading()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          " Product Id : ${widget.productId}",
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      widget.productTitle,
                      style: AppTextStyle().textColor29292916w500,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      children: [
                        Text(
                          'USD ${widget.productPrice}',
                          style: AppTextStyle().textColor29292924w700,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 200,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: imageModel!.results!.length,
                        itemBuilder: (context, i) {
                          return Container(
                            width: 328.w,
                            height: 246.h,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    width: 2, color: ColorSelect.colorF7E641)),
                            child: CachedNetworkImage(
                              // imageUrl: (baseUrl+haveProducts2[i].photo.toString()),
                              imageUrl:
                                  imageModel!.results![i].url570xN.toString(),
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => Icon(
                                Icons.error,
                                size: 40,
                              ),
                              progressIndicatorBuilder: (a, b, c) => Opacity(
                                opacity: 0.3,
                                child: Shimmer.fromColors(
                                  baseColor: Colors.black12,
                                  highlightColor: Colors.white,
                                  child: Container(
                                    width: 173,
                                    height: 129,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: ColorSelect.colorE0E0E0,
                                            width: 1),
                                        color: ColorSelect.colorFFFFFF,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(width: 10),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Column(
                      children: [
                        Text(
                          widget.productDescription,
                          maxLines: 100,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    SizedBox(height: 22),
                    SizedBox(
                      height: 60,
                      child: YellowButtonWithText(
                        backgroundColor:
                            MaterialStateProperty.all(ColorSelect.colorF7E641),
                        textStyleColor: ColorSelect.color292929,
                        title: 'Add Product',
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return Container(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      // GestureDetector(
                                      //   onTap: () {
                                      //     Navigator.push(
                                      //         context,
                                      //         MaterialPageRoute(
                                      //             builder: (context) => ManuallyAdd(
                                      //                 /*model: widget.model,*/)));
                                      //   },
                                      //   child: Container(
                                      //     width: 138.w,
                                      //     height: 44.h,
                                      //     margin: EdgeInsets.only(right: 16),
                                      //     decoration: BoxDecoration(
                                      //         color: Colors.white,
                                      //         borderRadius:
                                      //             BorderRadius.circular(8)),
                                      //     child: Row(
                                      //       mainAxisAlignment:
                                      //           MainAxisAlignment.center,
                                      //       children: [
                                      //         Text(
                                      //           "Add manually",
                                      //           style: AppTextStyle()
                                      //               .textcolor27272714w500,
                                      //         ),
                                      //         SizedBox(
                                      //           width: 4,
                                      //         ),
                                      //         Padding(
                                      //           padding:
                                      //               const EdgeInsets.symmetric(
                                      //                   horizontal: 10,
                                      //                   vertical: 7),
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 32,
                                              ),
                                              Text(
                                                "Select Details",
                                                style: AppTextStyle()
                                                    .textColor29292924w700,
                                                // style: AppTextStyle().textColor70707012w400,
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              // Text(
                                              //   "Paste an amazon or etsy URL link to add a wanted product.",
                                              //   style: AppTextStyle().textColor70707012w400,
                                              // ),
                                              SizedBox(
                                                height: 28,
                                              ),
                                              Container(
                                                width: 328.w,
                                                height: 52.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: ColorSelect
                                                        .colorEDEDF1),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: TextFormField(
                                                          onChanged: (v) {
                                                            setState(() {});
                                                          },
                                                          controller:
                                                              dateController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          readOnly: true,
                                                          onTap: () {
                                                            setState(() async {
                                                              DateTime?
                                                                  pickedDate =
                                                                  await showDialog(
                                                                context:
                                                                    context,
                                                                builder: (_) =>
                                                                    DatePickerWidget(
                                                                  onPop:
                                                                      (date) {
                                                                    dateController
                                                                        .text = DateFormat
                                                                            .yMMMd()
                                                                        .format(
                                                                            date);
                                                                    dateFormat = DateFormat(
                                                                            'yyyy-MM-dd')
                                                                        .format(
                                                                            date);
                                                                  },
                                                                  maximumDate:
                                                                      2023,
                                                                ),
                                                              );
                                                            });
                                                          },
                                                          decoration: InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              hintText:
                                                                  "Ideal Purchased date or Purchase date",
                                                              hintStyle:
                                                                  AppTextStyle()
                                                                      .textColor70707014w400,
                                                              suffixIcon:
                                                                  Image.asset(
                                                                      "assets/images/calendarimg.png")),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 16,
                                              ),
                                              Container(
                                                width: 328.w,
                                                height: 52.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: ColorSelect
                                                        .colorEDEDF1),
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 12),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: TextFormField(
                                                            onChanged: (v) {
                                                              setState(() {});
                                                            },
                                                            controller:
                                                                productTypeController,
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            decoration:
                                                                InputDecoration(
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    hintText:
                                                                        "Type",
                                                                    hintStyle:
                                                                        AppTextStyle()
                                                                            .textColor70707014w400,
                                                                    suffixIconConstraints: BoxConstraints(
                                                                        maxHeight:
                                                                            40,
                                                                        maxWidth:
                                                                            40),
                                                                    suffixIcon:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              15.0),
                                                                      child: Image
                                                                          .asset(
                                                                        'assets/images/down-arrow.png',
                                                                        height:
                                                                            25,
                                                                      ),
                                                                    )),
                                                            onTap: () {
                                                              showModalBottomSheet(
                                                                  shape:
                                                                      const RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.only(
                                                                        topRight:
                                                                            Radius.circular(
                                                                                20),
                                                                        topLeft:
                                                                            Radius.circular(20)),
                                                                  ),
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) =>
                                                                          ProductTypeBottomSheet(
                                                                            productType:
                                                                                productTypeController.text,
                                                                            onPop:
                                                                                (val) {
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
                                                    )),
                                              ),
                                              SizedBox(
                                                height: 16,
                                              ),
                                              SizedBox(
                                                height: 52.h,
                                                width: 88.w,
                                                child:
                                                    LightYellowButtonWithText(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(ColorSelect
                                                                    .colorF7E641),
                                                        textStyleColor:
                                                            ColorSelect
                                                                .color292929,
                                                        onTap: () {
                                                          etsyStoreApi(
                                                            type:
                                                                productTypeController
                                                                    .text,
                                                            name: widget
                                                                .productTitle,
                                                            link: widget
                                                                .productUrl,
                                                            price: widget
                                                                .productPrice,
                                                            purchaseDate:
                                                                dateFormat,
                                                            status: 'public',
                                                            photoUrl: imageModel!
                                                                .results![0]
                                                                .urlFullxfull
                                                                .toString(),
                                                            photo: '',
                                                          ).then((value) {
                                                            if (value[
                                                                    'status'] ==
                                                                true) {
                                                              Navigator.of(
                                                                  context)
                                                                ..pop()
                                                                ..pop();
                                                              Fluttertoast.showToast(
                                                                  msg: value[
                                                                      'message']);
                                                            } else {
                                                              Fluttertoast.showToast(
                                                                  msg: value[
                                                                      'message']);
                                                            }
                                                          });
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
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
