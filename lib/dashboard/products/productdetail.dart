import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/dashboard/products/product_privacy.dart';
import 'package:swishlist/dashboard/products/widget/product_widget.dart';

import '../../api/user_apis/products_api.dart';
import '../../buttons/red_button.dart';
import '../../buttons/white_button.dart';
import '../../buttons/yellow_button.dart';
import '../../constants/color.dart';
import '../../constants/decoration.dart';
import '../../profile_page/add_date_events.dart';

class ProductDetail extends StatefulWidget {
  final String name;
  final String price;
  final String link;
  final String image;
  final String purchaseDate;
  final String id;
  final String type;
  // final String id;
  const ProductDetail({Key? key,
    required this.name,
    required this.price,
    required this.link, required this.image, required this.purchaseDate, required this.id, required this.type,
    // required this.id
  }) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool seenBy = false;
  final textController = TextEditingController();
  final privacyController = TextEditingController();

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
          GestureDetector(
            onTap: () {
              Share.share(widget.link);
              // seenBy
              //     ? showModalBottomSheet(
              //         backgroundColor: Colors.transparent,
              //         context: context,
              //         builder: (context) {
              //           return SingleChildScrollView(
              //             child: Container(
              //               width: 1.sw,
              //               decoration: BoxDecoration(
              //                   color: Colors.white,
              //                   borderRadius: BorderRadius.vertical(
              //                       top: Radius.circular(20))),
              //               child: Padding(
              //                 padding:
              //                     const EdgeInsets.symmetric(horizontal: 16),
              //                 child: Column(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   children: [
              //                     Row(
              //                       mainAxisAlignment: MainAxisAlignment.center,
              //                       children: [
              //                         Padding(
              //                           padding: const EdgeInsets.only(top: 8),
              //                           child: Container(
              //                             width: 48,
              //                             height: 4,
              //                             decoration: BoxDecoration(
              //                                 color: ColorSelect.colorDCDCDC,
              //                                 borderRadius:
              //                                     BorderRadius.circular(8)),
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                     SizedBox(
              //                       height: 20,
              //                     ),
              //                     Text(
              //                       "Seen by",
              //                       style: AppTextStyle().textColor29292914w400,
              //                     ),
              //                     ListView.separated(
              //                         physics: NeverScrollableScrollPhysics(),
              //                         scrollDirection: Axis.vertical,
              //                         shrinkWrap: true,
              //                         itemCount: 10,
              //                         itemBuilder:
              //                             (BuildContext context, int index) {
              //                           return Column(children: [
              //                             Container(
              //                               margin: EdgeInsets.only(top: 16),
              //                               child: Row(
              //                                 children: [
              //                                   CircleAvatar(
              //                                     radius: 20,
              //                                     backgroundColor: Colors.grey,
              //                                     backgroundImage: AssetImage(
              //                                         'assets/images/Rectangle319.png'),
              //                                   ),
              //                                   SizedBox(
              //                                     width: 8.h,
              //                                   ),
              //                                   Text(
              //                                     "Jan Levinson",
              //                                     style: AppTextStyle()
              //                                         .textColor00000014w400,
              //                                   ),
              //                                 ],
              //                               ),
              //                             )
              //                           ]);
              //                         },
              //                         separatorBuilder:
              //                             (BuildContext context, int index) {
              //                           return SizedBox(
              //                             height: 16,
              //                           );
              //                         })
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           );
              //         })
              //     : showModalBottomSheet(
              //         backgroundColor: Colors.transparent,
              //         context: context,
              //         isScrollControlled: true,
              //         builder: (context) {
              //           return ShareBottomSheet();
              //         });
            },
            child: Image.asset(
              "assets/images/Vectorsend.png",
              height: 24,
              width: 20,
            ),
          ),
          SizedBox(
            width: 32,
          ),
          InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 32.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height: 338.h,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 16),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 32.h,
                                                ),
                                                Text(
                                                  "Edit title",
                                                  style: AppTextStyle().textColor3D3D3D24w700,
                                                ),
                                                SizedBox(
                                                  height: 28.h,
                                                ),
                                                Container(
                                                  height: 154.h,
                                                  width: 328.w,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8),
                                                      color: ColorSelect.colorFEFCF6,
                                                      border: Border.all(color: ColorSelect.colorF7E641)),
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                                                    child: Column(
                                                      children: [
                                                        TextFormField(
                                                        controller:textController,
                                                          onChanged: (v) {

                                                          },
                                                          // controller: moviesController,
                                                          cursorColor: ColorSelect.colorF7E641,
                                                          decoration: InputDecoration(
                                                            border: InputBorder.none,
                                                            focusedBorder: InputBorder.none,
                                                            enabledBorder: InputBorder.none,
                                                            errorBorder: InputBorder.none,
                                                            disabledBorder: InputBorder.none,
                                                          ), //keyboardType: TextInputType.phone,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 16.h,
                                                ),
                                                SizedBox(
                                                  width: 87.w,
                                                  height: 48.h,
                                                  child: YellowButtonWithText(
                                                      backgroundColor:
                                                      MaterialStateProperty.all(ColorSelect.colorF7E641),
                                                      textStyleColor: ColorSelect.color292929,
                                                      onTap: () {
                                                        updateProducts(
                                                            type: widget.type,
                                                            name: textController.text,
                                                            link: widget.link,
                                                            price: widget.price,
                                                            purchaseDate: widget.purchaseDate,
                                                            privacyStatus: 'public',
                                                            photo: '',
                                                            id: widget.id,
                                                            photoUrl: widget.image
                                                        ).then((value) {
                                                              if(value['status'] == true) {
                                                                Navigator.of(context)..pop()..pop()..pop();
                                                                Fluttertoast.showToast(msg: value['message']);
                                                              } else {
                                                                Fluttertoast.showToast(msg: value['message']);
                                                              }
                                                        }
                                                        );
                                                        /*Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => UserDetails()));*/
                                                      },
                                                      title: 'Save'),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: Container(
                                  height: 40.h,
                                  width: 328.w,
                                  color: Colors.transparent,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 15),
                                        child: SvgPicture.asset("assets/icons/edittitle.svg"),
                                      ),
                                      Text(
                                        "Edit title",
                                        style: AppTextStyle().textColor39393914w500,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                showDialog(
                                context: context,
                                 builder: (BuildContext context) {
                                  return AlertDialog(
                                    insetPadding: EdgeInsets.only(left: 20, right: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 0,
                                    backgroundColor: Colors.white,
                                    content: SizedBox(
                                      width: 1.sw,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Text(
                                              "Edit Privacy",
                                              style: AppTextStyle().textColor29292918w500,
                                            ),
                                            SizedBox(
                                              height: 8.h,
                                            ),
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
                                                        onTap:() {
                                                          showModalBottomSheet(
                                                              shape: const RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.only(
                                                                    topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                                              ),
                                                              context: context,
                                                              builder: (context) => PrivacyStatusBottomSheet(
                                                                onPop: (val) {
                                                                  setState(() {
                                                                    privacyController.text = val;
                                                                  });
                                                                },
                                                                privacyStatus: privacyController.text,
                                                              ));
                                                        },
                                                        onChanged: (v) {
                                                          setState(() {});
                                                        },
                                                        controller: privacyController,
                                                        decoration: InputDecoration(
                                                            border: InputBorder.none,
                                                            hintText: "Select privacy",
                                                            hintStyle: AppTextStyle().textColor70707014w400,
                                                            suffixIconConstraints: BoxConstraints(maxHeight: 40,maxWidth: 40),
                                                            suffixIcon: Padding(
                                                              padding: const EdgeInsets.only(right: 15.0),
                                                              child: Image.asset('assets/images/down-arrow.png',height: 25,),
                                                            )
                                                        ),
                                                        keyboardType: TextInputType.text,
                                                        readOnly: true,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 16.h),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: SizedBox(
                                                    height: 52,
                                                    child: WhiteButtonWithText(
                                                        backgroundColor:
                                                        MaterialStateProperty.all(Colors.white),
                                                        textStyleColor: ColorSelect.color292929,
                                                        onTap: () {
                                                          Navigator.pop(context);
                                                        },
                                                        title: 'Cancel'),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 12.w,
                                                ),
                                                Expanded(
                                                  child: SizedBox(
                                                    height: 52,
                                                    child:WhiteButtonWithText(
                                                        backgroundColor:
                                                        MaterialStateProperty.all(ColorSelect.colorCE5252),
                                                        textStyleColor: ColorSelect.colorFFFFFF,
                                                        onTap: () {
                                                          updateProducts(
                                                              type: widget.type,
                                                              name: widget.name,
                                                              link: widget.link,
                                                              price: widget.price,
                                                              purchaseDate: widget.purchaseDate,
                                                              privacyStatus: privacyController.text,
                                                              photo: '',
                                                              id: widget.id,
                                                              photoUrl: widget.image).then((value) {
                                                            if(value['status'] == true) {
                                                              Navigator.of(context)..pop()..pop()..pop();
                                                              Fluttertoast.showToast(msg: value['message']);
                                                            } else {
                                                              Fluttertoast.showToast(msg: value['message']);
                                                            }
                                                          }
                                                          );

                                                        },
                                                        title: 'Save'),
                                                    /*RedButtonWithText(
                                                      backgroundColor:
                                                      MaterialStateProperty.all(ColorSelect.colorCE5252),
                                                      textStyleColor: ColorSelect.colorFFFFFF,
                                                      image: Image.asset(""),
                                                      onTap: () {
                                                        deleteProductsApi(
                                                            id: widget.id).
                                                        then((value){
                                                          if(value['status'] == true) {

                                                            Navigator.of(context)..pop()..pop();
                                                            Fluttertoast.showToast(msg: value['message']);
                                                          } else {
                                                            Fluttertoast.showToast(msg: value['message']);
                                                          }
                                                        });
                                                      },
                                                      title: 'Save',
                                                    ),*/
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                 } );

                                  // Navigator.push(context,
                                  //     MaterialPageRoute(builder: (context) => ProductPrivacy()));
                                },
                                child: Container(
                                  height: 40.h,
                                  width: 328.w,
                                  color: Colors.transparent,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 32,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 15),
                                        child:
                                        SvgPicture.asset("assets/icons/eyeeditprivacy.svg"),
                                      ),
                                      Text(
                                        "Edit privacy",
                                        style: AppTextStyle().textColor39393914w500,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Share.share(widget.link);
                                },
                                child: Container(
                                  height: 40.h,
                                  width: 328.w,
                                  color: Colors.transparent,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 32,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 15),
                                        child: SvgPicture.asset("assets/icons/shareimage.svg"),
                                      ),
                                      Text(
                                        "Share externally",
                                        style: AppTextStyle().textColor39393914w500,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   height: 8.h,
                              // ),
                              // Container(
                              //   height: 40.h,
                              //   width: 328.w,
                              //   color: Colors.transparent,
                              //   child: Row(
                              //     children: [
                              //       SizedBox(
                              //         height: 32,
                              //       ),
                              //       Padding(
                              //         padding: const EdgeInsets.only(right: 15),
                              //         child: SvgPicture.asset("assets/icons/folder-download.svg"),
                              //       ),
                              //       Text(
                              //         "Archieve",
                              //         style: AppTextStyle().textColor39393914w500,
                              //       )
                              //     ],
                              //   ),
                              // ),
                              SizedBox(
                                height: 8.h,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          insetPadding: EdgeInsets.only(left: 20, right: 20),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          elevation: 0,
                                          backgroundColor: Colors.white,
                                          content: SizedBox(
                                            width: 1.sw,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Delete this product?",
                                                    style: AppTextStyle().textColor29292918w500,
                                                  ),
                                                  SizedBox(
                                                    height: 8.h,
                                                  ),
                                                  Text(
                                                    "This product with will be permanently deleted",
                                                    style: AppTextStyle().textcolor82828212w400,
                                                  ),
                                                  SizedBox(
                                                    height: 44.h,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: SizedBox(
                                                          height: 52,
                                                          child: WhiteButtonWithText(
                                                              backgroundColor:
                                                              MaterialStateProperty.all(Colors.white),
                                                              textStyleColor: ColorSelect.color292929,
                                                              onTap: () {
                                                                Navigator.pop(context);
                                                              },
                                                              title: 'Cancel'),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 12.w,
                                                      ),
                                                      Expanded(
                                                        child: SizedBox(
                                                          height: 52,
                                                          child: RedButtonWithText(
                                                            backgroundColor:
                                                            MaterialStateProperty.all(ColorSelect.colorCE5252),
                                                            textStyleColor: ColorSelect.colorFFFFFF,
                                                            image: Image.asset("assets/images/trashdel.png"),
                                                            onTap: () {
                                                              deleteProductsApi(
                                                                  id: widget.id).
                                                              then((value){
                                                                if(value['status'] == true) {

                                                                  Navigator.of(context)..pop()..pop();
                                                                  Fluttertoast.showToast(msg: value['message']);
                                                                } else {
                                                                  Fluttertoast.showToast(msg: value['message']);
                                                                }
                                                              });
                                                            },
                                                            title: 'Delete',
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                        // return DialogWidget();
                                      });
                                },
                                child: Container(
                                  height: 40.h,
                                  width: 328.w,
                                  color: Colors.transparent,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 32,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 15),
                                        child: SvgPicture.asset("assets/icons/trash1.svg"),
                                      ),
                                      Text(
                                        "Delete",
                                        style: AppTextStyle().textcolorCE535314w500,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: Container(
                height: 24,
                  width: 24,
                  child: Image.asset("assets/images/4xdot.png"))),
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
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.name,
                  // "RESPAWN 110 Racing Style Gaming Chair, Reclining Ergonomic Chair with Footrest, in Green",
                  style: AppTextStyle().textColor29292916w500,
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                children: [
                  Text(
                    widget.price,
                    // "47.99",
                    style: AppTextStyle().textColor29292924w700,
                  ),
                  Spacer(),
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 28, vertical: 9),
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(8),
                  //     color: ColorSelect.colorF7E641,
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             "View on",
                  //             style: AppTextStyle().textcolor3F3F3F12w500,
                  //           ),
                  //           SizedBox(height: 4),
                  //           Image.asset('assets/images/amazonimage.png')
                  //         ],
                  //       ),
                  //       SizedBox(width: 16),
                  //       SizedBox(
                  //         width: 24,
                  //         height: 24,
                  //         child: SvgPicture.asset(
                  //           "assets/icons/arrowimage.svg",
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // )
                ],
              ),
              SizedBox(height: 20.h),
              Container(
                width: 1.sw,
                height: 246,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(color: ColorSelect.colorE0E0E0, width: 1)),
                child: CachedNetworkImage(
                  imageUrl: widget.image,
                  // imageUrl: (baseUrl+getProducts!.data![i].photo.toString()),
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error,size: 40,),
                  progressIndicatorBuilder:  (a,b,c) =>
                      Opacity(
                        opacity: 0.3,
                        child: Shimmer.fromColors(
                          baseColor: Colors.black12,
                          highlightColor: Colors.white,
                          child: Container(
                            width: 1.sw,
                            height: 246,
                            decoration: BoxDecoration(
                                border:
                                Border.all(color: ColorSelect.colorE0E0E0, width: 1),
                                color: ColorSelect.colorFFFFFF,
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                )
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text(
                    'Purchase date :  ${widget.purchaseDate}',
                    // "12 June, 2022",
                    style: AppTextStyle().textColor70707012w400,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),

                  // Container(
                  //   height: 2.h,
                  //   width: 2.w,
                  //   decoration: BoxDecoration(
                  //       shape: BoxShape.circle, color: ColorSelect.color707070),
                  // ),
                  // SizedBox(
                  //   width: 10.w,
                  // ),
                  // SvgPicture.asset("assets/icons/eyeicons.svg"),
                  // SizedBox(
                  //   width: 6.w,
                  // ),
                  // Text(
                  //   "4",
                  //   style: AppTextStyle().textColor70707012w400,
                  // )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.link.toString(),
                  // "12 June, 2022",
                    style: AppTextStyle().textColor29292916w500,
                ),
              ),
              // Container(
              //   height: 52.h,
              //   width: 328.w,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(8),
              //       color: ColorSelect.colorEBF6E9),
              //   child: Row(
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.only(
              //             left: 12, top: 10, bottom: 10, right: 4),
              //         child: CircleAvatar(
              //           radius: 20,
              //           backgroundImage:
              //               AssetImage('assets/images/Rectangle1072.png'),
              //         ),
              //       ),
              //       Text(
              //         "I want this.",
              //         style: AppTextStyle().textcolor4B955714w400,
              //       ),
              //       Spacer(),
              //       Padding(
              //         padding: const EdgeInsets.only(right: 18),
              //         child: Text(
              //           "Change",
              //           style: AppTextStyle().textcolor27272714w500,
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 12.h,
              // ),
              // Container(
              //   width: 328.w,
              //   height: 101.h,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(8),
              //       color: ColorSelect.colorF0F0F0),
              //   child: Padding(
              //     padding:
              //         const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              //     child: TextField(
              //       decoration: InputDecoration(
              //           hintText: "Write a note", border: InputBorder.none),
              //     ),
              //   ),
              // ),
              // SizedBox(
              //   height: 40.h,
              // )
            ],
          ),
        ),
      ),
    );
  }
}


