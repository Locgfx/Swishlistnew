import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swishlist/constants/color.dart';

import '../api/user_apis/interest_api.dart';
import '../buttons/yellow_button.dart';
import '../expanded/user_all_details.dart';
import '../models/interest_model.dart';
import '../models/login_models.dart';

class MyInterests extends StatefulWidget {
  final LoginResponse response;
  final String id;
  MyInterests({
    Key? key,
    required this.response,
    required this.id,
  }) : super(key: key);

  @override
  State<MyInterests> createState() => _MyInterestsState();
}

class _MyInterestsState extends State<MyInterests> {
  @override
  void initState() {
    getInterest();
    super.initState();
  }

  List tags = [
    'Cycling',
    'Fashion',
    'Reading',
    'Singing',
    'Dancing',
    'Trekking',
    'Make-up',
    'Writing',
    'Photography',
    'Swimming',
    'Coding',
    'Designing',
    'Eating',
    'Movies',
    'Music',
    'Gardening',
    'Cooking',
    'Gadgets',
    'Video games',
    'Travelling',
    'Sports',
    'Antiques',
    'Board Games',
    'Hiking',
    'Pets',
    'Yoga',
    'Shows',
    'Beauty',
    'Gym',
    'Craft',
    'Fishing',
    'Art'
  ];
  List tagsList = [];
  // LoginResponse? response;
  // InterestModel? interest;

  List<String>? elements = [''];
  bool isLoading = false;
  InterestModel? _interest = InterestModel(data: Data(interest: ''));
  getInterest() {
    isLoading = true;
    var resp = getInterestApi();
    resp.then((value) {
      if (value['status'] == true) {
        setState(() {
          _interest = InterestModel.fromJson(value);
          elements = _interest?.data!.interest!.split(",");
          isLoading = false;
        });
      } else {
        isLoading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Text(
              "My Interests",
              style: AppTextStyle().textColor29292916w500,
            ),
            /*Spacer(),
            Image.asset("assets/images/Frame1000003051.png")*/
          ],
        ),
        leadingWidth: 40,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.only(left: 20),
            child: SvgPicture.asset(
              "assets/icons/arrowback.svg",
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      //extendBody: true,
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        width: 1.sw,
        // height: 60.h,
        color: Colors.transparent,
        child: SingleChildScrollView(
            child: (_interest!.data!.interest == '')
                ? YellowButtonWithText(
                    size: 15,
                    backgroundColor:
                        MaterialStateProperty.all(ColorSelect.colorF7E641),
                    textStyleColor: ColorSelect.color292929,
                    onTap: () {
                      if (tagsList.isNotEmpty) {
                        postInterest(
                          interest: tagsList.join(","),
                        ).then((value) async {
                          if (value['status'] == true) {
                            Fluttertoast.showToast(msg: value['message']);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    UserAllDetails(response: widget.response),
                              ),
                            );
                          } else {
                            Fluttertoast.showToast(msg: value['message']);
                          }
                        });
                      }
                    },
                    title:
                        'Save ${tagsList.isNotEmpty && tagsList.length < 11 ? '(${tagsList.length}/10)' : ''}',
                  )
                : YellowButtonWithText(
                    size: 15,
                    backgroundColor:
                        MaterialStateProperty.all(ColorSelect.colorF7E641),
                    textStyleColor: ColorSelect.color292929,
                    onTap: () {
                      if (tagsList.isNotEmpty) {
                        updateInterest(
                                userid: _interest!.data!.userId.toString(),
                                interest: tagsList.join(","),
                                id: _interest!.data!.id.toString())
                            .then((value) async {
                          if (value['status'] == true) {
                            // print(_interest!.data!.userId.toString());
                            // print(tagsList.toString());
                            // print(_interest!.data!.id.toString());
                            Fluttertoast.showToast(msg: value['message']);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    UserAllDetails(response: widget.response),
                              ),
                            );
                          } else {
                            Fluttertoast.showToast(msg: value['message']);
                          }
                        });
                      }
                    },
                    title:
                        'update ${tagsList.isNotEmpty && tagsList.length < 11 ? '(${tagsList.length}/10)' : ''}',
                  )),
      ),
      body: Container(
        constraints: BoxConstraints(maxHeight: 1.sh),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Select your Interests",
              style: AppTextStyle().textColor29292924w700,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "Select upto 10 interests",
              style: AppTextStyle().textColor8F8F8F12w400,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: tags.length,
                //physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 2.8,
                ),
                itemBuilder: (_, i) {
                  return TagContainer(
                    onTap: () {
                      if (tagsList.length < 10 && !tagsList.contains(tags[i])) {
                        tagsList.add(tags[i]);
                      } else {
                        tagsList.remove(tags[i]);
                      }
                      setState(() {
                        //print(tagsList);
                      });
                      print(tagsList);
                    },
                    title: tags[i],
                    selected: tagsList.contains(tags[i]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TagContainer extends StatelessWidget {
  final Function onTap;
  final bool selected;
  final String title;
  const TagContainer({
    Key? key,
    required this.selected,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: selected ? ColorSelect.colorCBE0FA : Colors.white,
          borderRadius: BorderRadius.circular(48),
          border: Border.all(color: ColorSelect.colorCBE0FA, width: 1),
        ),
        child: Center(
          child: Text(selected ? title : '+ ' + title,
              style: AppTextStyle().textColor29292913w400),
        ),
      ),
    );
  }
}
