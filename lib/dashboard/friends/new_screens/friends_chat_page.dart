import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/api/user_apis/friends_api.dart';
import 'package:swishlist/api/user_apis/message_api.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/constants/globals/loading.dart';
import 'package:swishlist/constants/globals/shared_prefs.dart';
import 'package:swishlist/dashboard/friends/profile_chat.dart';
import 'package:swishlist/models/new_models/room_create_model.dart';

import '../../../constants/globals/globals.dart';
import '../../../constants/urls.dart';
import '../../../models/login_models.dart';
import '../../../models/new_models/main_friend_model.dart';
import 'add_friend_by_email_phone.dart';


class AllFriendsChatScreen extends StatefulWidget {
  final  LoginResponse resp;

  const AllFriendsChatScreen({super.key,
    required this.resp
  });

  @override
  State<AllFriendsChatScreen> createState() => _AllFriendsChatScreenState();
}

class _AllFriendsChatScreenState extends State<AllFriendsChatScreen> {
  @override
  void initState() {
   getFriends();
    super.initState();
  }

  bool isLoading = false;

  List<NewModelFriend> friendList = [];
  ChatRoomModel? resp;


  getFriends(){
    isLoading = true;
    var resp = getFriendsApi();
    resp.then((value) {
      friendList.clear();
      if(value['error'] == false){
        setState(() {
          for(var v in value['data']){

            friendList.add(NewModelFriend.fromJson(v));
          }
          isLoading = false;
        });
      }else{
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          return getFriends();
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Row(
                      children: [
                        Text(
                          "Chat",
                          style: AppTextStyle().textColor29292924w700,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    SizedBox(
                      height: 14,
                    ),
                    friendList.isEmpty || friendList == null
                        ? AddProductImage(
                      image: 'assets/images/addfriends.png',
                      txt:
                      'Add friends to share your profile and your favorite product',
                      buttonTxt: 'Add Friend',
                      tap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AddFriendByMailPhone()));
                      },
                      buttonIcon: 'assets/images/4xuseradd.png',
                    )
                        : Padding(
                      padding: const EdgeInsets.only(bottom: 200.0),
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: friendList.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          return Column(
                            children: [
                              GestureDetector(

                                onTap: () {


                                    postChatApi(friendId: friendList[i].friend!.id.toString()).then((value) {
                                      if(value.error == false){
                                        resp = value;
                                        print(resp);
                                        print('ggg');
                                        if (resp != null && resp?.data != null && resp?.data!.lastMessage != null) {
                                          print(resp?.data!.lastMessage!.chatId);
                                        SharedPrefs().setIntValue(resp!.data!.lastMessage!.chatId!);
                                        }
                                        //print(resp!.data!.lastMessage!.chatId);
                                        //SharedPrefs().setIntValue(resp!.data!.lastMessage!.chatId!);

                                        Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProfileChatPage(
                                                            resp: widget.resp,
                                                            friendId: friendList[i].friend!.id.toString(),
                                                            name: friendList[i].friend!.name.toString(),
                                                            friendImage: friendList[i].friend!.photo.toString(),
                                                            selectedItems: [])
                                                ),
                                              );

                                      }
                                      // resp = value;
                                      // if(resp?.error != null &&
                                      //     resp!.error == false){
                                      //   print('ggg');
                                      //   print(resp!.data!.lastMessage!.chatId);
                                      //
                                      //   // chatRoomId = resp!.data!.lastMessage!.chatId!;
                                      //   SharedPrefs().setIntValue(resp!.data!.lastMessage!.chatId!);
                                      //   Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             ProfileChatPage(
                                      //                 resp: widget.resp,
                                      //                 friendId: friendList[i].friend!.id.toString(),
                                      //                 name: friendList[i].friend!.name.toString(),
                                      //                 friendImage: friendList[i].friend!.photo.toString(),
                                      //                 selectedItems: [])
                                      //     ),
                                      //   );
                                      // }
                                      else {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           ProfileChatPage(
                                        //               resp: widget.resp,
                                        //               friendId: friendList[i].friend!.id.toString(),
                                        //               name: friendList[i].friend!.name.toString(),
                                        //               friendImage: friendList[i].friend!.photo.toString(),
                                        //               selectedItems: [])
                                        //   ),
                                        // );
                                      }
                                    });




                                },
                                // onTap: () {
                                //   postChatApi(friendId: friendList[0].friend!.id.toString()).then((value) {
                                //     if(value['error'] == false){
                                //       final int chat_Id = value['data']['last_message']['chat_id'];
                                //       print('nnnn$chat_Id');
                                //       Navigator.push(
                                //         context,
                                //         MaterialPageRoute(
                                //             builder: (context) =>
                                //                 ProfileChatPage(
                                //                   resp: widget.resp,
                                //                   chatId: chat_Id,
                                //                     friendId: friendList[0].friend!.id.toString(),
                                //                     name: friendList[0].friend!.name.toString(),
                                //                     friendImage: friendList[0].friend!.photo.toString(),
                                //                     selectedItems: [])
                                //         ),
                                //       );
                                //     }
                                //   });
                                //
                                //
                                // },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                          Colors.grey.shade200,
                                        ),
                                        clipBehavior: Clip.hardEdge,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                          friendList[i]
                                              .friend!
                                              .photo  == null ? '':

                                          friendList[i]
                                              .friend!
                                              .photo!
                                              .contains('http')
                                              ? friendList[i]
                                              .friend!
                                              .photo
                                              .toString()
                                              : newBaseUrl +
                                              friendList[i]
                                                  .friend!
                                                  .photo
                                                  .toString(),
                                          fit: BoxFit.cover,
                                          errorWidget: (context,
                                              url, error) =>
                                              Icon(Icons.error),
                                          progressIndicatorBuilder:
                                              (a, b, c) => Opacity(
                                            opacity: 0.3,
                                            child:
                                            Shimmer.fromColors(
                                              baseColor:
                                              Colors.black12,
                                              highlightColor:
                                              Colors.white,
                                              child: Container(
                                                width: 50,
                                                height: 50,
                                                //margin: EdgeInsets.symmetric(horizontal: 24),
                                                decoration:
                                                BoxDecoration(
                                                    color: Colors
                                                        .white,
                                                    shape: BoxShape
                                                        .circle),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text(
                                              friendList[i]
                                                  .friend!
                                                  .name ==
                                                  null
                                                  ? 'friend not added name yet'
                                                  : friendList[i]
                                                  .friend!
                                                  .name!,
                                              // "Andy Bernard",
                                              style: AppTextStyle()
                                                  .textColor29292914w500,
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              friendList[i]
                                                  .friend!
                                                  .username ==
                                                  null
                                                  ? 'friend not added name yet'
                                                  : friendList[i]
                                                  .friend!
                                                  .username!,

                                              // "AndyAngie3260",
                                              style: AppTextStyle()
                                                  .textColor70707014w400,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                        separatorBuilder:
                            (BuildContext context, int index) {
                          return SizedBox(
                            height: 16,
                          );
                        },
                      ),
                    )
                    // : Padding(
                    //     padding: const EdgeInsets.only(bottom: 200.0),
                    //     child: ListView.separated(
                    //       padding: EdgeInsets.zero,
                    //       // itemCount: 4,
                    //       itemCount: searchList.length,
                    //       physics: NeverScrollableScrollPhysics(),
                    //       shrinkWrap: true,
                    //       itemBuilder: (context, i) {
                    //         return Column(
                    //           children: [
                    //             GestureDetector(
                    //               onTap: () {
                    //                 Navigator.push(
                    //                     context,
                    //                     MaterialPageRoute(
                    //                         builder: (context) =>
                    //                             FriendProduct(
                    //                               friendName:
                    //                                   searchList[i]
                    //                                       .friend!
                    //                                       .name
                    //                                       .toString(),
                    //                               friendUserName:
                    //                                   searchList[i]
                    //                                       .friend!
                    //                                       .name
                    //                                       .toString(),
                    //                               friendId:
                    //                                   searchList[i]
                    //                                       .friend!
                    //                                       .id
                    //                                       .toString(),
                    //                               friendPhoto:
                    //                                   baseUrl +
                    //                                       friendList[
                    //                                               i]
                    //                                           .friend!
                    //                                           .photo!,
                    //                               id: friendList[i]
                    //                                   .id!
                    //                                   .toString(),
                    //                               // id: searchList[i].id.toString(),
                    //                             )));
                    //               },
                    //               onLongPress: () {},
                    //               child: Container(
                    //                 color: Colors.transparent,
                    //                 child: Row(
                    //                   children: [
                    //                     Container(
                    //                       height: 50,
                    //                       width: 50,
                    //                       decoration: BoxDecoration(
                    //                         shape: BoxShape.circle,
                    //                         color:
                    //                             Colors.grey.shade200,
                    //                       ),
                    //                       clipBehavior: Clip.hardEdge,
                    //                       child: CachedNetworkImage(
                    //                         imageUrl: baseUrl +
                    //                             searchList[i]
                    //                                 .friend!
                    //                                 .photo!,
                    //                         fit: BoxFit.cover,
                    //                         errorWidget: (context,
                    //                                 url, error) =>
                    //                             Icon(Icons.error),
                    //                         progressIndicatorBuilder:
                    //                             (a, b, c) => Opacity(
                    //                           opacity: 0.3,
                    //                           child:
                    //                               Shimmer.fromColors(
                    //                             baseColor:
                    //                                 Colors.black12,
                    //                             highlightColor:
                    //                                 Colors.white,
                    //                             child: Container(
                    //                               width: 50,
                    //                               height: 50,
                    //                               //margin: EdgeInsets.symmetric(horizontal: 24),
                    //                               decoration:
                    //                                   BoxDecoration(
                    //                                       color: Colors
                    //                                           .white,
                    //                                       shape: BoxShape
                    //                                           .circle),
                    //                             ),
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     ),
                    //                     // CircleAvatar(
                    //                     //   radius: 24,
                    //                     //   backgroundColor: Colors.grey,
                    //                     //   backgroundImage:
                    //                     //       NetworkImage(model.data[i].user.photo),
                    //                     // ),
                    //                     SizedBox(
                    //                       width: 8,
                    //                     ),
                    //                     Expanded(
                    //                       child: Column(
                    //                         crossAxisAlignment:
                    //                             CrossAxisAlignment
                    //                                 .start,
                    //                         children: [
                    //                           Text(
                    //                             searchList[i]
                    //                                 .friend!
                    //                                 .name!,
                    //                             // "Andy Bernard",
                    //                             style: AppTextStyle()
                    //                                 .textColor29292914w500,
                    //                           ),
                    //                           SizedBox(height: 4),
                    //                           Text(
                    //                             searchList[i]
                    //                                 .friend!
                    //                                 .username!,
                    //                             // "AndyAngie3260",
                    //                             style: AppTextStyle()
                    //                                 .textColor70707014w400,
                    //                           )
                    //                         ],
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             )
                    //           ],
                    //         );
                    //       },
                    //       separatorBuilder:
                    //           (BuildContext context, int index) {
                    //         return SizedBox(
                    //           height: 16,
                    //         );
                    //       },
                    //     ),
                    //   )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
