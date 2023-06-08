import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/api/user_apis/contact_api.dart';
import 'package:swishlist/buttons/yellow_button.dart';
import 'package:swishlist/constants/globals/loading.dart';
import '../../api/user_apis/friends_api.dart';
import '../../constants/color.dart';
import '../../constants/urls.dart';
import '../../models/contact_model.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class AddFriends extends StatefulWidget {
  // final FriendModel friendModel;
  const AddFriends({Key? key,/* required this.friendModel*/}) : super(key: key);

  @override
  State<AddFriends> createState() => _AddFriendsState();
}

class _AddFriendsState extends State<AddFriends> {

  @override
  void initState() {
    // getContactPermission();
    getContact();
    super.initState();
  }
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
  List<Contact>? contacts;
  bool isLoading = true;


  List<ModelContact> searchList = [];
  List<ModelContact> friendList = [];
  final searchController = TextEditingController();

  contact() {
    isLoading = true;
    var resp = getContactApi(contacts: phNo);
    resp.then((value) {
      if(mounted){
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

          // isLoading = false;
        }
      }
    });
  }

  void getContact() async {
    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
      for (var v in contacts!){
        phNo.add(v.phones.first.number);
      }
      contact();


      // print(contacts);
      setState(() {});
    }
  }
  final TextEditingController _controller = TextEditingController();
   List <String> phNo = [];
   List  listPh = [];

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
      body: isLoading ? Loading() : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 16,),
              Container(
                width: 328.w,
                height: 52.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorSelect.colorEDEDF1,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    Image.asset("assets/images/Vectorse.png"),
                    SizedBox(width: 16,),
                    Expanded(
                      child: TextFormField(
                        controller: searchController,
                        onChanged: (val) {
                          for (var v in friendList) {
                            if(v.name! == val) {
                              if(searchList.contains(v)) {

                              } else {
                                searchList.add(v);
                              }
                            }
                          }
                          setState(() {
                            if(searchController.text.isEmpty) {
                              searchList.clear();
                            }
                            print(searchList);
                          });


                        },

                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search friend name"),
                        keyboardType: TextInputType.text,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16,),
              (contacts) == null ?
              Padding(
                      padding: const EdgeInsets.only(top: 200),
                      child: LoadingAnimationWidget.inkDrop(
                        size: 40, color: ColorSelect.colorF7E641,
                      ),
                    ) :
            Column(
              children: [
                searchList.isEmpty ?
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: friendList.length,
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
                              imageUrl: baseUrl+friendList[i].photo.toString(),
                              // imageUrl: baseUrl+contactModel.data![i].photo.toString(),
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
                                        //margin: EdgeInsets.symmetric(horizontal: 24),
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
                                      friendList[i].name.toString(),
                                    // contactModel.data![i].name.toString()
                                    // "${contacts![index].name.first} ${contacts![index].name.last}",
                                    // style: AppTextStyle().textColor29292914w500,
                                  ),
                                  Text(
                                      friendList[i].phone.toString()
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

                }) :
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

                    })
              ],
            )
            ],
          ),
        ),
      ),
    );
  }
}

