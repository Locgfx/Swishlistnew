import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../api/user_apis/friends_api.dart';
import '../../constants/color.dart';
import '../../constants/decoration.dart';
import '../../constants/globals/loading.dart';
import '../../constants/urls.dart';
import '../../models/add_friend_model.dart';
import '../../models/friends_model.dart';
import 'addfriends.dart';
import 'friendproduct.dart';
import 'friends_notifications.dart';
import 'message.dart';

class Friends extends StatefulWidget {
  // final FriendModel friendId;
  const Friends({Key? key,
    // required this.friendId,
    // required this.searchList,
  }) : super(key: key);

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  bool emptyFriends = true;
  @override
  void initState() {
    getFriends();
    super.initState();
    focusNode = FocusNode();
    // searchList = widget.searchList;
  }
  bool isLoading = false;
  bool showSearch = false;
  FriendModel ? friendsModels;
  getFriends() {
    isLoading = true;
    var resp = getFriendsApi();
    resp.then((value) {
      if(mounted){
        if (value['status'] == true) {
          setState(() {
            for (var v in value['data']) {
              friendList.add(ModelFriend.fromJson(v));
            }
            isLoading = false;
            // friendsModels = FriendModel.fromJson(value);
          });
        } else {
          setState(() {
            // friendsModels = GetFriendsModel.fromJson(value);
            isLoading = false;
          });

          // isLoading = false;
        }
      }
    });
  }

  late FocusNode focusNode;
  final searchController = TextEditingController();

