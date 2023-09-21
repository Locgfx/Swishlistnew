import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../api/user_apis/profile_apis.dart';
import '../../constants/color.dart';
import '../../constants/globals/shared_prefs.dart';
import '../../models/profile_model.dart';

class ProfileRowWidget extends StatefulWidget {
  const ProfileRowWidget({Key? key}) : super(key: key);

  @override
  State<ProfileRowWidget> createState() => _ProfileRowWidgetState();
}

class _ProfileRowWidgetState extends State<ProfileRowWidget> {
  double dou = 00;
  var percent = "";
  // String per = '';
  List<String> per = [];

  _sharedPrefs() {
    if (SharedPrefs().getPPercent() == '100 %') {
      per.add('profile');
      percent = ((per.length / 1) * 100).toString().split(".").first;
      dou = (per.length / 1);
    }
  }

  @override
  void initState() {
    _sharedPrefs();
    getProfile();
    super.initState();
  }

  String? completePercent;
  double parsedPercent = 0.0;
  double normalizedPercent = 0.0;

  ProfileModel? profile = ProfileModel(
    data: Data(
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
      user: User(
          name: '',
          username: '',
          email: '',
          phone: '',
          type: '',
          photo: '${SharedPrefs().getUserPhoto()}'),
    ),
  );
  bool isLoading = false;
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
    completePercent = profile?.data?.completePercent;
    parsedPercent = double.tryParse(completePercent ?? '0') ?? 0.0;
    normalizedPercent = parsedPercent / 100.0;
    return Row(
      children: [
        CircularPercentIndicator(
          circularStrokeCap: CircularStrokeCap.round,
          radius: 40.w,
          lineWidth: 2.w,
          percent: normalizedPercent,
          // percent: .12,
          backgroundColor: Color(0xff66D340).withOpacity(0.28),
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
          ],
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 27),
          child: SvgPicture.asset("assets/icons/forwordarrow.svg"),
        )
      ],
    );
  }
}
