import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:swishlist/constants/urls.dart';
import 'package:swishlist/dashboard/products/productalready.dart';
import 'package:swishlist/dashboard/products/productdetail.dart';
import 'package:swishlist/dashboard/products/productdontwant.dart';
import 'package:swishlist/dashboard/products/wantproducts.dart';
import 'package:swishlist/dashboard/products/widget/already_manually_add_bottom_sheet.dart';
import 'package:swishlist/dashboard/products/widget/manuallyaddbottomsheetwidget.dart';
import 'package:swishlist/expanded/add_family_member.dart';
import 'package:swishlist/expanded/manage_family_members.dart';
import 'package:swishlist/expanded/member_settings.dart';
import 'package:swishlist/expanded/user_all_details.dart';
import 'package:swishlist/expanded/widgets/expanded_section_row_option.dart';

import '../../api/user_apis/products_api.dart';
import '../../api/user_apis/profile_apis.dart';
import '../../buttons/yellow_button.dart';
import '../../constants/color.dart';
import '../../constants/globals/globals.dart';
import '../../constants/globals/loading.dart';
import '../../models/login_models.dart';
import '../../models/product_model.dart';
import '../../models/product_type_model.dart';
import '../../models/profile_model.dart';
import '../friends/friends.dart';

class ProductsPage extends StatefulWidget {
  static const PREFERENCES_IS_FIRST_LAUNCH_STRING =
      "PREFERENCES_IS_FIRST_LAUNCH_STRING";

  final LoginResponse response;
  const ProductsPage({
    Key? key,
    required this.response,
  }) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  LoginResponse? response;

  bool showBox = true;
  bool showExpandedScreen = false;
  bool isLoading = false;
  int itemCount = 2;

  Future<void> _handleRefresh() async {
    getProfile();
    getWantProducts();
    getNotWant();
    getHaveProducts();

    // Implement your refresh logic here.
    // For example, fetch new data from an API or update some data.
    // You can use async/await for asynchronous operations.

    // For demonstration purposes, let's delay for 2 seconds.
    await Future.delayed(Duration(seconds: 2));

    // Once the refresh operation is complete, call setState to rebuild the UI.
    setState(() {
      // Update your data or UI state as needed.
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey _first = GlobalKey();
  final GlobalKey _second = GlobalKey();
  final GlobalKey _third = GlobalKey();
  final GlobalKey _fourth = GlobalKey();
  final GlobalKey _fifth = GlobalKey();

  @override
  void initState() {
    getProfile();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isFirstLaunch().then((result) {
        if (result) {
          ShowCaseWidget.of(context)
              .startShowCase([_first, _third, _fourth, _fifth]);
        }
      });
    });

    getWantProducts();
    getNotWant();
    getHaveProducts();

    super.initState();
  }

  Future<bool> _isFirstLaunch() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    bool isFirstLaunch = sharedPreferences
            .getBool(ProductsPage.PREFERENCES_IS_FIRST_LAUNCH_STRING) ??
        true;

    if (isFirstLaunch) {
      sharedPreferences.setBool(
          ProductsPage.PREFERENCES_IS_FIRST_LAUNCH_STRING, false);
    }

    return isFirstLaunch;
  }

  ProfileModel? profile = ProfileModel(
    data: ProfileData(
      name: '',
      gender: '',
      dob: '',
      occupation: '',
      relationStatus: '',
      email: '',
      phone: '',
      alternatePhone: '',
      homeAddress: '',
      workAddress: '',
      privacyStatus: '',
      createdAt: '',
      completePercent: '',
      user: ProfileUser(
          name: '', username: '', email: '', phone: '', type: '', photo: ''),
    ),
  );

