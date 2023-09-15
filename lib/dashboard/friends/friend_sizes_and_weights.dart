import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swishlist/constants/globals/loading.dart';
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
    getFriendDetails();
    super.initState();
  }

  bool isLoading = false;

  FriendDetailsModel? friendDetails = FriendDetailsModel(
    data: Data(
      sizeWeight: SizeWeight(
        shirt: '',
        waist: '',
        shoes: '',
        bed: '',
      )
    )
  );

  getFriendDetails() {
    isLoading = true;
    var resp = friendDetailsApi(friendUserId: widget.friendId);
    resp.then((value) {
      if(mounted) {
        if(value['status'] == true) {
          if(value['message'] == "No Size Weight") {
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
  }



  List homeValues = ['Bed'];
  @override
  Widget build(BuildContext context) {
    return isLoading ? Loading(): Scaffold(
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
      body: isLoading ? Loading(): SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: friendDetails!.data!.sizeWeight!.bed == ''
          ?
          Text('data'):
          Column(
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
              InkWell(
                onTap: () {
                },
                child: Row(
                  children: [
                    Text(
                      "Waist",
                      style: AppTextStyle().textColor70707014w400,
                    ),
                    Spacer(),
                    Text(
                      friendDetails!.data!.sizeWeight!.waist.toString(),
                      // '+ Add',
                      style:
                      // AppTextStyle().textColorD5574514w500 :
                      AppTextStyle().textColor29292914w400,
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
                height: 20.h,
              ),
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
                      style: AppTextStyle().textColor70707014w400,
                    ),
                    Spacer(),
                    Text(
                    /*  friendDetails!.data!.sizeWeight!.shirt.toString() == '' ?
                      'waist is not added yet' :*/
                      friendDetails!.data!.sizeWeight!.shirt.toString(),
                      // '+ Add',
                        /*:
                      sizeWeight!.data!.shirt!.toString(),
                      style: sizeWeight!.data!.shirt! == '' ?
                      AppTextStyle().textColorD5574514w500 :*/
                     style: AppTextStyle().textColor29292914w400,
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
                height: 20.h,
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,

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
                      style: AppTextStyle().textColor70707014w400,
                    ),
                    Spacer(),
                    SizedBox(
                      width: 5.w,
                    ),
                    Text(
                     /* friendDetails!.data!.sizeWeight!.shoes.toString() == '' ?
                      'waist is not added yet' :*/
                      friendDetails!.data!.sizeWeight!.shoes.toString(),
                      // '+ Add',
                      style:AppTextStyle().textColor29292914w400,
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
                height: 40.h,
              ),
              Text(
                "Home",
                style:AppTextStyle().textColor29292914w400,
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                },
                child: Row(
                  children: [
                    Text(
                      "Bed",
                      style: AppTextStyle().textColor70707014w400,
                    ),
                    Spacer(),
                    Text(friendDetails!.data!.sizeWeight!.bed.toString(),
                      // '+ Add' ,
                      style: AppTextStyle().textColor29292914w400
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
            ],
          ) ,
        ),
      ),
    );
  }
}
