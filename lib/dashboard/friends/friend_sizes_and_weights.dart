import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swishlist/api/friend_apis/user_details_api.dart';
import 'package:swishlist/constants/globals/loading.dart';
import 'package:swishlist/models/user_details_model.dart';

import '../../api/user_apis/friends_api.dart';
import '../../constants/color.dart';
import '../../models/friends_details_model.dart';

class FSizesAndWeights extends StatefulWidget {
  final String friendId;
  const FSizesAndWeights({Key? key, required this.friendId}) : super(key: key);

  @override
  State<FSizesAndWeights> createState() => _FSizesAndWeightsState();
}

class _FSizesAndWeightsState extends State<FSizesAndWeights> {
  @override
  void initState() {
    getUserDetails();
    //getFriendDetails();
    super.initState();
  }

  bool isLoading = false;


  UserDetailsModel ? userDetails;


  getUserDetails(){
    isLoading = true;
    var resp = userDetailsApi(id: widget.friendId);
    resp.then((value) {
      if(value['error'] == false){
        setState(() {
          userDetails = UserDetailsModel.fromJson(value);
        });
        isLoading = false;

      }
      else{
        isLoading = false;
      }
    });


  }
// dsnkdnknsd
 /* FriendDetailsModel? friendDetails = FriendDetailsModel(
      data: Data(
          sizeWeight: SizeWeight(
    shirt: '',
    waist: '',
    shoes: '',
    bed: '',
  )));

  getFriendDetails() {
    isLoading = true;
    var resp = friendDetailsApi(friendUserId: widget.friendId);
    resp.then((value) {
      if (mounted) {
        if (value['status'] == true) {
          if (value['message'] == "No Size Weight") {
            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {
              friendDetails = FriendDetailsModel.fromJson(value);
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
  }*/

