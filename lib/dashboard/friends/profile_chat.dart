
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/api/user_apis/message_api.dart';
import 'package:swishlist/constants/globals/shared_prefs.dart';
import 'package:swishlist/dashboard/friends/widget/messagechat.dart';
import '../../constants/color.dart';
import '../../constants/globals/loading.dart';
import '../../models/list_message_model.dart';
import '../products/widget/product_add_widget.dart';

class ProfileChatPage extends StatefulWidget {
  final String friendId;
  final String name;
  final String friendImage;
  final List<int> selectedItems;
  // final ModelFriend friendModel;
  const ProfileChatPage({Key? key,
    required this.friendId,
    required this.name,
    required this.friendImage, required this.selectedItems, /* required this.friendModel,*/
  }) : super(key: key);

  @override
  State<ProfileChatPage> createState() => _ProfileChatPageState();
}

class _ProfileChatPageState extends State<ProfileChatPage> {
  // List<int> selectedItems = [];
  @override
  void initState() {
    super.initState();
    SharedPrefs().getId();
    getMessages();
    focusNode.addListener(() {
      setState(() {});
    });
    // getUserMessages();
    ids = int.parse(SharedPrefs().getId()!);
    // print(SharedPrefs().getId());
    print(widget.friendId);
    print(widget.name);
    print(widget.friendImage);
  }
  final GlobalKey _groupListKey = GlobalKey();
  bool isLoading = true;
  ListMessageModel? listMessages;
  // ListMessageModel  listMessages = ListMessageModel();
  int ids = 0;
  getMessages() {
    isLoading = true;
    var resp = listMessageApi(specificUserid: widget.friendId);
    resp.then((value) {
      print(widget.friendId);
      if (mounted) {
        if (value['status'] == true) {
          setState(() {
            listMessages = ListMessageModel.fromJson(value);
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

  final focusNode = FocusNode();
  final sendMsgController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return isLoading ? Loading() :Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSelect.colorFFFFFF,
        elevation: 0,
        centerTitle: false,
        title: Container(
          color: Colors.transparent,
          child: Row(
            children: [
              Container(
                height:45,
                width:45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:Colors.grey.shade200,
                ),
                clipBehavior: Clip.hardEdge,
                child: CachedNetworkImage(
                  imageUrl: widget.friendImage,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error,color: Colors.black,),
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
              //   radius: 20,
              //   backgroundColor: Colors.grey,
              //   backgroundImage: AssetImage('assets/images/Rectangle3194.png'),
              // ),
              SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    // "Pam",
                    style: AppTextStyle().robotocolor1F1F1C14w500,
                  ),
                  Row(
                    children: [
                      // Text(
                      //   widget.name,
                      //   // "PamRox23",
                      //   style: AppTextStyle().robotocolor96969614w400,
                      // ),
                      SizedBox(
                        width: 6,
                      ),
                      Container(
                        height: 2,
                        width: 2,
                        decoration: BoxDecoration(
                            color: ColorSelect.colorBCBCBC,
                            shape: BoxShape.circle),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Image.asset(
                "assets/images/Vector.png",
                height: 40,
                width: 40,
              )
            ],
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            color: Colors.transparent,
            child: Image.asset('assets/images/Vector190.png'),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        height: 1.sh,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  GroupedListView<Data,String>(
                    padding: EdgeInsets.only(bottom: 100),
                      order: GroupedListOrder.DESC,
                      shrinkWrap:  true,
                      elements: listMessages!.data!,
                      groupBy: (element) => DateTime.now()
                          .difference(
                          DateTime.parse(
                              element.createdAt.toString()))
                          .inMinutes <=
                          59
                          ? "${DateTime.now().difference(
                          DateTime.parse(element.createdAt.toString())).inMinutes} min ago"
                          : DateTime.now()
                          .difference(DateTime
                          .parse(element.createdAt.toString()))
                          .inHours <=
                          23
                          ? "${DateTime.now().difference(
                          DateTime.parse(element.createdAt.toString())).inHours} hr ago"
                          : "${DateTime.now().difference(
                          DateTime.parse(element.createdAt.toString())).inDays} days ago",
                      groupSeparatorBuilder: (String groupByValue) =>
                          Text(groupByValue,textAlign: TextAlign.center,),
                      itemBuilder: (context, Data element) =>
                      ids == element.sendFromUserId ?
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: ColorSelect.color343434),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: Text(
                              element.message.toString(),
                              style: AppTextStyle().textColorFFFFFF14w400,
                            ),
                          ),
                        ),
                      ) :
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: ColorSelect.colorECEDF0),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            child: Text(
                              element.message.toString(),
                              style: AppTextStyle().textColor2C2C2C14w500roboto,
                            ),
                          ),
                        ),
                      )


                    // Align(
                    //   alignment:  ids == element.sendFromUserId ? Alignment.centerRight : Alignment.centerLeft,
                    //   child: Row(
                    //     children: [
                    //       Text(element.message.toString(),
                    //       style: ids == element.sendFromUserId ? TextStyle(color: Colors.red) :
                    //       TextStyle(color: Colors.yellow) ,
                    //       /*style:  AppTextStyle().textColorFFFFFF14w400,*/),
                    //     ],
                    //   ),
                    // )
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: Row(
                    //     children: [
                    //       Text(element.message.toString(),
                    //         /*style:  AppTextStyle().textColorFFFFFF14w400,*/),
                    //     ],
                    //   ),
                    // ),


                    // itemComparator: (item1, item2) => item1['name'].compareTo(item2['name']), // optional
                    // useStickyGroupSeparators: true, // optional
                    // floatingHeader: true, // optional
                    // optional-9
                  ),


                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       "Today, 5:23 AM",
                  //       style: AppTextStyle().textColor70707012w400,
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 16,
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 100),
                  //   child: Container(
                  //     width: 144.w,
                  //     height: 108.h,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(12),
                  //         border: Border.all(
                  //             width: 1, color: ColorSelect.colorC2C2C2)),
                  //     child: Center(
                  //       child: Image.asset("assets/images/image10.png"),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 8,
                  // ),
                  // Text(
                  //   "RESPAWN 110 Racing Style Gaming Chair, Reclining\nErgonomic Chair with Footrest, in Green",
                  //   style: AppTextStyle().textColor8F8F8F10w400,
                  // ),
                  // SizedBox(
                  //   height: 16,
                  // ),
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //       width: 20,
                  //     ),
                  //     CircleAvatar(
                  //       radius: 15,
                  //       backgroundColor: Colors.grey,
                  //       backgroundImage:
                  //           AssetImage('assets/images/Rectangle3194.png'),
                  //     ),
                  //     SizedBox(
                  //       width: 12,
                  //     ),
                  //     Container(
                  //       width: 231.w,
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(8),
                  //           color: ColorSelect.colorECEDF0),
                  //       child: Padding(
                  //         padding: const EdgeInsets.symmetric(
                  //             horizontal: 12, vertical: 8),
                  //         child: Text(
                  //           "Send me this ASAP. You haven’t gifted me yet",
                  //           style: AppTextStyle().textColor2C2C2C14w500roboto,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: Container(
                  //     margin: EdgeInsets.symmetric(vertical: 12),
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(8),
                  //         color: ColorSelect.color343434),
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(
                  //           horizontal: 12, vertical: 8),
                  //       child: Text(
                  //         "Sure, why not, lemme see",
                  //         style: AppTextStyle().textColorFFFFFF14w400,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  /*GestureDetector(
                    onTap: () {
                      */ /*Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ChatMessage()));*/ /*
                    },
                    child: MessageChatWidget(selectedItems: selectedItems),
                  ),*/
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  width: 328.w,
                  height: 52.h,
                  margin: EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: focusNode.hasFocus
                          ? ColorSelect.colorFDFAE3
                          : ColorSelect.colorEDEDF1),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            focusNode: focusNode,
                            cursorColor: ColorSelect.colorF7E641,
                            cursorWidth: 3,
                            controller: sendMsgController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Message",
                                hintStyle: AppTextStyle().textColor70707014w400,
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      focusNode.hasFocus
                                          ? () {}
                                          : showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                color: ColorSelect.colorFFFFFF,
                                                borderRadius: BorderRadius.vertical(
                                                  top: Radius.circular(20),
                                                ),
                                              ),
                                              child: SingleChildScrollView(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: 8,
                                                      ),
                                                      Container(
                                                        width: 48.w,
                                                        height: 4.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                8),
                                                            color: ColorSelect
                                                                .colorDCDCDC),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            "Products I Want",
                                                            style: AppTextStyle()
                                                                .textColor29292914w500,
                                                          ),
                                                          SizedBox(width: 8),
                                                          Image.asset(
                                                              "assets/images/directiondown01.png")
                                                        ],
                                                      ),
                                                      SizedBox(height: 16),
                                                      Container(
                                                        width: 328.w,
                                                        height: 52.h,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                8),
                                                            color: ColorSelect
                                                                .colorEDEDF1),
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 16,
                                                            ),
                                                            Image.asset(
                                                              "assets/images/Vectorse.png",
                                                              color: Colors.black,
                                                            ),
                                                            SizedBox(width: 16),
                                                            //Todo: TextField corrections
                                                            Expanded(
                                                              child: TextFormField(
                                                                onChanged: (v) {setState(() {

                                                                });},
                                                                // controller: sendMsgController,
                                                                decoration:
                                                                InputDecoration(
                                                                  border:
                                                                  InputBorder.none,
                                                                  hintText:
                                                                  "Search",
                                                                ),
                                                                // keyboardType:
                                                                //     TextInputType.text,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      ProductListWidget(
                                                          selectedItems:
                                                          widget.selectedItems),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    child: focusNode.hasFocus
                                        ? GestureDetector(
                                        onTap: () {
                                          FocusManager.instance.primaryFocus?.unfocus();
                                          if(sendMsgController.text.isNotEmpty) {
                                            print(widget.friendId);
                                            sendMessageApi(
                                                sendUserid: widget.friendId,
                                                message: sendMsgController.text).then((value) async {
                                              print(widget.friendId);
                                              print(sendMsgController);
                                              if(value['status'] == true) {
                                                isLoading ? Loading() :getMessages();
                                                // Fluttertoast.showToast(msg: value['message']);
                                              } else {
                                                Fluttertoast.showToast(msg: value['message']);
                                              }
                                            });
                                          }
                                        },
                                        child: Image.asset('assets/images/sentimage.png'))
                                        : Image.asset("assets/images/shoppingbag.png"))),
                            keyboardType: TextInputType.text,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              // MessageChatWidget(
              //   selectedItems: selectedItems,
              //   friendId: widget.friendId,
              //   /*friendId: widget.friendId,*/),
            ),
            // Positioned(
            //   bottom: 0,
            //   child: MessageChatWidget(selectedItems: selectedItems, friendId: widget.friendId,
            //     /*friendId: widget.friendId,*/),
            // ),
          ],
        ),
      ),
    );
  }
}
