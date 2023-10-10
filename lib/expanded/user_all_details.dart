import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/dashboard/reset_password/reset_password.dart';
import 'package:swishlist/expanded/widgets/Profile_data_and_all_uesr_data.dart';
import 'package:swishlist/profile_page/account.dart';
import 'package:swishlist/profile_page/date_and_events.dart';
import 'package:swishlist/profile_page/favorites.dart';
import 'package:swishlist/profile_page/my_interests.dart';
import 'package:swishlist/profile_page/pets.dart';
import 'package:swishlist/profile_page/profile.dart';
import 'package:swishlist/profile_page/widgets/popup_menu_widget.dart';

import '../api/user_apis/favourites_api.dart';
import '../api/user_apis/interest_api.dart';
import '../api/user_apis/profile_apis.dart';
import '../api/user_apis/sizes_and_weight_api.dart';
import '../constants/globals/shared_prefs.dart';
import '../constants/urls.dart';
import '../login/login.dart';
import '../models/favourites_model.dart';
import '../models/interest_model.dart';
import '../models/login_models.dart';
import '../models/profile_model.dart';
import '../models/sizes_and_weight_model.dart';
import '../profile_page/sizes_and_weights.dart';

class UserAllDetails extends StatefulWidget {
  final LoginResponse response;
  const UserAllDetails({
    Key? key,
    required this.response,
  }) : super(key: key);

  @override
  State<UserAllDetails> createState() => _UserAllDetailsState();
}

class _UserAllDetailsState extends State<UserAllDetails> {
  @override
  void initState() {
    getInterest();
    getSizedWeight();
    getFavourites();
    getProfile();
    super.initState();
  }

  List<String>? elements = [''];
  bool isLoading = false;
  InterestModel _interest = InterestModel(data: Data(interest: ''));
  // InterestModel? _interest;
  getInterest() {
    isLoading = true;
    var resp = getInterestApi();
    resp.then((value) {
      if (value['status'] == true) {
        setState(() {
          _interest = InterestModel.fromJson(value);
          elements = _interest.data!.interest!.split(",");
          isLoading = false;
        });
      } else {
        isLoading = false;
      }
    });
  }

