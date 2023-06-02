import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/constants/urls.dart';
import 'package:swishlist/expanded/add_family_member_details.dart';
import 'package:swishlist/expanded/widgets/managed_family_member_row.dart';

import '../api/user_apis/family_apis.dart';
import '../constants/globals/loading.dart';
import '../models/family_model.dart';

class ManageFamilyMembers extends StatefulWidget {
  const ManageFamilyMembers({Key? key}) : super(key: key);

  @override
  State<ManageFamilyMembers> createState() => _ManageFamilyMembersState();
}

class _ManageFamilyMembersState extends State<ManageFamilyMembers> {
  @override
  void initState() {
    getFamilyMember();
    super.initState();
  }
  bool isLoading = false;
  GetFamilyModel? familyModel;
  List<Data> familyModel2 = [];
  List<Data> familyRequested = [];
  getFamilyMember() {
    isLoading = true;
    var resp = getFamilyMemberApi();
    resp.then((value) {
      if(value['status'] == true) {
        setState(() {
          familyModel = GetFamilyModel.fromJson(value);
          for (var v in familyModel!.data!) {
            if (v.status == "accepted") {
              familyModel2.add(v);
            }
            if(v.status == "requested") {
              familyRequested.add(v);

            }
          }
          isLoading = false;
        });
      } else{
        isLoading = false;
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
        title: Row(
          children: [
            Text(
              "Manage family members",
              style: AppTextStyle().textColor29292916w500,
            ),
            Spacer(),
            // Padding(
            //   padding: const EdgeInsets.only(right: 24),
            //   child: GestureDetector(
            //     onTap: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => AddFamilyMemberDetails()));
            //     },
            //     child: Container(
            //       // color: Colors.red,
            //       child: Padding(
            //         padding: const EdgeInsets.only(left: 8,top: 8,bottom: 8),
            //         child: SvgPicture.asset(
            //           "assets/icons/Union.svg",
            //           height: 14,
            //           width: 14,
            //         ),
            //       ),
            //     ),
            //   ),
            // )
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
      body: isLoading ? Loading() :SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Linked",
                style: AppTextStyle().textColor70707012w500,
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: familyModel2.length,
                  itemBuilder: (context,i) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: UserRowWidget(
                        familyName: familyModel2[i].familyMemberUser!.name.toString(),
                        familyUsername: familyModel2[i].familyMemberUser!.username.toString(),
                        familyPhoto: baseUrl+familyModel2[i].familyMemberUser!.photo.toString(),
                        familyRelation: familyModel2[i].relation.toString(),
                        id: familyModel2[i].familyMemberUserId.toString(),
                      ),
                    );
                  },
                ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Manged by me",
                style: AppTextStyle().textColor70707012w500,
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  // scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: MangedByMeWidget(),
                    );
                  }),
              SizedBox(
                height: 20.h,
              ),
              Text(
                "Requested",
                style: AppTextStyle().textColor70707012w500,
              ),
              SizedBox(
                height: 20.h,
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: familyRequested.length,
                itemBuilder: (context,i) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: UserRowWidget(
                      familyName: familyRequested[i].familyMemberUser!.name.toString(),
                      familyUsername: familyRequested[i].familyMemberUser!.username.toString(),
                      familyPhoto: baseUrl+familyRequested[i].familyMemberUser!.photo.toString(),
                      familyRelation: familyRequested[i].relation.toString(),
                      id: familyRequested[i].familyMemberUserId.toString(),
                      widget: GestureDetector(
                          onTap: () {
                            updateFamilyMember(
                                status: 'cancelled',
                                id: familyModel!.data![i].id.toString(),
                                familyMemberId: familyRequested[i].familyMemberUserId.toString(),
                                relation: familyRequested[i].relation.toString(),
                                privacy: 'public').then((value) {
                              if(value['status'] ==  true) {
                                Fluttertoast.showToast(msg: value['message']);
                              } else {
                                Fluttertoast.showToast(msg: value['message']);
                              }

                            });
                          },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                          child: Text(
                            "Cancel Request",
                            textAlign: TextAlign.right,
                            style: AppTextStyle().textColorC92C2C14w500,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),

              // Row(
              //   children: [
              //     Column(
              //       children: [
              //         CircleAvatar(
              //           radius: 20,
              //           backgroundColor: Colors.grey,
              //           backgroundImage:
              //               AssetImage('assets/images/Rectangle3194.png'),
              //         ),
              //       ],
              //     ),
              //     SizedBox(
              //       width: 10.w,
              //     ),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           "Ryan Howard",
              //           style: AppTextStyle().textColor29292914w500,
              //         ),
              //         SizedBox(
              //           height: 10.h,
              //         ),
              //         Text(
              //           "Ryan372882",
              //           style: AppTextStyle().textColor70707014w400,
              //         )
              //       ],
              //     ),
              //     Spacer(),
              //     Padding(
              //       padding: const EdgeInsets.only(right: 16),
              //       child: Text(
              //         "Cancel Request",
              //         style: AppTextStyle().textColorC92C2C14w500,
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