  getProfile() {
    isLoading = true;
    var resp = getProfileDetails();
    resp.then((value) {
      print(value);
      if (mounted) {
        if (value['status'] == true) {
          if (value['message'] == "No Profile") {
            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {
              profile = ProfileModel.fromJson(value);
              isLoading = false;
            });
          }
        } else {
          setState(() {
            isLoading = false;
          });
        }
      }
    });
  }

  // bool isLoading = false;
  GetProductModel? getProducts;
  List<ProductTypeModel> wantProducts = [];
  List<ProductTypeModel> wantProducts2 = [];

  getWantProducts() {
    isLoading = true;
    var resp = getProductsApi();
    resp.then((value) {
      wantProducts2.clear();
      wantProducts.clear();
      if (value['status'] == true) {
        setState(() {
          for (var v in value['data']) {
            wantProducts.add(ProductTypeModel.fromJson(v));
          }
          for (var v in wantProducts) {
            if (v.type! == "want") {
              wantProducts2.add(v);
              wantProducts2.removeWhere((element) => element.id == v);
            }
          }
          isLoading = false;
        });
      } else {
        isLoading = false;
        // wantProducts2.clear();
      }
    });
  }

  // GetProductModel? getProducts2;
  List<ProductTypeModel> notWant = [];
  List<ProductTypeModel> notWant2 = [];
  getNotWant() {
    isLoading = true;
    var resp = getProductsApi();
    resp.then((value) {
      notWant2.clear();
      notWant.clear();
      if (value['status'] == true) {
        setState(() {
          for (var v in value["data"]) {
            notWant.add(ProductTypeModel.fromJson(v));
          }
          for (var v in notWant) {
            if (v.type! == "dont_want") {
              notWant2.add(v);
            }
          }
          isLoading = false;
          // notWant2.clear();
        });
      } else {
        isLoading = false;
      }
    });
  }

  // GetProductModel? getProducts;
  List<ProductTypeModel> haveProducts = [];
  List<ProductTypeModel> haveProducts2 = [];

  getHaveProducts() {
    isLoading = true;
    var resp = getProductsApi();
    resp.then((value) {
      haveProducts2.clear();
      haveProducts.clear();

      if (value['status'] == true) {
        setState(() {});
        setState(() {
          for (var v in value["data"]) {
            haveProducts.add(ProductTypeModel.fromJson(v));
          }
          for (var v in haveProducts) {
            if (v.type! == "have") {
              haveProducts2.add(v);
              setState(() {});
            }
          }
          isLoading = false;
        });
      } else {
        isLoading = false;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: isLoading
            ? Center(
                child: LoadingAnimationWidget.inkDrop(
                  size: 40,
                  color: ColorSelect.colorF7E641,
                ),
              )
            : RefreshIndicator(
                backgroundColor: Colors.white,
                color: ColorSelect.colorF7E641,
                strokeWidth: 3,
                onRefresh: _handleRefresh,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        // clipBehavior: Clip.none,
                        children: [
                          Positioned(
                              top: 250,
                              left: 0,
                              child: Image.asset(
                                  "assets/images/Rectangle356.png")),
                          Positioned(
                            top: 600,
                            left: 0,
                            child:
                                Image.asset("assets/images/Rectangle3564.png"),
                          ),
                          Container(
                            color: Colors.white,
                            padding:
                                const EdgeInsets.only(left: 16, bottom: 10),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => UserAllDetails(
                                          response: widget.response,
                                        ),
                                      ),
                                    );
                                    // setState(() {
                                    //   showBox = true;
                                    // });
                                  },
                                  child: Stack(
                                    alignment: Alignment.center,
                                    clipBehavior: Clip.none,
                                    children: [
                                      /* CircularPercentIndicator(
                                  circularStrokeCap: CircularStrokeCap.round,
                                  radius: 65,
                                  lineWidth: 5,
                                  percent: .100,
                                  animateFromLastPercent: true,
                                  backgroundColor: ColorSelect.colorEDEDF1,
                                  progressColor: Colors.black,
                                  center:*/
                                      Container(
                                        margin:
                                            EdgeInsets.only(top: 10, right: 10),
                                        height: 50,
                                        width: 50,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              // SharedPrefs()
                                              //     .getUserPhoto()
                                              //     .toString(),

                                              // imageUrl: '${SharedPrefs().getUserPhoto()}'
                                              //         .isEmpty
                                              //     ? widget.response.data.photo
                                              //         .toString()
                                              //     : '${SharedPrefs().getUserPhoto()}',
                                              profile!.data!.user!.photo
                                                      .toString()
                                                      .contains("https")
                                                  ? profile!.data!.user!.photo
                                                      .toString()
                                                  : baseUrl +
                                                      profile!.data!.user!.photo
                                                          .toString(),
                                          // imageUrl: widget.response.data.photo
                                          //         .toString()
                                          //         .contains("https")
                                          //     ? widget.response.data.photo
                                          //         .toString()
                                          //     : baseUrl +
                                          //         widget.response.data.photo
                                          //             .toString(),
                                          // haveProducts2[i]
                                          //     .photo
                                          //     .toString()
                                          //     .contains("https")
                                          //     ? haveProducts2[i].photo.toString()
                                          //     : baseUrl +
                                          //     haveProducts2[i].photo.toString(),
                                          // SharedPrefs()
                                          //         .getUserPhoto()
                                          //         .toString()
                                          //         .contains('https')
                                          //     ? SharedPrefs()
                                          //         .getUserPhoto()
                                          //         .toString()
                                          //     : '$baseUrl${SharedPrefs().getUserPhoto()}',
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                                  "assets/icons/userico.jpg"),
                                          progressIndicatorBuilder: (a, b, c) =>
                                              Opacity(
                                            opacity: 0.3,
                                            child: Shimmer.fromColors(
                                              baseColor: Colors.black12,
                                              highlightColor: Colors.white,
                                              child: Container(
                                                width: 40,
                                                height: 40,
                                                //margin: EdgeInsets.symmetric(horizontal: 24),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // ),
                                      // Positioned(
                                      //   bottom: -5,
                                      //   child: Container(
                                      //     padding: EdgeInsets.all(5),
                                      //     decoration: BoxDecoration(
                                      //       color: ColorSelect.colorF7E641,
                                      //       borderRadius: BorderRadius.all(
                                      //         Radius.circular(80),
                                      //       ),
                                      //     ),
                                      //     child: Text(
                                      //       " 25% ",
                                      //       style: AppTextStyle().textColor29292910w500,
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 5),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showExpandedScreen = !showExpandedScreen;
                                      showBox = false;
                                    });
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                profile!.data!.name
                                                                .toString() ==
                                                            "" ||
                                                        profile!.data!.name ==
                                                            null
                                                    ? Text(
                                                        "User",

                                                        // '${SharedPrefs().getName()}'
                                                        //         .isEmpty
                                                        //     ? 'user'
                                                        //     : '${SharedPrefs().getName()}',
                                                        // '${SharedPrefs().getName()}'
                                                        //         .isEmpty
                                                        //     ? widget.response.data.name
                                                        //         .toString()
                                                        //     :
                                                        // '${SharedPrefs().getName().}',
                                                        // profile!.data!.name.toString(),
                                                        // '${SharedPrefs().getName()}',
                                                        // SharedPrefs()
                                                        //         .getName()
                                                        //         .toString()
                                                        //         .isEmpty
                                                        //     ? 'user'
                                                        //     : SharedPrefs()
                                                        //         .getName()
                                                        //         .toString(),

                                                        style: AppTextStyle()
                                                            .textColor29292916w500r,
                                                      )
                                                    : Text(
                                                        profile!.data!.name
                                                            .toString(),

                                                        // '${SharedPrefs().getName()}'
                                                        //         .isEmpty
                                                        //     ? 'user'
                                                        //     : '${SharedPrefs().getName()}',
                                                        // '${SharedPrefs().getName()}'
                                                        //         .isEmpty
                                                        //     ? widget.response.data.name
                                                        //         .toString()
                                                        //     :
                                                        // '${SharedPrefs().getName().}',
                                                        // profile!.data!.name.toString(),
                                                        // '${SharedPrefs().getName()}',
                                                        // SharedPrefs()
                                                        //         .getName()
                                                        //         .toString()
                                                        //         .isEmpty
                                                        //     ? 'user'
                                                        //     : SharedPrefs()
                                                        //         .getName()
                                                        //         .toString(),

                                                        style: AppTextStyle()
                                                            .textColor29292916w500r,
                                                      ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                showExpandedScreen
                                                    ? SvgPicture.asset(
                                                        'assets/icons/Vector458.svg')
                                                    : SvgPicture.asset(
                                                        "assets/icons/Vector4581.svg",
                                                      ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 8),
                                              child: Text(
                                                // '${SharedPrefs().getEmail()}'
                                                //         .isEmpty
                                                //     ? widget.response.data.name
                                                //         .toString()
                                                //     :
                                                // '${SharedPrefs().getEmail()}',
                                                /* '${SharedPrefs().getUsername()}' == 'null' ?
                                          'Add your Username' :*/
                                                widget.response.data.email
                                                    .toString(),
                                                style: AppTextStyle()
                                                    .textColor70707014w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // SizedBox(
                                        //   width: 100,
                                        // ),
                                        // showExpandedScreen
                                        //     ? Icon(Icons.more_vert)
                                        //     :
                                        // Image.asset(
                                        //   'assets/images/send1.png',
                                        //   height: 32,
                                        //   width: 32,
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                                Spacer(),
                                // showExpandedScreen
                                //     ? GestureDetector(
                                //         behavior: HitTestBehavior.translucent,
                                //         onTap: () {
                                //           Navigator.push(
                                //             context,
                                //             MaterialPageRoute(
                                //               builder: (_) => UserAllDetails(
                                //                 response: widget.response,
                                //               ),
                                //             ),
                                //           );
                                //         },
                                //         child: Container(
                                //           color: Colors.redAccent,
                                //           padding: EdgeInsets.all(16),
                                //           child: Icon(Icons.more_vert),
                                //         ),
                                //       )
                                //     :
                                Showcase(
                                  key: _first,
                                  description: 'Share profile with others',
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () async {
                                      if (Platform.isIOS) {
                                        setState(() {
                                          Share.share(
                                              'https://apps.apple.com/us/app/swishlist/id6447429473');
                                        });
                                      } else {
                                        setState(() {
                                          Share.share(
                                              'https://play.google.com/store/apps/details?id=com.locgfx.swishlist&pcampaignid=web_share');
                                        });
                                      }
                                      // final url = Uri.parse(
                                      //   'https://play.google.com/store/apps/details?id=com.locgfx.swishlist&pcampaignid=web_share',
                                      // );
                                      // if (await canLaunchUrl(url)) {
                                      //   launchUrl(url);
                                      // } else {
                                      //   // ignore: avoid_print
                                      //   print("Can't launch $url");
                                      // }
                                      // // final Uri url = Uri.parse(
                                      // //     'https://play.google.com/store/apps/details?id=com.locgfx.swishlist&pcampaignid=web_share');
                                      // // if (!await launchUrl(url)) {
                                      // //   throw Exception(
                                      // //       'Could not launch $_url');
                                      // // }
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Container(
                                        // color: Colors.red,
                                        height: 48,
                                        width: 48,
                                        padding: EdgeInsets.all(8),
                                        child: Image.asset(
                                          'assets/images/send1.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (!showBox)
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.fastOutSlowIn,
                          width: 1.sw,
                          height: showExpandedScreen ? 300.h : 0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          padding:
                              EdgeInsets.only(left: 16, top: 0, bottom: 20),
                          margin: EdgeInsets.only(top: 10),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                // OptionRowFamily(),
                                SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => AddFamilyMember(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 44,
                                          height: 44,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: ColorSelect.colorEDEDF1,
                                          ),
                                          padding: EdgeInsets.all(15),
                                          child: SvgPicture.asset(
                                            'assets/icons/Union.svg',
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Add family member',
                                          style: AppTextStyle()
                                              .textColor29292914w500,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                OptionRow(
                                  icon: 'userpro',
                                  label: 'Manage family members',
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ManageFamilyMembers(),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: 20),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ShowCaseWidget(
                                          builder: Builder(
                                              builder: (context) => Friends()),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 44,
                                          height: 44,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: ColorSelect.colorEDEDF1,
                                          ),
                                          padding: EdgeInsets.all(8),
                                          child: Image.asset(
                                            'assets/images/send1.png',
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Share Product with friend',
                                          style: AppTextStyle()
                                              .textColor29292914w500,
                                        ),
                                        Spacer(),
                                        Container(
                                          width: 32,
                                          height: 16,
                                          padding: EdgeInsets.only(right: 16),
                                          color: Colors.transparent,
                                          child: Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                OptionRow(
                                  icon: 'setting',
                                  label: 'Settings',
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => MemberSettings(
                                          response: widget.response,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      if (showBox)
                        Container(
                          width: 1.sw,
                          color: Colors.transparent,
                          margin: EdgeInsets.only(left: 16),
                          child: Stack(
                            children: [
                              SizedBox(
                                width: 1.sw,
                                child: Image.asset(
                                  'assets/images/bbox.png',
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              Positioned(
                                top: 50.h,
                                left: 20,
                                child: Text(
                                  "Let your friends know about you!",
                                  style: AppTextStyle().textColorFFFFFF14w400,
                                ),
                              ),
                              Positioned(
                                top: 90.h,
                                left: 20,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ShowCaseWidget(
                                          builder: Builder(
                                            builder: (context) =>
                                                UserAllDetails(
                                              response: widget.response,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    color: Colors.transparent,
                                    padding:
                                        EdgeInsets.only(right: 10, bottom: 10),
                                    child: Text(
                                      "Add Details",
                                      style:
                                          AppTextStyle().textColorF7E64114w400,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 42,
                                top: 45,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showBox = false;
                                    });
                                  },
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    color: Colors.grey.withOpacity(0.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(children: [
                          Text(
                            "I want",
                            style: AppTextStyle().textColor29292924w700,
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WantProducts(
                                            isUser: true,
                                          )));
                            },
                            child: Text(
                              "View all",
                              style: AppTextStyle().textColor29292914w500,
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Showcase(
                            targetPadding: EdgeInsets.all(8),
                            key: _third,
                            description: "This is for add products manually",
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return ManuallyAddBottomSheetWidget(
                                        productType:
                                            'want', /*model: widget.model,*/
                                      );
                                    });
                              },
                              child: Container(
                                height: 36,
                                width: 36,
                                decoration: BoxDecoration(
                                    color: ColorSelect.colorF7E641,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(child: Icon(Icons.add)),
                              ),
                            ),
                          ),
                        ]),
                      ),
                      isLoading
                          ? DotsLoader()
                          : wantProducts2.isEmpty
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 60,
                                          right: 60,
                                          bottom: 12,
                                          top: 20),
                                      child: Image.asset(
                                          'assets/images/Asset 1product 1.png'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                      child: SizedBox(
                                        height: 50.h,
                                        width: 1.sw,
                                        child: YellowButtonWithIcon(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  ColorSelect.colorF7E641),
                                          textStyleColor:
                                              ColorSelect.color292929,
                                          onTap: () {
                                            showModalBottomSheet(
                                                backgroundColor:
                                                    Colors.transparent,
                                                context: context,
                                                isScrollControlled: true,
                                                builder: (context) {
                                                  return ManuallyAddBottomSheetWidget(
                                                    productType: 'want',
                                                    //*model: widget.model,*//*);
                                                  );
                                                });
                                          },
                                          title: "Add Product",
                                          buttonIcon: "assets/images/plus.png",
                                        ),
                                      ),
                                    ),
                                    // )
                                  ],
                                )
                              : Container(
                                  height: 220,
                                  width: 1.sw,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: wantProducts2.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, i) {
                                        return Container(
                                          color: Colors.transparent,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 16),
                                              Expanded(
                                                flex: 4,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ProductDetail(
                                                                  name: wantProducts2[
                                                                          i]
                                                                      .name
                                                                      .toString(),
                                                                  price:
                                                                      '\$${wantProducts2[i].price.toString()}',
                                                                  link: wantProducts2[
                                                                          i]
                                                                      .link
                                                                      .toString(),
                                                                  image: wantProducts2[
                                                                              i]
                                                                          .photo
                                                                          .toString()
                                                                          .contains(
                                                                              "https")
                                                                      ? wantProducts2[
                                                                              i]
                                                                          .photo
                                                                          .toString()
                                                                      : baseUrl +
                                                                          wantProducts2[i]
                                                                              .photo
                                                                              .toString(),
                                                                  purchaseDate:
                                                                      wantProducts2[
                                                                              i]
                                                                          .purchasedDate
                                                                          .toString(),
                                                                  id: wantProducts2[
                                                                          i]
                                                                      .id
                                                                      .toString(),
                                                                  type: wantProducts2[
                                                                          i]
                                                                      .type
                                                                      .toString(),
                                                                )));
                                                    // Navigator.push(
                                                    //   context,
                                                    //   MaterialPageRoute(
                                                    //     builder: (context) => WantProducts(
                                                    //       isUser: true,
                                                    //     ),
                                                    //   ),
                                                    // );
                                                  },
                                                  child: Container(
                                                    width: 173,
                                                    height: 129,
                                                    margin: EdgeInsets.only(
                                                        left: 16),
                                                    clipBehavior: Clip.hardEdge,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: ColorSelect
                                                                .colorE0E0E0,
                                                            width: 1),
                                                        color: ColorSelect
                                                            .colorFFFFFF,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    child: CachedNetworkImage(
                                                      imageUrl: wantProducts2[i]
                                                              .photo
                                                              .toString()
                                                              .contains("https")
                                                          ? wantProducts2[i]
                                                              .photo
                                                              .toString()
                                                          : baseUrl +
                                                              wantProducts2[i]
                                                                  .photo
                                                                  .toString(),
                                                      fit: BoxFit.cover,
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(
                                                        Icons.error,
                                                        size: 40,
                                                      ),
                                                      progressIndicatorBuilder:
                                                          (a, b, c) => Opacity(
                                                        opacity: 0.3,
                                                        child:
                                                            Shimmer.fromColors(
                                                          baseColor:
                                                              Colors.black12,
                                                          highlightColor:
                                                              Colors.white,
                                                          child: Container(
                                                            width: 173,
                                                            height: 129,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: ColorSelect
                                                                        .colorE0E0E0,
                                                                    width: 1),
                                                                color: ColorSelect
                                                                    .colorFFFFFF,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 12),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16),
                                                  child: SizedBox(
                                                    width: 173,
                                                    child: Text(
                                                      wantProducts2[i]
                                                          .name
                                                          .toString(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: AppTextStyle()
                                                          .textColor29292912w400,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16),
                                                  child: Text(
                                                    'USD ${wantProducts2[i].price.toString()}',
                                                    style: AppTextStyle()
                                                        .textColor29292914w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ) /*:isLoading ? Center(
        child: LoadingAnimationWidget.waveDots(
          size: 70,
          color: ColorSelect.colorF7E641,
        ),
      ): Text("flmv")*/
                                  ),
                      SizedBox(
                        height: 68,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(children: [
                          Text(
                            "I don’t want",
                            style: AppTextStyle().textColor29292924w700,
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Productdontwant(
                                    isUser: true,
                                    // model:widget.model ,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              "View all",
                              style: AppTextStyle().textColor29292914w500,
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return ManuallyAddBottomSheetWidget(
                                      productType:
                                          'dont_want', /*model: widget.model,*/
                                    );
                                  });
                            },
                            child: Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                  color: ColorSelect.colorF7E641,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(child: Icon(Icons.add)),
                            ),
                          ),
                        ]),
                      ),
                      isLoading
                          ? DotsLoader()
                          : notWant2.isEmpty
                              ? AddProductError(
                                  image: 'assets/images/addproducts2.png',
                                  tap: () {
                                    showModalBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (context) {
                                          return ManuallyAddBottomSheetWidget(
                                            productType:
                                                'dont_want', /*model: widget.model,*/
                                          );
                                        });
                                  },
                                )
                              : SizedBox(
                                  height: 220,
                                  width: 1.sw,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: notWant2.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, i) {
                                        return Container(
                                          color: Colors.transparent,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 16),
                                              Expanded(
                                                flex: 4,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ProductDetail(
                                                                  name: notWant2[
                                                                          i]
                                                                      .name
                                                                      .toString(),
                                                                  price:
                                                                      '\$${notWant2[i].price.toString()}',
                                                                  link: notWant2[
                                                                          i]
                                                                      .link
                                                                      .toString(),
                                                                  image: notWant2[
                                                                              i]
                                                                          .photo
                                                                          .toString()
                                                                          .contains(
                                                                              "https")
                                                                      ? notWant2[
                                                                              i]
                                                                          .photo
                                                                          .toString()
                                                                      : baseUrl +
                                                                          notWant2[i]
                                                                              .photo
                                                                              .toString(),
                                                                  purchaseDate:
                                                                      notWant2[
                                                                              i]
                                                                          .purchasedDate
                                                                          .toString(),
                                                                  id: notWant2[
                                                                          i]
                                                                      .id
                                                                      .toString(),
                                                                  type: notWant2[
                                                                          i]
                                                                      .type
                                                                      .toString(),
                                                                )));
                                                  },
                                                  child: Container(
                                                    width: 173,
                                                    height: 129,
                                                    margin: EdgeInsets.only(
                                                        left: 16),
                                                    clipBehavior: Clip.hardEdge,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: ColorSelect
                                                                .colorE0E0E0,
                                                            width: 1),
                                                        color: ColorSelect
                                                            .colorFFFFFF,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    child: CachedNetworkImage(
                                                      imageUrl: notWant2[i]
                                                              .photo
                                                              .toString()
                                                              .contains("https")
                                                          ? notWant2[i]
                                                              .photo
                                                              .toString()
                                                          : baseUrl +
                                                              notWant2[i]
                                                                  .photo
                                                                  .toString(),
                                                      fit: BoxFit.cover,
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(
                                                        Icons.error,
                                                        size: 40,
                                                      ),
                                                      progressIndicatorBuilder:
                                                          (a, b, c) => Opacity(
                                                        opacity: 0.3,
                                                        child:
                                                            Shimmer.fromColors(
                                                          baseColor:
                                                              Colors.black12,
                                                          highlightColor:
                                                              Colors.white,
                                                          child: Container(
                                                            width: 173,
                                                            height: 129,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: ColorSelect
                                                                        .colorE0E0E0,
                                                                    width: 1),
                                                                color: ColorSelect
                                                                    .colorFFFFFF,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 12),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16),
                                                  child: SizedBox(
                                                    width: 173,
                                                    child: Text(
                                                      notWant2[i]
                                                          .name
                                                          .toString(),
                                                      // widget.itemNameList[i],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2,
                                                      style: AppTextStyle()
                                                          .textColor29292912w400,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16),
                                                  child: Text(
                                                    'USD ${notWant2[i].price.toString()}',
                                                    // widget.itemPrice[i],
                                                    style: AppTextStyle()
                                                        .textColor29292914w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                  /*:isLoading ? Center(
          child: LoadingAnimationWidget.waveDots(
          size: 70,
           color: ColorSelect.colorF7E641,
          ),
    )*/
                                  ),
                      SizedBox(
                        height: 68,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Text(
                              "I already have",
                              style: AppTextStyle().textColor29292924w700,
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProductAlready()));
                              },
                              child: Text(
                                "View all",
                                style: AppTextStyle().textColor29292914w500,
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return ManuallyAlreadyAddBottomSheetWidget(
                                        productType: 'have',
                                      );
                                    });
                              },
                              child: Container(
                                height: 36,
                                width: 36,
                                decoration: BoxDecoration(
                                    color: ColorSelect.colorF7E641,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Center(child: Icon(Icons.add)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      isLoading
                          ? DotsLoader()
                          : haveProducts2.isEmpty
                              ? AddProductError(
                                  image: 'assets/images/addproduct3.png',
                                  tap: () {
                                    showModalBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (context) {
                                          return ManuallyAddBottomSheetWidget(
                                            productType:
                                                'have', /*model: widget.model,*/
                                          );
                                        });
                                  },
                                )
                              : SizedBox(
                                  height: 220,
                                  width: 1.sw,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: haveProducts2.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, i) {
                                        return Container(
                                          color: Colors.transparent,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 16),
                                              Expanded(
                                                flex: 4,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ProductDetail(
                                                                  name: haveProducts2[
                                                                          i]
                                                                      .name
                                                                      .toString(),
                                                                  price:
                                                                      '\$${haveProducts2[i].price.toString()}',
                                                                  link: haveProducts2[
                                                                          i]
                                                                      .link
                                                                      .toString(),
                                                                  image: haveProducts2[
                                                                              i]
                                                                          .photo
                                                                          .toString()
                                                                          .contains(
                                                                              "https")
                                                                      ? haveProducts2[
                                                                              i]
                                                                          .photo
                                                                          .toString()
                                                                      : baseUrl +
                                                                          haveProducts2[i]
                                                                              .photo
                                                                              .toString(),
                                                                  purchaseDate:
                                                                      haveProducts2[
                                                                              i]
                                                                          .purchasedDate
                                                                          .toString(),
                                                                  id: haveProducts2[
                                                                          i]
                                                                      .id
                                                                      .toString(),
                                                                  type: haveProducts2[
                                                                          i]
                                                                      .type
                                                                      .toString(),
                                                                )));
                                                  },
                                                  child: Container(
                                                    width: 173,
                                                    height: 129,
                                                    margin: EdgeInsets.only(
                                                        left: 16),
                                                    clipBehavior: Clip.hardEdge,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: ColorSelect
                                                                .colorE0E0E0,
                                                            width: 1),
                                                        color: ColorSelect
                                                            .colorFFFFFF,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    child: CachedNetworkImage(
                                                      imageUrl: haveProducts2[i]
                                                              .photo
                                                              .toString()
                                                              .contains("https")
                                                          ? haveProducts2[i]
                                                              .photo
                                                              .toString()
                                                          : baseUrl +
                                                              haveProducts2[i]
                                                                  .photo
                                                                  .toString(),
                                                      fit: BoxFit.cover,
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(
                                                        Icons.error,
                                                        size: 40,
                                                      ),
                                                      progressIndicatorBuilder:
                                                          (a, b, c) => Opacity(
                                                        opacity: 0.3,
                                                        child:
                                                            Shimmer.fromColors(
                                                          baseColor:
                                                              Colors.black12,
                                                          highlightColor:
                                                              Colors.white,
                                                          child: Container(
                                                            width: 173,
                                                            height: 129,
                                                            decoration: BoxDecoration(
                                                                border: Border.all(
                                                                    color: ColorSelect
                                                                        .colorE0E0E0,
                                                                    width: 1),
                                                                color: ColorSelect
                                                                    .colorFFFFFF,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12)),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 12),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16),
                                                  child: SizedBox(
                                                    width: 173,
                                                    child: Text(
                                                      haveProducts2[i]
                                                          .name
                                                          .toString(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 3,
                                                      style: AppTextStyle()
                                                          .textColor29292912w400,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16),
                                                  child: Text(
                                                    'USD ${haveProducts2[i].price.toString()}',
                                                    style: AppTextStyle()
                                                        .textColor29292914w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ), /*:isLoading ? Center(
       child: LoadingAnimationWidget.waveDots(
        size: 70,
        color: ColorSelect.colorF7E641),
       ): Text("flmv"*/
                                ),
                      SizedBox(height: 132)
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

//
class AlreadyProductListWidget extends StatefulWidget {
  const AlreadyProductListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AlreadyProductListWidget> createState() =>
      _AlreadyProductListWidgetState();
}

class _AlreadyProductListWidgetState extends State<AlreadyProductListWidget> {
  @override
  void initState() {
    getHaveProducts();
    super.initState();
  }

  bool isLoading = false;
  GetProductModel? getProducts;
  List<ProductTypeModel> haveProducts = [];
  List<ProductTypeModel> haveProducts2 = [];

  getHaveProducts() {
    isLoading = true;
    var resp = getProductsApi();
    resp.then((value) {
      if (value['status'] == true) {
        setState(() {});
        setState(() {
          for (var v in value["data"]) {
            haveProducts.add(ProductTypeModel.fromJson(v));
          }
          for (var v in haveProducts) {
            if (v.type! == "have") {
              haveProducts2.add(v);
              setState(() {});
            }
          }
          isLoading = false;
        });
      } else {
        isLoading = false;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? DotsLoader()
        : haveProducts2.isEmpty
            ? AddProductError(
                image: 'assets/images/addproduct3.png',
                tap: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return ManuallyAlreadyAddBottomSheetWidget(
                          productType: 'have', /*model: widget.model,*/
                        );
                      });
                },
              )
            : SizedBox(
                height: 220,
                width: 1.sw,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: haveProducts2.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return Container(
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16),
                            Expanded(
                              flex: 4,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductDetail(
                                                name: haveProducts2[i]
                                                    .name
                                                    .toString(),
                                                price:
                                                    '\$${haveProducts2[i].price.toString()}',
                                                link: haveProducts2[i]
                                                    .link
                                                    .toString(),
                                                image: haveProducts2[i]
                                                        .photo
                                                        .toString()
                                                        .contains("https")
                                                    ? haveProducts2[i]
                                                        .photo
                                                        .toString()
                                                    : baseUrl +
                                                        haveProducts2[i]
                                                            .photo
                                                            .toString(),
                                                purchaseDate: haveProducts2[i]
                                                    .purchasedDate
                                                    .toString(),
                                                id: haveProducts2[i]
                                                    .id
                                                    .toString(),
                                                type: haveProducts2[i]
                                                    .type
                                                    .toString(),
                                              )));
                                },
                                child: Container(
                                  width: 173,
                                  height: 129,
                                  margin: EdgeInsets.only(left: 16),
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: ColorSelect.colorE0E0E0,
                                          width: 1),
                                      color: ColorSelect.colorFFFFFF,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: CachedNetworkImage(
                                    imageUrl: haveProducts2[i]
                                            .photo
                                            .toString()
                                            .contains("https")
                                        ? haveProducts2[i].photo.toString()
                                        : baseUrl +
                                            haveProducts2[i].photo.toString(),
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
                                          width: 173,
                                          height: 129,
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
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 12),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: SizedBox(
                                  width: 173,
                                  child: Text(
                                    haveProducts2[i].name.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: AppTextStyle().textColor29292912w400,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  'USD ${haveProducts2[i].price.toString()}',
                                  style: AppTextStyle().textColor29292914w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ), /*:isLoading ? Center(
       child: LoadingAnimationWidget.waveDots(
        size: 70,
        color: ColorSelect.colorF7E641),
       ): Text("flmv"*/
              );
  }
}

class IWantProductListWidget extends StatefulWidget {
  final GlobalKey second;
  IWantProductListWidget({Key? key, required this.second})
      : super(
          key: key,
        );

  @override
  State<IWantProductListWidget> createState() => _IWantProductListWidgetState();
}

class _IWantProductListWidgetState extends State<IWantProductListWidget> {
  @override
  void initState() {
    getWantProducts();
    super.initState();
  }

  bool isLoading = false;
  GetProductModel? getProducts;
  List<ProductTypeModel> wantProducts = [];
  List<ProductTypeModel> wantProducts2 = [];

  getWantProducts() {
    isLoading = true;
    var resp = getProductsApi();
    resp.then((value) {
      if (value['status'] == true) {
        setState(() {
          for (var v in value['data']) {
            wantProducts.add(ProductTypeModel.fromJson(v));
          }
          for (var v in wantProducts) {
            if (v.type! == "want") {
              wantProducts2.add(v);
              wantProducts2.removeWhere((element) => element.id == v);
            }
          }
          isLoading = false;
        });
      } else {
        isLoading = false;
        // wantProducts2.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? DotsLoader()
        : wantProducts2.isEmpty
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 60, right: 60, bottom: 12, top: 20),
                    child: Image.asset('assets/images/Asset 1product 1.png'),
                  ),
                  Showcase(
                    key: widget.second,
                    description: "this is for add products manually",
                    child:
                        // Positioned(
                        //   top: 800,
                        //   bottom: 50,
                        //   child:
                        Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: SizedBox(
                        height: 50.h,
                        width: 1.sw,
                        child: YellowButtonWithIcon(
                          backgroundColor: MaterialStateProperty.all(
                              ColorSelect.colorF7E641),
                          textStyleColor: ColorSelect.color292929,
                          onTap: () {
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return ManuallyAddBottomSheetWidget(
                                    productType: 'want',
                                    //*model: widget.model,*//*);
                                  );
                                });
                          },
                          title: "Add Product",
                          buttonIcon: "assets/images/plus.png",
                        ),
                      ),
                    ),
                  ),
                  // )
                ],
              )
            : Container(
                height: 220,
                width: 1.sw,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: wantProducts2.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return Container(
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16),
                            Expanded(
                              flex: 4,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductDetail(
                                                name: wantProducts2[i]
                                                    .name
                                                    .toString(),
                                                price:
                                                    '\$${wantProducts2[i].price.toString()}',
                                                link: wantProducts2[i]
                                                    .link
                                                    .toString(),
                                                image: wantProducts2[i]
                                                        .photo
                                                        .toString()
                                                        .contains("https")
                                                    ? wantProducts2[i]
                                                        .photo
                                                        .toString()
                                                    : baseUrl +
                                                        wantProducts2[i]
                                                            .photo
                                                            .toString(),
                                                purchaseDate: wantProducts2[i]
                                                    .purchasedDate
                                                    .toString(),
                                                id: wantProducts2[i]
                                                    .id
                                                    .toString(),
                                                type: wantProducts2[i]
                                                    .type
                                                    .toString(),
                                              )));
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => WantProducts(
                                  //       isUser: true,
                                  //     ),
                                  //   ),
                                  // );
                                },
                                child: Container(
                                  width: 173,
                                  height: 129,
                                  margin: EdgeInsets.only(left: 16),
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: ColorSelect.colorE0E0E0,
                                          width: 1),
                                      color: ColorSelect.colorFFFFFF,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: CachedNetworkImage(
                                    imageUrl: wantProducts2[i]
                                            .photo
                                            .toString()
                                            .contains("https")
                                        ? wantProducts2[i].photo.toString()
                                        : baseUrl +
                                            wantProducts2[i].photo.toString(),
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
                                          width: 173,
                                          height: 129,
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
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 12),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: SizedBox(
                                  width: 173,
                                  child: Text(
                                    wantProducts2[i].name.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: AppTextStyle().textColor29292912w400,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  'USD ${wantProducts2[i].price.toString()}',
                                  style: AppTextStyle().textColor29292914w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ) /*:isLoading ? Center(
        child: LoadingAnimationWidget.waveDots(
          size: 70,
          color: ColorSelect.colorF7E641,
        ),
      ): Text("flmv")*/
                );
  }
}

class NotWantProductListWidget extends StatefulWidget {
  const NotWantProductListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<NotWantProductListWidget> createState() =>
      _NotWantProductListWidgetState();
}

class _NotWantProductListWidgetState extends State<NotWantProductListWidget> {
  @override
  void initState() {
    getNotWant();
    super.initState();
  }

  bool isLoading = false;
  GetProductModel? getProducts;
  List<ProductTypeModel> notWant = [];
  List<ProductTypeModel> notWant2 = [];
  getNotWant() {
    isLoading = true;
    var resp = getProductsApi();
    resp.then((value) {
      if (value['status'] == true) {
        setState(() {
          for (var v in value["data"]) {
            notWant.add(ProductTypeModel.fromJson(v));
          }
          for (var v in notWant) {
            if (v.type! == "dont_want") {
              notWant2.add(v);
            }
          }
          isLoading = false;
          // notWant2.clear();
        });
      } else {
        isLoading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? DotsLoader()
        : notWant2.isEmpty
            ? AddProductError(
                image: 'assets/images/addproducts2.png',
                tap: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return ManuallyAddBottomSheetWidget(
                          productType: 'dont_want', /*model: widget.model,*/
                        );
                      });
                },
              )
            : SizedBox(
                height: 220,
                width: 1.sw,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: notWant2.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return Container(
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 16),
                            Expanded(
                              flex: 4,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductDetail(
                                                name:
                                                    notWant2[i].name.toString(),
                                                price:
                                                    '\$${notWant2[i].price.toString()}',
                                                link:
                                                    notWant2[i].link.toString(),
                                                image: notWant2[i]
                                                        .photo
                                                        .toString()
                                                        .contains("https")
                                                    ? notWant2[i]
                                                        .photo
                                                        .toString()
                                                    : baseUrl +
                                                        notWant2[i]
                                                            .photo
                                                            .toString(),
                                                purchaseDate: notWant2[i]
                                                    .purchasedDate
                                                    .toString(),
                                                id: notWant2[i].id.toString(),
                                                type:
                                                    notWant2[i].type.toString(),
                                              )));
                                },
                                child: Container(
                                  width: 173,
                                  height: 129,
                                  margin: EdgeInsets.only(left: 16),
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: ColorSelect.colorE0E0E0,
                                          width: 1),
                                      color: ColorSelect.colorFFFFFF,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: CachedNetworkImage(
                                    imageUrl: notWant2[i]
                                            .photo
                                            .toString()
                                            .contains("https")
                                        ? notWant2[i].photo.toString()
                                        : baseUrl +
                                            notWant2[i].photo.toString(),
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
                                          width: 173,
                                          height: 129,
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
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 12),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: SizedBox(
                                  width: 173,
                                  child: Text(
                                    notWant2[i].name.toString(),
                                    // widget.itemNameList[i],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: AppTextStyle().textColor29292912w400,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: Text(
                                  'USD ${notWant2[i].price.toString()}',
                                  // widget.itemPrice[i],
                                  style: AppTextStyle().textColor29292914w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
                /*:isLoading ? Center(
          child: LoadingAnimationWidget.waveDots(
          size: 70,
           color: ColorSelect.colorF7E641,
          ),
    )*/
                );
  }
}
