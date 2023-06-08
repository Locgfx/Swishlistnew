import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/constants/globals/loading.dart';
import '../../api/user_apis/message_api.dart';
import '../../constants/color.dart';
import '../../constants/urls.dart';
import '../../models/message_model.dart';
import '../friends/chatpage.dart';

class Messages extends StatefulWidget {
  // final String friendId;
  const Messages({Key? key,
    // required this.friendId,
  }) : super(key: key);

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  void initState() {
    getMessages();
    // print(msgModel);
    super.initState();
  }

 bool isLoading = false;
  MessageModel?  msgModel;
  getMessages() {
    isLoading = true;
    var resp = getMessageApi();
    resp.then((value) {
      if (value['status'] == true) {
        setState(() {
          msgModel = MessageModel.fromJson(value);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSelect.colorFFFFFF,
        elevation: 0,
        title: Row(children: [
          Text(
            "Messages",
            style: AppTextStyle().textColor29292916w500,
          ),
          Spacer(),
        ]),
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
      backgroundColor: ColorSelect.colorFFFFFF,
      body:isLoading ? Loading(): Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child:
            msgModel!.data!.isEmpty ?
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.message,color: Colors.black,size: 80,),
                  SizedBox(height: 5),
                  Text('No Messages Found',
                    style: AppTextStyle().textColor29292914w500,)
                ],
              ),
            ) :
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              removeBottom: true,
              child: ListView.separated(
                itemCount: msgModel!.data!.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  return Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatPage(
                                      friendId: msgModel!.data![i].userMessages![0].sendToUserId.toString(),
                                      name: msgModel!.data![i].friendProfile!.name.toString(),
                                       friendImage: baseUrl+msgModel!.data![i].friendProfile!.photo.toString(), selectedItems: [],
                                      /*friendId: widget.friendId,*/)));
                          },
                          child: Container(
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
                                    imageUrl: baseUrl+msgModel!.data![i].friendProfile!.photo.toString(),
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
                                              width: 45,
                                              height: 45,
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
                                SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      msgModel!.data![i].friendProfile!.name.toString() == '' ?
                                      'your friend does not updated name yet':
                                msgModel!.data![i].friendProfile!.name.toString(),
                                      // "Pam",
                                      style: AppTextStyle()
                                          .robotocolor1F1F1C14w500,
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          msgModel!.data![i].userMessages![0].message.toString(),
                                          // "Sent you a product",
                                          style: AppTextStyle()
                                              .robotocolor21212113w500,
                                        ),
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
                                        SizedBox(
                                          width: 6,
                                        ),

                                        Text(
                                            DateTime.now()
                                                .difference(
                                                DateTime.parse(
                                                    msgModel!.data![i].userMessages![0].createdAt.toString()))
                                                .inMinutes <=
                                                59
                                                ? "${DateTime.now().difference(
                                                DateTime.parse( msgModel!.data![i].userMessages![0].createdAt.toString())).inMinutes} min ago"
                                                : DateTime.now()
                                                .difference(DateTime
                                                .parse( msgModel!.data![i].userMessages![0].createdAt.toString()))
                                                .inHours <=
                                                23
                                                ? "${DateTime.now().difference(
                                                DateTime.parse( msgModel!.data![i].userMessages![0].createdAt.toString())).inHours} hr ago"
                                                : "${DateTime.now().difference(
                                                DateTime.parse( msgModel!.data![i].userMessages![0].createdAt.toString())).inDays} days ago",
                                          style: AppTextStyle()
                                              .robotocolor21212113w400,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: ColorSelect.colorF7E641,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 16);
                },
              ),
            ),

      ),
    );
  }
}
