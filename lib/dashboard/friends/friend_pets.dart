import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/api/friend_apis/user_details_api.dart';
import 'package:swishlist/constants/globals/loading.dart';
import 'package:swishlist/constants/urls.dart';
import 'package:swishlist/models/user_details_model.dart';

import '../../api/user_apis/friends_api.dart';
import '../../constants/color.dart';
import '../../models/friends_details_model.dart';

class FPets extends StatefulWidget {
  final String friendId;
  const FPets({Key? key, required this.friendId}) : super(key: key);

  @override
  State<FPets> createState() => _FPetsState();
}

class _FPetsState extends State<FPets> {
  @override
  void initState() {
    //getFriendPets();
    getUserDetails();
    super.initState();
  }

  bool isLoading = false;
  //FriendDetailsModel? friendDetails;

  Future<void> _handleRefresh() async {
    getUserDetails();
    //getFriendPets();
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

/*  getFriendPets() {
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
  }*/

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
      body:
      isLoading
          ? Loading()
          : RefreshIndicator(
              backgroundColor: Colors.white,
              color: ColorSelect.colorF7E641,
              strokeWidth: 3,
              onRefresh: _handleRefresh,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  child:
                  userDetails!.data!.pets!.isEmpty
                 /* friendDetails!.data!.pets!.isEmpty*/
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
                              )
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            itemCount: userDetails!.data!.pets!.length,
                            //friendDetails!.data!.pets!.length,
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (ctx, i) {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                height: 300,
                                width: 130,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: ColorSelect.colorF7E641,

                                        // color: Colors.grey,
                                        width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Center(
                                      child: Container(
                                        height: 80,
                                        width: 80,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey.shade200,
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: userDetails!.data!.pets![i].photo.toString(),
                                          //(newBaseUrl + userDetails!.data!.pets![i].photo.toString()),
                                          /*(baseUrl +
                                              friendDetails!
                                                  .data!.pets![i].photo
                                                  .toString()),*/
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
                                    ),
                                    // Image.asset(pets!.data[index].photo.toString()),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          userDetails!.data!.pets![i].name.toString(),
                                         /* friendDetails!.data!.pets![i].name
                                              .toString(),*/
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppTextStyle()
                                              .textColor29292914w400,
                                        ),
                                        Text(
                                          userDetails!.data!.pets![i].type.toString(),
                                          /*friendDetails!.data!.pets![i].type
                                              .toString(),*/
                                          style: AppTextStyle()
                                              .textColor70707014w400,
                                        ),
                                        Text(
                                          userDetails!.data!.pets![i].origin.toString(),
                                          /*friendDetails!.data!.pets![i].origin
                                              .toString(),*/
                                          style: AppTextStyle()
                                              .textColor70707014w400,
                                        ),
                                      ],
                                    ),

                                    // Text(
                                    //   pets!.data![index].origin
                                    //       .toString(),
                                    //   style: AppTextStyle()
                                    //       .textColor70707014w400,
                                    // ),
                                  ],
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
              ),
            ),
    );
  }
}
