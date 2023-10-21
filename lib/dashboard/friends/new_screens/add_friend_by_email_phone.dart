import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:swishlist/api/friend_apis/add_friend_api.dart';
import 'package:swishlist/buttons/light_yellow.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/constants/globals/globals.dart';

import 'friend_request_send.dart';

class AddFriendByMailPhone extends StatefulWidget {
  const AddFriendByMailPhone({
    Key? key,
  }) : super(key: key);

  @override
  State<AddFriendByMailPhone> createState() => _AddFriendByMailPhoneState();
}

class _AddFriendByMailPhoneState extends State<AddFriendByMailPhone> {
  final TextEditingController emailPhoneController = TextEditingController();
  bool isLoading = false;
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        height: 52.h,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        child: isLoading
            ? Center(
                child: LoadingAnimationWidget.waveDots(
                  size: 40,
                  color: ColorSelect.colorF7E641,
                ),
              )
            : show
                ? LoadingLightYellowButton()
                : LightYellowButtonWithText(
                    backgroundColor: (emailPhoneController.text.isNotEmpty)
                        ? MaterialStateProperty.all(ColorSelect.colorF7E641)
                        : MaterialStateProperty.all(ColorSelect.colorFCF5B6),
                    textStyleColor: (emailPhoneController.text.isNotEmpty)
                        ? Colors.black
                        : ColorSelect.colorB5B07A,
                    onTap: () {
                      setState(() {
                        show = !show;
                      });
                      Timer timer = Timer(Duration(seconds: 2), () {
                        setState(() {
                          show = false;
                        });
                      });
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => FriendRequestSent(
                      //               name: emailPhoneController.text,
                      //             )));

                      if (emailPhoneController.text.isNotEmpty) {
                        addFriendByMailPhoneApi(
                          phoneEmail: emailPhoneController.text,
                        ).then((value) async {
                          if (value['status'] == true) {
                            Fluttertoast.showToast(msg: value['message']);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FriendRequestSent(
                                          name: emailPhoneController.text,
                                        )));
                          } else {
                            Fluttertoast.showToast(msg: value['message']);
                          }
                        });
                      }
                    },
                    title: 'Send Request',
                  ),
      ),
      body: TextFieldUnFocusOnTap(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Row(
                  children: [
                    Text(
                      "Add Friend",
                      style: AppTextStyle().textColor29292916w500,
                    ),
                  ],
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
              ),
              SizedBox(height: 40),
              Text(
                "Add friend account",
                style: AppTextStyle().textColor29292924w700,
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "Please enter the friend linked with\n SwishList account.",
                  textAlign: TextAlign.center,
                  style: AppTextStyle().textColor70707012w400,
                ),
              ),
              SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  width: 328.w,
                  decoration: BoxDecoration(
                    color: ColorSelect.colorEDEDF1,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextFormField(
                      onChanged: (v) {
                        setState(() {});
                      },
                      controller: emailPhoneController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 24),
                        border: InputBorder.none,
                        hintText: "Enter friend email",
                      ),
                    ),
                  ),
                ),
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 16),
              //   height: 52.h,
              //   decoration: BoxDecoration(
              //   color: ColorSelect.colorEDEDF1,
              //   borderRadius: BorderRadius.all(Radius.circular(8))),
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 20.0),
              //     child: TypeAheadField(
              //       hideSuggestionsOnKeyboardHide: true,
              //       animationStart: 0,
              //       animationDuration: Duration.zero,
              //       textFieldConfiguration: TextFieldConfiguration(
              //         onSubmitted: (v) {
              //           setState(() {
              //             searchModel.clear();
              //           });
              //         },
              //         onChanged: (val) {
              //           if(val.length >=4){
              //             getSearch(val);
              //           } else {
              //             setState(() {
              //               searchModel.clear();
              //               matches.clear();
              //             });
              //           }
              //           },
              //         controller: searchController,
              //           autofocus: true,
              //           style: TextStyle(fontSize: 15),
              //           decoration: InputDecoration(
              //             hintText: 'Enter Full Name',
              //               border: InputBorder.none
              //           ),
              //       ),
              //       suggestionsBoxDecoration: SuggestionsBoxDecoration(
              //         color: ColorSelect.colorEDEDF1,
              //       ),
              //       suggestionsCallback: (pattern) async {
              //         print(searchController.text);
              //         matches.addAll(searchModel);
              //         matches.retainWhere((s){
              //           return s.name!.toLowerCase().contains(pattern.toLowerCase());
              //         });
              //         return matches;
              //       },
              //       itemBuilder: (context,SearchModel i) {
              //         return Container(
              //           padding: EdgeInsets.all(10),
              //           child:Text(i.name.toString()),
              //         );
              //       },
              //         onSuggestionSelected: (SearchModel suggestion) {
              //         print(suggestion);
              //         setState(() {
              //           searchController.clear();
              //           searchController.text = suggestion.name!;
              //           memberId.text = suggestion.userId!.toString();
              //           privacyStatus.text = suggestion.privacyStatus!;
              //           searchModel.clear();
              //         },
              //         );
              //       },
              //     ),
              //   ),
              // ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
