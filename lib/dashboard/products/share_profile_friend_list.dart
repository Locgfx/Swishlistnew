import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/dashboard/friends/new_screens/add_friend_by_email_phone.dart';

import '../../api/share_profile_apis/share_profile_api.dart';
import '../../api/user_apis/friends_api.dart';
import '../../buttons/yellow_button.dart';
import '../../constants/color.dart';
import '../../constants/urls.dart';
import '../../models/add_friend_model.dart';

class ShareProfileFriendList extends StatefulWidget {
  // final String productId;
  const ShareProfileFriendList({
    Key? key,
    // required this.productId
  }) : super(key: key);

  @override
  State<ShareProfileFriendList> createState() => _ShareProfileFriendListState();
}

class _ShareProfileFriendListState extends State<ShareProfileFriendList> {
  @override
  void initState() {
    getFriends();
    super.initState();
  }

  FriendModel friendList = FriendModel();
  bool isLoading = false;
  getFriends() {
    isLoading = true;
    var resp = getFriendsApi();
    resp.then((value) {
      if (mounted) {
        if (value['status'] == true) {
          setState(() {
            friendList = FriendModel.fromJson(value);
            // for (var v in value) {
            //   friendList.add(ModelFriend.fromJson(v));
            // }
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
      body: isLoading
          ? Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: LoadingAnimationWidget.staggeredDotsWave(
                  size: 70,
                  color: ColorSelect.colorF7E641,
                ),
              ),
            )
          : friendList.data!.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80, right: 80),
                        child: Image.asset("assets/images/addfriends.png"),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 24, right: 24, top: 10),
                        child: Text(
                          "Add Friends to Share Profile",
                          style: AppTextStyle().roboto29292914w500,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 50.h,
                        width: 1.sw,
                        child: YellowButtonWithIcon(
                          backgroundColor: MaterialStateProperty.all(
                              ColorSelect.colorF7E641),
                          textStyleColor: ColorSelect.color292929,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AddFriendByMailPhone()));
                          },
                          title: "Add Friend",
                          buttonIcon: "assets/images/4xuseradd.png",
                        ),
                      )
                    ],
                  ),
                )
              : ListView.builder(
                  physics: ScrollPhysics(),
                  itemCount: friendList.data!.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: friendList.data![i].friend!.photo
                                          .toString()
                                          .contains("https")
                                      ? friendList.data![i].friend!.photo
                                          .toString()
                                      : baseUrl +
                                          friendList.data![i].friend!.photo
                                              .toString(),
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>

                                      // Image.asset(
                                      // "assets/icons/userico.jpg"),
                                      Image.asset("assets/icons/userico.jpg"),
                                  progressIndicatorBuilder: (a, b, c) =>
                                      Opacity(
                                    opacity: 0.3,
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.black12,
                                      highlightColor: Colors.white,
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: ColorSelect.colorFFFFFF,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  friendList.data![i].friend!.name.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: AppTextStyle().textColor29292914w400,
                                ),
                              ),
                              Spacer(),
                              YellowButtonWithText(
                                  backgroundColor: MaterialStateProperty.all(
                                      ColorSelect.colorF7E641),
                                  textStyleColor: Colors.black,
                                  onTap: () {
                                    sharedProfileApi(
                                            leadUserId: friendList
                                                .data![i].friendUserId
                                                .toString())
                                        .then((value) {
                                      if (value['status'] == true) {
                                        Navigator.pop(context);
                                        // Navigator.of(
                                        //     context)
                                        //   ..pop()
                                        //   ..pop();
                                        Fluttertoast.showToast(
                                            msg: value['message']);
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: value[
                                                'please enter all products details']);
                                      }
                                    });
                                  },
                                  title: 'Send')
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
    );
  }
}
