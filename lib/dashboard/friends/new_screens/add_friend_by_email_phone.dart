import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fast_contacts/fast_contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/api/friend_apis/add_friend_api.dart';
import 'package:swishlist/buttons/light_yellow.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/constants/globals/globals.dart';

import '../../../api/user_apis/contact_api.dart';
import '../../../api/user_apis/friends_api.dart';
import '../../../buttons/yellow_button.dart';
import '../../../constants/urls.dart';
import '../../../models/contact_model.dart';
import 'friend_request_send.dart';

class AddFriendByMailPhone extends StatefulWidget {
  const AddFriendByMailPhone({
    Key? key,
  }) : super(key: key);

  @override
  State<AddFriendByMailPhone> createState() => _AddFriendByMailPhoneState();
}

class _AddFriendByMailPhoneState extends State<AddFriendByMailPhone> {
  @override
  void initState() {
    loadContacts();
    super.initState();
  }

  final TextEditingController emailPhoneController = TextEditingController();
  bool isLoading = false;
  bool show = false;

  List<String> phNo = [];
  List<ModelContact> friendList = [];
  final searchController = TextEditingController();

  contact() {
    isLoading = true;
    var resp = getContactApi(contacts: phNo);
    resp.then((value) {
      if (mounted) {
        if (value['status'] == true) {
          setState(() {
            for (var v in value['data']) {
              friendList.add(ModelContact.fromJson(v));
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

  List<Contact> _contacts = const [];
  String? _text;

  bool _isLoading = false;

  final _ctrl = ScrollController();

  Future<void> loadContacts() async {
    try {
      await Permission.contacts.request();
      _isLoading = true;
      if (mounted) setState(() {});
      // phNo.clear();
      final sw = Stopwatch()..start();
      _contacts = await FastContacts.getAllContacts();
      for (var v in _contacts) {
        for (var q in v.phones) {
          var h = q.number.replaceAll('-', '').replaceAll(" ", "");
          phNo.add(h);
          // phNo.add(q.number);
        }
      }

      contact();
      sw.stop();
      _text =
          'Contacts: ${_contacts.length}\nTook: ${sw.elapsedMilliseconds}ms';
    } on PlatformException catch (e) {
      _text = 'Failed to get contacts:\n${e.details}';
    } finally {
      _isLoading = false;
    }
    if (!mounted) return;
    setState(() {});
  }

  final TextEditingController _controller = TextEditingController();

  final List<bool> delete = List.generate(1000, (index) => false);
  final List<bool> accept = List.generate(1000, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        height: 52.h,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        child:
            // isLoading
            // ? Center(
            //     child: LoadingAnimationWidget.waveDots(
            //       size: 40,
            //       color: ColorSelect.colorF7E641,
            //     ),
            //   )
            // :
            show
                ? LoadingLightYellowButton()
                : LightYellowButtonWithText(
                    backgroundColor: (emailPhoneController.text.isNotEmpty)
                        ? MaterialStateProperty.all(ColorSelect.colorF7E641)
                        : MaterialStateProperty.all(ColorSelect.colorFCF5B6),
                    textStyleColor: (emailPhoneController.text.isNotEmpty)
                        ? Colors.black
                        : ColorSelect.colorB5B07A,
                    onTap: () {
                      setState(() {
                        show = !show;
                      });
                      Timer timer = Timer(Duration(seconds: 2), () {
                        setState(() {
                          show = false;
                        });
                      });
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => FriendRequestSent(
                      //               name: emailPhoneController.text,
                      //             )));

                      if (emailPhoneController.text.isNotEmpty) {
                        addFriendByMailPhoneApi(
                          phoneEmail: emailPhoneController.text,
                        ).then((value) async {
                          if (value['status'] == true) {
                            Fluttertoast.showToast(msg: value['message']);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FriendRequestSent(
                                          name: emailPhoneController.text,
                                        )));
                          } else {
                            Fluttertoast.showToast(msg: value['message']);
                          }
                        });
                      }
                    },
                    title: 'Send Request',
                  ),
      ),
      body: TextFieldUnFocusOnTap(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Row(
                  children: [
                    Text(
                      "Add Friend",
                      style: AppTextStyle().textColor29292916w500,
                    ),
                  ],
                ),
                leadingWidth: 40,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 00),
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 20),
                      // color: Colors.red,
                      child: SvgPicture.asset(
                        "assets/icons/arrowback.svg",
                      ),
                    ),
                  ),
                ),
                // actions: [
                //   Padding(
                //     padding: const EdgeInsets.only(right: 16.0),
                //     child: GestureDetector(
                //       onTap: () {
                //         // setState(() {
                //         //   loadContacts();
                //         // });
                //       },
                //       child: Container(
                //         child: Center(
                //           child: Text(
                //             "Sync Contacts",
                //             style: AppTextStyle().textColor29292916w500,
                //           ),
                //         ),
                //       ),
                //     ),
                //   )
                // ],
              ),
              SizedBox(height: 40),
              Text(
                "Add friend account",
                style: AppTextStyle().textColor29292924w700,
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "Please enter the friend linked with\n SwishList account.",
                  textAlign: TextAlign.center,
                  style: AppTextStyle().textColor70707012w400,
                ),
              ),
              SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  width: 328.w,
                  decoration: BoxDecoration(
                    color: ColorSelect.colorEDEDF1,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextFormField(
                      onChanged: (v) {
                        setState(() {});
                      },
                      controller: emailPhoneController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 24),
                        border: InputBorder.none,
                        hintText: "Enter friend email",
                      ),
                    ),
                  ),
                ),
              ),

              isLoading
                  ? Padding(
                      padding: const EdgeInsets.only(top: 60.0),
                      child: Column(
                        children: [
                          Text("Please wait while contact syncing"),
                          SizedBox(
                            height: 10,
                          ),
                          LoadingAnimationWidget.staggeredDotsWave(
                            size: 40,
                            color: ColorSelect.colorF7E641,
                          )
                        ],
                      ),
                    )
                  : friendList.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 60.0),
                          child: Text("No swishlist contact found"),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          itemCount: friendList.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, i) {
                            return ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade200,
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  child: CachedNetworkImage(
                                    imageUrl: baseUrl +
                                        friendList[i].photo.toString(),
                                    // imageUrl: baseUrl+contactModel.data![i].photo.toString(),
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                    progressIndicatorBuilder: (a, b, c) =>
                                        Opacity(
                                      opacity: 0.3,
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.black12,
                                        highlightColor: Colors.white,
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          //margin: EdgeInsets.symmetric(horizontal: 24),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          friendList[i].name.toString(),
                                        ),
                                        Text(friendList[i].phone.toString()),
                                      ],
                                    ),
                                    accept[i]
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                right: 22.0),
                                            child: CircularProgressIndicator(
                                              color: ColorSelect.colorF7E641,
                                            ),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: SizedBox(
                                              width: 70,
                                              height: 36,
                                              child: YellowButtonWithText(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        ColorSelect
                                                            .colorF7E641),
                                                textStyleColor:
                                                    ColorSelect.color292929,
                                                title: 'Add',
                                                onTap: () {
                                                  setState(() {
                                                    accept[i] = !accept[i];
                                                  });
                                                  Timer timer = Timer(
                                                      Duration(seconds: 2), () {
                                                    setState(() {
                                                      accept[i] = false;
                                                    });
                                                  });
                                                  addFriendApi(
                                                          friendsId:
                                                              friendList[i]
                                                                  .id
                                                                  .toString(),
                                                          status: 'requested')
                                                      .then((value) {
                                                    print(value);
                                                    if (value['status'] ==
                                                        true) {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  FriendRequestSent(
                                                                    name: friendList[
                                                                            i]
                                                                        .name
                                                                        .toString(),
                                                                  )));
                                                      setState(() {
                                                        Fluttertoast.showToast(
                                                            msg: value[
                                                                'message']);
                                                      });
                                                    } else {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              value['message']);
                                                    }
                                                  });
                                                },
                                              ),
                                            ),
                                          )
                                  ],
                                ),
                                // subtitle: Text(num),
                                onTap: () {});
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              SizedBox(
                            height: 10,
                          ),
                        ),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 16),
              //   height: 52.h,
              //   decoration: BoxDecoration(
              //   color: ColorSelect.colorEDEDF1,
              //   borderRadius: BorderRadius.all(Radius.circular(8))),
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 20.0),
              //     child: TypeAheadField(
              //       hideSuggestionsOnKeyboardHide: true,
              //       animationStart: 0,
              //       animationDuration: Duration.zero,
              //       textFieldConfiguration: TextFieldConfiguration(
              //         onSubmitted: (v) {
              //           setState(() {
              //             searchModel.clear();
              //           });
              //         },
              //         onChanged: (val) {
              //           if(val.length >=4){
              //             getSearch(val);
              //           } else {
              //             setState(() {
              //               searchModel.clear();
              //               matches.clear();
              //             });
              //           }
              //           },
              //         controller: searchController,
              //           autofocus: true,
              //           style: TextStyle(fontSize: 15),
              //           decoration: InputDecoration(
              //             hintText: 'Enter Full Name',
              //               border: InputBorder.none
              //           ),
              //       ),
              //       suggestionsBoxDecoration: SuggestionsBoxDecoration(
              //         color: ColorSelect.colorEDEDF1,
              //       ),
              //       suggestionsCallback: (pattern) async {
              //         print(searchController.text);
              //         matches.addAll(searchModel);
              //         matches.retainWhere((s){
              //           return s.name!.toLowerCase().contains(pattern.toLowerCase());
              //         });
              //         return matches;
              //       },
              //       itemBuilder: (context,SearchModel i) {
              //         return Container(
              //           padding: EdgeInsets.all(10),
              //           child:Text(i.name.toString()),
              //         );
              //       },
              //         onSuggestionSelected: (SearchModel suggestion) {
              //         print(suggestion);
              //         setState(() {
              //           searchController.clear();
              //           searchController.text = suggestion.name!;
              //           memberId.text = suggestion.userId!.toString();
              //           privacyStatus.text = suggestion.privacyStatus!;
              //           searchModel.clear();
              //         },
              //         );
              //       },
              //     ),
              //   ),
              // ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
