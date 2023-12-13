import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/api/user_apis/message_api.dart';
import 'package:swishlist/models/new_models/room_create_model.dart';
import 'package:swishlist/models/product_type_model.dart';

import '../../api/user_apis/products_api.dart';
import '../../constants/color.dart';
import '../../constants/globals/loading.dart';
import '../../constants/globals/shared_prefs.dart';
import '../../constants/urls.dart';
import '../../models/login_models.dart';
import '../../models/new_messages_model.dart';


class ProfileChatPage extends StatefulWidget {
  final  LoginResponse resp;
  final String friendId;
  final String name;
  final String friendImage;
  final List<int> selectedItems;

  const ProfileChatPage({
    Key? key,
    required this.resp,
    required this.friendId,
    required this.name,
    required this.friendImage,
    required this.selectedItems,
  }) : super(key: key);

  @override
  State<ProfileChatPage> createState() => _ProfileChatPageState();
}

class _ProfileChatPageState extends State<ProfileChatPage> {
  @override
  void initState() {
    super.initState();
     getWantProduct();
     getMessages();
     // createChatRoom();
    focusNode.addListener(() {
      setState(() {});
    });
    ids = int.parse(SharedPrefs().getId()!);
  }

  final GlobalKey _groupListKey = GlobalKey();

  bool isLoading = true;
  //ListMessageModel? listMessages;
  int ids = 0;
  String name  = '';

  //ChatRoomModel? resp;
  int chatRoomId = 0;

  // createChatRoom() {
  //     postChatApi(friendId: widget.friendId).then((value) {
  //       resp = value;
  //       if(resp?.error != null &&
  //           resp!.error == false){
  //         // chatRoomId = resp!.data!.lastMessage!.chatId!;
  //         SharedPrefs().setIntValue(resp!.data!.lastMessage!.chatId!);
  //         // print(resp!.data!.lastMessage!.chatId);
  //       }
  //     });
  // }

  MessageModel  response = MessageModel();



