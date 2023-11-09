import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/constants/urls.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../api/user_apis/friends_api.dart';
import '../../../constants/color.dart';
import '../../../models/add_friend_model.dart';
import '../../../models/login_models.dart';

class FriendProductDetail extends StatefulWidget {
  final String name;
  final String price;
  final String link;
  final String image;
  final String purchaseDate;
  final String id;
  final String type;
  final LoginResponse response;
  final String productId;
  // final String id;
  const FriendProductDetail({
    Key? key,
    required this.name,
    required this.price,
    required this.link,
    required this.image,
    required this.purchaseDate,
    required this.id,
    required this.type,
    required this.response,
    required this.productId,
    // required this.id
  }) : super(key: key);

  @override
  State<FriendProductDetail> createState() => _FriendProductDetailState();
}

class _FriendProductDetailState extends State<FriendProductDetail> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getFriends();
    super.initState();
  }

  int pageIndex = 0;
  int selectedIndex = 0;

  bool seenBy = false;
  final textController = TextEditingController();
  final privacyController = TextEditingController();

  Future<void> launchUrlStart({required String url}) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  FriendModel friendList = FriendModel();
  bool isLoading = false;
  getFriends() {
    isLoading = true;
    // friendList.clear();
    var resp = getFriendsApi();
    resp.then((value) {
      if (mounted) {
        if (value['status'] == true) {
          setState(() {
            friendList = FriendModel.fromJson(value);
            // for (var v in value) {
            //   friendList.add(ModelFriend.fromJson(v));
            // }
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });

          // isLoading = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double price = double.tryParse(widget.price) ?? 0.0;
    double normalizedPercent = price / 100.0;
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          backgroundColor: ColorSelect.colorFFFFFF,
          elevation: 0,
          title: Row(children: [
            Text(
              "Product details",
              style: AppTextStyle().textColor29292916w500,
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      widget.link.contains("etsy")
                          ? '\$ ${normalizedPercent}'
                          : '\$ ${widget.price}',
                      // "47.99",
                      style: AppTextStyle().textColor29292924w700,
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: () {
                    print(widget.image);
                  },
                  child: Container(
                      width: 1.sw,
                      height: 246,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: ColorSelect.colorE0E0E0, width: 1)),
                      child: CachedNetworkImage(
                        imageUrl: widget.image.contains("http")
                            ? widget.image
                            : baseUrl + widget.image,
                        // wantProducts2[i].photo.toString().contains("https")
                        //     ? wantProducts2[i].photo.toString()
                        //     :
                        // baseUrl + wantProducts2[i].photo.toString(),
                        // imageUrl: (baseUrl+getProducts!.data![i].photo.toString()),
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
                              width: 1.sw,
                              height: 246,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorSelect.colorE0E0E0, width: 1),
                                  color: ColorSelect.colorFFFFFF,
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 10.h,
                ),
                /* Row(
                  children: [
                    Text(
                      'Purchase date :  ${widget.purchaseDate}',
                      // "12 June, 2022",
                      style: AppTextStyle().textColor70707012w400,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                  ],
                ),*/
                SizedBox(
                  height: 10,
                ),
                /*  Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      launchUrlStart(url: widget.link.toString() );
                    },
                    child: Text(
                      widget.link.toString(),
                      // "12 June, 2022",
                        style: AppTextStyle().textColor29292916w500,
                    ),
                  ),
                ),*/
                GestureDetector(
                  onTap: () {
                    launchUrlStart(url: widget.link.toString());
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 52.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                          color: ColorSelect.colorF7E641,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "View on\n website",
                            style: AppTextStyle().textColor29292912w400,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Image.asset(
                            "assets/images/website view icon.png",
                            height: 24,
                            width: 24,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                /*   SizedBox(
                  height: 52.h,
                  width: 88.w,
                  child: LightYellowButtonWithText(
                      backgroundColor:
                      MaterialStateProperty.all(ColorSelect.colorF7E641),
                      textStyleColor:
                      Colors.black,
                      onTap: (){},


                      title: 'Add'),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
