import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swishlist/api/user_apis/message_api.dart';
import '../../../constants/color.dart';
import '../../products/widget/product_add_widget.dart';

class MessageChatWidget extends StatefulWidget {
  final String friendId;
  const MessageChatWidget({
    Key? key,
    required this.selectedItems,
    required this.friendId,
  }) : super(key: key);

  final List<int> selectedItems;
  @override
  State<MessageChatWidget> createState() => _MessageChatWidgetState();
}

class _MessageChatWidgetState extends State<MessageChatWidget> {
  final focusNode = FocusNode();
  bool isFocused = false;
  @override
  void initState() {
    print(widget.friendId);
    super.initState();
    focusNode.addListener(() {
      setState(() {});
    });
  }

  final sendMsgController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
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
                            behavior: HitTestBehavior.opaque,

                            onTap: () {
                              if(sendMsgController.text.isNotEmpty) {
                                print(widget.friendId);
                                sendMessageApi(
                                    sendUserid: widget.friendId,
                                    message: sendMsgController.text, productId: '').then((value) async {
                                  print(widget.friendId);
                                  print(sendMsgController);
                                      if(value['status'] == true) {
                                        Fluttertoast.showToast(msg: value['message']);
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
    );
  }
}
