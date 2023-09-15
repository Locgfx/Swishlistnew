import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../buttons/red_button.dart';
import '../../../buttons/white_button.dart';
import '../../../buttons/yellow_button.dart';
import '../../../constants/color.dart';
import '../product_privacy.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 338.h,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 32.h,
            ),
            Text(
              "Edit title",
              style: AppTextStyle().textColor3D3D3D24w700,
            ),
            SizedBox(
              height: 28.h,
            ),
            Container(
              height: 154.h,
              width: 328.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: ColorSelect.colorFEFCF6,
                  border: Border.all(color: ColorSelect.colorF7E641)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: Column(
                  children: [
                    Text(
                      "RESPAWN 110 Racing Style Gaming Chair, Reclining Ergonomic Chair with Footrest, in Green",
                      style: AppTextStyle().textColor00000014w400,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            SizedBox(
              width: 87.w,
              height: 48.h,
              child: YellowButtonWithText(
                  backgroundColor:
                      MaterialStateProperty.all(ColorSelect.colorF7E641),
                  textStyleColor: ColorSelect.color292929,
                  onTap: () {
                    /*Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => UserDetails()));*/
                  },
                  title: 'Save'),
            )
          ],
        ),
      ),
    );
  }
}

class DialogWidget extends StatefulWidget {
  const DialogWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.only(left: 20, right: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      content: SizedBox(
        width: 1.sw,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Delete this product?",
                style: AppTextStyle().textColor29292918w500,
              ),
              SizedBox(
                height: 8.h,
              ),
              Text(
                "This product with will be permanently deleted",
                style: AppTextStyle().textcolor82828212w400,
              ),
              SizedBox(
                height: 44.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: WhiteButtonWithText(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          textStyleColor: ColorSelect.color292929,
                          onTap: () {
                            /*Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ResetPasswordViaPhone()));*/
                          },
                          title: 'Cancel'),
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: RedButtonWithText(
                        backgroundColor:
                            MaterialStateProperty.all(ColorSelect.colorCE5252),
                        textStyleColor: ColorSelect.colorFFFFFF,
                        image: Image.asset("assets/images/trashdel.png"),
                        onTap: () {},
                        title: 'Delete',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShareBottomSheet extends StatefulWidget {
  const ShareBottomSheet({Key? key}) : super(key: key);

  @override
  State<ShareBottomSheet> createState() => _ShareBottomSheetState();
}

class _ShareBottomSheetState extends State<ShareBottomSheet> {
  bool _switchValue = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 622.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 138.w,
              height: 44.h,
              margin: EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/icons/shareimg.svg"),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Share via",
                    style: AppTextStyle().textcolor27272714w500,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 1.sw,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Container(
                        width: 48,
                        height: 4,
                        decoration: BoxDecoration(
                            color: ColorSelect.colorDCDCDC,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 106.h,
                      width: 328.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: ColorSelect.colorEFEFEF),
                      child: Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Write a maessage",
                                border: InputBorder.none),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Send to",
                          style: AppTextStyle().textColor29292924w700,
                        ),
                        Spacer(),
                        Text(
                          "Anonymously",
                          style: AppTextStyle().textColor70707014w400,
                        ),
                        Switch(
                          value: _switchValue,
                          onChanged: (value) {
                            setState(() {
                              _switchValue = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      width: 328.w,
                      height: 52.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: ColorSelect.colorEDEDF1),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 16,
                          ),
                          Image.asset("assets/images/Vectorse.png"),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: "Search"),
                              keyboardType: TextInputType.text,
                            ),
                          )
                        ],
                      ),
                    ),
                    ListView.separated(
                      //physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.grey,
                                  backgroundImage: AssetImage(
                                      'assets/images/Rectangle319.png'),
                                ),
                                SizedBox(
                                  width: 8.h,
                                ),
                                Text(
                                  "Jan Levinson",
                                  style: AppTextStyle().textColor00000014w400,
                                ),
                                Spacer(),
                                SizedBox(
                                  width: 70,
                                  height: 36,
                                  child: YellowButtonWithText(
                                    backgroundColor: MaterialStateProperty.all(
                                        ColorSelect.colorF7E641),
                                    textStyleColor: ColorSelect.color292929,
                                    title: 'Send',
                                    onTap: () {},
                                  ),
                                )
                              ],
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 16,
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProductForBottomSheetWidget extends StatelessWidget {
  const ProductForBottomSheetWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 296.h,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: 32.h,
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return BottomSheetWidget();
                    });
              },
              child: Container(
                height: 40.h,
                width: 328.w,
                color: Colors.transparent,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: SvgPicture.asset("assets/icons/edittitle.svg"),
                    ),
                    Text(
                      "Edit title",
                      style: AppTextStyle().textColor39393914w500,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProductPrivacy()));
              },
              child: Container(
                height: 40.h,
                width: 328.w,
                color: Colors.transparent,
                child: Row(
                  children: [
                    SizedBox(
                      height: 32,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child:
                          SvgPicture.asset("assets/icons/eyeeditprivacy.svg"),
                    ),
                    Text(
                      "Edit privacy",
                      style: AppTextStyle().textColor39393914w500,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Container(
              height: 40.h,
              width: 328.w,
              color: Colors.transparent,
              child: Row(
                children: [
                  SizedBox(
                    height: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: SvgPicture.asset("assets/icons/shareimage.svg"),
                  ),
                  Text(
                    "Share externally",
                    style: AppTextStyle().textColor39393914w500,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Container(
              height: 40.h,
              width: 328.w,
              color: Colors.transparent,
              child: Row(
                children: [
                  SizedBox(
                    height: 32,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: SvgPicture.asset("assets/icons/folder-download.svg"),
                  ),
                  Text(
                    "Archieve",
                    style: AppTextStyle().textColor39393914w500,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DialogWidget();
                    });
              },
              child: Container(
                height: 40.h,
                width: 328.w,
                color: Colors.transparent,
                child: Row(
                  children: [
                    SizedBox(
                      height: 32,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: SvgPicture.asset("assets/icons/trash1.svg"),
                    ),
                    Text(
                      "Delete",
                      style: AppTextStyle().textcolorCE535314w500,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