  List<ModelFriend> searchList = [];
  List<ModelFriend> friendList = [];


  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
     // if(!isLoading)
        Scaffold(
          body: isLoading ? Loading(): SingleChildScrollView(
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
                        "Friends",
                        style: AppTextStyle().textColor29292924w700,
                      ),
                      Spacer(),

                      GestureDetector(
                        // behavior: HitTestBehavior.translucent,
                        onTap: () {
                          setState(() {
                            showSearch = !showSearch;
                          });

                        },
                        child:showSearch ?
                        Container(
                          color: Colors.transparent,
                          height: 24,
                          width: 24,
                          child: Image.asset(
                            "assets/images/Frame 1000002471.png",
                            fit: BoxFit.cover,
                            // color: ColorSelect.color292929,
                          ),
                        ) :
                        Container(
                          color: Colors.transparent,
                          height: 24,
                          width: 24,
                          child: Image.asset(
                            "assets/images/search 03.png",
                            fit: BoxFit.cover,
                            color: ColorSelect.color292929,
                          ),
                        ) ,
                      ),
                      SizedBox(width: 16),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => AddFriends()));
                        },
                        child: Container(
                          height: 24,
                          width: 24,
                          color: Colors.transparent,
                          child: Image.asset(
                            "assets/images/user-add.png",
                            color: ColorSelect.color292929,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Messages()));
                        },
                        child: Container(
                          height: 24,
                          width: 24,
                          color: Colors.transparent,
                          child: Image.asset(
                            "assets/images/messageicon.png",
                            color: ColorSelect.color292929,
                          ),
                        ),
                      ),
                          SizedBox(width: 16),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => FriendNotification()));
                            },
                            child: Container(
                              color: Colors.transparent,
                              height: 24,
                              width: 24,
                              child: Image.asset("assets/images/notification-pngrepo-com.png",
                                  color: ColorSelect.color292929,)
                            ),
                          )
                    ]),
                    SizedBox(
                      height: 32,
                    ),
                  showSearch ?
                  Container(
                    color: Colors.transparent,
                    child:TextFormField(
                      onChanged: (val) {
                        print(friendList);
                        print(searchController.text);
                        print(friendList[0].friend!.name);
                        for (var v in friendList) {
                          if(v.friend!.name! == val) {
                            if(searchList.contains(v)) {

                            } else {
                              searchList.add(v);
                            }
                          }
                        }
                        final suggestions = friendList.where((element) =>
                        element.friend!.name == searchController.text).toList();
                        print(suggestions);
                        setState(() {
                          searchList = suggestions;
                          print(searchList);
                          if(searchController.text.isEmpty) {
                            searchList.clear();
                          }
                        });
                      },
                      controller: searchController,
                      cursorColor: ColorSelect.colorF7E641,
                      decoration: AppTFDecoration(
                          hint: 'Enter Friend Name').decoration(),
                      //keyboardType: TextInputType.phone,
                    ),
                  ) : SizedBox(),
                  SizedBox(
                    height: 20,
                  ),
                    Row(
                      children: [
                        Text(
                          "${friendList.length.toString()} Friends",
                          // "24",
                          style: AppTextStyle().textColor70707012w500,
                        ),
                        Spacer(),
                        // GestureDetector(
                        //   onTap: () {
                        //    setState(() {
                        //      // isLoading ? Loading() : getFriends();
                        //    });
                        //   },
                        //   child: Text(
                        //     "Refresh List",
                        //     style: AppTextStyle().robotocolor22222214w500,
                        //   ),
                        // ),
                        // SizedBox(width: 6),
                        // Image.asset("assets/images/sortarrowdown.png")
                      ],
                    ),
                    SizedBox(
                      height: 14,
                    ),
                  friendList.isEmpty?
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline,color: Colors.black,size: 80,),
                        // Image.asset("assets/images/delivery.png",height: 100,),
                        SizedBox(height: 5),
                        Text('No Friends Added Yet',
                          style: AppTextStyle().textColor29292914w500,)
                      ],
                    ),
                  ) :
                      searchList.isEmpty ?
                  Padding(
                      padding: const EdgeInsets.only(bottom: 200.0),
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        // itemCount: 4,
                        itemCount: friendList.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FriendProduct(
                                              friendName:friendList[i].friend!.name.toString(),
                                            friendUserName:friendList[i].friend!.name.toString(),
                                            friendId: friendList[i].friend!.id.toString(),
                                            friendPhoto: baseUrl+friendList[i].friend!.photo!,
                                            id: friendList[i].id!.toString(),
                                           /* id: searchList[i].id.toString(),*/
                                          ),
                                        ),
                                     );
                                  },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    children: [
                                      Container(
                                        height:50,
                                        width:50,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:Colors.grey.shade200,
                                        ),
                                        clipBehavior: Clip.hardEdge,
                                        child: CachedNetworkImage(
                                            imageUrl: baseUrl+friendList[i].friend!.photo!,
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
                                      // CircleAvatar(
                                      //   radius: 24,
                                      //   backgroundColor: Colors.grey,
                                      //   backgroundImage:
                                      //       NetworkImage(model.data[i].user.photo),
                                      // ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              friendList[i].friend!.name!,
                                              // "Andy Bernard",
                                              style: AppTextStyle().textColor29292914w500,
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              friendList[i].friend!.username!,
                                              // "AndyAngie3260",
                                              style: AppTextStyle().textColor70707014w400,
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
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 16,
                          );
                        },
                      ),
                    ):
                      Padding(
                        padding: const EdgeInsets.only(bottom: 200.0),
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          // itemCount: 4,
                          itemCount: searchList.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, i) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => FriendProduct(
                                              friendName:searchList[i].friend!.name.toString(),
                                              friendUserName:searchList[i].friend!.name.toString(),
                                              friendId: searchList[i].friend!.id.toString(),
                                              friendPhoto: baseUrl+friendList[i].friend!.photo!,
                                              id: friendList[i].id!.toString(),
                                              // id: searchList[i].id.toString(),
                                             )));
                                  },
                                  onLongPress : () {},
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Row(
                                      children: [
                                        Container(
                                          height:50,
                                          width:50,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:Colors.grey.shade200,
                                          ),
                                          clipBehavior: Clip.hardEdge,
                                          child: CachedNetworkImage(
                                            imageUrl: baseUrl+searchList[i].friend!.photo!,
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
                                        // CircleAvatar(
                                        //   radius: 24,
                                        //   backgroundColor: Colors.grey,
                                        //   backgroundImage:
                                        //       NetworkImage(model.data[i].user.photo),
                                        // ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                searchList[i].friend!.name!,
                                                // "Andy Bernard",
                                                style: AppTextStyle().textColor29292914w500,
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                searchList[i].friend!.username!,
                                                // "AndyAngie3260",
                                                style: AppTextStyle().textColor70707014w400,
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
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 16,
                            );
                          },
                        ),
                      )
                  ],
                ),
              ),
          ),
            ),
        // if(isLoading) Loading()
      ],
    );
  }
}
