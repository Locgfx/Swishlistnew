import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../buttons/yellow_button.dart';
import '../../constants/color.dart';


class AddFriendList extends StatefulWidget {
  // final FriendModel friendModel;
  const AddFriendList({Key? key,
 /*   required this.friendModel*/}) : super(key: key);

  @override
  State<AddFriendList> createState() => _AddFriendListState();
}

class _AddFriendListState extends State<AddFriendList> {
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
              child: Image.asset('assets/images/Vector190.png')),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
              Container(
                width: 328.w,
                height: 52.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorSelect.colorEDEDF1),
                child: Row(
                  children: [
                    SizedBox(width: 16,),
                    Image.asset("assets/images/Vectorse.png"),
                    SizedBox(width: 16,),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search product, username and more",
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              MediaQuery.removePadding(
                context: context,
                removeTop: true,
                removeBottom: true,
                child: ListView.separated(
                  itemCount: 16,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey,
                              backgroundImage:
                                  AssetImage('assets/images/Rectangle3194.png'),
                            ),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Andy Bernard",
                                  style: AppTextStyle().textColor29292914w500,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "AndyAngie3260",
                                  style: AppTextStyle().textColor70707014w400,
                                )
                              ],
                            ),
                            Spacer(),
                            SizedBox(
                              height: 36,
                              width: 64,
                              child: YellowButtonWithText(
                                backgroundColor: MaterialStateProperty.all(
                                    ColorSelect.colorF7E641),
                                textStyleColor: ColorSelect.color292929,
                                title: 'Add',
                                onTap: () {

                                },
                              ),
                            )
                          ],
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
