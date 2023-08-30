import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';
import 'package:swishlist/dashboard/dashboard.dart';
import 'package:swishlist/expanded/user_all_details.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/color.dart';
import '../models/login_models.dart';
import 'notifications.dart';

class MemberSettings extends StatefulWidget {
  final LoginResponse response;
  const MemberSettings({
    Key? key,
    required this.response,
  }) : super(key: key);

  @override
  State<MemberSettings> createState() => _MemberSettingsState();
}

class _MemberSettingsState extends State<MemberSettings> {
  final Uri _url =
      Uri.parse('https://swishlist.godaddysites.com/privacy-policy');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorSelect.colorF7E641,
      appBar: AppBar(
        backgroundColor: ColorSelect.colorF7E641,
        elevation: 0,
        leadingWidth: 40,
        leading: InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Dashboard(
                            response: widget.response,
                          )));
              // Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SvgPicture.asset("assets/icons/arrowback.svg"),
            )),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 300.h,
                  width: 1.sw,
                  color: ColorSelect.colorF7E641,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Text(
                      "Settings",
                      style: AppTextStyle().textColor1A1A1A28w700,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  height: 400.h,
                  width: 1.sw,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Text(
                      "Settings",
                      style: AppTextStyle().textColor1A1A1A28w700,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Container(
                    width: 1.sw,
                    margin: EdgeInsets.all(16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 0,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "User",
                          style: AppTextStyle().textColorA3A3A312w400,
                        ),
                        SizedBox(height: 20),
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
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Text(
                                  "Account",
                                  style: AppTextStyle().textColor39393914w500,
                                ),
                                Spacer(),
                                SvgPicture.asset(
                                    "assets/icons/forwordarrow.svg")
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (_) => Privacy(),
                        //       ),
                        //     );
                        //   },
                        //   child: Container(
                        //     padding: EdgeInsets.symmetric(vertical: 5),
                        //     color: Colors.transparent,
                        //     child: Row(
                        //       children: [
                        //         Text(
                        //           "Privacy",
                        //           style: AppTextStyle().textColor39393914w500,
                        //         ),
                        //         Spacer(),
                        //         SvgPicture.asset(
                        //             "assets/icons/forwordarrow.svg")
                        //       ],
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  Container(
                    width: 1.sw,
                    margin: EdgeInsets.all(16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 0,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "App",
                          style: AppTextStyle().textColorA3A3A312w400,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Notifications()));
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                Text(
                                  "Notifications",
                                  style: AppTextStyle().textColor39393914w500,
                                ),
                                Spacer(),
                                SvgPicture.asset(
                                    "assets/icons/forwordarrow.svg")
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              Share.share('Check out SwishList on AppStore');
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Text(
                                  "Share with your friends",
                                  style: AppTextStyle().textColor39393914w500,
                                ),
                                Spacer(),
                                SvgPicture.asset(
                                    "assets/icons/forwordarrow.svg")
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 1.sw,
                    margin: EdgeInsets.all(16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 0,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Support",
                          style: AppTextStyle().textColorA3A3A312w400,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            Text(
                              "Help & Support",
                              style: AppTextStyle().textColor39393914w500,
                            ),
                            Spacer(),
                            SvgPicture.asset("assets/icons/forwordarrow.svg")
                          ],
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () async {
                            final Uri url = Uri.parse(
                                'https://swishlist.godaddysites.com/terms-of-service');
                            if (!await launchUrl(url)) {
                              throw Exception('Could not launch $_url');
                            }
                          },
                          child: Row(
                            children: [
                              Text(
                                "Terms & Conditions",
                                style: AppTextStyle().textColor39393914w500,
                              ),
                              Spacer(),
                              SvgPicture.asset("assets/icons/forwordarrow.svg")
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () async {
                            final Uri url = Uri.parse(
                                'https://swishlist.godaddysites.com/privacy-policy');
                            if (!await launchUrl(url)) {
                              throw Exception('Could not launch $_url');
                            }
                          },
                          child: Row(
                            children: [
                              Text(
                                "Privacy Policy",
                                style: AppTextStyle().textColor39393914w500,
                              ),
                              Spacer(),
                              SvgPicture.asset("assets/icons/forwordarrow.svg")
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // body: Stack(
      //   clipBehavior: Clip.none,
      //   children: [
      //     Container(
      //       height: 400.h,
      //       width: 1.sw,
      //       color: ColorSelect.colorF7E641,
      //     ),
      //     Column(
      //       children: [
      //         SizedBox(height: 30),
      //         Center(
      //           child: Text(
      //             "Settings",
      //             style: AppTextStyle().textColor1A1A1A28w700,
      //           ),
      //         ),
      //         Container(
      //           width: 1.sw,
      //           margin: EdgeInsets.all(16),
      //           padding: const EdgeInsets.all(20),
      //           decoration: BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.all(Radius.circular(12)),
      //             boxShadow: [
      //               BoxShadow(
      //                 spreadRadius: 0,
      //                 blurRadius: 10,
      //                 color: Colors.black.withOpacity(0.1),
      //               )
      //             ],
      //           ),
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Text(
      //                 "User",
      //                 style: AppTextStyle().textColorA3A3A312w400,
      //               ),
      //               SizedBox(height: 20),
      //               GestureDetector(
      //                 onTap: () {
      //                   Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                       builder: (_) => UserAllDetails(
      //                         response: widget.response,
      //                       ),
      //                     ),
      //                   );
      //                 },
      //                 child: Container(
      //                   padding: EdgeInsets.symmetric(vertical: 5),
      //                   color: Colors.transparent,
      //                   child: Row(
      //                     children: [
      //                       Text(
      //                         "Account",
      //                         style: AppTextStyle().textColor39393914w500,
      //                       ),
      //                       Spacer(),
      //                       SvgPicture.asset("assets/icons/forwordarrow.svg")
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //               SizedBox(height: 20),
      //               // GestureDetector(
      //               //   onTap: () {
      //               //     Navigator.push(00000
      //               //       context,
      //               //       MaterialPageRoute(
      //               //         builder: (_) => Privacy(),
      //               //       ),
      //               //     );
      //               //   },
      //               //   child: Container(
      //               //     padding: EdgeInsets.symmetric(vertical: 5),
      //               //     color: Colors.transparent,
      //               //     child: Row(
      //               //       children: [
      //               //         Text(
      //               //           "Privacy",
      //               //           style: AppTextStyle().textColor39393914w500,
      //               //         ),
      //               //         Spacer(),
      //               //         SvgPicture.asset("assets/icons/forwordarrow.svg")
      //               //       ],
      //               //     ),
      //               //   ),
      //               // )
      //             ],
      //           ),
      //         ),
      //         Container(
      //           width: 1.sw,
      //           margin: EdgeInsets.all(16),
      //           padding: const EdgeInsets.all(20),
      //           decoration: BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.all(Radius.circular(12)),
      //             boxShadow: [
      //               BoxShadow(
      //                 spreadRadius: 0,
      //                 blurRadius: 10,
      //                 color: Colors.black.withOpacity(0.1),
      //               )
      //             ],
      //           ),
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Text(
      //                 "App",
      //                 style: AppTextStyle().textColorA3A3A312w400,
      //               ),
      //               SizedBox(
      //                 height: 20.h,
      //               ),
      //               InkWell(
      //                 onTap: () {
      //                   Navigator.push(
      //                       context,
      //                       MaterialPageRoute(
      //                           builder: (context) => Notifications()));
      //                 },
      //                 child: Container(
      //                   color: Colors.transparent,
      //                   padding: EdgeInsets.symmetric(vertical: 5),
      //                   child: Row(
      //                     children: [
      //                       Text(
      //                         "Notifications",
      //                         style: AppTextStyle().textColor39393914w500,
      //                       ),
      //                       Spacer(),
      //                       SvgPicture.asset("assets/icons/forwordarrow.svg")
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //               SizedBox(height: 20),
      //               GestureDetector(
      //                 onTap: () {
      //                   setState(() {
      //                     Share.share('Check out SwishList on AppStore');
      //                   });
      //                 },
      //                 child: Container(
      //                   padding: EdgeInsets.symmetric(vertical: 5),
      //                   color: Colors.transparent,
      //                   child: Row(
      //                     children: [
      //                       Text(
      //                         "Share with your friends",
      //                         style: AppTextStyle().textColor39393914w500,
      //                       ),
      //                       Spacer(),
      //                       SvgPicture.asset("assets/icons/forwordarrow.svg")
      //                     ],
      //                   ),
      //                 ),
      //               )
      //             ],
      //           ),
      //         ),
      //         SizedBox(height: 20),
      //         //SupportMemberSettingWidget(),
      //         Container(
      //           width: 1.sw,
      //           margin: EdgeInsets.all(16),
      //           padding: const EdgeInsets.all(20),
      //           decoration: BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.all(Radius.circular(12)),
      //             boxShadow: [
      //               BoxShadow(
      //                 spreadRadius: 0,
      //                 blurRadius: 10,
      //                 color: Colors.black.withOpacity(0.1),
      //               )
      //             ],
      //           ),
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Text(
      //                 "Support",
      //                 style: AppTextStyle().textColorA3A3A312w400,
      //               ),
      //               SizedBox(
      //                 height: 20.h,
      //               ),
      //               Row(
      //                 children: [
      //                   Text(
      //                     "Help & Support",
      //                     style: AppTextStyle().textColor39393914w500,
      //                   ),
      //                   Spacer(),
      //                   SvgPicture.asset("assets/icons/forwordarrow.svg")
      //                 ],
      //               ),
      //               SizedBox(height: 20),
      //               Row(
      //                 children: [
      //                   Text(
      //                     "Terms & Conditions",
      //                     style: AppTextStyle().textColor39393914w500,
      //                   ),
      //                   Spacer(),
      //                   SvgPicture.asset("assets/icons/forwordarrow.svg")
      //                 ],
      //               ),
      //               SizedBox(height: 20),
      //               Row(
      //                 children: [
      //                   Text(
      //                     "Privacy Policy",
      //                     style: AppTextStyle().textColor39393914w500,
      //                   ),
      //                   Spacer(),
      //                   SvgPicture.asset("assets/icons/forwordarrow.svg")
      //                 ],
      //               )
      //             ],
      //           ),
      //         ),
      //
      //         Spacer(),
      //         Text(
      //           "Version 2.34.0",
      //           style: AppTextStyle().textColorA3A3A312w500,
      //         ),
      //         SizedBox(height: 20),
      //       ],
      //     ),
      //   ],
      // ),
    );
  }
}