  getMessages() {
    isLoading = true;
    int? chatId = SharedPrefs().getIntValue();
    if (chatId != null) {
      var resp = getMessageApi(chatId: chatId, page: '0');
      resp.then((value) {
        if (value['error'] == false) {
          setState(() {
            response = MessageModel.fromJson(value);
            response.data?.sort((a, b) {
              final createdAtA = a.createdAt ?? "";
              final createdAtB = b.createdAt ?? "";
              return createdAtB.compareTo(createdAtA);
            });
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }



  final focusNode = FocusNode();
  final sendMsgController = TextEditingController();
  bool show = false;
  bool show2 = false;

  List<int> selectedItems = [];
  int productIds = 0;
  final key = GlobalKey<FormState>();

  List<ProductTypeModel> wantProducts = [];
  List<ProductTypeModel> wantProducts2 = [];

  getWantProduct(){
    isLoading = true;
    var resp = getProductsApi();
    resp.then((value) {
      wantProducts2.clear();
      wantProducts.clear();
      if(value['error'] == false){
        setState(() {
          for(var v in value['data']){
            wantProducts.add(ProductTypeModel.fromJson(v));
          }
          for(var q in wantProducts){
            if(q.type == 'want'){
              wantProducts2.add(q);
            }
          }
          print(wantProducts2);
          isLoading = false;
        });
          }  else{
        isLoading = false;
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return
      isLoading
        ? Loading()
        :
    Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: ColorSelect.colorFFFFFF,
              elevation: 0,
              centerTitle: false,
              title: Container(
                color: Colors.transparent,
                child: Row(
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade200,
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: CachedNetworkImage(
                        imageUrl: widget.friendImage.contains('http')
                            ? widget.friendImage
                            : baseUrl + widget.friendImage,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>   Image.asset(
                            "assets/icons/userico.jpg"),
                        progressIndicatorBuilder: (a, b, c) => Opacity(
                          opacity: 0.3,
                          child: Shimmer.fromColors(
                            baseColor: Colors.black12,
                            highlightColor: Colors.white,
                            child: Container(
                              width: 50,
                              height: 50,
                              //margin: EdgeInsets.symmetric(horizontal: 24),
                              decoration: BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8,),
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
            body: RefreshIndicator(
              displacement: 500,
              backgroundColor: Colors.white,
              color: ColorSelect.colorF7E641,
              strokeWidth: 3,
              onRefresh: () {
                setState(() {
                  isLoading = true;
                });
                return getMessages();
              },
              child: Stack(
                children: [
                  Container(
                    height: 1.sh,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                        child: Column(
                          children: [
                            GroupedListView<MsgData, String>(
                                physics: ScrollPhysics(),
                                padding: EdgeInsets.only(bottom: 100),
                                order: GroupedListOrder.DESC,
                                shrinkWrap: true,
                                elements: response.data ?? [],
                                groupBy: (element) => DateTime.now()
                                    .difference(DateTime.parse(
                                    element.createdAt.toString()))
                                    .inMinutes <=
                                    59
                                    ? "${DateTime.now().difference(DateTime.parse(
                                    element.createdAt.toString())).inMinutes} min ago"
                                    : DateTime.now()
                                    .difference(DateTime.parse(
                                    element.createdAt
                                        .toString()))
                                    .inHours <=
                                    23
                                    ? "${DateTime.now().difference(DateTime.parse(
                                    element.createdAt.toString())).inHours} hr ago"
                                    : "${DateTime.now().difference(DateTime.parse(
                                    element.createdAt.toString())).inDays} days ago",
                                    groupSeparatorBuilder: (String groupByValue) =>
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Text(
                                        groupByValue,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                itemBuilder: (context, MsgData element) {
                                 return (element.product != null &&
                                      (element.product!.photo != null || element.product!.photo!.isNotEmpty)) ?
                                 Align(
                                   alignment:
                                   ids == element.user!.id
                                   //ids == element.user!.username.toString()
                                       //widget.resp.data!.id
                                   //element.sendFromUserId
                                       ? Alignment.centerRight
                                       : Alignment.centerLeft,
                                   child: Padding(
                                     padding: const EdgeInsets.symmetric(
                                         horizontal: 12, vertical: 8),
                                     child: Container(
                                       width: 220,
                                       clipBehavior: Clip.hardEdge,
                                       decoration: BoxDecoration(
                                         color: ids ==
                                            element.user!.id
                                         //element.sendFromUserId
                                             ? Colors.grey
                                             .withOpacity(0.40)
                                             : Colors.grey
                                             .withOpacity(0.40),
                                         borderRadius:
                                         BorderRadius.circular(16),
                                       ),
                                       child:
                                       Column(
                                         children: [
                                           CachedNetworkImage(
                                             imageUrl:
                                             element.product?.photo?.toString() ?? '',
                                             fit: BoxFit.cover,
                                             errorWidget:
                                                 (context, url, error) =>
                                                 Icon(Icons.error),
                                             progressIndicatorBuilder:
                                                 (a, b, c) => Opacity(
                                               opacity: 0.3,
                                               child: Shimmer.fromColors(
                                                 baseColor:
                                                 Colors.black12,
                                                 highlightColor:
                                                 Colors.white,
                                                 child: Container(
                                                   width: 45,
                                                   height: 45,
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
                                           Padding(
                                             padding:
                                             const EdgeInsets.all(
                                                 8.0),
                                             child: Align(
                                               alignment:
                                               Alignment.centerLeft,
                                               child: Text(
                                                 element.message
                                                     .toString(),
                                                 style: TextStyle(
                                                     color: ids == element.user!.id
                                                         //widget.resp.data!.id
                                                     //element.sendFromUserId
                                                         ? Colors.black
                                                         : Colors.black),
                                                 maxLines: 4,
                                                 overflow: TextOverflow
                                                     .ellipsis,
                                               ),
                                             ),
                                           ),
                                         ],
                                       ),
                                     ),
                                   ),
                                 ) :
                                  Align(
                                          alignment:
                                   ids == element.user!.id
                                                  ? Alignment.centerRight
                                                  : Alignment.centerLeft,
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 12),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: ids == element.user!.id

                                                    ? ColorSelect.color343434
                                                    : ColorSelect.colorECEDF0),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 8),
                                              child: Text(
                                                  element.message.toString(),
                                                  style: ids == element.user!.id
                                                         // element.sendFromUserId
                                                      ? AppTextStyle()
                                                          .textColorFFFFFF14w400
                                                      : AppTextStyle()
                                                          .textColor00000014w400),
                                            ),
                                          ),
                                        );
                                },
                              ),
                            ],
                         ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: 328.w,
                      height: 52.h,
                      margin: EdgeInsets.only(
                          top: 16, bottom: 18, left: 16, right: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: focusNode.hasFocus
                              ? ColorSelect.colorFDFAE3
                              : ColorSelect.colorEDEDF1),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Form(
                          key: key,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  focusNode: focusNode,
                                  cursorColor: ColorSelect.colorF7E641,
                                  cursorWidth: 3,
                                  controller: sendMsgController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your msg';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Message",
                                      hintStyle:
                                          AppTextStyle().textColor70707014w400,
                                      suffixIcon: /*focusNode.hasFocus
                                              ?*/
                                          Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween, // added line
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          GestureDetector(
                                            behavior:
                                                HitTestBehavior.translucent,
                                            onTap: () {
                                              if (sendMsgController
                                                  .text.isNotEmpty) {
                                                setState(() {
                                                  show = !show;
                                                });
                                                Timer timer = Timer(
                                                    Duration(seconds: 3), () {
                                                  setState(() {
                                                    show = false;
                                                  });
                                                });

                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                                if (sendMsgController
                                                    .text.isNotEmpty) {
                                                  print(widget.friendId);
                                                  sendMessageApi(
                                                    chatId: chatRoomId,
                                                    message:
                                                        sendMsgController.text,
                                                  ).then((value) async {
                                                    print(widget.friendId);
                                                    print(sendMsgController);
                                                    if (value['error'] ==
                                                        false) {
                                                      sendMsgController.clear();
                                                      isLoading
                                                          ? Loading()
                                                          : getMessages();
                                                      // Fluttertoast.showToast(msg: value['message']);
                                                    } else {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              value['message']);
                                                    }
                                                  });
                                                }
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg: "Please Add your msg");
                                              }
                                            },
                                            child: show
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0),
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: ColorSelect
                                                          .colorF7E641,
                                                    ),
                                                  )
                                                : Container(
                                                    height: 40,
                                                    width: 40,
                                                    // color: Colors.yellow,
                                                    child: Image.asset(
                                                        'assets/images/sentimage.png'),
                                                  ),
                                          ),
                                          SizedBox(width: 0),
                                          GestureDetector(
                                            behavior:
                                                HitTestBehavior.translucent,
                                            onTap: () {
                                              showModalBottomSheet(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (context) {
                                                    return StatefulBuilder(
                                                        builder: (BuildContext
                                                                context,
                                                            StateSetter
                                                                setState) {
                                                      return Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: ColorSelect
                                                              .colorFFFFFF,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .vertical(
                                                            top:
                                                                Radius.circular(
                                                                    20),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      16),
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
                                                                        BorderRadius
                                                                            .circular(
                                                                                8),
                                                                    color: ColorSelect
                                                                        .colorDCDCDC),
                                                              ),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Text(
                                                                        "Products I Want",
                                                                        style: AppTextStyle()
                                                                            .textColor29292914w500,
                                                                      ),
                                                                      // SizedBox(width: 8),
                                                                      // Image.asset("assets/images/directiondown01.png"),
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                  height: 16),
                                                              wantProducts2
                                                                      .isEmpty
                                                                  ? Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          bottom:
                                                                              80.0,
                                                                          top:
                                                                              20),
                                                                      child: Image
                                                                          .asset(
                                                                        "assets/images/addproducts2.png",
                                                                        height:
                                                                            200,
                                                                        width:
                                                                            200,
                                                                      ),
                                                                    )
                                                                  :  Expanded(
                                                                      child: ListView.builder(
                                                                          padding: EdgeInsets.only(bottom: 16),
                                                                          itemCount: wantProducts2.length,
                                                                          shrinkWrap: true,
                                                                          scrollDirection: Axis.vertical,
                                                                          itemBuilder: (context, i) {
                                                                            print(wantProducts2.length);
                                                                            return Padding(
                                                                              padding: const EdgeInsets.only(top: 16),
                                                                              child: GestureDetector(
                                                                                onTap: () {
                                                                                  FocusManager.instance.primaryFocus?.unfocus();
                                                                                  // selectedItems.add(wantProduct2[i].id!);
                                                                                  productIds = wantProducts2[i].id!;
                                                                                  sendProductMessageApi(
                                                                                    chatId: chatRoomId,
                                                                                    productId: productIds.toString(),
                                                                                    message: wantProducts2[i].name.toString(),
                                                                                  ).then((value) async {
                                                                                    print(sendMsgController);
                                                                                    if (value['error'] == false) {
                                                                                      sendMsgController.clear();
                                                                                      isLoading ? Loading() : getMessages();
                                                                                      Fluttertoast.showToast(msg: value['message']);
                                                                                    } else {
                                                                                      Fluttertoast.showToast(msg: value['message']);
                                                                                    }
                                                                                  });
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                child: Container(
                                                                                  color: Colors.transparent,
                                                                                  child: Column(
                                                                                    children: [
                                                                                      Row(
                                                                                        children: [
                                                                                          Stack(children: [
                                                                                            Container(
                                                                                              height: 86,
                                                                                              width: 86,
                                                                                              clipBehavior: Clip.hardEdge,
                                                                                              decoration: BoxDecoration(
                                                                                                borderRadius: BorderRadius.circular(8),
                                                                                                border: Border.all(
                                                                                                  width: 1,
                                                                                                  color: selectedItems.contains(wantProducts2[i].id!) ?
                                                                                                  ColorSelect.colorF7E641 : ColorSelect.colorE0E0E0,
                                                                                                ),
                                                                                              ),
                                                                                              child: Center(
                                                                                                  child: CachedNetworkImage(
                                                                                                // imageUrl: (baseUrl+wantProduct2[i].photo.toString()),
                                                                                                imageUrl: wantProducts2[i].photo.toString().contains("https") ?
                                                                                                wantProducts2[i].photo.toString() : baseUrl + wantProducts2[i].photo.toString(),
                                                                                                fit: BoxFit.cover,
                                                                                                errorWidget: (context, url, error) => Icon(
                                                                                                  Icons.error,
                                                                                                  size: 40,
                                                                                                ),
                                                                                                progressIndicatorBuilder: (a, b, c) => Opacity(
                                                                                                  opacity: 0.3,
                                                                                                  child: Shimmer.fromColors(
                                                                                                    baseColor: Colors.black12,
                                                                                                    highlightColor: Colors.white,
                                                                                                    child: Container(
                                                                                                      width: 173,
                                                                                                      height: 129,
                                                                                                      decoration: BoxDecoration(border: Border.all(color: ColorSelect.colorE0E0E0, width: 1), color: ColorSelect.colorFFFFFF, borderRadius: BorderRadius.circular(12)),
                                                                                                     ),
                                                                                                   ),
                                                                                                 ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Positioned(
                                                                                              bottom: 0,
                                                                                              right: 0,
                                                                                              child: selectedItems.contains(wantProducts2[i].id!)
                                                                                                  ? Image.asset(
                                                                                                      "assets/images/select.png",
                                                                                                      height: 28,
                                                                                                      width: 28,
                                                                                                    )
                                                                                                  : SizedBox(),
                                                                                            )
                                                                                          ]),
                                                                                          Expanded(
                                                                                            child: Column(
                                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                                              children: [
                                                                                                Padding(
                                                                                                  padding: const EdgeInsets.only(left: 16),
                                                                                                  child: SizedBox(
                                                                                                    // width: 230.w,
                                                                                                    child: Text(
                                                                                                      wantProducts2[i].name.toString(),
                                                                                                      overflow: TextOverflow.ellipsis,
                                                                                                      maxLines: 2,
                                                                                                      style: AppTextStyle().textColor29292912w400,
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 8,
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: const EdgeInsets.only(left: 16),
                                                                                                  child: Text(
                                                                                                    '\$ ${wantProducts2[i].price.toString()}',
                                                                                                    style: AppTextStyle().textColor29292914w500,
                                                                                                  ),
                                                                                                ),
                                                                                                SizedBox(
                                                                                                  height: 4,
                                                                                                ),
                                                                                                Padding(
                                                                                                  padding: const EdgeInsets.only(left: 16.0),
                                                                                                  child: selectedItems.contains(wantProducts2[i].id!)
                                                                                                      ? GestureDetector(
                                                                                                          onTap: () {
                                                                                                            setState(() {
                                                                                                              selectedItems.clear();
                                                                                                            });
                                                                                                          },
                                                                                                          child: Icon(Icons.cancel))
                                                                                                      : SizedBox(),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          }),
                                                                    ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    });
                                                  });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                child: Image.asset(
                                                    "assets/images/shoppingbag.png"),
                                              ),
                                            ),
                                          )
                                        ],
                                      )),
                                  keyboardType: TextInputType.text,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
