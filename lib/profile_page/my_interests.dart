import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/constants/globals/loading.dart';
import '../api/user_apis/interest_api.dart';
import '../buttons/yellow_button.dart';
import '../expanded/user_all_details.dart';
import '../models/interest_model.dart';
import '../models/login_models.dart';

class MyInterests extends StatefulWidget {
  final LoginResponse response;
  final String id;
  // final InterestModel interest;
  // final GetInterestModel interest;

  MyInterests({Key? key,
     // required this.interest,
      required this.response, required this.id,
    // required this.interest,
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
  InterestModel? _interest = InterestModel(
    data: Data(interest: '')

  );
  // InterestModel? _interest;
  getInterest() {
    isLoading = true;
    var resp = getInterestApi();
    resp.then((value) {
      if (value ['status'] == true) {
        setState(() {
          _interest = InterestModel.fromJson(value);
          elements =  _interest?.data!.interest!.split(",");
          isLoading= false;

        });
      } else {
        isLoading = false;
      }
    });
  }
  // getInterest() {
  //   isLoading = true;
  //   var resp = getInterestApi();
  //   resp.then((value) {
  //     if (value ['status'] == true) {
  //       setState(() {
  //         interest = InterestModel.fromJson(value);
  //         isLoading = false;
  //       });
  //     } else {
  //       setState(() {
  //         isLoading = false;
  //       });
  //     }
  //   });
  // }




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
        height: 52.h,
        color: Colors.transparent,
        child:  SingleChildScrollView(
          child:(_interest!.data!.interest == '') ?
          YellowButtonWithText(
            backgroundColor: MaterialStateProperty.all(ColorSelect.colorF7E641),
            textStyleColor: ColorSelect.color292929,
            onTap: () {
                if(tagsList.isNotEmpty) {
                  postInterest(
                      interest: tagsList.join(","),
                   ).then((value) async {
                    if(value['status'] == true) {
                      Fluttertoast.showToast(
                          msg: value['message']);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) =>
                              UserAllDetails(response: widget.response),
                          ),
                      );
                    } else {
                      Fluttertoast.showToast(
                          msg: value['message']);
                    }
                  });
                }
            },
            title: 'Save ${tagsList.isNotEmpty && tagsList.length < 11 ? '(${tagsList.length}/10)' : ''}',
          ) : YellowButtonWithText(
              backgroundColor: MaterialStateProperty.all(ColorSelect.colorF7E641),
              textStyleColor: ColorSelect.color292929,
              onTap: () {
                if(tagsList.isNotEmpty) {
                  updateInterest(
                      userid: _interest!.data!.userId.toString(),
                      interest: tagsList.join(","),
                      id: _interest!.data!.id.toString()
                  ).then((value) async {
                        if(value['status'] == true) {
                          // print(_interest!.data!.userId.toString());
                          // print(tagsList.toString());
                          // print(_interest!.data!.id.toString());
                          Fluttertoast.showToast(
                              msg: value['message']);
                          Navigator.push(context,
                            MaterialPageRoute(builder: (_) =>
                                UserAllDetails(response: widget.response),
                            ),
                          );
                        } else {
                          Fluttertoast.showToast(
                              msg: value['message']);

                        }

                  });
                }

              },
              title: 'update ${tagsList.isNotEmpty && tagsList.length < 11 ? '(${tagsList.length}/10)' : ''}',)
        ),
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
                    selected: tagsList.contains(tags[i]
                    ),
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

            /*Tags(
                key: _globalKey,
                itemCount: tags.length,
                columns: 6,
                */ /*textField: TagsTextField(
                    // textStyle: AppTextStyle().textColor29292913w400,
                    onSubmitted: (string) {
                  setState(() {
                    tags.add(Item(title: string));
                  });
                }),*/ /*
                itemBuilder: (index) {
                  //final Item currentItem = tags[index];
                  return ItemTags(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    elevation: 0,
                    border: Border.all(color: ColorSelect.colorCBE0FA),
                    color: ColorSelect.colorCBE0FA,
                    activeColor: Colors.white,
                    textColor: ColorSelect.color292929,
                    textActiveColor: ColorSelect.color292929,
                    index: index,
                    title: tags[index],
                    textStyle: AppTextStyle().textColor29292913w400,
                    // customData: currentItem.customData,
                    combine: ItemTagsCombine.withTextBefore,
                    onPressed: (i) {
                      tagsList.add(tags[index]);
                    },
                    // onLongPressed: (i) => print(i),
                    */ /* removeButton: ItemTagsRemoveButton(onRemoved: () {
                      setState(() {
                        tags.removeAt(index);
                      });
                      return true;
                    }),*/ /*
                  );
                },
              )*/
/* SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 36,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(48),
                          ),
                          color: ColorSelect.colorCBE0FA),
                      child: Center(
                        child: Text("Cycling",
                            style: AppTextStyle().textColor29292913w400),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                      height: 36,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(48),
                          ),
                          color: ColorSelect.colorCBE0FA),
                      child: Center(
                        child: Text("Reading",
                            style: AppTextStyle().textColor29292913w400),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                      height: 36,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(48),
                          ),
                          color: ColorSelect.colorCBE0FA),
                      child: Center(
                        child: Text("Fishing",
                            style: AppTextStyle().textColor29292913w400),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                      height: 36,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(48),
                          ),
                          color: ColorSelect.colorCBE0FA),
                      child: Center(
                        child: Text("Fishing",
                            style: AppTextStyle().textColor29292913w400),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 36,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(48),
                          ),
                          color: ColorSelect.colorCBE0FA),
                      child: Center(
                        child: Text("Singing",
                            style: AppTextStyle().textColor29292913w400),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                      height: 36,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(48),
                          ),
                          color: Colors.white,
                          border: Border.all(
                              color: ColorSelect.colorCBE0FA, width: 1)),
                      child: Center(
                        child: Text("+ Reading"),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                      height: 36,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(48),
                          ),
                          color: ColorSelect.colorCBE0FA),
                      child: Center(
                        child: Text("Trekking"),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                      height: 36,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(48),
                          ),
                          color: ColorSelect.colorCBE0FA),
                      child: Center(
                        child: Text("Coding"),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 36,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(48),
                          ),
                          color: ColorSelect.colorCBE0FA),
                      child: Center(
                        child: Text("Swimming",
                            style: AppTextStyle().textColor29292913w400),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                      height: 36,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(48),
                          ),
                          color: Colors.white,
                          border: Border.all(
                              color: ColorSelect.colorCBE0FA, width: 1)),
                      child: Center(
                        child: Text("+ Reading"),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                      height: 36,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(48),
                          ),
                          color: Colors.white,
                          border: Border.all(
                              color: ColorSelect.colorCBE0FA, width: 1)),
                      child: Center(
                        child: Text("+ Swimming"),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 36,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(48),
                          ),
                          color: ColorSelect.colorCBE0FA),
                      child: Center(
                        child: Text("Swimming",
                            style: AppTextStyle().textColor29292913w400),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                      height: 36,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(48),
                          ),
                          color: Colors.white,
                          border: Border.all(
                              color: ColorSelect.colorCBE0FA, width: 1)),
                      child: Center(
                        child: Text("+ Fishing"),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                      height: 36,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(48),
                          ),
                          color: Colors.white,
                          border: Border.all(
                              color: ColorSelect.colorCBE0FA, width: 1)),
                      child: Center(
                        child: Text("+ Reading"),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 36,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(48),
                          ),
                          color: ColorSelect.colorCBE0FA),
                      child: Center(
                        child: Text("Swimming",
                            style: AppTextStyle().textColor29292913w400),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                      height: 36,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(48),
                          ),
                          color: Colors.white,
                          border: Border.all(
                              color: ColorSelect.colorCBE0FA, width: 1)),
                      child: Center(
                        child: Text("+ Reading"),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                      height: 36,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(48),
                          ),
                          color: ColorSelect.colorCBE0FA),
                      child: Center(
                        child: Text("Watches",
                            style: AppTextStyle().textColor29292913w400),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                      height: 36,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(48),
                          ),
                          color: ColorSelect.colorCBE0FA),
                      child: Center(
                        child: Text("Fishing",
                            style: AppTextStyle().textColor29292913w400),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 36,
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(48),
                          ),
                          color: ColorSelect.colorCBE0FA),
                      child: Center(
                        child: Text("Biking",
                            style: AppTextStyle().textColor29292913w400),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                      height: 36,
                      width: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(48),
                          ),
                          color: ColorSelect.colorCBE0FA),
                      child: Center(
                        child: Text("Reading",
                            style: AppTextStyle().textColor29292913w400),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                      height: 36,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(48),
                          ),
                          color: Colors.white,
                          border: Border.all(
                              color: ColorSelect.colorCBE0FA, width: 1)),
                      child: Center(
                        child: Text("+ Swimming"),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 36,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(48),
                          ),
                          color: Colors.white,
                          border: Border.all(
                              color: ColorSelect.colorCBE0FA, width: 1)),
                      child: Center(
                        child: Text("+ Cycling",
                            style: AppTextStyle().textColor29292913w400),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                      height: 36,
                      width: 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(48),
                          ),
                          color: Colors.white,
                          border: Border.all(
                              color: ColorSelect.colorCBE0FA, width: 1)),
                      child: Center(
                        child: Text("+ Singing",
                            style: AppTextStyle().textColor29292913w400),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                      height: 36,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(48),
                        ),
                        color: ColorSelect.colorCBE0FA,
                      ),
                      child: Center(
                        child: Text("Swimming"),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 36,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(48),
                          ),
                          color: Colors.white,
                          border: Border.all(
                              color: ColorSelect.colorCBE0FA, width: 1)),
                      child: Center(
                        child: Text("+ Singing",
                            style: AppTextStyle().textColor29292913w400),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                      height: 36,
                      width: 90,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(48),
                          ),
                          color: ColorSelect.colorCBE0FA),
                      child: Center(
                        child: Text("Reading",
                            style: AppTextStyle().textColor29292913w400),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                      child: Container(
                    height: 36,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(48),
                        ),
                        color: Colors.white,
                        border: Border.all(
                            color: ColorSelect.colorCBE0FA, width: 1)),
                    child: Center(
                      child: Text("+ Fishing"),
                    ),
                  )),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        height: 36,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(48),
                            ),
                            color: Colors.white,
                            border: Border.all(
                                color: ColorSelect.colorCBE0FA, width: 1)),
                        child: Center(
                          child: Text("+ Biking",
                              style: AppTextStyle().textColor29292913w400),
                        )),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Container(
                        height: 36,
                        width: 110,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(48),
                            ),
                            color: Colors.white,
                            border: Border.all(
                                color: ColorSelect.colorCBE0FA, width: 1)),
                        child: Center(
                          child: Text("+ Swimming",
                              style: AppTextStyle().textColor29292913w400),
                        )),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                      child: Container(
                    height: 36,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(48),
                        ),
                        color: Colors.white,
                        border: Border.all(
                            color: ColorSelect.colorCBE0FA, width: 1)),
                    child: Center(
                      child: Text("+ Watches"),
                    ),
                  )),
                ],
              ),*/
