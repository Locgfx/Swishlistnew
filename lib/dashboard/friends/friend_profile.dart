import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/constants/globals/loading.dart';
import 'package:swishlist/dashboard/friends/friend_date_and_events.dart';
import 'package:swishlist/dashboard/friends/friend_family_page.dart';
import 'package:swishlist/dashboard/friends/friend_favourites.dart';
import 'package:swishlist/dashboard/friends/friend_pets.dart';
import 'package:swishlist/dashboard/friends/friend_profile_page.dart';
import 'package:swishlist/dashboard/friends/friend_sizes_and_weights.dart';

import '../../api/user_apis/friends_api.dart';
import '../../constants/color.dart';
import '../../constants/urls.dart';
import '../../models/friends_details_model.dart';

class FriendProfile extends StatefulWidget {
  final String friendId;
  // final String friendName;
  // final String friendUserName;
  const FriendProfile({
    Key? key,
    required this.friendId,
    /*  required this.friendName,
    required this.friendUserName*/
  }) : super(key: key);

  @override
  State<FriendProfile> createState() => _FriendProfileState();
}

class _FriendProfileState extends State<FriendProfile> {
  @override
  void initState() {
    getFriendInterest();
    // widget.friendId;
    getFriendProfile();
    print(widget.friendId);
    super.initState();
  }

  List popList = [];
  List interestList = ['Cycling', 'Fishing', 'Singing', 'Dancing', 'Biking'];
  List<String>? elements = [''];
  bool isLoading = false;
  // FriendDetailsModel? friendDetails;

  // FriendDetailsModel ? friendDetails;
  FriendDetailsModel friendDetails = FriendDetailsModel();

  FriendDetailsModel? friendInterest;

