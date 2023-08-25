import 'package:cached_network_image/cached_network_image.dart';
import 'package:fast_contacts/fast_contacts.dart';
// import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/api/user_apis/contact_api.dart';
import 'package:swishlist/constants/globals/loading.dart';

import '../../api/user_apis/friends_api.dart';
import '../../buttons/yellow_button.dart';
import '../../constants/color.dart';
import '../../constants/urls.dart';
import '../../models/contact_model.dart';

class AddFriends extends StatefulWidget {
  // final FriendModel friendModel;
  const AddFriends({
    Key? key,
    /* required this.friendModel*/
  }) : super(key: key);

  @override
  State<AddFriends> createState() => _AddFriendsState();
}

class _AddFriendsState extends State<AddFriends> {
  @override
  void initState() {
    // getContactPermission();
    // getContact();
    loadContacts();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // List<Contact>? contacts;
  bool isLoading = true;
  List<String> phNo = [];
  List<ModelContact> friendList = [];
  final searchController = TextEditingController();

  contact() {
    isLoading = true;
    var resp = getContactApi(contacts: phNo);
    phNo.clear();
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
      final sw = Stopwatch()..start();
      _contacts = await FastContacts.getAllContacts();
      for (var v in _contacts) {
        for (var q in v.phones) {
          var h = q.number.replaceAll("-", "");
          phNo.add(h);
          // phNo.add(q.number);
        }
      }
      /*for(var e in phNo) {
        e.replaceAll("-", "");
      }*/
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

  // void getContact() async {
  //   if (await FlutterContacts.requestPermission()) {
  //     contacts = await FlutterContacts.getContacts(
  //         withProperties: true, withPhoto: false
  //     );
  //     print(contacts);
  //     // await Future.delayed(Duration(seconds: 1),() {
  //     //   log(contacts!.first.phones.first.number.toString());
  //     //   for (var v in contacts!) {
  //     //     log(v.phones.first.number.toString());
  //     //     // phNo.add(v.phones.toString());
  //     //     // contact();
  //     //   }
  //     //
  //     // });
  //     // print(phNo);
  //     // setState(() {});
  //   }
  // }

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSelect.colorFFFFFF,
        elevation: 0,
        title: Row(
          children: [
            Text(
              "Add friend",
              style: AppTextStyle().textColor29292916w500,
            ),
          ],
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset('assets/images/Vector190.png'),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: isLoading
          ? Loading()
          : RefreshIndicator(
              displacement: 500,
              backgroundColor: Colors.white,
              color: ColorSelect.colorF7E641,
              strokeWidth: 3,
              onRefresh: () {
                setState(() {
                  isLoading = true;
                });
                return contact();
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      // Container(
                      //   width: 328.w,
                      //   height: 52.h,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(8),
                      //     color: ColorSelect.colorEDEDF1,
                      //   ),
                      //   child: Row(
                      //     children: [
                      //       SizedBox(
                      //         width: 16,
                      //       ),
                      //       Image.asset("assets/images/Vectorse.png"),
                      //       SizedBox(
                      //         width: 16,
                      //       ),
                      //       /* Expanded(
                      //   child: TextFormField(
                      //     controller: searchController,
                      //     onChanged: (val) {
                      //       for (var v in friendList) {
                      //         if(v.name! == val) {
                      //           if(searchList.contains(v)) {
                      //           } else {
                      //             searchList.add(v);
                      //           }
                      //         }
                      //       }
                      //       setState(() {
                      //         if(searchController.text.isEmpty) {
                      //           searchList.clear();
                      //         }
                      //         print(searchList);
                      //       });
                      //     },
                      //     decoration: InputDecoration(
                      //         border: InputBorder.none,
                      //         hintText: "Search friend name"),
                      //     keyboardType: TextInputType.text,
                      //   ),
                      // )*/
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 16,
                      // ),
                      // (contact) == null ?
                      // Padding(
                      //         padding: const EdgeInsets.only(top: 200),
                      //         child: LoadingAnimationWidget.inkDrop(
                      //           size: 40, color: ColorSelect.colorF7E641,
                      //         ),
                      //       ) :
                      Column(
                        children: [
                          // ListView.builder(
                          //   shrinkWrap: true,
                          // itemCount: _contacts.length,
                          // itemBuilder: (_,i) {
                          //   return  _ContactItem(contact: _contacts[i]);
                          //   // return Text(_contacts[i].phones.toString());
                          //   },
                          // ),
                          /*   searchList.isEmpty ?*/
                          RefreshIndicator(
                            displacement: 500,
                            backgroundColor: Colors.white,
                            color: ColorSelect.colorF7E641,
                            strokeWidth: 3,
                            onRefresh: () {
                              setState(() {
                                isLoading = true;
                              });
                              return contact();
                            },
                            child: ListView.builder(
                                padding: EdgeInsets.only(bottom: 36),
                                shrinkWrap: true,
                                itemCount: friendList.length,
                                physics: ScrollPhysics(),
                                // physics: NeverScrollableScrollPhysics(),
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
                                                // contactModel.data![i].name.toString()
                                                // "${contacts![index].name.first} ${contacts![index].name.last}",
                                                // style: AppTextStyle().textColor29292914w500,
                                              ),
                                              Text(friendList[i]
                                                  .phone
                                                  .toString()),
                                            ],
                                          ),
                                          Padding(
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
                                      onTap: () {
                                        // if (contacts![index].phones.isNotEmpty) {
                                        //   launch('tel: ${num}');
                                        // }
                                      });
                                }),
                          )
                          /*                :
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: searchList.length,
                      itemBuilder: (context,i) {
                        return ListTile(
                            leading: Container(
                              height:50,
                              width:50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:Colors.grey.shade200,
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: CachedNetworkImage(
                                imageUrl: baseUrl+searchList[i].photo.toString(),
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
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle
                                          ),
                                        ),
                                      ),
                                    ),
                              ),
                            ),
                            title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(crossAxisAlignment:CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      searchList[i].name.toString(),
                                    ),
                                    Text(
                                        searchList[i].phone.toString()
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: SizedBox(
                                    width: 70,
                                    height: 36,
                                    child: YellowButtonWithText(
                                      backgroundColor:
                                      MaterialStateProperty.all(ColorSelect.colorF7E641),
                                      textStyleColor: ColorSelect.color292929,
                                      title: 'Add',
                                      onTap: () {
                                        addFriendApi(
                                            friendsId: friendList[i].id.toString(),
                                            status: 'requested').then((value) {
                                          print(value);
                                          if(value['status'] == true) {
                                            setState(() {
                                              Fluttertoast.showToast(
                                                  msg: value['message']);
                                            });
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: value['message']);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                            // subtitle: Text(num),
                            onTap: () {
                              // if (contacts![index].phones.isNotEmpty) {
                              //   launch('tel: ${num}');
                              // }
                            });

                      })*/
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  const _ContactItem({
    Key? key,
    required this.contact,
  }) : super(key: key);

  static final height = 86.0;

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    final phones = contact.phones.map((e) => e.number).join(', ');
    final emails = contact.emails.map((e) => e.address).join(', ');
    final name = contact.structuredName;
    final nameStr = name != null
        ? [
            if (name.namePrefix.isNotEmpty) name.namePrefix,
            if (name.givenName.isNotEmpty) name.givenName,
            if (name.middleName.isNotEmpty) name.middleName,
            if (name.familyName.isNotEmpty) name.familyName,
            if (name.nameSuffix.isNotEmpty) name.nameSuffix,
          ].join(', ')
        : '';
    final organization = contact.organization;
    final organizationStr = organization != null
        ? [
            if (organization.company.isNotEmpty) organization.company,
            if (organization.department.isNotEmpty) organization.department,
            if (organization.jobDescription.isNotEmpty)
              organization.jobDescription,
          ].join(', ')
        : '';

    return SizedBox(
      height: height,
      child: ListTile(
        title: Text(
          contact.displayName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (phones.isNotEmpty)
              Text(
                phones,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            // if (emails.isNotEmpty)
            // Text(
            // emails,
            // maxLines: 1,
            // overflow: TextOverflow.ellipsis,
            // ),
            // if (nameStr.isNotEmpty)
            // Text(
            // nameStr,
            // maxLines: 1,
            // overflow: TextOverflow.ellipsis,
            // ),
            // if (organizationStr.isNotEmpty)
            // Text(
            // organizationStr,
            // maxLines: 1,
            // overflow: TextOverflow.ellipsis,
            // ),
          ],
        ),
      ),
    );
  }
}