  Future<void> _handleRefresh() async {
    getUserDetails();
    //getFriendDetails();
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

  List homeValues = ['Bed'];
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset('assets/images/Vector190.png')),
              ),
              title: Text(
                "Sized and Weights",
                style: AppTextStyle().textColor39393916w500,
              ),
              centerTitle: false,
            ),
            body: isLoading
                ? Loading()
                : RefreshIndicator(
                    backgroundColor: Colors.white,
                    color: ColorSelect.colorF7E641,
                    strokeWidth: 3,
                    onRefresh: _handleRefresh,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),
                            Text(
                              "Fashion",
                              style: AppTextStyle().textColor29292914w600,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
/*
                           userDetails!.data!.sizing!.waist.toString() == '' ||
                          userDetails!.data!.sizing!.waist == null
                           *//* friendDetails!.data!.sizeWeight!.waist.toString() ==
                                        "" ||
                                    friendDetails!.data!.sizeWeight!.waist ==
                                        null*//*
                                ? SizedBox()
                                :*/
                           InkWell(
                                    onTap: () {},
                                    child: Row(
                                      children: [
                                        Text(
                                          "Waist",
                                          style: AppTextStyle()
                                              .textColor70707014w400,
                                        ),
                                        Spacer(),
                                        Text(
                                          userDetails!.data!.sizing!.waist.toString() == '' ||
                                              userDetails!.data!.sizing!.waist == null
                                          /*friendDetails!.data!.sizeWeight!.waist
                                                          .toString() ==
                                                      "" ||
                                                  friendDetails!.data!
                                                          .sizeWeight!.waist ==
                                                      null*/
                                              ? "friend not updated shirt size"
                                              :
                                          userDetails!.data!.sizing!.waist.toString(),

                                          /*friendDetails!
                                                  .data!.sizeWeight!.waist
                                                  .toString(),*/
                                          // '+ Add',
                                          style:
                                              // AppTextStyle().textColorD5574514w500 :
                                              AppTextStyle()
                                                  .textColor29292914w400,
                                        ),
                                        // SizedBox(
                                        //   width: 5.w,
                                        // ),
                                        // Image.asset("assets/images/image46.png"),
                                        // SizedBox(
                                        //   width: 20.w,
                                        // ),
                                        // Image.asset("assets/images/Vector175.png"),
                                      ],
                                    ),
                                  ),
                            SizedBox(
                              height:

                              /*userDetails!.data!.sizing!.waist.toString() == '' ||
                                  userDetails!.data!.sizing!.waist == null
                              *//*friendDetails!.data!.sizeWeight!.waist
                                              .toString() ==
                                          "" ||
                                      friendDetails!.data!.sizeWeight!.waist ==
                                          null*//*
                                  ? 0
                                  : */
                              20.h,
                            ),

                           /* userDetails!.data!.sizing!.shirt.toString() == '' ||
                                userDetails!.data!.sizing!.shirt == null
                           *//* friendDetails!.data!.sizeWeight!.shirt.toString() ==
                                        "" ||
                                    friendDetails!.data!.sizeWeight!.shirt ==
                                        null*//*
                                ? SizedBox()
                                : */
                            InkWell(
                                    onTap: () {
                                      // showDialog(
                                      //   context: context,
                                      //   builder: (BuildContext context) {
                                      //
                                      //   },
                                      // );
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "Shirt",
                                          style: AppTextStyle()
                                              .textColor70707014w400,
                                        ),
                                        Spacer(),
                                        Text(
                                          /*  friendDetails!.data!.sizeWeight!.shirt.toString() == '' ?
                        'waist is not added yet' :*/
                                          // friendDetails!.data!.sizeWeight!.shirt.toString(),

                                          userDetails!.data!.sizing!.shirt.toString() == '' ||
                                              userDetails!.data!.sizing!.shirt == null
                                         /* friendDetails!.data!.sizeWeight!.shirt
                                                          .toString() ==
                                                      "" ||
                                                  friendDetails!.data!
                                                          .sizeWeight!.shirt ==
                                                      null*/
                                              ? "friend not updated shirt size"
                                              :

                                          userDetails!.data!.sizing!.waist.toString() ,

                                          /*friendDetails!
                                                  .data!.sizeWeight!.shirt
                                                  .toString(),*/
                                          // '+ Add',
                                          /*:
                        sizeWeight!.data!.shirt!.toString(),
                        style: sizeWeight!.data!.shirt! == '' ?
                        AppTextStyle().textColorD5574514w500 :*/
                                          style: AppTextStyle()
                                              .textColor29292914w400,
                                        ),
                                        // SizedBox(
                                        //   width: 5.w,
                                        // ),
                                        // Image.asset("assets/images/image461.png"),
                                        // SizedBox(
                                        //   width: 20.w,
                                        // ),
                                        // Image.asset("assets/images/Vector175.png"),
                                      ],
                                    ),
                                  ),
                            SizedBox(
                              height:
                            /*  userDetails!.data!.sizing!.shirt.toString() == '' ||
                                  userDetails!.data!.sizing!.shirt == null
                              *//*friendDetails!.data!.sizeWeight!.shirt
                                              .toString() ==
                                          "" ||
                                      friendDetails!.data!.sizeWeight!.shirt ==
                                          null*//*
                                  ? 0
                                  : */
                              20.h,
                            ),

                            /*userDetails!.data!.sizing!.shoe.toString() == '' ||
                                userDetails!.data!.sizing!.shoe == null
                            *//*friendDetails!.data!.sizeWeight!.shoes.toString() ==
                                        "" ||
                                    friendDetails!.data!.sizeWeight!.shoes ==
                                        null*//*
                                ? SizedBox()
                                : */
                            GestureDetector(
                                    onTap: () {
                                      // showDialog(
                                      //   context: context,
                                      //   builder: (BuildContext context) {
                                      //   },
                                      // );
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "Shoes",
                                          style: AppTextStyle()
                                              .textColor70707014w400,
                                        ),
                                        Spacer(),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        Text(
                                          /* friendDetails!.data!.sizeWeight!.shoes.toString() == '' ?
                        'waist is not added yet' :*/

                                          userDetails!.data!.sizing!.shoe.toString() == '' ||
                                              userDetails!.data!.sizing!.shoe == null
                                         /* friendDetails!.data!.sizeWeight!.shoes
                                                          .toString() ==
                                                      "" ||
                                                  friendDetails!.data!
                                                          .sizeWeight!.shoes ==
                                                      null*/
                                              ? "friend not updated shoes size"
                                              :
                                          userDetails!.data!.sizing!.shoe.toString() ,

                                         /* friendDetails!
                                                  .data!.sizeWeight!.shoes
                                                  .toString(),*/
                                          // '+ Add',
                                          style: AppTextStyle()
                                              .textColor29292914w400,
                                        ),
                                        // Image.asset("assets/images/information2.png"),
                                        // SizedBox(
                                        //   width: 20.w,
                                        // ),
                                        // Image.asset("assets/images/Vector175.png"),
                                      ],
                                    ),
                                  ),
                            SizedBox(
                              height:

                             /* userDetails!.data!.sizing!.shoe.toString() == '' ||
                                  userDetails!.data!.sizing!.shoe == null
                             *//* friendDetails!.data!.sizeWeight!.shoes
                                              .toString() ==
                                          "" ||
                                      friendDetails!.data!.sizeWeight!.shoes ==
                                          null*//*
                                  ? 20.h
                                  : */
                              40.h,
                            ),
                            Text(
                              "Home",
                              style: AppTextStyle().textColor29292914w600,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),

                           /* userDetails!.data!.sizing!.bed.toString() == '' ||
                                userDetails!.data!.sizing!.bed == null
                            *//*friendDetails!.data!.sizeWeight!.bed.toString() ==
                                        "" ||
                                    friendDetails!.data!.sizeWeight!.bed == null*//*
                                ? SizedBox()
                                : */
                            GestureDetector(
                                    onTap: () {},
                                    child: Row(
                                      children: [
                                        Text(
                                          "Bed",
                                          style: AppTextStyle()
                                              .textColor70707014w400,
                                        ),
                                        Spacer(),
                                        Text(


                                            userDetails!.data!.sizing!.bed.toString() == '' ||
                                                userDetails!.data!.sizing!.bed == null
                                            /*friendDetails!.data!.sizeWeight!.bed
                                                            .toString() ==
                                                        "" ||
                                                    friendDetails!.data!
                                                            .sizeWeight!.bed ==
                                                        null*/
                                                ? "friend not updated bed size"
                                                :

                                            userDetails!.data!.sizing!.bed.toString() ,

                                           /* friendDetails!
                                                    .data!.sizeWeight!.bed
                                                    .toString(),*/
                                            //  Add' ,
                                            style: AppTextStyle()
                                                .textColor29292914w400),
                                        // SizedBox(
                                        //   width: 5.w,
                                        // ),
                                        // Image.asset("assets/images/image46.png"),
                                        // SizedBox(
                                        //   width: 20.w,
                                        // ),
                                        // Image.asset("assets/images/Vector175.png"),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
          );
  }
}