  getFriendInterest() {
    isLoading = true;
    var resp = friendDetailsApi(friendUserId: widget.friendId);
    resp.then((value) {
      if (mounted) {
        if (value['status'] == true) {
          setState(() {
            friendInterest = FriendDetailsModel.fromJson(value);
            // elements =  friendDetails.data!.interest!.interest!.split(",");
            if (friendDetails.data != null) {
              if (friendDetails.data!.interest == null) {
              } else {
                elements = friendDetails.data!.interest!.interest!.split(",");
              }
            } else {
              friendDetails = FriendDetailsModel(
                  data: Data(
                id: 0,
                name: '',
                username: '',
                phone: '',
                email: '',
                photo: '',
                type: '',
                profile: Profile(
                  id: 0,
                  userId: 0,
                  name: '',
                  photo: '',
                  gender: '',
                  dob: '',
                  occupation: '',
                  relationStatus: '',
                  email: '',
                  phone: '',
                  alternatePhone: '',
                  homeAddress: '',
                  workAddress: '',
                  privacyStatus: '',
                  createdAt: '',
                ),
                sizeWeight: SizeWeight(
                  id: 0,
                  userId: 0,
                  waist: '',
                  shirt: '',
                  shoes: '',
                  bed: '',
                  privacyStatus: '',
                  createdAt: '',
                ),
                interest: Interest(interest: ''),
              ));
            }
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      }
    });
  }

  getFriendProfile() {
    isLoading = true;
    var resp = friendDetailsApi(friendUserId: widget.friendId);
    resp.then((value) {
      if (mounted) {
        if (value['status'] == true) {
          friendDetails = FriendDetailsModel.fromJson(value);
          // if(friendDetails!.data!.interest == null ) {
          // } else {
          //   elements =  friendDetails!.data!.interest!.interest!.split(",");
          //
          // }
          isLoading = false;
        } else {
          isLoading = false;
        }
      }
    });
  }

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
                friendDetails.data!.name == ''
                    ? 'User'
                    : friendDetails.data!.name.toString(),
                // 'Andy Bernard',
                style: AppTextStyle().textColor29292920w700,
              ),
              // title: Text(
              //   friendDetails!.data!.username.toString(),
              //   // "AndyAngie3260",
              //   style: AppTextStyle().textColor39393916w500,
              // ),
              centerTitle: false,
              actions: [
                // Popupmen(
                //   menuList: [
                //     for (int i = 0; i < popList.length; i++)
                //       PopupMenuItem(
                //           child: ListTile(
                //         title: InkWell(
                //           onTap: () {},
                //           child: Text(
                //             popList[i],
                //             style: AppTextStyle().textColor39393914w500,
                //           ),
                //         ),
                //       )),
                //   ],
                //   icon: AppBarIcon(
                //     onTap: () {},
                //     iconName: 'Vector',
                //   ),
                // ),
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                height: 1.sh,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: CachedNetworkImage(
                            imageUrl: friendDetails.data!.photo
                                    .toString()
                                    .contains('http')
                                ? friendDetails.data!.photo.toString()
                                : baseUrl +
                                    friendDetails.data!.photo.toString(),
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            progressIndicatorBuilder: (a, b, c) => Opacity(
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
                                      shape: BoxShape.circle),
                                ),
                              ),
                            ),
                          ),
                          // child: Image.asset(
                          //   'assets/images/Rectangle319.png',
                          //   fit: BoxFit.fill,
                          // ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            friendDetails.data!.name == ''
                                ? 'User'
                                : friendDetails.data!.name.toString(),
                            // 'Andy Bernard',
                            style: AppTextStyle().textColor29292920w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Interests',
                      style: AppTextStyle().textColor29292914w600,
                    ),
                    SizedBox(height: 12),
                    // friendDetails!.data!.interest! == null ?
                    //     Text('Friend has no interest added yet'):
                    Wrap(
                      children: elements!.map((e) => chipBox(name: e)).toList(),
                    ),
                    // GridView.builder(
                    //   shrinkWrap: true,
                    //   physics: NeverScrollableScrollPhysics(),
                    //   itemCount: interestList.length,
                    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 4,
                    //     childAspectRatio: 2.1,
                    //     mainAxisSpacing: 8,
                    //     crossAxisSpacing: 8,
                    //   ),
                    //   itemBuilder: (_, i) {
                    //     return Container(
                    //       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                    //       decoration: BoxDecoration(
                    //         color: ColorSelect.colorCBE0FA,
                    //         borderRadius: BorderRadius.circular(48),
                    //       ),
                    //       child: Center(
                    //         child: Text(
                    //           interestList[i],
                    //           style: AppTextStyle().textColor29292913w400,
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),
                    SizedBox(height: 24),
                    ProfileRow(
                      icon: 'userimg',
                      title: 'Profile',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FProfile(
                              friendId: widget.friendId,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 36),
                    ProfileRow(
                      icon: 'zoomin',
                      title: 'Sized and Weights',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FSizesAndWeights(
                              friendId: widget.friendId,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 36),
                    ProfileRow(
                      icon: 'Subtract',
                      title: 'Favourites',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FFavourites(
                              friendId: widget.friendId,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 36),
                    ProfileRow(
                      icon: 'mdi_dog',
                      title: 'Pets',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FPets(
                              friendId: widget.friendId,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 36),
                    ProfileRow(
                      icon: 'agenda1',
                      title: 'Dates and Events',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FDatesAndEvents(
                              friendId: widget.friendId,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 36),
                    ProfileRow(
                      icon: 'user',
                      title: 'Family',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FFamily(
                              friendId: widget.friendId,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Container chipBox({required String name}) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(48),
          ),
          color: ColorSelect.colorCBE0FA),
      padding: EdgeInsets.all(10),
      child: Text(
        name,
        style: AppTextStyle().textColor29292914w400,
      ),
    );
  }
}

class ProfileRow extends StatefulWidget {
  final String icon;
  final String title;
  final Function onTap;
  const ProfileRow({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ProfileRow> createState() => _ProfileRowState();
}

class _ProfileRowState extends State<ProfileRow> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Image.asset('assets/images/${widget.icon}.png'),
            ),
            SizedBox(width: 13),
            Text(
              widget.title,
              style: AppTextStyle().textColor29292914w600,
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
