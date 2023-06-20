import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/buttons/grey_border_button.dart';
import 'package:swishlist/buttons/yellow_button.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/constants/urls.dart';
import '../../api/user_apis/products_api.dart';
import '../../models/product_type_model.dart';
import 'manuallyadd.dart';

class ProductAdded extends StatefulWidget {
  final String name;
  final String price;
  final String productImage;
  const ProductAdded({Key? key,
    required this.name,
    required this.price,
    required this.productImage,}) : super(key: key);

  @override
  State<ProductAdded> createState() => _ProductAddedState();
}

class _ProductAddedState extends State<ProductAdded> {
  @override
  void initState() {
    print(widget.productImage);
    print(widget.productImage);
    print(widget.productImage);

    super.initState();
  }

  int count = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 52,
                child: YellowButtonWithText(
                  backgroundColor:
                      MaterialStateProperty.all(ColorSelect.colorF7E641),
                  textStyleColor: Colors.black,
                  onTap: () {
                    print(widget.productImage);

                   /* Navigator.of(context)..pop()..pop()..pop();*/
                  },
                  title: 'Home',
                ),
              ),
              SizedBox(height: 12),
              SizedBox(
                height: 52,
                child: GreyBorderButtonWithText(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  textStyleColor: Colors.black,
                  onTap: () {
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>
                   ManuallyAdd()));
                  },
                  title: '+ Add more',
                ),
              ),
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: SizedBox(
                      width: 36.w,
                      height: 36.w,
                      child: Image.asset('assets/images/done.png'),
                    ),
                  ),
                  Text(
                    'New Product Added',
                    style: AppTextStyle().textColor29292924w700,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'to products you want.',
                    style: AppTextStyle().textColor29292914w400,
                  ),
                  SizedBox(height: 40),
                  Container(
                    width: 1.sw,
                    margin: EdgeInsets.symmetric(horizontal: 45),
                    padding: EdgeInsets.symmetric(vertical: 27),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          offset: Offset(12, 12),
                          spreadRadius: 0,
                          blurRadius: 60,
                        ),
                      ],
                    ),
                    child: CachedNetworkImage(
                      // imageUrl: (baseUrl+haveProducts2[i].photo.toString()),
                      imageUrl: '$baseUrl2${widget.productImage}',
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
                                // height: 129,
                                decoration: BoxDecoration(
                                    border:
                                    Border.all(color: ColorSelect.colorE0E0E0, width: 1),
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
                    child: Text(
                      widget.name,
                      style: AppTextStyle().textColor29292914w400,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 45),
                    width: 1.sw,
                    child: Text(
                      widget.price,
                      style: AppTextStyle().roboto32323216w600,
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
