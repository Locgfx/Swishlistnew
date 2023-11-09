import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/api/scapping_api.dart';
import 'package:swishlist/buttons/yellow_button.dart';
import 'package:swishlist/constants/color.dart';

import '../../../constants/urls.dart';
import '../../../models/ProductStoreMode.dart';

class ScrappingProductAdded extends StatefulWidget {
  final String name;
  final String price;
  final String productImage;
  final String productLink;
  final String type;
  const ScrappingProductAdded({
    Key? key,
    required this.name,
    required this.price,
    required this.productImage,
    required this.productLink,
    required this.type,
    // required this.productImage,
  }) : super(key: key);

  @override
  State<ScrappingProductAdded> createState() => _ScrappingProductAddedState();
}

class _ScrappingProductAddedState extends State<ScrappingProductAdded> {
  @override
  void initState() {
    super.initState();
    downloadAndSaveImage();
  }

  late String localImagePath;
  bool show = false;

  Future<void> downloadAndSaveImage() async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    final filePath = '${documentDirectory.path}/image.png';
    Uri imageUri =
        Uri.parse(widget.productImage); // Convert the string to a Uri

    http.Response response = await http.get(imageUri);

    if (response.statusCode == 200) {
      File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      if (mounted) {
        setState(() {
          localImagePath = filePath;
        });
      }
    } else {
      // Handle the case when the image couldn't be downloaded
    }
  }

  // Future<void> downloadAndSaveImage() async {
  //   final documentDirectory = await getApplicationDocumentsDirectory();
  //   final filePath = '${documentDirectory.path}/image.png';
  //   File file = File(filePath);
  //   await file.writeAsString(widget.productImage);
  //   if (mounted) {
  //     setState(() {
  //       localImagePath = filePath;
  //     });
  //   }
  // }

  int count = 3;
  ProductStoreModel? respStore;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('yyyy-MM-dd').format(now);
    String input = widget.price;
    String priceWithoutDollar = input.replaceAll(r'$', '');
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              show
                  ? SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(0),
                            backgroundColor: MaterialStateProperty.all(
                                ColorSelect.colorF7E641),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ))),
                        onPressed: () {},
                        child: Center(
                          child: LoadingAnimationWidget.waveDots(
                            size: 40,
                            // color: ColorSelect.colorF7E641,
                            color: Colors.black38,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 52,
                      child: YellowButtonWithText(
                        backgroundColor:
                            MaterialStateProperty.all(ColorSelect.colorF7E641),
                        textStyleColor: Colors.black,
                        onTap: () {
                          // setState(() {
                          //   downloadAndSaveImage();
                          // });
                          setState(() {
                            show = !show;
                          });
                          Timer timer = Timer(Duration(seconds: 4), () {
                            setState(() {
                              show = false;
                            });
                          });
                          scrappingAddProduct(
                                  name: widget.name,
                                  link: widget.productLink,
                                  price: priceWithoutDollar,
                                  purchaseDate: formattedTime,
                                  photo: localImagePath,
                                  context: context,
                                  privacy: 'public',
                                  type: widget.type)
                              .then(
                            (value) async {
                              if (value['status'] == true) {
                                Fluttertoast.showToast(msg: 'Product Added');
                              } else {
                                Fluttertoast.showToast(msg: value['message']);
                              }
                            },
                          );
                        },
                        title: 'Add',
                      ),
                    ),
              SizedBox(height: 16),

              // SizedBox(
              //   height: 52,
              //   child: YellowButtonWithText(
              //     backgroundColor:
              //         MaterialStateProperty.all(ColorSelect.colorF7E641),
              //     textStyleColor: Colors.black,
              //     onTap: () {
              //       Navigator.of(context);
              //       // productStoreApi(
              //       //         type: 'want',
              //       //         name: response!
              //       //             .data!.title
              //       //             .toString(),
              //       //         link:
              //       //             productLinkController
              //       //                 .text,
              //       //         price:
              //       //             response!
              //       //                 .data!.price
              //       //                 .toString(),
              //       //         purchaseDate:
              //       //             formattedTime,
              //       //         privacyStatus: 'public',
              //       //         photo: localImagePath)
              //       //     .then(
              //       //   (value) async {
              //       //     respStore = value;
              //       //     if (respStore!.status ==
              //       //         true) {
              //       //       setState(() {
              //       //         // isLoading = false;
              //       //       });
              //       //       Navigator.push(
              //       //         context,
              //       //         MaterialPageRoute(
              //       //           builder: (_) =>
              //       //               ProductAdded(
              //       //                   name: response!
              //       //                       .data!.title
              //       //                       .toString(),
              //       //                   price: response!
              //       //                       .data!.price
              //       //                       .toString(),
              //       //                   productImage:
              //       //                       response!
              //       //                           .data!
              //       //                           .image
              //       //                           .toString()),
              //       //         ),
              //       //       );
              //       //       Fluttertoast.showToast(
              //       //           msg: respStore!.message
              //       //               .toString());
              //       //     } else {
              //       //       Fluttertoast.showToast(
              //       //           msg:
              //       //               'Please enter product image');
              //       //     }
              //       //   },
              //       // );
              //     },
              //     title: 'Home',
              //   ),
              // ),
              SizedBox(height: 20),
              // SizedBox(
              //   height: 52,
              //   child: GreyBorderButtonWithText(
              //     backgroundColor: MaterialStateProperty.all(Colors.white),
              //     textStyleColor: Colors.black,
              //     onTap: () {
              //       Navigator.pushReplacement(context,
              //           MaterialPageRoute(builder: (_) => ManuallyAdd()));
              //     },
              //     title: '+ Add more',
              //   ),
              // ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
              width: 1.sw,
              child: Image.asset(
                'assets/images/bg1.png',
                fit: BoxFit.cover,
              )),
          SafeArea(
            child: SizedBox(
              width: 1.sw,
              child: Column(
                children: [
                  SizedBox(height: 24.h),

                  // GestureDetector(
                  //   onTap: () {
                  //     // print(widget.productImage);
                  //   },
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(vertical: 12),
                  //     child: SizedBox(
                  //       width: 36.w,
                  //       height: 36.w,
                  //       child: Image.asset('assets/images/done.png'),
                  //     ),
                  //   ),
                  // ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            padding: EdgeInsets.all(6),
                            child: SvgPicture.asset(
                              "assets/icons/arrowback.svg",
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 24),
                      Text(
                        'Add Product Now',
                        style: AppTextStyle().textColor29292920w500,
                      ),
                    ],
                  ),
                  SizedBox(height: 8),

                  // Text(
                  //   'to products you want.',
                  //   style: AppTextStyle().textColor29292914w400,
                  // ),
                  SizedBox(height: 40),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    width: 1.sw,
                    height: 200,
                    clipBehavior: Clip.hardEdge,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    // child: Image.file(
                    //   File(widget.productImage),
                    //   width: 1.sw,
                    //   height: 420,
                    //   fit: BoxFit.cover,
                    // ),
                    child: CachedNetworkImage(
                      // imageUrl: (baseUrl+haveProducts2[i].photo.toString()),
                      imageUrl: widget.productImage.toString().contains("https")
                          ? widget.productImage
                          : baseUrl + widget.productImage,
                      fit: BoxFit.fitHeight,
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
                            width: 1.sw,
                            // height: 129,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorSelect.colorE0E0E0, width: 1),
                                color: ColorSelect.colorFFFFFF,
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 45),
                    width: 1.sw,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Product name :',
                              style: AppTextStyle().textColor29292914w400,
                            ),
                            // Text(
                            //   '  ${widget.name}',
                            //   overflow: TextOverflow.ellipsis,
                            //   maxLines: 5,
                            //   style: AppTextStyle().roboto32323216w600,
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${widget.name}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                          style: AppTextStyle().roboto32323216w600,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 45),
                    width: 1.sw,
                    child: Row(
                      children: [
                        Text(
                          'Price:',
                          style: AppTextStyle().textColor29292914w400,
                        ),
                        Text(
                          '  ${widget.price}',
                          style: AppTextStyle().roboto32323216w600,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
