import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/dashboard/products/productAdded.dart';

import '../../../buttons/yellow_button.dart';
import '../../../models/login_models.dart';

class MyOptionsDialog extends StatefulWidget {

  const MyOptionsDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<MyOptionsDialog> createState() => _MyOptionsDialogState();
}

class _MyOptionsDialogState extends State<MyOptionsDialog> {
  bool checkedby = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) => Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(right: 16,left: 180),
              child: Material(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(width: 1,color: ColorSelect.colorECEDF0),
                      borderRadius: BorderRadius.circular(16)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ListTile(
                          title: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return MoveToSheet();
                                  });
                              // setState(() {
                              //   Share.share('Share your friend details');
                              // });
                            },
                            child: Text(
                              'Move to..',
                              style:
                              // AppTextStyle().textColorBA505014w500
                              AppTextStyle().textColor39393914w500,
                            ),
                          ),
                        ),
                        ListTile(
                          title: GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => FriendNotification()));

                            },
                            child: Text(
                              'Archive',
                              style:
                              // AppTextStyle().textColorBA505014w500
                              AppTextStyle().textColor39393914w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // margin: EdgeInsets.only(
                  //     right: 10,
                  //     top: 10,
                  //     left: 60,
                  //     bottom: 6004
                  // ),
                  // ),
                ),
              ),
            ),
          ),
        );
      },
        child: Container(
          margin: EdgeInsets.only(left: 16),
            height: 25,
            width: 25,
            child: Image.asset('assets/images/4xdot.png',)
        )
    );
    // return PopupMenuButton(
    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    //     /*icon: ImageIcon(
    //       AssetImage(
    //         "assets/images/dots2.png",
    //       ),
    //     ),*/
    //     child: Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Container(
    //         color: Colors.red,
    //           child: Image.asset("assets/images/dotsV.png"),
    //       ),
    //     ),
    //     itemBuilder: (context) {
    //       return [
    //         PopupMenuItem(
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               GestureDetector(
    //                 onTap: () {
    //                   showModalBottomSheet(
    //                       context: context,
    //                       builder: (context) {
    //                         return MoveToSheet();
    //                       });
    //                 },
    //                 child: Text(
    //                   "Move to...",
    //                   style: AppTextStyle().textColor39393914w500,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         PopupMenuItem(
    //           child: Text(
    //             "Archive",
    //             style: AppTextStyle().textColor39393914w500,
    //           ),
    //         ),
    //       ];
    //     });
  }
}

class MoveToSheet extends StatefulWidget {
  const MoveToSheet({Key? key}) : super(key: key);

  @override
  State<MoveToSheet> createState() => _MoveToSheetState();
}

class _MoveToSheetState extends State<MoveToSheet> {
  int selected = -1;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 326.h,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 32.h,
            ),
            Text(
              "Move to products...",
              style: AppTextStyle().textColor29292924w700,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Select the list to add this product",
              style: AppTextStyle().textColor70707012w400,
            ),
            SizedBox(
              height: 28,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selected = 0;
                });
              },
              child: Container(
                height: 52.h,
                width: 328.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(width: 1, color: ColorSelect.colorA3A3A3)),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      margin: EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(
                        color: selected == 0
                            ? ColorSelect.colorF7E641
                            : Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selected == 0
                              ? ColorSelect.colorF7E641
                              : ColorSelect.kAFAFAF,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.done,
                          size: 18,
                          color:
                              selected == 0 ? Colors.black : Colors.transparent,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      "I don’t want",
                      style: AppTextStyle().textColor70707014w400,
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child: SvgPicture.asset(
                        "assets/icons/likeicon.svg",
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selected = 1;
                });
              },
              child: Container(
                height: 52.h,
                width: 328.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(width: 1, color: ColorSelect.colorA3A3A3)),
                child: Row(
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      margin: EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(
                        color: selected == 1
                            ? ColorSelect.colorF7E641
                            : Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selected == 1
                              ? ColorSelect.colorF7E641
                              : ColorSelect.kAFAFAF,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.done,
                          size: 18,
                          color:
                              selected == 1 ? Colors.black : Colors.transparent,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      "I have already",
                      style: AppTextStyle().textColor70707014w400,
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child: SvgPicture.asset(
                        "assets/icons/bi_stars.svg",
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 52.h,
              width: 88.w,
              child: YellowButtonWithText(
                  backgroundColor:
                      MaterialStateProperty.all(ColorSelect.colorF7E641),
                  textStyleColor: ColorSelect.colorB5B07A,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductAdded(name: '', price: '', productImage: '',)));
                  },
                  title: 'Move'),
            )
          ],
        ),
      ),
    );
  }
}

class MyOptionsDialoglist extends StatefulWidget {
  final Function() onTap;
  const MyOptionsDialoglist({
    Key? key, required this.onTap,
  }) : super(key: key);

  @override
  State<MyOptionsDialoglist> createState() => _MyOptionsDialoglistState();
}

class _MyOptionsDialoglistState extends State<MyOptionsDialoglist> {
  bool checkedby = false;
  var popKey = GlobalKey<PopupMenuButtonState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   popKey.currentState!.activate();
      //
      // },
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(right: 16,left: 180),
                child: Material(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(width: 1,color: ColorSelect.colorECEDF0),
                        borderRadius: BorderRadius.circular(16)),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListTile(
                            title: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return MoveToSheet();
                                    });

                                // setState(() {
                                //   Share.share('Share your friend details');
                                // });
                              },
                              child: Text(
                                'Move to..',
                                style:
                                // AppTextStyle().textColorBA505014w500
                                AppTextStyle().textColor39393914w500,
                              ),
                            ),
                          ),
                          ListTile(
                            title: GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => FriendNotification()));

                              },
                              child: Text(
                                'Archive',
                                style:
                                // AppTextStyle().textColorBA505014w500
                                AppTextStyle().textColor39393914w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // margin: EdgeInsets.only(
                    //     right: 10,
                    //     top: 10,
                    //     left: 60,
                    //     bottom: 6004
                    // ),
                    // ),
                  ),
                ),
              ),
            ),
          );
        },
      child:Container(
          margin: EdgeInsets.only(right: 16),
          height: 25,
          width: 25,
          child: Image.asset('assets/images/4xdot.png'
          )
      )
    );
      /*Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Colors.transparent,
        child: PopupMenuButton(
            key: popKey,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            iconSize: 40,
            *//*icon: ImageIcon(
              AssetImage(
                "assets/images/dots2.png",
              ),
            ),*//*
            child: Image.asset("assets/images/Vector.png"),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  enabled: false,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, top: 16, bottom: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            widget.onTap;
                          },
                          child: Row(
                            children: [
                              Text(
                                "Refresh list",
                                style: AppTextStyle().textColor39393914w500,
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 26),
                        Row(
                          children: [
                            Text(
                              "Send list",
                              style: AppTextStyle().textColor39393914w500,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ];
            }),
      )*/
  }
}
