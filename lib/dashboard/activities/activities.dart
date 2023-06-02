// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:swishlist/buttons/yellow_button.dart';
// import 'package:swishlist/constants/urls.dart';
// import '../../api/user_apis/activities_api.dart';
// import '../../api/user_apis/activity_store_model.dart';
// import '../../constants/color.dart';
// import '../../constants/globals/loading.dart';
// import '../../models/activity_model.dart';
// import 'friendwants.dart';
//
// class Activities extends StatefulWidget {
//   const Activities({Key? key}) : super(key: key);
//
//   @override
//   State<Activities> createState() => _ActivitiesState();
// }
//
// class _ActivitiesState extends State<Activities> {
//     @override
//   void initState() {
//     getActivity();
//     super.initState();
//   }
//
//   bool emptyData = true;
//   bool isLoading = false;
//
//   GetActivityModel? activity;
//   ActivityStoreModel? storeModel;
//
//     getActivity() {
//       getActivityApi().then((value) {
//         if (value.status) {
//
//           setState(() {
//             activity = value;
//             //print(activity1!.data.length);
//           });
//         }
//       });
//     }
//
//   //   getActivity() {
//   //   isLoading = true;
//   //   var resp = getActivityApi();
//   //   resp.then((value) {
//   //     if(value['status'] == true) {
//   //       setState(() {
//   //         activity = GetActivityModel.fromJson(value);
//   //         isLoading = false;
//   //       });
//   //     } else {
//   //       isLoading = false;
//   //     }
//   //   });
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body:  isLoading ? Loading() : SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(
//               left: 16,
//               right:16 ,
//               bottom: 120
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 52,
//               ),
//               Text(
//                 "Activities",
//                 style: AppTextStyle().ubuntu29292924w700,
//               ),
//               SizedBox(
//                 height: 32,
//               ),
//               Text(
//                 "This week",
//                 style: AppTextStyle().textColor70707012w500,
//               ),
//               SizedBox(height: 11),
//               if (activity != null)
//                 if (activity!.data!.isNotEmpty)
//               MediaQuery.removePadding(
//                 context: context,
//                 removeTop: true,
//                 removeBottom: true,
//                 child: ListView.separated(
//                   itemCount: activity!.data!.length,
//                   // itemCount: 4,
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemBuilder: (context, i) {
//                     return Container(
//                       child: GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => FriendWants()));
//                         },
//                         child: Container(
//                           color: Colors.transparent,
//                           child: Column(
//                             children: [
//                               Row(
//                                 children: [
//                                 Container(
//                                   height:48,
//                                   width:48,
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color:Colors.grey.shade200,
//                                   ),
//                                   clipBehavior: Clip.hardEdge,
//                                   child: CachedNetworkImage(
//                                     imageUrl: baseUrl+activity!.data![i].leadUser!.photo!,
//                                     fit: BoxFit.cover,
//                                     errorWidget: (context, url, error) =>
//                                         Icon(Icons.error),
//                                     progressIndicatorBuilder:  (a,b,c) =>
//                                         Opacity(
//                                           opacity: 0.2,
//                                           child: Shimmer.fromColors(
//                                             baseColor: Colors.black12,
//                                             highlightColor: Colors.white,
//                                             child: Container(
//                                               width: 50,
//                                               height: 50,
//                                               //margin: EdgeInsets.symmetric(horizontal: 24),
//                                               decoration: BoxDecoration(
//                                                   color: Colors.white,
//                                                   shape: BoxShape.circle
//                                               ),
//                                             ),
//
//                                           ),
//                                         ),
//                                   ),
//                                 ),
//                                   // CircleAvatar(
//                                   //   radius: 24,
//                                   //   backgroundColor: Colors.grey,
//                                   //   backgroundImage: AssetImage(
//                                   //       'assets/images/Rectangle3194.png'),
//                                   // ),
//                                   SizedBox(width: 8),
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "Someone shared 1 product with you",
//                                           style: AppTextStyle()
//                                               .robotocolor1F1F1F13w400,
//                                         ),
//                                         Text(
//                                             DateTime.now().difference(DateTime.parse(
//                                                 activity!.data![i].createdAt!
//                                             )).inMinutes <=
//                                                 59
//                                                 ? "${DateTime.now().difference(DateTime.parse(
//                                                 activity!.data![i].createdAt!)).inMinutes
//                                             } min ago" :
//                                             DateTime.now().difference(DateTime.parse(
//                                                 activity!.data![i].createdAt!
//                                             )).inHours <=
//                                                 23?
//                                             "${DateTime.now().difference(DateTime.parse(
//                                                 activity!.data![i].createdAt!)).inHours} hour ago" :
//                                             "${DateTime.now().difference(DateTime.parse(
//                                                 activity!.data![i].createdAt!)).inDays} day ago",
//                                           // "Just now",
//                                           style: AppTextStyle()
//                                               .robotocolor7C7F8C12w400,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 8,
//                                   ),
//                                   Container(
//                                     height:48,
//                                     width:48,
//                                         decoration: BoxDecoration(
//                                           color: Colors.grey.shade200,
//                                         borderRadius: BorderRadius.circular(8),
//                                         border: Border.all(
//                                             width: 1,
//                                             color: ColorSelect.colorDCDCE6
//                                         ),),
//                                     clipBehavior: Clip.hardEdge,
//                                     child: CachedNetworkImage(
//                                       imageUrl: baseUrl+activity!.data![i].product!.photo!,
//                                       fit: BoxFit.cover,
//                                       errorWidget: (context, url, error) =>
//                                           Icon(Icons.error),
//                                       progressIndicatorBuilder:  (a,b,c) =>
//                                           Opacity(
//                                             opacity: 0.2,
//                                             child: Shimmer.fromColors(
//                                               baseColor: Colors.black12,
//                                               highlightColor: Colors.white,
//                                               child: Container(
//                                                 width: 50,
//                                                 height: 50,
//                                                 //margin: EdgeInsets.symmetric(horizontal: 24),
//                                                 decoration: BoxDecoration(
//                                                     color: Colors.white,
//                                                     shape: BoxShape.circle
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                     ),
//                                   ),
//                                   // Container(
//                                   //   height: 52,
//                                   //   width: 52,
//                                   //   decoration: BoxDecoration(
//                                   //       borderRadius: BorderRadius.circular(8),
//                                   //       border: Border.all(
//                                   //           width: 1,
//                                   //           color: ColorSelect.colorDCDCE6)),
//                                   //   child: Center(
//                                   //     child: Padding(
//                                   //       padding: const EdgeInsets.symmetric(
//                                   //           horizontal: 16, vertical: 8),
//                                   //       child: Image.asset(
//                                   //           "assets/images/image10.png"),
//                                   //     ),
//                                   //   ),
//                                   // )
//                                 ],
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                   separatorBuilder: (BuildContext context, int index) {
//                     return SizedBox(
//                       height: 16,
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 "Earlier",
//                 style: AppTextStyle().textColor70707012w500,
//               ),
//               SizedBox(
//                 height: 12,
//               ),
//               if (activity != null)
//                 if (activity!.data!.isNotEmpty)
//               MediaQuery.removePadding(
//                 context: context,
//                 removeTop: true,
//                 removeBottom: true,
//                 child: ListView.separated(
//                   itemCount: activity!.data!.length,
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemBuilder: (context, i) {
//                     return Container(
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               Container(
//                                 height:48,
//                                 width:48,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color:Colors.grey.shade200,
//                                 ),
//                                 clipBehavior: Clip.hardEdge,
//                                 child: CachedNetworkImage(
//                                   imageUrl: baseUrl+activity!.data![i].leadUser!.photo!,
//                                   fit: BoxFit.cover,
//                                   errorWidget: (context, url, error) =>
//                                       Icon(Icons.error),
//                                   progressIndicatorBuilder:  (a,b,c) =>
//                                       Opacity(
//                                         opacity: 0.2,
//                                         child: Shimmer.fromColors(
//                                           baseColor: Colors.black12,
//                                           highlightColor: Colors.white,
//                                           child: Container(
//                                             width: 50,
//                                             height: 50,
//                                             //margin: EdgeInsets.symmetric(horizontal: 24),
//                                             decoration: BoxDecoration(
//                                                 color: Colors.white,
//                                                 shape: BoxShape.circle
//                                             ),
//                                           ),
//
//                                         ),
//                                       ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 8,
//                               ),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "Someone shared 1 product with you",
//                                       style:
//                                       AppTextStyle().robotocolor1F1F1F13w400,
//                                     ),
//                                     SizedBox(
//                                       height: 8,
//                                     ),
//                                     Text(
//                                       "Just now",
//                                       style:
//                                       AppTextStyle().robotocolor7C7F8C12w400,
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(width: 10),
//                               SizedBox(
//                                 height: 36,
//                                 width: 64,
//                                 child: YellowButtonWithText(
//                                   backgroundColor: MaterialStateProperty.all(
//                                       ColorSelect.colorF7E641),
//                                   textStyleColor: ColorSelect.color292929,
//                                   title: 'Add',
//                                   onTap: () {
//                                     postActivityApi(
//                                         userid: storeModel!.data!.userId.toString(),
//                                         leadUserid: storeModel!.data!.leadUserId.toString(),
//                                         productId: storeModel!.data!.productId.toString()).
//                                     then((value) {
//                                       if(value['status'] == true) {
//                                         Fluttertoast.showToast(msg: value['message']);
//                                       } else {
//                                         Fluttertoast.showToast(msg: value['message']);
//
//                                       }
//                                     });
//                                   },
//                                 ),
//                               )
//                             ],
//                           )
//                         ],
//                       ),
//                     );
//                   },
//                   separatorBuilder: (BuildContext context, int index) {
//                     return SizedBox(height: 16);
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/buttons/yellow_button.dart';
import 'package:intl/intl.dart';
import '../../api/user_apis/activities_api.dart';
import '../../api/user_apis/activity_store_model.dart';
import '../../constants/color.dart';
import '../../constants/globals/loading.dart';
import '../../constants/urls.dart';
import '../../models/activity1_model.dart';
import 'friendwants.dart';

class Activities extends StatefulWidget {
  const Activities({Key? key}) : super(key: key);

  @override
  State<Activities> createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  @override
  void initState() {
    getActivity();
    super.initState();
  }

  Activity1? activity1;
  ActivityStoreModel? activityStore;
  // ActivityStore? activityStore1;
  // ActivityStoreModel? storeModel;
  bool isLoading = false;
  getActivity() {
    isLoading = true;
    activity().then((value) {
      if (value.status) {
        setState(() {
          activity1 = value;
          isLoading = false;
          //print(activity1!.data.length);
        });
      } else {
        isLoading = false;
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading ? Loading(): SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 52,
              ),
              Text(
                "Activities",
                style: AppTextStyle().ubuntu29292924w700,
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                "This week",
                style: AppTextStyle().textColor70707012w500,
              ),
              SizedBox(height: 11),
              // Center(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Icon(Icons.error_outline,color: Colors.black,size: 80,),
              //       // Image.asset("assets/images/delivery.png",height: 100,),
              //       SizedBox(height: 5),
              //       Text('No Activities Found',
              //         style: AppTextStyle().textColor29292914w500,)
              //     ],
              //   ),
              // )


              //
              // if (activity1 != null)
              //   if (activity1!.data.isNotEmpty)
                  activity1!.data!.isEmpty ?
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline,color: Colors.black,size: 80,),
                        // Image.asset("assets/images/delivery.png",height: 100,),
                        SizedBox(height: 5),
                        Text('No Activities Found',
                          style: AppTextStyle().textColor29292914w500,)
                      ],
                    ),
                  ) :
                  MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    removeBottom: true,
                    child: ListView.separated(
                      itemCount: activity1!.data!.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        // print(activity1!.data.length);
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FriendWants()));
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        shape: BoxShape.circle,
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                        baseUrl+activity1!.data![i].user!.photo.toString(),
                                        fit: BoxFit.cover,
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                        progressIndicatorBuilder:  (a,b,c) =>
                                            Opacity(
                                              opacity: 0.3,
                                              child: Shimmer.fromColors(
                                                baseColor: Colors.black12,
                                                highlightColor: Colors.white,
                                                child: Container(
                                                  // width: 50,
                                                  // height: 50,
                                                  //margin: EdgeInsets.symmetric(horizontal: 24),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle
                                                  ),
                                                ),
                                              ),
                                            ),
                                      ),
                                      // child: Image.asset(
                                      //   'assets/images/Rectangle319.png',
                                      //   fit: BoxFit.fill,
                                      // ),
                                    ),
                                   //  CircleAvatar(
                                   //      radius: 24,
                                   //      backgroundColor: Colors.grey,
                                   //      //Todo: network image error widget
                                   //      backgroundImage: NetworkImage(
                                   //          '${baseUrl}${activity1!.data![i].user!.photo}') /*Image.network(
                                   //
                                   //
                                   // */
                                   //  ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${activity1!.data![i].user!.name} shared 1 product with you",
                                            style: AppTextStyle()
                                                .robotocolor1F1F1F13w400,
                                          ),
                                          Text(
                                              DateTime.now()
                                              .difference(
                                              DateTime.parse(
                                                  activity1!
                                                      .data![i].createdAt.toString()))
                                              .inMinutes <=
                                              59
                                              ? "${DateTime.now().difference(DateTime.parse(activity1!
                                                  .data![i].createdAt.toString())).inMinutes} min ago"
                                              : DateTime.now()
                                              .difference(DateTime
                                              .parse(activity1!
                                                  .data![i].createdAt.toString()))
                                              .inHours <=
                                              23
                                              ? "${DateTime.now().difference(DateTime.parse(activity1!
                                                  .data![i].createdAt.toString())).inHours} hr ago"
                                              : "${DateTime.now().difference(DateTime.parse(activity1!
                                                  .data![i].createdAt.toString())).inDays} days ago"),

                                          /*Text(
                                            "${activity1!.data[i].createdAt}",
                                            style: AppTextStyle()
                                                .robotocolor7C7F8C12w400,
                                          )*/
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      height: 52,
                                      width: 52,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(8),
                                          border: Border.all(
                                              width: 1,
                                              color:
                                              ColorSelect.colorDCDCE6)),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          child: Image.asset(
                                              "assets/images/image10.png"),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 16,
                        );
                      },
                    ),
                  ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Earlier",
                style: AppTextStyle().textColor70707012w500,
              ),
              SizedBox(
                height: 12,
              ),
              // if (activity1 != null)
              //   if (activity1!.data.isNotEmpty)
        /*      activity1!.data.isEmpty ?
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline,color: Colors.black,size: 80,),
                    // Image.asset("assets/images/delivery.png",height: 100,),
                    SizedBox(height: 5),
                    Text('No Activities Found',
                      style: AppTextStyle().textColor29292914w500,)
                  ],
                ),
              ) :*/
              activity1!.data!.isEmpty ?
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline,color: Colors.black,size: 80,),
                    // Image.asset("assets/images/delivery.png",height: 100,),
                    SizedBox(height: 5),
                    Text('No Activities Found',
                      style: AppTextStyle().textColor29292914w500,)
                  ],
                ),
              ) :
                  MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    removeBottom: true,
                    child: ListView.separated(
                      itemCount: activity1!.data!.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.grey,
                                      backgroundImage: NetworkImage(
                                          '${baseUrl}${activity1!.data![i].user!.photo}')
                                    //AssetImage('assets/images/Rectangle3194.png'),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${activity1!.data![i].user!.name} shared 1 product with you",
                                          style: AppTextStyle()
                                              .robotocolor1F1F1F13w400,
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                            DateTime.now()
                                                .difference(
                                                DateTime.parse(
                                                    activity1!
                                                        .data![i].createdAt.toString()))
                                                .inMinutes <=
                                                59
                                                ? "${DateTime.now().difference(DateTime.parse(activity1!
                                                .data![i].createdAt.toString())).inMinutes} min ago"
                                                : DateTime.now()
                                                .difference(DateTime
                                                .parse(activity1!
                                                .data![i].createdAt.toString()))
                                                .inHours <=
                                                23
                                                ? "${DateTime.now().difference(DateTime.parse(activity1!
                                                .data![i].createdAt.toString())).inHours} hr ago"
                                                : "${DateTime.now().difference(DateTime.parse(activity1!
                                                .data![i].createdAt.toString())).inDays} days ago"),


              // Text(DateFormat("dd MM yyyy").format(
              //                               DateTime.parse(
              //                                   activity1!
              //                                       .data![i].createdAt.toString()))),
              //                           Text(
              //                         "${activity1!.data![i].createdAt}",
              //                         style:
              //                             AppTextStyle().robotocolor7C7F8C12w400,
              //                       )
                                        // Text('${DateTime.now()}')
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  SizedBox(
                                    //Todo: padding length for device responsive
                                    height: 36,
                                    width: 64,
                                    child: YellowButtonWithText(
                                      backgroundColor:
                                      MaterialStateProperty.all(
                                          ColorSelect.colorF7E641),
                                      textStyleColor: ColorSelect.color292929,
                                      title: 'Add',
                                      onTap: () {
                                        postActivityApi(
                                            leadUserid: activity1!.data![i].leadUserId.toString(),
                                            productId: activity1!.data![i].productId.toString())
                                            .then((value) {
                                          print(value);
                                          if(value['status'] == true) {
                                            setState(() {
                                              isLoading ? Loading() : getActivity();
                                             Fluttertoast.showToast(
                                                        msg: 'Activity added successfully');
                                            });
                                          } else {
                                            Fluttertoast.showToast(
                                                msg:
                                                'Activity failed');

                                          }

                                        });
                                      },
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 16,
                        );
                      },
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}