  Future<void> _handleRefresh() async {
    getInterest();
    getSizedWeight();
    getFavourites();
    getProfile();

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

  double dou = 00;
  var sizePercent = "";
  List<String> per = [];

  // _sharedPrefs() {
  //   if (SharedPrefs().getSetSize() == '100 %') {
  //     per.add('profile');
  //     sizePercent = ((per.length / 1) * 100).toString().split(".").first;
  //     dou = (per.length / 1);
  //   }
  // }''

  String? completePercent;
  double parsedPercent = 0.0;
  double normalizedPercent = 0.0;

  SizesAndWeightModel? sizeWeight = SizesAndWeightModel(
      data: SizeData(
    waist: '',
    shirt: '',
    shoes: '',
    bed: '',
  ));
  getSizedWeight() {
    isLoading = true;
    var resp = getSizeAndWeightApi();
    resp.then((value) {
      print(value);
      if (mounted) {
        if (value['status'] == true) {
          if (value['message'] == 'No Size Weight') {
            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {
              sizeWeight = SizesAndWeightModel.fromJson(value);
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

  //---------------------------_Favourite_______________________________

  String? FavcompletePercent;
  double FavparsedPercent = 0.0;
  double FavnormalizedPercent = 0.0;

  // _sharedPrefs() {
  //   if (SharedPrefs().getFavourites() == '100 %') {
  //     per.add('profile');
  //     favPercent = ((per.length / 1) * 100).toString().split(".").first;
  //     dou = (per.length / 1);
  //   }
  // }

  FavouritesModel? favourites = FavouritesModel(
      data: FavouriteData(
    // id: '',
    // userId: '',
    cars: '',
    bikes: '',
    movies: '',
    shows: '',
    foods: '',
    gadgets: '',
    superheroes: '',
    actors: '',
    actresses: '',
    singers: '',
    players: '',
    cities: '',
    countries: '',
    restaurants: '',
    hotels: '',
    privacyStatus: '',
    createdAt: '',
  ));
  getFavourites() {
    isLoading = true;
    var resp = getFavouritesApi();
    resp.then((value) {
      print(value);
      if (mounted) {
        if (value['status'] == true) {
          if (value['message'] == "No Favourites") {
            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {
              favourites = FavouritesModel.fromJson(value);
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
  //------------------------Profile Model -=--------------------------//

  String? proCompletePercent;
  double proParsedPercent = 0.0;
  double proNormalizedPercent = 0.0;

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
          name: '',
          username: '',
          email: '',
          phone: '',
          type: '',
          photo: '${SharedPrefs().getUserPhoto()}'),
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

  @override
  Widget build(BuildContext context) {
    completePercent = sizeWeight?.data?.completePercent;
    parsedPercent = double.tryParse(completePercent ?? '0') ?? 0.0;
    normalizedPercent = parsedPercent / 100.0;

    FavcompletePercent = favourites?.data?.completePercent;
    FavparsedPercent = double.tryParse(FavcompletePercent ?? '0') ?? 0.0;
    FavnormalizedPercent = FavparsedPercent / 100.0;

    proCompletePercent = profile?.data?.completePercent;
    proParsedPercent = double.tryParse(proCompletePercent ?? '0') ?? 0.0;
    proNormalizedPercent = proParsedPercent / 100.0;

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: false,
            title: Text(
              "Account",
              // '${SharedPrefs().getName()}',
              // '${SharedPrefs().getUsername()}' == "null" ?
              // "Please Add Your Username" :
              // '${SharedPrefs().getUsername()}',
              // "MichieMaster34",
              style: AppTextStyle().textColor29292916w500,
            ),
            leadingWidth: 40,
            leading: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => MemberSettings(
                  //               response: widget.response,
                  //             )));
                },
                child: SvgPicture.asset(
                  "assets/icons/arrowback.svg",
                ),
              ),
            ),
            actions: [
              Popupmen(menuList: [
                PopupMenuItem(
                  child: ListTile(
                    title: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Account()));
                      },
                      child: Text(
                        'Delete Account',
                        style: AppTextStyle().textColor39393914w500,
                      ),
                    ),
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    title: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResetPassword()));
                      },
                      child: Text(
                        'Change Password',
                        style: AppTextStyle().textColor39393914w500,
                      ),
                    ),
                  ),
                ),
                // PopupMenuItem(
                //   child: ListTile(
                //     title: InkWell(
                //       onTap: () {
                //         Navigator.push(context,
                //             MaterialPageRoute(builder: (context) => Privacy()));
                //       },
                //       child: Text(
                //         'Privacy',
                //         style: AppTextStyle().textColor39393914w500,
                //       ),
                //     ),
                //   ),
                // ),
                PopupMenuItem(
                  child: GestureDetector(
                    onTap: () {
                      SharedPrefs().setLoginFalse();
                      // SharedPrefs().setAppleLoginFalse();
                      // SharedPrefs().setGoogleLoginFalse();

                      // SharedPrefs().clearPrefs();
                      // logoutApi().then((value) {
                      //   if(value['status'] == true) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Login(),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Text(
                        'Log out',
                        style: AppTextStyle().textColor39393914w500,
                      ),
                    ),
                  ),
                ),
              ], icon: SvgPicture.asset('assets/icons/more-vertical.svg'))
            ],
          ),
          body: /* isLoading ? Loading():*/
              RefreshIndicator(
            backgroundColor: Colors.white,
            color: ColorSelect.colorF7E641,
            strokeWidth: 3,
            onRefresh: _handleRefresh,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // UserImageRowWidget(
                    //   response: widget.response,
                    // ),
                    Row(
                      children: [
                        Stack(
                          children: [
                            // CircularPercentIndicator(
                            //   circularStrokeCap: CircularStrokeCap.round,
                            //   radius: 40.0,
                            //   lineWidth: 5.0,
                            //   percent: dou,
                            //   backgroundColor: ColorSelect.colorEDEDF1,
                            //   progressColor: Colors.black,
                            //   center:
                            Container(
                              height: 40,
                              width: 40,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: CachedNetworkImage(
                                /* imageUrl: baseUrl+widget.response.data.photo.toString(),*/
                                imageUrl:
                                    // '${SharedPrefs().getUserPhoto()}'.isEmpty
                                    //     ? widget.response.data.photo.toString()
                                    //     : '${SharedPrefs().getUserPhoto()}',
                                    profile!.data!.user!.photo
                                            .toString()
                                            .contains("https")
                                        ? profile!.data!.user!.photo.toString()
                                        : baseUrl +
                                            profile!.data!.user!.photo
                                                .toString(),
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    Image.asset("assets/icons/userico.jpg"),
                                progressIndicatorBuilder: (a, b, c) => Opacity(
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
                            // center: Image.asset('assets/images/Rectangle1072.png'),
                            // ),
                          ],
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                profile!.data!.name.toString() == "" ||
                                        profile!.data!.name == null
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
                                        profile!.data!.name.toString(),

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
                              ],
                            ),
                            SizedBox(height: 10.h),
                            isLoading
                                ? LoadingAnimationWidget.staggeredDotsWave(
                                    size: 30,
                                    color: ColorSelect.colorF7E641,
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      print(profile!.data!.completePercent
                                          .toString());
                                    },
                                    child: Container(
                                      // height: 30,
                                      // width: 120.w,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: ColorSelect.colorF8F1AA,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(80))),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              profile!.data!.completePercent
                                                              .toString() ==
                                                          "" ||
                                                      profile!.data!
                                                              .completePercent ==
                                                          null
                                                  ? "0"
                                                  : profile!
                                                      .data!.completePercent
                                                      .toString()
                                                      .split(".")
                                                      .first,
                                              // sizeWeight!.data!.completePercent
                                              //     .toString()
                                              //     .split(".")
                                              //     .first,
                                              style: AppTextStyle()
                                                  .textColor70707012w400,
                                            ),
                                            Text(
                                              "%  Percent",
                                              style: AppTextStyle()
                                                  .textColor70707012w400,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyInterests(
                                      response: widget.response,
                                      // id: _interest!.data!.id.toString(),
                                    )));
                        // print(_interest!.data!.id);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Text(
                              "My Interests",
                              style: AppTextStyle().textColor29292914w600,
                            ),
                            Spacer(),
                            Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: SvgPicture.asset(
                                    "assets/icons/Vectoredit.svg")),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    //InterestRow1Widget(),
                    // Builder(
                    //   builder: (BuildContext context) {
                    //     return  Wrap(
                    //           children: interest!.data!.interest!.map((context) => chipBox(name:context)).toList(),
                    //         );
                    // //   },
                    // // ),
                    // _interest!.data!.interest!.isEmpty ?
                    // Text('hi'):
                    isLoading == true
                        ?

                        // SizedBox()
                        Text(
                            "Add Your Interest",
                            style: AppTextStyle().textColor29292914w400,
                          )
                        : Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: Wrap(
                              children: elements!
                                  .map((e) => chipBox(name: e))
                                  .toList(),
                            ),
                          ),
                    // SizedBox(height: 10.h,),
                    // InterestRow2Widget(),
                    // SizedBox(height: 10.h,),
                    // InterestRow3Widget(),
                    SizedBox(
                      height: 30.h,
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserProfile()));
                      },
                      child: Row(
                        children: [
                          CircularPercentIndicator(
                            circularStrokeCap: CircularStrokeCap.round,
                            radius: 40.w,
                            lineWidth: 2.w,
                            percent: proNormalizedPercent,
                            // percent: .12,
                            backgroundColor:
                                Color(0xff66D340).withOpacity(0.28),
                            center: Image.asset('assets/images/userimg.png'),
                            progressColor: ColorSelect.color66D340,
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Profile",
                                style: AppTextStyle().textColor29292914w400,
                              ),
                              isLoading
                                  ? SizedBox()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          profile!.data!.completePercent
                                                          .toString() ==
                                                      "" ||
                                                  profile!.data!
                                                          .completePercent ==
                                                      null
                                              ? "0"
                                              : profile!.data!.completePercent
                                                  .toString()
                                                  .split(".")
                                                  .first,
                                          // sizeWeight!.data!.completePercent
                                          //     .toString()
                                          //     .split(".")
                                          //     .first,
                                          style: AppTextStyle()
                                              .textColor70707012w400,
                                        ),
                                        Text(
                                          "%  Percent",
                                          style: AppTextStyle()
                                              .textColor70707012w400,
                                        )
                                      ],
                                    ),
                            ],
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 27),
                            child: SvgPicture.asset(
                                "assets/icons/forwordarrow.svg"),
                          )
                        ],
                      ),
                      // child: ProfileRowWidget(),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => SizeAndWeights(
                                        response: widget.response,
                                      )));
                        },
                        child: Row(
                          children: [
                            CircularPercentIndicator(
                              circularStrokeCap: CircularStrokeCap.round,
                              radius: 40.w,
                              lineWidth: 2.w,
                              percent: normalizedPercent,
                              backgroundColor:
                                  Color(0xff576ACC).withOpacity(0.28),
                              center: Image.asset('assets/images/zoomin.png'),
                              progressColor: ColorSelect.color576ACC,
                            ),
                            SizedBox(width: 10.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Sizes and weights",
                                  style: AppTextStyle().textColor29292914w400,
                                ),
                                isLoading
                                    ? SizedBox()
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            sizeWeight!.data!.completePercent
                                                            .toString() ==
                                                        "" ||
                                                    sizeWeight!.data!
                                                            .completePercent ==
                                                        null
                                                ? "0"
                                                : sizeWeight!
                                                    .data!.completePercent
                                                    .toString()
                                                    .split(".")
                                                    .first,
                                            // sizeWeight!.data!.completePercent
                                            //     .toString()
                                            //     .split(".")
                                            //     .first,
                                            style: AppTextStyle()
                                                .textColor70707012w400,
                                          ),
                                          Text(
                                            "%  Percent",
                                            style: AppTextStyle()
                                                .textColor70707012w400,
                                          )
                                        ],
                                      ),
                              ],
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 27),
                              child: SvgPicture.asset(
                                  "assets/icons/forwordarrow.svg"),
                            )
                          ],
                        )),
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Favorites()));
                      },
                      child: Row(
                        children: [
                          CircularPercentIndicator(
                            circularStrokeCap: CircularStrokeCap.round,
                            radius: 40.w,
                            lineWidth: 2.w,
                            percent: FavnormalizedPercent,
                            backgroundColor:
                                Color(0xffD55745).withOpacity(0.28),
                            center: Image.asset('assets/images/Subtract.png'),
                            progressColor: ColorSelect.colorD55745,
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Favourites",
                                style: AppTextStyle().textColor29292914w400,
                              ),
                              isLoading
                                  ? SizedBox()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          favourites!.data!.completePercent
                                                          .toString() ==
                                                      "" ||
                                                  favourites!.data!
                                                          .completePercent ==
                                                      null
                                              ? "0"
                                              : favourites!
                                                  .data!.completePercent
                                                  .toString()
                                                  .split(".")
                                                  .first,
                                          // sizeWeight!.data!.completePercent
                                          //     .toString()
                                          //     .split(".")
                                          //     .first,
                                          style: AppTextStyle()
                                              .textColor70707012w400,
                                        ),
                                        Text(
                                          "%  Percent",
                                          style: AppTextStyle()
                                              .textColor70707012w400,
                                        )
                                      ],
                                    ),
                            ],
                          ),
                          Spacer(),
                          Padding(
                              padding: const EdgeInsets.only(right: 27),
                              child: SvgPicture.asset(
                                  "assets/icons/forwordarrow.svg"))
                        ],
                      ),
                      // child: FavoritesRowWidget(),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Pets(),
                            ));
                      },
                      child: PetsRowWidget(),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DateAndEvents()));
                      },
                      child: DateAndEventsRowWidget(),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        // if (isLoading) Loading(),
      ],
    );
  }

  Container chipBox({required String name}) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(48),
          ),
          color: ColorSelect.colorCBE0FA),
      padding: EdgeInsets.all(10),
      child: Text(
        name,
        style: AppTextStyle().textColor29292914w400,
      ),
    );
  }
}
