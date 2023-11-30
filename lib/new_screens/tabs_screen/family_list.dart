import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/expanded/add_family_member.dart';

import '../../api/notifications/meber_notifiction_aapi.dart';
import '../../api/shared_product_api/shared_product_api.dart';
import '../../buttons/yellow_button.dart';
import '../../constants/color.dart';
import '../../constants/urls.dart';
import '../../models/notification_models/member_index_model.dart';

class FamilyList extends StatefulWidget {
  final String productId2;
  const FamilyList({Key? key, required this.productId2}) : super(key: key);

  @override
  State<FamilyList> createState() => _FamilyListState();
}

class _FamilyListState extends State<FamilyList> {
  @override
  void initState() {
    get();
    super.initState();
  }

  MemberIndexModel? index;
  bool isLoading = false;
  List<Index> familyA = [];

  get() {
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
          : familyA.isEmpty
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
                          "Add family member to share profile",
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
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const AddFamilyMember(),
                              ),
                            );
                            // AddFamilyMember
                          },
                          title: "Add Family Member",
                          buttonIcon: "assets/images/4xuseradd.png",
                        ),
                      )
                    ],
                  ),
                )
              : ListView.builder(
                  physics: ScrollPhysics(),
                  itemCount: familyA.length,
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
                                  imageUrl: familyA[i]
                                              .familyMemberUser!
                                              .photo
                                              .toString()
                                              .isEmpty ||
                                          familyA[i].familyMemberUser!.photo ==
                                              null
                                      ? 'assets/icons/userico.jpg'
                                      : familyA[i]
                                              .familyMemberUser!
                                              .photo
                                              .toString()
                                              .contains("https")
                                          ? familyA[i]
                                              .familyMemberUser!
                                              .photo
                                              .toString()
                                          : baseUrl +
                                              familyA[i]
                                                  .familyMemberUser!
                                                  .photo
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
                                  familyA[i].familyMemberUser!.name.toString(),
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
                                    sharedProductApi(
                                            productId: widget.productId2,
                                            leadUserId: familyA[i]
                                                .familyMemberUserId
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
