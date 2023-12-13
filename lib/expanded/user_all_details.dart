import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/api/user_apis/complete_percent_api.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/dashboard/reset_password/reset_password.dart';
import 'package:swishlist/expanded/widgets/Profile_data_and_all_uesr_data.dart';
import 'package:swishlist/models/complete_percent_model.dart';
import 'package:swishlist/new_screens/tabs_screen/address.dart';
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

    print(interest);
    super.initState();
  }

  List<CompletePercentModel> percent = [];
  getCompletePercent() {
    isLoading = true;
    var resp = getCompletePercentApi();
    resp.then((value) {
      setState(() {
        percent.add(CompletePercentModel.fromJson(value));
        isLoading = false;
      });
    });
  }


  bool isLoading = false;

  List<InterestModel> interest = [];
  List<String>? elements = [''];







  getInterest() {
    isLoading = true;
    var resp = getInterestApi();
    resp.then((value) {
      if (value is Map<String, dynamic> && value['error'] == false) {
        setState(() {
          var data = value['data'];
          if (data is Map<String, dynamic>) {
            var interests = data['interests'];
            if (interests is List) {
              var interestsString = interests.join(", ");
              elements = interestsString.split(", ");
              isLoading = false;
            } else {
              print('Error: Interests is not a list');
              isLoading = false;
            }
          } else {
            print('Error: Data is not a map');
            isLoading = false;
          }
        });
      } else {
        print('Error: API response indicates an error');
        isLoading = false;
      }
    });
  }



  Future<void> _handleRefresh() async {
     getInterest();
    getSizedWeight();
   getFavourites();
    getProfile();

    await Future.delayed(Duration(seconds: 2));


    setState(() {
    });
  }

  double dou = 00;
  var sizePercent = "";
  List<String> per = [];


  String? completePercent;
  double parsedPercent = 0.0;
  double normalizedPercent = 0.0;


  SizesAndWeightModel sizeWeight = SizesAndWeightModel();

  getSizedWeight(){
    isLoading = true;
    var resp = getSizeAndWeightApi();
    resp.then((value) {
      if(value['error'] == false){
        if(mounted){
        setState(() {
          sizeWeight = SizesAndWeightModel.fromJson(value);
          isLoading = false;
        });

      }else{
        setState(() {
          isLoading = false;
        });
      }}
    });
  }

  //---------------------------_Favourite_______________________________

  String? FavcompletePercent;
  double FavparsedPercent = 0.0;
  double FavnormalizedPercent = 0.0;



  FavouritesModel favourites = FavouritesModel();

  getFavourites() async {
    isLoading = true;
    var resp = getFavouritesApi();
    resp.then((value) {

      if(value['error'] == false){
        setState(() {
          favourites = FavouritesModel.fromJson(value);
          isLoading = false;
          print('qwertty${favourites}');
        });

      }else{
        setState(() {
          isLoading = false;
        });
      }

    });
  }

  //------------------------Profile Model -=--------------------------//



  ProfileModel ? profile;

  getProfile() {

    isLoading = true;
    var resp = getProfileApi();
    resp.then((value) {
      if(value['error'] == false){
        setState(() {
          profile = ProfileModel.fromJson(value);
          isLoading = false;
        });

      }else{
        setState(() {
          isLoading = false;
        });
      }

    });


  }

  String? favComplete;
  double favparsedPercent = 0.0;



  String? proCompletePercent;
  double proParsedPercent = 0.0;
  double proNormalizedPercent = 0.0;

  @override
  Widget build(BuildContext context) {
    completePercent = sizeWeight.data?.complete;
    parsedPercent = double.tryParse(completePercent?.replaceAll('%', '') ?? '0') ?? 0.0;
    normalizedPercent = parsedPercent / 100.0;


    favComplete = favourites?.data?.complete;
    favparsedPercent = double.tryParse(favComplete?.replaceAll('%', '') ?? '0') ?? 0.0;
    FavnormalizedPercent = favparsedPercent/100.0;


    proCompletePercent = widget.response.data!.complete.toString();
    proParsedPercent = double.tryParse(proCompletePercent!.replaceAll("%", '') ?? '0') ?? 0.0;
    proNormalizedPercent = proParsedPercent/100.0;


    double combinedPercentages =
        normalizedPercent + FavnormalizedPercent + proNormalizedPercent;
    double combinedNormalizedPercent = (combinedPercentages / 3) * 100;

    String combinedPercentAsString = combinedNormalizedPercent.toString();



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
              style: AppTextStyle().textColor29292916w500,
            ),
            leadingWidth: 40,
            leading: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
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
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Account(
                                      response: widget.response,
                                    )));
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            'Delete Account',
                            style: AppTextStyle().textColor39393914w500,
                          ),
                        ),
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
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            'Change Password',
                            style: AppTextStyle().textColor39393914w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                PopupMenuItem(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      SharedPrefs().setLoginFalse();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Login(),
                        ),
                      );
                    },
                    child: ListTile(
                      title: Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            'Log out',
                            style: AppTextStyle().textColor39393914w500,
                          ),
                        ),
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
                    Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: CachedNetworkImage(
                                imageUrl:
                                profile?.data?.profile?.photo != null
                                    ? profile!.data!.profile!.photo.toString()
                                    : baseUrl + (profile?.data?.profile?.photo?.toString() ?? ""),
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
                                profile?.data?.name?.toString() == "" ||
                                        profile?.data?.name == null
                                    ? Text(
                                        "User",
                                        style: AppTextStyle()
                                            .textColor29292916w500r,
                                      )
                                    : Text(
                                        profile!.data!.name.toString(),
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
                                :  GestureDetector(
                                    onTap: () {
                                   },
                              child: Container(
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
                                        combinedPercentAsString
                                            .toString()
                                            .split(".")
                                            .first,
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
                    isLoading == true ?
                       Text(
                           "Add Your Interest",
                            style: AppTextStyle().textColor29292914w400,
                          )
                        :
                    Padding(
                      padding: const EdgeInsets.only(right: 2.0),
                      child: Wrap(
                        children: elements!.map((e) => chipBox(name: e)).toList(),
                       ),
                     ),
                    SizedBox(
                      height: 30.h,
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserProfile(
                                      response: widget.response,
                                    ),
                            ),
                        );
                      },
                      child: Row(
                        children: [
                          CircularPercentIndicator(
                            circularStrokeCap: CircularStrokeCap.round,
                            radius: 40.w,
                            lineWidth: 2.w,
                            percent: proNormalizedPercent,
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
                                         /* profile!.data!.completePercent
                                                          .toString() ==
                                                      "" ||
                                                  profile!.data!
                                                          .completePercent ==
                                                      null*/
                              widget.response.data!.complete.toString() == "" || widget.response.data!.complete.toString() == null
                                              ? "0"
                                              :
                                  widget.response.data!.complete.toString().split(".").first,
                              /*profile!.data!.completePercent
                                                  .toString()
                                                  .split(".")
                                                  .first,*/
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
                          print(completePercent);
                          print(parsedPercent);
                          print(parsedPercent/100);
                          Navigator.pushReplacement(
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
                                            (sizeWeight.data?.complete?.toString() ?? "") == ""
                                                ? "0"
                                                : sizeWeight.data!.complete.toString().split(".").first,
                                            style: AppTextStyle().textColor70707012w400,
                                          ),
                                          /*Text(
                                            sizeWeight.data!.complete
                                                            .toString() ==
                                                        ""
                                                ||
                                                    sizeWeight.data!
                                                            .complete ==
                                                        null
                                                ? "0"
                                                : sizeWeight!
                                                    .data!.complete
                                                    .toString()
                                                    .split(".")
                                                    .first,
                                            // sizeWeight!.data.completePercent
                                            //     .toString()
                                            //     .split(".")
                                            //     .first,
                                            style: AppTextStyle()
                                                .textColor70707012w400,
                                          ),*/
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
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Favorites(
                                      response: widget.response,
                                    )));
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
                              (favourites.data?.complete?.toString() ?? "") == ""
                        ? "0"
                        : favourites.data!.complete.toString().split(".").first,
                        style: AppTextStyle().textColor70707012w400,
                       ),
                                          /*favourites?.data!.complete
                                                          .toString() ==
                                                      "" ||
                                                  favourites?.data!
                                                          .complete ==
                                                      null
                                              ? "0"
                                              : favourites!
                                                  .data!.complete
                                                  .toString()
                                                  .split(".")
                                                  .first,

                                          style: AppTextStyle()
                                              .textColor70707012w400,*/
                                       // ),
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
                                builder: (context) => ManageAddress(response: widget.response,)));
                      },
                      child: AddressRowWidget(),
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
