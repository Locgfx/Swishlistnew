import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/models/login_models.dart';

import '../../api/user_apis/profile_apis.dart';
import '../../constants/color.dart';
import '../../constants/globals/shared_prefs.dart';
import '../../constants/urls.dart';
import '../../models/profile_model.dart';

class UserImageRowWidget extends StatefulWidget {
  final LoginResponse response;
  const UserImageRowWidget({
    Key? key,
    required this.response,
  }) : super(key: key);

  @override
  State<UserImageRowWidget> createState() => _UserImageRowWidgetState();
}

class _UserImageRowWidgetState extends State<UserImageRowWidget> {
  var percent = "";
  bool size = false;
  bool favourite = false;
  // final String bh=  percent* 10;

  double dou = 00;
  List<String> per = [];

  _sharedPrefs() {
    if (SharedPrefs().getPPercent() == '100 %') {
      per.add('profile');
    }
    if (SharedPrefs().getSetSize() == '100 %') {
      per.add('Size');
    }
    if (SharedPrefs().getFavourites() == '100 %') {
      per.add('favourites');
    }
    percent = ((per.length / 3) * 100).toString().split(".").first;
    dou = (per.length / 3);
  }

  @override
  void initState() {
    _sharedPrefs();
    getProfile();

    super.initState();
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
              // fields();
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

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Row(
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
                    profile!.data!.user!.photo.toString().contains("https")
                        ? profile!.data!.user!.photo.toString()
                        : baseUrl + profile!.data!.user!.photo.toString(),
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Opacity(
                  opacity: 0.3,
                  child: Shimmer.fromColors(
                    baseColor: Colors.black12,
                    highlightColor: Colors.white,
                    child: Container(
                      width: 40,
                      height: 40,
                      //margin: EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                    ),
                  ),
                ),
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
                          color: Colors.white, shape: BoxShape.circle),
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
                Text(
                  '${SharedPrefs().getName()}'.isEmpty
                      ? widget.response.data.name.toString()
                      : '${SharedPrefs().getName()}',

                  // widget.response.data.name.toString(),
                  // '${SharedPrefs().getName()}',
                  // "Michael Scott",
                  style: AppTextStyle().textColor29292916w500,
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
                      print(profile!.data!.completePercent.toString());
                    },
                    child: Container(
                      // height: 30,
                      // width: 120.w,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: ColorSelect.colorF8F1AA,
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              profile!.data!.completePercent.toString() == "" ||
                                      profile!.data!.completePercent == null
                                  ? "0"
                                  : profile!.data!.completePercent
                                      .toString()
                                      .split(".")
                                      .first,
                              // sizeWeight!.data!.completePercent
                              //     .toString()
                              //     .split(".")
                              //     .first,
                              style: AppTextStyle().textColor70707012w400,
                            ),
                            Text(
                              "%  Percent",
                              style: AppTextStyle().textColor70707012w400,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ],
    );
  }
}
