import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swishlist/constants/globals/loading.dart';

import '../api/notifications/meber_notifiction_aapi.dart';
import '../constants/color.dart';
import '../constants/urls.dart';
import '../expanded/widgets/managed_family_member_row.dart';
import '../models/notification_models/member_notification_models.dart';

class MembersNotifications extends StatefulWidget {
  const MembersNotifications({Key? key}) : super(key: key);

  @override
  State<MembersNotifications> createState() => _MembersNotificationsState();
}

class _MembersNotificationsState extends State<MembersNotifications> {
  @override
  void initState() {
    getFamilyMember();
    super.initState();
  }

  bool isLoading = false;
  FamilyMemberIndexModel? familyIndex;
  List<Data> familyRequested = [];

  // List<FamilyMemberIndexModel> familyIndex = [];

  getFamilyMember() {
    isLoading = true;
    var resp = familyMemberIndexApi();
    resp.then((value) {
      if (value['status'] == true) {
        setState(() {
          familyIndex = FamilyMemberIndexModel.fromJson(value);
          for (var v in familyIndex!.data!) {
            //   if (v.status == "accepted") {
            //     familyModel2.add(v);
            //   }
            if (v.status == "requested") {
              familyRequested.add(v);
            }
          }
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Text(
              "Notifications",
              style: AppTextStyle().textColor29292916w500,
            ),
            Spacer(),
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
      body: isLoading
          ? Loading()
          : familyRequested.isEmpty
              ? Text("")
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16),
                    child: Column(
                      children: [
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: familyRequested.length,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: UserRowWidget(
                                widget: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    familyMemberUpdateApi(
                                            status: 'accepted',
                                            id: familyIndex!.data![0].id
                                                .toString())
                                        .then((value) async {
                                      if (value['status'] == true) {
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
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: ColorSelect.colorF7E641,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Accept"),
                                    ),
                                  ),
                                ),
                                widget2: GestureDetector(
                                  onTap: () {
                                    familyMemberUpdateApi(
                                            status: 'rejected',
                                            id: familyIndex!.data![0].id
                                                .toString())
                                        .then((value) async {
                                      if (value['status'] == true) {
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
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color:
                                            Colors.redAccent.withOpacity(0.65),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text("Reject"),
                                      )),
                                ),
                                familyName:
                                    familyRequested[i].user!.name.toString(),
                                familyUsername:
                                    familyRequested[i].user!.email.toString(),
                                familyPhoto: baseUrl +
                                    familyRequested[i]
                                        .user!
                                        .username
                                        .toString(),
                                familyRelation:
                                    familyRequested[i].status.toString(),
                                id: familyRequested[i].id.toString(),
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
    );
  }
}
