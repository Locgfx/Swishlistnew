import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/api/friend_apis/user_details_api.dart';
import 'package:swishlist/constants/globals/loading.dart';
import 'package:swishlist/family_members/family_members_date_events.dart';
import 'package:swishlist/family_members/family_members_favourites.dart';
import 'package:swishlist/family_members/family_members_pets.dart';
import 'package:swishlist/family_members/family_members_size_weights.dart';
import 'package:swishlist/models/user_details_model.dart';

import '../../api/user_apis/friends_api.dart';
import '../../constants/color.dart';
import '../../constants/urls.dart';
import '../api/family_member_apis/family_details_api.dart';
import '../models/new_models/family_details_models.dart';
import 'family_members_details.dart';

class FamilyMemberDetails extends StatefulWidget {
  final String familyMemberId;
  final String familyPhoto;
  final String familyName;
  final String familyUserName;
  // final String friendName;
  // final String friendUserName;
  const FamilyMemberDetails({
    Key? key,
    required this.familyPhoto,
    required this.familyMemberId,
    required this.familyName,
    required this.familyUserName
    /*  required this.friendName,
    required this.friendUserName*/
  }) : super(key: key);

  @override
  State<FamilyMemberDetails> createState() => _FamilyMemberDetailsState();
}

class _FamilyMemberDetailsState extends State<FamilyMemberDetails> {
  @override
  void initState() {
    getUserDetails();

    super.initState();
  }
  bool isLoading = false;
  UserDetailsModel ? userDetails;
  List<String>? elements = [''];


  getUserDetails(){
    isLoading = true;
    var resp = userDetailsApi(id: widget.familyMemberId);
    resp.then((value) {
      if(value['error'] == false){
        setState(() {
          userDetails = UserDetailsModel.fromJson(value);
          var interestsString = userDetails!.data!.interests![0].interests!.join(", ");
          elements = interestsString.split(", ");
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
              //  familyDetails.data!.name == ''
                widget.familyName,
                /*userDetails?.data?.name == '' || userDetails?.data?.name == null
                    ? 'no data'
                    : userDetails!.data!.name.toString(),*/
                //familyDetails.data!.name.toString(),
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
                            imageUrl: widget.familyPhoto,
                            //userDetails?.data!.profile!.photo.toString(),
                               // baseUrl + familyDetails.data!.photo.toString(),
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

                            widget.familyName,
                            //userDetails!.data!.name.toString(),
                            //familyDetails.data!.name.toString(),
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
                   /* elements!.isEmpty || elements == null
                        ? Text('No data')
                        : Wrap(
                            children:
                                elements!.map((e) => chipBox(name: e)).toList(),
                          ),*/
                    Padding(
                      padding: const EdgeInsets.only(right: 2.0),
                      child: Wrap(
                        children: elements!.map((e) => chipBox(name: e)).toList(),
                      ),
                    ),
                    SizedBox(height: 24),
                    ProfileRow(
                      icon: 'userimg',
                      title: 'Profile',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FamilyMemberProfile(
                              friendId: widget.familyMemberId,
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
                            builder: (_) => FamilySizesAndWeights(
                              friendId: widget.familyMemberId,
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
                            builder: (_) => FamilyMemberFavourites(
                              friendId: widget.familyMemberId,
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
                            builder: (_) => FamilyMembersPets(
                              friendId: widget.familyMemberId,
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
                            builder: (_) => FamilyDatesAndEvents(
                              friendId: widget.familyMemberId,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 36),
                    // ProfileRow(
                    //   icon: 'user',
                    //   title: 'Family',
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (_) => FFamily(
                    //           friendId: widget.friendId,
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),
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
