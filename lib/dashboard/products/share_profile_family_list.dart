import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../api/notifications/meber_notifiction_aapi.dart';
import '../../api/share_profile_apis/share_profile_api.dart';
import '../../buttons/yellow_button.dart';
import '../../constants/color.dart';
import '../../constants/urls.dart';
import '../../models/notification_models/member_index_model.dart';

class ShareProfileFamilyList extends StatefulWidget {
  const ShareProfileFamilyList({
    Key? key,
  }) : super(key: key);

  @override
  State<ShareProfileFamilyList> createState() => _ShareProfileFamilyListState();
}

class _ShareProfileFamilyListState extends State<ShareProfileFamilyList> {
  @override
  void initState() {
    //get();
    getFamilyMembers();
    super.initState();
  }

  //MemberIndexModel? index;
  bool isLoading = false;
  List<FamilyMemberIndexModel> familyA = [];

/*
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
*/

  getFamilyMembers() {
    isLoading = true;
    var resp = familyMemberIndexApi();
    resp.then((value) {
      if(value['error'] == false){
        setState(() {
          for(var v in value['data']){
            familyA.add(FamilyMemberIndexModel.fromJson(v));

          }
          // Fluttertoast.showToast(msg: value['message']);
          // print(familyA[0].member!.name.toString());

          isLoading = false;

        });
      }
      else{
        setState(() {
         // Fluttertoast.showToast(msg: value['message']);
          isLoading = false;
        });
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
          : familyA.isEmpty || familyA == null
              ?
      // Align(
      //             alignment: Alignment.topCenter,
      //             child: Padding(
      //               padding: const EdgeInsets.only(top: 60),
      //               child: Column(
      //                 children: [
      //                   Image.asset(
      //                     "assets/images/addproducts2.png",
      //                     height: 200,
      //                     width: 200,
      //                   ),
      //                   SizedBox(height: 10),
      //                   Text("No Family Member Yet",
      //                       style: AppTextStyle()
      //                           .textColor29292912w500
      //                           .copyWith(color: Color(0xff292929))),
      //                 ],
      //               ),
      //             ),
      //           )
      Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Column(
            children: [
              Image.asset(
                "assets/images/addproducts2.png",
                height: 200,
                width: 200,
              ),
              SizedBox(height: 10),
              Text("No Family Member Yet",
                  style: AppTextStyle()
                      .textColor29292912w500
                      .copyWith(color: Color(0xff292929))),
            ],
          ),
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
                                  imageUrl:

                                          familyA[i].member!.photo ==
                                              null
                                      ? 'assets/icons/userico.jpg'
                                      : familyA[i]
                                              .member!
                                              .photo
                                              .toString()
                                              .contains("https")
                                          ? familyA[i]
                                              .member!
                                              .photo
                                              .toString()
                                          : baseUrl +
                                              familyA[i]
                                                  .member!
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
                                  familyA[i].member!.name.toString(),
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
                                    // sharedProfileApi(
                                    //         leadUserId: familyA[i]
                                    //             .member!.id
                                    //             .toString())
                                    //     .then((value) {
                                    //   if (value['status'] == true) {
                                    //     Navigator.pop(context);
                                    //     // Navigator.of(
                                    //     //     context)
                                    //     //   ..pop()
                                    //     //   ..pop();
                                    //     Fluttertoast.showToast(
                                    //         msg: value['message']);
                                    //   } else {
                                    //     Fluttertoast.showToast(
                                    //         msg: value[
                                    //             'please enter all products details']);
                                    //   }
                                    // });


                                    sharedProfileApi(sharedWithId: familyA[i].member!.id.toString() ).then((value) {
                                      if(value['error'] == false ){
                                        Navigator.pop(context);
                                        Fluttertoast.showToast(msg: value['message']);
                                      }else{
                                        Fluttertoast.showToast(msg: value['message']);
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
