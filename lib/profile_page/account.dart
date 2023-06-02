
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/constants/globals/loading.dart';
import '../api/user_apis/profile_apis.dart';
import '../buttons/red_text_white_color_button.dart';
import '../models/profile_model.dart';
import 'change_password.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {


  @override
  void initState() {
    getProfile();
    super.initState();
  }
  bool isLoading = false;
  // ProfileModel? profile;
  ProfileModel profile = ProfileModel();
  getProfile() {
    isLoading = true;
    var resp = getProfileDetails();
    resp.then((value){
      if (value['status']== true) {
        setState(() {
          profile = ProfileModel.fromJson(value);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(children: [
          Text(
            "Account",
            style: AppTextStyle().textColor29292916w500,
          ),
          SizedBox(
            width: 130.w,
          ),
        ]),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => UserAllDetails()));
              },
              child: Image.asset('assets/images/Vector190.png')),
        ),
      ),
      backgroundColor: Colors.white,
      body: isLoading ? Loading() :Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: 40.h,
            ),
            Row(
              children: [
                Text(
                  "Username",
                  style: AppTextStyle().textColor70707014w400,
                ),
                Spacer(),
                Text(
                  profile.data!.user!.username!.toString() == "null" ?
                  "Add Your Username" :
                  profile.data!.user!.username!.toString(),
                  // "MichieMaster34",
                  style: AppTextStyle().textColor29292914w400,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Image.asset("assets/images/Vector175.png"),
              ],
            ),
            SizedBox(
              height: 40.h,
            ),
            Row(
              children: [
                Text(
                  "Email",
                  style: AppTextStyle().textColor70707014w400,
                ),
                Spacer(),
                Text(
                  profile.data!.user!.email!.toString() == "null" ?
                  "Add your email" :
                  profile.data!.user!.email!.toString(),
                  // "Harrywilson134@gmail.com",
                  style: AppTextStyle().textColor29292914w400,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Image.asset("assets/images/Vector175.png"),
              ],
            ),
            SizedBox(
              height: 40.h,
            ),
            Row(
              children: [
                Text(
                  "Phone",
                  style: AppTextStyle().textColor70707014w400,
                ),
                Spacer(),
                Text(
                  profile.data!.user!.phone!.toString() == "null" ?
                  "Add your phone no" :
                  profile.data!.user!.phone!.toString(),
                  // "+18397840844",
                  style: AppTextStyle().textColor29292914w400,
                ),
                SizedBox(
                  width: 10.w,
                ),
                Image.asset("assets/images/Vector175.png"),
              ],
            ),
            SizedBox(
              height: 40.h,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) =>ChangePassword()));
              },
              child: Row(
                children: [
                  Text(
                    "Change Password",
                    style: AppTextStyle().textColor70707014w400,
                  ),
                  Spacer(),
                  Image.asset("assets/images/Vector175.png"),
                ],
              ),
            ),
            SizedBox(
              height: 40.h,
            ),
            // Row(
            //   children: [
            //     Text(
            //       "Google",
            //       style: AppTextStyle().textColor70707014w400,
            //     ),
            //     Spacer(),
            //     Image.asset("assets/images/Vector175.png"),
            //   ],
            // ),
            // SizedBox(
            //   height: 40.h,
            // ),
            // Row(
            //   children: [
            //     Text(
            //       "Contacts syncing",
            //       style: AppTextStyle().textColor70707014w400,
            //     ),
            //     Spacer(),
            //     Image.asset("assets/images/Vector175.png"),
            //   ],
            // ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 34),
              child: SizedBox(
                height: 52.h,
                width: 328.w,
                child: RedTextWhiteButtonWithText(
                  title: 'Delete Account',
                  textStyleColor: ColorSelect.colorC33C3C,
                  onTap: () {},
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
