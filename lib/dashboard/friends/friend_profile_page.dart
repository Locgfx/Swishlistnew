import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swishlist/constants/globals/loading.dart';
import '../../api/user_apis/friends_api.dart';
import '../../constants/color.dart';
import '../../models/friends_details_model.dart';

class FProfile extends StatefulWidget {
  final String friendId;
  const FProfile({Key? key,
    required this.friendId}) : super(key: key);

  @override
  State<FProfile> createState() => _FProfileState();
}

class _FProfileState extends State<FProfile> {


  @override
  void initState() {
    getFriendDetails();
    super.initState();
  }

  bool isLoading = true;
  FriendDetailsModel friendDetails = FriendDetailsModel(
    data: Data(
      profile: Profile(
        name: '',
        photo: '',
        gender: '',
        occupation: '',
        relationStatus: '',
        email: '',
        phone: '',
        alternatePhone: '',
        homeAddress: '',
        workAddress: '',
        privacyStatus: '',
        createdAt: '',
      )
    )
  );

  getFriendDetails() {
    isLoading = true;
    var resp = friendDetailsApi(friendUserId: widget.friendId);
    resp.then((value) {
      if(mounted) {
        if(value['status'] == true) {
          if(value['message'] == "No Data") {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Profile",
          style: AppTextStyle().textColor39393916w500,
        ),
        centerTitle: false,
      ),
      body:isLoading ? Loading(): SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child:
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Personal",
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
                      "Name",
                      style: AppTextStyle().textColor70707014w400,
                    ),
                    Spacer(),

                    Text(
                        friendDetails.data!.profile!.name.toString() == '' ?
                        'No Name added yet' :
                        friendDetails.data!.profile!.name.toString(),
                      // 'Harry Wilson',
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
                      "Gender",
                      style: AppTextStyle().textColor70707014w400,
                    ),
                    Spacer(),
                    // friendDetails.data!.profile!.gender!.isEmpty?
                    // Text(
                    //   friendDetails.data!.profile!.gender!.toString(),
                    //   style:
                    //   AppTextStyle().textColor29292914w400,
                    // ):
                    Text(
                      friendDetails.data!.profile!.gender.toString()=='' ?
                      'Gender is not added yet':
                      friendDetails.data!.profile!.gender.toString(),
                      // 'Male',
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
                      "Date of birth",
                      style: AppTextStyle().textColor70707014w400,
                    ),
                    Spacer(),
                    SizedBox(
                      width: 5.w,
                    ),

                    // friendDetails.data!.profile!.dob!.isEmpty?
                    // Text(
                    //   friendDetails.data!.profile!.dob.toString(),
                    //   style:
                    //   AppTextStyle().textColor29292914w400,
                    // ):
                    Text(
                      friendDetails.data!.profile!.dob.toString() == '' ?
                      'Dob is not added yet' :
                      friendDetails.data!.profile!.dob.toString(),
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
                height: 20.h,
              ),
              Row(
                children: [
                  Text(
                    "Occupation",
                    style: AppTextStyle().textColor70707014w400,
                  ),
                  Spacer(),
                  SizedBox(
                    width: 5.w,
                  ),
                  // friendDetails.data!.profile!.occupation!.isEmpty?
                  // Text(
                  //   friendDetails.data!.profile!.occupation.toString(),
                  //   style:
                  //   AppTextStyle().textColor29292914w400,
                  // ):
                  Text(
                    friendDetails.data!.profile!.occupation.toString() == '' ?
                    'Occupation is not added yet' :
                    friendDetails.data!.profile!.occupation.toString(),
                    style:AppTextStyle().textColor29292914w400,
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Text(
                    "Relationship Status",
                    style: AppTextStyle().textColor70707014w400,
                  ),
                  Spacer(),
                  SizedBox(
                    width: 5.w,
                  ),
                  // friendDetails.data!.profile!.relationStatus!.isEmpty?
                  // Text(
                  //   friendDetails.data!.profile!.relationStatus.toString(),
                  //   style:
                  //   AppTextStyle().textColor29292914w400,
                  // ):
                  Text(
                    friendDetails.data!.profile!.relationStatus.toString() == '' ?
                    'Relationship is not added yet'  :
                    friendDetails.data!.profile!.relationStatus.toString(),
                    style:AppTextStyle().textColor29292914w400,
                  ),
                  // Image.asset("assets/images/information2.png"),
                  // SizedBox(
                  //   width: 20.w,
                  // ),
                  // Image.asset("assets/images/Vector175.png"),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              Text(
                "Contact",
                style:AppTextStyle().textColor29292914w400,
              ),
              SizedBox(
                height: 20.h,
              ),
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
                      "Phone",
                      style: AppTextStyle().textColor70707014w400,
                    ),
                    Spacer(),
                    // friendDetails.data!.profile!.phone!.isEmpty?
                    // Text(
                    //   friendDetails.data!.profile!.phone.toString(),
                    //   style:
                    //   AppTextStyle().textColor29292914w400,
                    // ):
                    Text(
                        friendDetails.data!.profile!.phone.toString() == '' ?
                        'phone is not added yet':
                        friendDetails.data!.profile!.phone.toString(),
                        style: AppTextStyle().textColor29292914w400
                    ),

                  ],
                ),
              ),
              SizedBox(height: 20.h,),
              Row(
                children: [
                  Text(
                    "Alternate Phone",
                    style: AppTextStyle().textColor70707014w400,
                  ),
                  Spacer(),
                  SizedBox(
                    width: 5.w,
                  ),
                  // friendDetails.data!.profile!.alternatePhone!.isEmpty?
                  // Text(
                  //   friendDetails.data!.profile!.alternatePhone.toString(),
                  //   style:
                  //   AppTextStyle().textColor29292914w400,
                  // ):
                  Text(
                    friendDetails.data!.profile!.alternatePhone.toString() == '' ?
                    'Alternate phone is not added yet' :
                    friendDetails.data!.profile!.alternatePhone.toString(),
                    style:AppTextStyle().textColor29292914w400,
                  ),
                ],
              ),
              SizedBox(height: 20.h,),
              Row(
                children: [
                  Text(
                    "Email",
                    style: AppTextStyle().textColor70707014w400,
                  ),
                  Spacer(),
                  SizedBox(
                    width: 5.w,
                  ),
                  // friendDetails.data!.profile!.email!.isEmpty?
                  // Text(
                  //   friendDetails.data!.profile!.email.toString(),
                  //   style:
                  //   AppTextStyle().textColor29292914w400,
                  // ):
                  Text(
                    friendDetails.data!.profile!.email.toString() == '' ?
                    'Email is not added yet' :
                    friendDetails.data!.profile!.email.toString(),
                    style:AppTextStyle().textColor29292914w400,
                  ),
                ],
              ),
              SizedBox(
                height: 40.h,
              ),
              Text(
                "Address",
                style:AppTextStyle().textColor29292914w400,
              ),
              SizedBox(height: 20.h,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Home",
                    style: AppTextStyle().textColor70707014w400,
                  ),
                  SizedBox(height: 10.h),
                  // friendDetails.data!.profile!.homeAddress!.isEmpty?
                  // Text(
                  //   friendDetails.data!.profile!.homeAddress.toString(),
                  //   style:
                  //   AppTextStyle().textColor29292914w400,
                  // ):
                  Text(
                    friendDetails.data!.profile!.homeAddress.toString() == '' ?
                    'home address is not added yet':
                    friendDetails.data!.profile!.homeAddress.toString(),
                    style:AppTextStyle().textColor29292914w400,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              SizedBox(height: 20.h,),
              Row(
                children: [
                  Text(
                    "work Address",
                    style: AppTextStyle().textColor70707014w400,
                  ),
                  Spacer(),
                  SizedBox(
                    width: 5.w,
                  ),
                  // friendDetails.data!.profile!.workAddress!.isEmpty?
                  // Text(
                  //   friendDetails.data!.profile!.workAddress.toString(),
                  //   style:
                  //   AppTextStyle().textColor29292914w400,
                  // ):
                  Text(
                    friendDetails.data!.profile!.workAddress.toString() == '' ?
                    'work Address is not added yet' :
                    friendDetails.data!.profile!.workAddress.toString(),
                    style:AppTextStyle().textColor29292914w400,
                  ),
                ],
              ),
              // SizedBox(height: 20.h,),
              // Row(
              //   children: [
              //     Text(
              //       "City",
              //       style: AppTextStyle().textColor70707014w400,
              //     ),
              //     Spacer(),
              //     SizedBox(
              //       width: 5.w,
              //     ),
              //     Text(
              //       'Houston',
              //       style:AppTextStyle().textColor29292914w400,
              //     ),
              //   ],
              // ),
              // SizedBox(height: 20.h,),
              // Row(
              //   children: [
              //     Text(
              //       "State",
              //       style: AppTextStyle().textColor70707014w400,
              //     ),
              //     Spacer(),
              //     SizedBox(
              //       width: 5.w,
              //     ),
              //     Text(
              //       'Texas',
              //       style:AppTextStyle().textColor29292914w400,
              //     ),
              //   ],
              // ),
              // SizedBox(height: 20.h,),
              // Row(
              //   children: [
              //     Text(
              //       "Zip Code",
              //       style: AppTextStyle().textColor70707014w400,
              //     ),
              //     Spacer(),
              //     SizedBox(
              //       width: 5.w,
              //     ),
              //     Text(
              //       '77042',
              //       style:AppTextStyle().textColor29292914w400,
              //     ),
              //   ],
              // ),
              // SizedBox(height: 20.h,),
              // Row(
              //   children: [
              //     Text(
              //       "Country",
              //       style: AppTextStyle().textColor70707014w400,
              //     ),
              //     Spacer(),
              //     SizedBox(
              //       width: 5.w,
              //     ),
              //     Text(
              //       'United States',
              //       style:AppTextStyle().textColor29292914w400,
              //     ),
              //   ],
              // ),
              SizedBox(height: 20.h,),
            ],
          ),
        ),
    /*    child: Container(
          constraints: BoxConstraints(maxHeight: 1.sh),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Personal', style: AppTextStyle().textColor29292914w600),
              for (int i = 0; i < personalDetails.length; i++)
                ProfileRowValue(title: personalDetails[i], value: 'Value'),
              SizedBox(height: 24),
              Text('Contact', style: AppTextStyle().textColor29292914w600),
              for (int i = 0; i < contactDetails.length; i++)
                ProfileRowValue(title: contactDetails[i], value: 'Value'),
              SizedBox(height: 24),
              Text('Addresses', style: AppTextStyle().textColor29292914w600),
              SizedBox(height: 16),
              Text('Home', style: AppTextStyle().k84848414w400Roboto),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                        'Address Value: 2850 Rogerdale Rd, Houston, Texas, United States, 77042'),
                  ),
                  Image.asset('assets/images/directiondown01.png')
                ],
              ),
              for (int i = 0; i < addressValues.length; i++)
                ProfileRowValue(title: addressValues[i], value: 'Value'),
              SizedBox(height: 24),
              Text('Education', style: AppTextStyle().textColor29292914w600),
              for (int i = 0; i < eduValues.length; i++)
                ProfileRowValue(title: eduValues[i], value: 'Value'),
              SizedBox(height: 24),
            ],
          ),
        ),*/
      ),
    );
  }
}

class ProfileRowValue extends StatelessWidget {
  final String title;
  final String value;
  const ProfileRowValue({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyle().k84848414w400Roboto,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                value,
                style: AppTextStyle().textColor29292914w400,
              ),
              SizedBox(width: 8),
              SizedBox(
                width: 20,
                height: 20,
                child: Image.asset('assets/images/copy.png'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
