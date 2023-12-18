import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/constants/urls.dart';
import 'package:swishlist/expanded/widgets/managed_family_member_row.dart';
import 'package:swishlist/models/login_models.dart';

import '../api/notifications/meber_notifiction_aapi.dart';
import '../api/user_apis/family_apis.dart';
import '../constants/globals/loading.dart';
import '../dashboard/family/family_products.dart';
import '../models/get_family_request_model.dart';
import '../models/notification_models/member_index_model.dart';
//import '../models/notification_models/member_notification_models.dart';

class ManageFamilyMembers extends StatefulWidget {
  final LoginResponse response;
  const ManageFamilyMembers({
    Key? key, required this.response,
  }) : super(key: key);

  @override
  State<ManageFamilyMembers> createState() => _ManageFamilyMembersState();
}

class _ManageFamilyMembersState extends State<ManageFamilyMembers> {
  @override


  void initState() {
    getFamilyRequest();
    //get();
   getFamilyMembers();
    super.initState();
  }

  Future<void> _handleRefresh() async {
    getFamilyRequest();
    //get();
    getFamilyMembers();
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

  // bool isLoading = false;
  // GetFamilyModel? familyModel;
  // List<Data> familyModel2 = [];
  // List<Data> familyRequested = [];
  // getFamilyMember() {
  //   isLoading = true;
  //   var resp = getFamilyMemberApi();
  //   resp.then((value) {
  //     familyModel2.clear();
  //     if (value['status'] == true) {
  //       setState(() {
  //         familyModel = GetFamilyModel.fromJson(value);
  //         for (var v in familyModel!.data!) {
  //           if (v.status == "accepted") {
  //             familyModel2.add(v);
  //           }
  //           if (v.status == "requested") {
  //             familyRequested.add(v);
  //             print(familyRequested);
  //           }
  //         }
  //         isLoading = false;
  //       });
  //     } else {
  //       isLoading = false;
  //     }
  //   });
  // }
  //List<Data> familyRequested = [];
  //List<Data> familyAccepted = [];

  bool isLoading = false;

  List<FamilyMemberRequestIndexModel> familyIndex =[];
  //List<FamilyMemberRequestIndexModel> familyRequested =[];

  getFamilyRequest() {
    isLoading = true;
    var resp = getFamilyRequestIndex();
    resp.then((value) {
      familyIndex.clear();

      if (value['error'] == false) {
        setState(() {
          //familyIndex = FamilyMemberRequestIndexModel.fromJson(value);
          for (var v in value['data']) {
            familyIndex.add(FamilyMemberRequestIndexModel.fromJson(v));
          }
            //   if (v.status == "accepted") {
            //     familyModel2.add(v);
            //   }
           /* for(var q in familyIndex){

              if (q.status == "requested") {
                familyRequested.add(q);
              }
            }*/

            //print(familyRequested.first.status.toString());

          //
          print('vvvv${familyIndex.length}');
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });

      }
    });
  }

  //MemberIndexModel? index;
  bool loading = false;
  List<FamilyMemberIndexModel> familyA = [];

 /* get() {
    isLoading = true;
    var resp = getAcceptMember();
    resp.then((value) {
      familyA.clear();
      if (value['status'] == true) {
        setState(() {
          index = MemberIndexModel.fromJson(value);
          for (var v in index!.data!) {
            //   if (v.status == "accepted") {
            //     familyModel2.add(v);
            //   }
            if (v.status == "accepted") {
              familyA.add(v);
            }
          }

          //

          isLoading = false;
        });
      } else {
        isLoading = false;
      }
    });
  }*/

  getFamilyMembers(){
   isLoading = true;
    var resp = familyMemberIndexApi();
    resp.then((value) {
      familyA.clear();
      if(value['error'] == false){
        setState(() {
          for(var v in value['data']){
            familyA.add(FamilyMemberIndexModel.fromJson(v));

          }

          print('mmm ${familyA.length}');
          isLoading = false;

        });
      }
      else{
        setState(() {
          isLoading = false;
        });

      }
    });

  }

  // bool show = false;

  final List<bool> delete = List.generate(1000, (index) => false);
  final List<bool> accept = List.generate(1000, (index) => false);
  final List<bool> remove = List.generate(1000, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // actions: [
        //   GestureDetector(
        //       onTap: () {
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (context) => MembersNotifications()));
        //       },
        //       child: Padding(
        //         padding: const EdgeInsets.all(16.0),
        //         child: familyRequested.isEmpty
        //             ? Container(
        //                 color: Colors.transparent,
        //                 height: 24,
        //                 width: 24,
        //                 child: Stack(
        //                   children: [
        //                     Image.asset(
        //                       "assets/images/notification-pngrepo-com.png",
        //                       color: ColorSelect.color292929,
        //                     ),
        //                     Positioned(
        //                       top: 0,
        //                       right: 0,
        //                       child: Container(
        //                         height: 6,
        //                         width: 6,
        //                         decoration: BoxDecoration(
        //                             color: Colors.redAccent,
        //                             shape: BoxShape.circle),
        //                       ),
        //                     )
        //                   ],
        //                 ))
        //             : Container(
        //                 color: Colors.transparent,
        //                 height: 24,
        //                 width: 24,
        //                 child: Image.asset(
        //                   "assets/images/notification-pngrepo-com.png",
        //                   color: ColorSelect.color292929,
        //                 )),
        //       )),
        // ],
        title: Row(
          children: [
            Text(
              "Manage family members",
              style: AppTextStyle().textColor29292916w500,
            ),
            Spacer(),
          ],
        ),
        leadingWidth: 40,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              "assets/icons/arrowback.svg",
            ),
          ),
        ),
      ),
      body:
      isLoading
          ? Loading()
          :
      RefreshIndicator(
              backgroundColor: Colors.white,
              color: ColorSelect.colorF7E641,
              strokeWidth: 3,
              onRefresh: _handleRefresh,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 40, right: 16),
                  // child:Padding(
                  //         padding: const EdgeInsets.only(top: 40.0),
                  //         child: Center(
                  //             child: Column(
                  //           children: [
                  //             Padding(
                  //               padding:
                  //                   const EdgeInsets.symmetric(horizontal: 30.0),
                  //               child:
                  //                   Image.asset("assets/images/addfriends.png"),
                  //             ),
                  //             Padding(
                  //               padding: const EdgeInsets.only(
                  //                   left: 66, right: 66, top: 24),
                  //               child: Text(
                  //                 "Add family members to share your profile and your favorite product",
                  //                 style: AppTextStyle().roboto29292914w500,
                  //                 textAlign: TextAlign.center,
                  //               ),
                  //             ),
                  //             // SizedBox(height: 40),
                  //             // SizedBox(
                  //             //   height: 50.h,
                  //             //   width: 1.sw,
                  //             //   child: YellowButtonWithIcon(
                  //             //     backgroundColor:
                  //             //     MaterialStateProperty.all(ColorSelect.colorF7E641),
                  //             //     textStyleColor: ColorSelect.color292929,
                  //             //     onTap: tap,
                  //             //     title: buttonTxt,
                  //             //     buttonIcon: buttonIcon,
                  //             //   ),
                  //             // )
                  //           ],
                  //         )),
                  //       ),
                  // AddProductImage(
                  //         image: 'assets/images/addfriends.png',
                  //         txt:
                  //             'Add family members to share your profile and your favorite product',
                  //         buttonTxt: 'Add  Member',
                  //         tap: () {
                  //           Navigator.of(context).push(
                  //             MaterialPageRoute(
                  //               builder: (context) =>
                  //                   const LinkMembersAccount(),
                  //             ),
                  //           );
                  //         },
                  //         buttonIcon: 'assets/images/4xuseradd.png',
                  //       )
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Linked",
                        style: AppTextStyle().textColor70707012w500,
                      ),
                      //if (familyA.isEmpty )
                    familyA.isEmpty ?
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Image.asset("assets/images/delivery.png",height: 100,),
                              SizedBox(height: 5),
                              Text(
                                'No Family Members Yet',
                                style: AppTextStyle().textColor29292914w500,
                              )
                            ],
                          ),
                        )
                    //  else
                    :
                        ListView.builder(
                          padding: EdgeInsets.only(top: 6),
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: familyA.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => FamilyMemberProduct(

                                        familyName:
                                        familyA[i]
                                            .member!
                                            .name!.isEmpty || familyA[i]
                                            .member!
                                            .name == null ? '' :
                                        familyA[i]
                                            .member!
                                            .name!.toString(),

                                        familyUserName:
                                        familyA[i]
                                            .member!
                                            .name!.isEmpty || familyA[i]
                                            .member!
                                            .name == null ? '':
                                        familyA[i]
                                            .member!
                                            .name!.toString() ,


                                        familyId:
                                        familyA[i].member!.id.toString().isEmpty ||
                                            familyA[i].member!.id  == null ? '':
                                        familyA[i]
                                            .member!
                                            .id!.toString(),


                                        familyPhoto:
                                        familyA[i]
                                            .member!
                                            .photo
                                            .toString().isEmpty ||  familyA[i]
                                            .member!
                                            .photo == null ? '':
                                        familyA[i]
                                            .member!
                                            .photo
                                            .toString() ,

                                        id: familyA[i].id.toString().isEmpty || familyA[i].id == null ? '':
                                        familyA[i].id.toString(), response: widget.response,
                                      ),
                                    ),
                                  );
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (_) => FamilyMemberDetails(
                                  //       familyMemberId: familyA[i]
                                  //           .familyMemberUser!
                                  //           .id
                                  //           .toString(),
                                  //     ),
                                  //   ),
                                  // );
                                },
                                child: UserRowWidget(
                                  widget2: GestureDetector(
                                    onTap: () {

                                      setState(() {
                                        remove[i] = !remove[i];
                                      });
                                      Timer timer =
                                          Timer(Duration(seconds: 2), () {
                                        setState(() {
                                          remove[i] = false;
                                        });
                                      });


                                   /*   deleteFamilyMembers(
                                              id: familyA[i].id.toString())
                                          .then((value) => {
                                                if (value['status'] == true)
                                                  {
                                                    setState(() {
                                                      isLoading
                                                          ? Loading()
                                                          : _handleRefresh();
                                                    }),
                                                    Fluttertoast.showToast(
                                                        msg: value['message']),
                                                  }
                                                else
                                                  {
                                                    Fluttertoast.showToast(
                                                        msg: value['message']),
                                                  }
                                              });*/

                                      deleteFamilyMembers(id: familyA[i].id!.toInt() ).then((value) {
                                        if(value['error'] == false){
                                          setState(() {
                                            isLoading ? Loading()
                                            :
                                                _handleRefresh();
                                          });
                                          print(familyA[i].member!.id.toString());
                                          print(familyA[i].id.toString());

                                        }
                                        else{
                                          // Fluttertoast.showToast(
                                          //     msg: value['message']);
                                        }
                                      });

                                    },
                                    child: remove[i]
                                        ? CircularProgressIndicator(
                                            color: Colors.yellow,
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Colors.redAccent
                                                  .withOpacity(0.65),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text("Remove"),
                                            )),
                                  ),
                                  familyName:
                                  // familyA[i]
                                  //     .member!
                                  //     .name!.isEmpty ||
                                      familyA[i]
                                      .member!
                                      .name == null ?
                                      '':
                                  familyA[i]
                                      .member!
                                      .name!.toString()
                                      //: ''
                                  ,

                                  // familyUserName:
                                  // familyA[i]
                                  //     .member!
                                  //     .name!.isEmpty || familyA[i]
                                  //     .member!
                                  //     .name == null ?
                                  // familyA[i]
                                  //     .member!
                                  //     .name!.toString() : '',
                                  //

                                  familyPhoto:
                                  familyA[i]
                                      .member!
                                      .photo
                                      .toString()
                                          .contains('http')
                                      ? familyA[i]
                                          .member!
                                          .photo
                                          .toString()
                                      : newBaseUrl +
                                          familyA[i]
                                              .member!
                                              .photo
                                              .toString(),


                                  familyRelation:
                                  familyA[i].member!.status.toString().isEmpty || familyA[i].member!.status == null ?
                                  familyA[i].member!.status.toString() : '',

                                  id: familyA[i].member!.id.toString().isEmpty || familyA[i].member!.id == null ?
                                  familyA[i].member!.id.toString() : ''
                                  ,
                                  tap: () {
                                    // deleteFamilyMembers(id: familyModel2[i].id.toString())
                                    //     .then((value) => {
                                    //           if (value['status'] == true)
                                    //             {
                                    //               setState(() {
                                    //                 isLoading ? Loading() : getFamilyMember();
                                    //               }),
                                    //               Fluttertoast.showToast(msg: value['message']),
                                    //             }
                                    //           else
                                    //             {
                                    //               Fluttertoast.showToast(msg: value['message']),
                                    //             }
                                    //         });
                                  },
                                  familyUsername:
                                // familyA[i]
                                //     .member!
                                //     .name!.isEmpty ||
                                    familyA[i]
                                    .member!
                                    .name == null ? '':
                                familyA[i]
                                    .member!
                                    .name!.toString() ,
                                ),
                              ),
                            );
                          },
                        ),
                      SizedBox(
                        height: 20.h,
                      ),
                      // Text(
                      //   "Manged by me",
                      //   style: AppTextStyle().textColor70707012w500,
                      // ),
                      // ListView.builder(
                      //     physics: NeverScrollableScrollPhysics(),
                      //     // scrollDirection: Axis.vertical,
                      //     shrinkWrap: true,
                      //     itemCount: 2,
                      //     itemBuilder: (BuildContext context, int index) {
                      //       return Padding(
                      //         padding: const EdgeInsets.only(bottom: 20),
                      //         child: MangedByMeWidget(),
                      //       );
                      //     }),
                      SizedBox(
                        height: 20.h,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Requested",
                          style: AppTextStyle().textColor70707012w500,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      familyIndex.isEmpty
                          ?
    Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Image.asset("assets/images/delivery.png",height: 100,),
                                  SizedBox(height: 5),
                                  Text(
                                    'No Family Requests',
                                    style: AppTextStyle().textColor29292914w500,
                                  )
                                ],
                              ),
                            )
                          :


    ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: familyIndex.length,
                              itemBuilder: (context, i) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: UserRowWidget(
                                    widget: GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        setState(() {
                                          accept[i] = !accept[i];
                                        });
                                        Timer timer =
                                            Timer(Duration(seconds: 2), () {
                                          setState(() {
                                            accept[i] = false;
                                          });
                                        });



                                        familyMemberUpdateApi(
                                                status: 'accepted',
                                                id: familyIndex[i].id
                                                    .toString())
                                            .then((value) async {
                                          if (value['error'] == false) {
                                            setState(() {
                                              isLoading
                                                  ? Loading()
                                                  : _handleRefresh();
                                            });
                                            // SharedPrefs().setPassword(passwordController.text);
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) => EmcailVerification(
                                            //       email: emailController.text,
                                            //       password: passwordController.text,
                                            //     ),
                                            //   ),
                                            // );
                                            Fluttertoast.showToast(
                                                msg: value['message']);

                                            // SharedPrefs().setPassword(passwordController.toString());
                                            // print(SharedPrefs().setPassword(passwordController.toString()));
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: value['message']);
                                          }
                                        });
                                      },
                                      child: accept[i]
                                          ? CircularProgressIndicator(
                                              color: Colors.yellow,
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: ColorSelect.colorF7E641,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text("Accept"),
                                              ),
                                            ),
                                    ),


                                    widget2: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          delete[i] = !delete[i];
                                        });
                                        Timer timer =
                                            Timer(Duration(seconds: 2), () {
                                          setState(() {
                                            delete[i] = false;
                                          });
                                        });



                                        familyMemberUpdateApi(
                                                status: 'rejected',
                                                id: familyIndex[i].id
                                                    .toString())
                                            .then((value) async {
                                          if (value['error'] == false) {
                                            setState(() {
                                              isLoading
                                                  ? Loading()
                                                  : getFamilyRequest();
                                            });
                                            // SharedPrefs().setPassword(passwordController.text);
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) => EmailVerification(
                                            //       email: emailController.text,
                                            //       password: passwordController.text,
                                            //     ),
                                            //   ),
                                            // );
                                            Fluttertoast.showToast(
                                                msg: value['message']);

                                            // SharedPrefs().setPassword(passwordController.toString());
                                            // print(SharedPrefs().setPassword(passwordController.toString()));
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: value['message']);
                                          }
                                        });
                                      },
                                      child: delete[i]
                                          ? CircularProgressIndicator(
                                              color: Colors.yellow,
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: Colors.redAccent
                                                    .withOpacity(0.65),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text("Reject"),
                                              )),
                                    ),
                                    familyName: familyIndex[i].requestBy!.
                                        name
                                        .toString(),
                                    familyUsername: familyIndex[i]
                                        .requestBy!.name

                                        .toString(),
                                    familyPhoto: familyIndex[i]
                                            .requestBy!
                                            .photo
                                            .toString()
                                            .contains('http')
                                        ? familyIndex[i]
                                            .requestBy!
                                            .photo
                                            .toString()
                                        : newBaseUrl +
                                            familyIndex[i]
                                                .requestBy!
                                                .photo
                                                .toString(),
                                    familyRelation:
                                        familyIndex[i].status.toString(),
                                    id: familyIndex[i].id.toString(),
                                    tap: () {
                                      // deleteFamilyMembers(id: familyModel2[i].id.toString())
                                      //     .then((value) => {
                                      //           if (value['status'] == true)
                                      //             {
                                      //               setState(() {
                                      //                 isLoading ? Loading() : getFamilyMember();
                                      //               }),
                                      //               Fluttertoast.showToast(msg: value['message']),
                                      //             }
                                      //           else
                                      //             {
                                      //               Fluttertoast.showToast(msg: value['message']),
                                      //             }
                                      //         });
                                    },
                                  ),
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
