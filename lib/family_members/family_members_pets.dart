import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/constants/globals/loading.dart';
import 'package:swishlist/constants/urls.dart';

import '../../api/user_apis/friends_api.dart';
import '../../constants/color.dart';
import '../../models/friends_details_model.dart';

class FamilyMembersPets extends StatefulWidget {
  final String friendId;
  const FamilyMembersPets({Key? key, required this.friendId}) : super(key: key);

  @override
  State<FamilyMembersPets> createState() => _FamilyMembersPetsState();
}

class _FamilyMembersPetsState extends State<FamilyMembersPets> {
  @override
  void initState() {
    getFriendPets();
    super.initState();
  }

  bool isLoading = false;
  FriendDetailsModel? friendDetails;

  getFriendPets() {
    isLoading = true;
    var resp = friendDetailsApi(friendUserId: widget.friendId);
    resp.then((value) {
      if (mounted) {
        if (value['status'] == true) {
          setState(() {
            friendDetails = FriendDetailsModel.fromJson(value);
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });

          // isLoading = false;
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
          "Friend's Pets",
          style: AppTextStyle().textColor39393916w500,
        ),
        centerTitle: false,
      ),
      body: isLoading
          ? Loading()
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: friendDetails!.data!.pets!.isEmpty
                  ? Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Colors.black,
                            size: 100,
                          ),
                          // Image.asset("assets/images/delivery.png",height: 100,),
                          SizedBox(height: 5),
                          Text(
                            'Your Friend has No Pets yet',
                            style: AppTextStyle().textColor29292914w500,
                          )
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        physics: ScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        itemCount: friendDetails!.data!.pets!.length,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (ctx, i) {
                          return GestureDetector(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              height: 220,
                              width: 130,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                          // selectedItems.contains(
                                          //     pets!
                                          //         .data![index].id!)
                                          //     ?
                                          ColorSelect.colorF7E641,
                                      // //     :
                                      // Colors.grey,
                                      // color: Colors.grey,
                                      width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Container(
                                    height: 80,
                                    width: 80,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey.shade200,
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl: (baseUrl +
                                          friendDetails!.data!.pets![i].photo
                                              .toString()),
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          Icon(
                                        Icons.error,
                                        size: 40,
                                      ),
                                      progressIndicatorBuilder: (a, b, c) =>
                                          Opacity(
                                        opacity: 0.3,
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.black12,
                                          highlightColor: Colors.white,
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Image.asset(pets!.data[index].photo.toString()),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              friendDetails!.data!.pets![i].name
                                                  .toString()
                                                  .toString(),
                                              style: AppTextStyle()
                                                  .textColor29292914w400,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  friendDetails!
                                                      .data!.pets![i].type
                                                      .toString(),
                                                  style: AppTextStyle()
                                                      .textColor70707014w400,
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Container(
                                                    height: 5.h,
                                                    width: 5.w,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        shape:
                                                            BoxShape.circle)),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                Text(
                                                  friendDetails!
                                                      .data!.pets![i].origin
                                                      .toString(),
                                                  style: AppTextStyle()
                                                      .textColor70707014w400,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(right: 10),
                                      //   child:
                                      //   Image.asset('assets/images/Vector175.png'),
                                      // )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
              // Column(
              //   children: [
              //     ListView.separated(
              //       itemCount: friendDetails!.data!.pets!.length,
              //         shrinkWrap:  true,
              //         itemBuilder: (context,i) {
              //         return Row(
              //           children: [
              //             Container(
              //               width: 52,
              //               height: 52,
              //               clipBehavior: Clip.hardEdge,
              //               decoration: BoxDecoration(
              //                 shape: BoxShape.circle,
              //               ),
              //               child: CachedNetworkImage(
              //                 imageUrl: (baseUrl+friendDetails!.data!.pets![i].photo.toString()),
              //                 fit: BoxFit.cover,
              //                 errorWidget: (context, url, error) =>
              //                     Icon(Icons.error,size: 40,),
              //                 progressIndicatorBuilder:  (a,b,c) =>
              //                     Opacity(
              //                       opacity: 0.3,
              //                       child: Shimmer.fromColors(
              //                         baseColor: Colors.black12,
              //                         highlightColor: Colors.white,
              //                         child: Container(
              //                           width: 50,
              //                           height: 50,
              //                           //margin: EdgeInsets.symmetric(horizontal: 24),
              //                           decoration: BoxDecoration(
              //                               color: Colors.white,
              //                               shape: BoxShape.circle
              //                           ),
              //                         ),
              //
              //                       ),
              //                     ),
              //               ),
              //             ),
              //             SizedBox(width: 8),
              //             Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Text(
              //                   friendDetails!.data!.pets![i].name.toString(),
              //                   // 'Pet Name',
              //                   style: AppTextStyle().textColor29292914w500,
              //                 ),
              //                 SizedBox(height: 5),
              //                 Row(
              //                   children: [
              //                     Text(
              //                     friendDetails!.data!.pets![i].type.toString(),
              //                       // 'Pet Type',
              //                       style: AppTextStyle().k84848414w400Inter,
              //                     ),
              //                     SizedBox(width: 8),
              //                     Container(
              //                       width: 4,
              //                       height: 4,
              //                       decoration: BoxDecoration(
              //                         shape: BoxShape.circle,
              //                         color: Colors.grey,
              //                       ),
              //                     ),
              //                     SizedBox(width: 8),
              //                     Text(
              //                     friendDetails!.data!.pets![i].origin.toString(),
              //                       // 'Pet Breed',
              //                       style: AppTextStyle().k84848414w400Inter,
              //                     ),
              //                   ],
              //                 ),
              //               ],
              //             ),
              //           ],
              //         );
              //         }, separatorBuilder: (BuildContext context, int index) => SizedBox(height: 20,),)
              //
              //   ],
              // ),
            ),
    );
  }
}
