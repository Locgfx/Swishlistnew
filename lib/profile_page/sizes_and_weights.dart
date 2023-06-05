import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/constants/globals/shared_prefs.dart';
import 'package:swishlist/expanded/user_all_details.dart';
import 'package:swishlist/profile_page/privacy.dart';

import '../api/user_apis/sizes_and_weight_api.dart';
import '../buttons/light_yellow.dart';
import '../constants/globals/loading.dart';
import '../models/login_models.dart';
import '../models/sizes_and_weight_model.dart';

class SizeAndWeights extends StatefulWidget {
  final LoginResponse response;
  const SizeAndWeights({Key? key,
    required this.response,
  }) : super(key: key);

  @override
  State<SizeAndWeights> createState() => _SizeAndWeightsState();
}

class _SizeAndWeightsState extends State<SizeAndWeights> {
  @override
  void initState() {
    getSizedWeight();
    super.initState();
  }

  bool isLoading = false;
  SizesAndWeightModel? sizeWeight = SizesAndWeightModel(
    data: Data(
      waist: '',
      shirt: '',
      shoes: '',
      bed: '',
    )
  );
  getSizedWeight() {
    isLoading = true;
    var resp = getSizeAndWeightApi();
    resp.then((value) {
      print(value);
      if(mounted) {
        if(value['status'] == true ) {
          if(value['message'] == 'No Size Weight') {
            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {
              sizeWeight = SizesAndWeightModel.fromJson(value);
              fields();
              isLoading = false;
            });
          }
        } else {
          setState(() {
            isLoading = false;
          });
        }
      }
    });
  }

  void fields() {
    waistController.text = sizeWeight!.data!.waist.toString() ?? '';
    shirtController.text = sizeWeight!.data!.shirt.toString() ?? '';
    shoesController.text = sizeWeight!.data!.shoes.toString() ?? '';
    bedController.text = sizeWeight!.data!.bed.toString() ?? '';
  }

  List <String> siz = [];
  double dou = 00;
  var percent = "";
  get() {
    if(sizeWeight!.data!.waist != null || sizeWeight!.data!.waist != ''){
      siz.add('cars');
    }
    if(sizeWeight!.data!.shirt != null || sizeWeight!.data!.shirt != ''){
      siz.add('bikes');
    }
    if(sizeWeight!.data!.shoes != null || sizeWeight!.data!.shoes != ''){
      siz.add('movies');
    }
    if(sizeWeight!.data!.bed != null || sizeWeight!.data!.bed != ''){
      siz.add('shows');
    }
    percent = ((siz.length / 4)*100).toString().split(".").first ;
    dou = (siz.length / 4);
  }


  int selectedSize = 0;
  // List tags = ['20','22','24','26','28','30','32','34','36','38','40','44' ];
  // List tagsList = [];
  bool selected = false;
  TextEditingController waistController = TextEditingController();
  final shirtController = TextEditingController();
  final shoesController = TextEditingController();
  final bedController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool showInput = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 100),
                    child: Text(
                      "Sizes and weights",
                      style: AppTextStyle().textColor29292916w500,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 150),
                    child: Text(
                      percent.isEmpty ?
                          '0% completed':
                      "$percent% completed",
                      // "60% Completed",
                      style: AppTextStyle().textColor70707012w400,
                    ),
                  )
                ],
              ),
            ],
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              UserAllDetails(response: widget.response,)));
                },
                child: Image.asset('assets/images/Vector190.png'),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body:  isLoading ? Loading():
        Form(
          key: formKey,
          child: Column(
            children: [
              LinearPercentIndicator(
                curve: Curves.linear,
                width: 1.sw,
                padding: EdgeInsets.zero,
                lineHeight: 8.0,
                percent: (siz.length/4) ,
                backgroundColor: Color(0xff576ACC).withOpacity(0.28),
                progressColor: ColorSelect.color576ACC,
              ),
              // Stack(
              //   children: [
              //     Container(
              //       height: 8.h,
              //       width: 360.w,
              //       decoration: BoxDecoration(
              //           color: Color(0xff576ACC).withOpacity(0.28),
              //           borderRadius: BorderRadius.all(Radius.circular(12))),
              //     ),
              //     Row(
              //       children: [
              //         Container(
              //           height: 8.h,
              //           width: 43.w,
              //           decoration: BoxDecoration(
              //               color: ColorSelect.color576ACC,
              //               borderRadius: BorderRadius.only(
              //                   topRight: Radius.circular(12),
              //                   bottomRight: Radius.circular(12))),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "Fashion",
                          style: AppTextStyle().textColor29292914w600,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return WaistDialog(onPop: (val) {
                                  setState(() {
                                    waistController.text = val;
                                  });
                                  if(!siz.contains("waist")) {
                                    setState(() {
                                      siz.add('waist');
                                    });
                                  }
                                },);
                              },
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                "Waist",
                                style: AppTextStyle().textColor70707014w400,
                              ),
                              Spacer(),
                              waistController.text.isNotEmpty ?
                                  Text(
                                    waistController.text,
                                  ): Text(
                                sizeWeight!.data!.waist!.toString() == '' ?
                                '+ Add' :
                                sizeWeight!.data!.waist!.toString(),
                                style: sizeWeight!.data!.waist! == '' ?
                                AppTextStyle().textColorD5574514w500 :
                                AppTextStyle().textColor29292914w400,
                              ),
                              // SizedBox(
                              //   width: 5.w,
                              // ),
                              // Image.asset("assets/images/image46.png"),
                              // SizedBox(
                              //   width: 20.w,
                              // ),
                              // Image.asset("assets/images/Vector175.png"),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ShirtDialog(onPop: (val) {
                                  setState(() {
                                    shirtController.text = val;
                                  });
                                  if(!siz.contains("shirt")) {
                                    setState(() {
                                      siz.add('shirt');
                                    });
                                  }
                                },);
                              },
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                "Shirt",
                                style: AppTextStyle().textColor70707014w400,
                              ),
                              Spacer(),
                              shirtController.text.isNotEmpty ?
                              Text(
                                shirtController.text,
                                style:AppTextStyle().textColor29292914w400,
                              ):
                              Text(
                               sizeWeight!.data!.shirt!.toString() == '' ?
                                '+ Add' :
                               sizeWeight!.data!.shirt!.toString(),
                                style: sizeWeight!.data!.shirt! == '' ?
                                AppTextStyle().textColorD5574514w500 :
                                AppTextStyle().textColor29292914w400,
                              ),
                              // SizedBox(
                              //   width: 5.w,
                              // ),
                              // Image.asset("assets/images/image461.png"),
                              // SizedBox(
                              //   width: 20.w,
                              // ),
                              // Image.asset("assets/images/Vector175.png"),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ShoesDialog(onPop: (val) {
                                  setState(() {
                                    shoesController.text = val;
                                  });
                                  if(!siz.contains("shoes")) {
                                    setState(() {
                                      siz.add('shoes');
                                    });
                                  }
                                },);
                              },
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                "Shoes",
                                style: AppTextStyle().textColor70707014w400,
                              ),
                              Spacer(),
                              SizedBox(
                                width: 5.w,
                              ),
                              shoesController.text.isNotEmpty ?
                              Text(
                                shoesController.text,
                                  style:AppTextStyle().textColor29292914w400,
                              ):
                              Text(
                                sizeWeight!.data!.shoes!.toString() == '' ?
                                '+ Add' :
                                sizeWeight!.data!.shoes!.toString(),
                                style: sizeWeight!.data!.shoes! == '' ?
                                AppTextStyle().textColorD5574514w500 :
                                AppTextStyle().textColor29292914w400,
                              ),
                              // Image.asset("assets/images/information2.png"),
                              // SizedBox(
                              //   width: 20.w,
                              // ),
                              // Image.asset("assets/images/Vector175.png"),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        Text(
                          "Home",
                          style: AppTextStyle().textColor29292914w600,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return BedsDialog(onPop: (val) {
                                  setState(() {
                                    bedController.text = val;
                                  });
                                  if(!siz.contains("bed")) {
                                    setState(() {
                                      siz.add('bed');
                                    });
                                  }
                                },);
                              },
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                "Bed",
                                style: AppTextStyle().textColor70707014w400,
                              ),
                              Spacer(),
                              bedController.text.isNotEmpty ?
                                  Text(bedController.text,
                                      style:AppTextStyle().textColor29292914w400,) :
                              Text(
                                sizeWeight!.data!.bed!.toString() == '' ?
                                '+ Add' :
                                sizeWeight!.data!.bed!.toString(),
                                style:
                                sizeWeight!.data!.bed! == '' ?
                                AppTextStyle().textColorD5574514w500 :
                                AppTextStyle().textColor29292914w400,
                              ),
                              // SizedBox(
                              //   width: 5.w,
                              // ),
                              // Image.asset("assets/images/image46.png"),
                              // SizedBox(
                              //   width: 20.w,
                              // ),
                              // Image.asset("assets/images/Vector175.png"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16,right: 16,bottom: 16),
                child: sizeWeight!.data! .bed.toString() == ''?
                    LightYellowButtonWithText(
                    backgroundColor:
                    (waistController.text.isNotEmpty &&
                    shirtController.text.isNotEmpty &&
                    shoesController.text.isNotEmpty &&
                    bedController.text.isNotEmpty) ?
                    MaterialStateProperty.all(ColorSelect.colorF7E641) :
                    MaterialStateProperty.all(ColorSelect.colorFCF5B6),
                    textStyleColor: (waistController.text.isNotEmpty &&
                        shirtController.text.isNotEmpty &&
                        shoesController.text.isNotEmpty &&
                        bedController.text.isNotEmpty
                    ) ? Colors.black :
                        ColorSelect.colorB5B07A,
                    onTap: () {
                      if(formKey.currentState!.validate()) {
                        postSizeAndWeightApi(
                            waist: waistController.text,
                            shirt: shirtController.text,
                            shoes: shoesController.text,
                            bed: bedController.text,
                            privacy: 'public').
                            then((value) async {
                              if(value['status'] == true ) {
                                SharedPrefs().setSize('100 %');
                                setState(() {
                                  isLoading ? Loading(): getSizedWeight();
                                });
                                // Navigator.pop(context);
                                Fluttertoast.showToast(
                                    msg: value['message']);
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Please fill all details fields");
                              }

                        });
                      }
                    },
                    title: 'Save'
                ):
                    LightYellowButtonWithText(
                        backgroundColor:
                        (waistController.text.isNotEmpty &&
                            shirtController.text.isNotEmpty &&
                            shoesController.text.isNotEmpty &&
                            bedController.text.isNotEmpty) ?
                        MaterialStateProperty.all(ColorSelect.colorF7E641) :
                        MaterialStateProperty.all(ColorSelect.colorFCF5B6),
                        textStyleColor: (waistController.text.isNotEmpty &&
                            shirtController.text.isNotEmpty &&
                            shoesController.text.isNotEmpty &&
                            bedController.text.isNotEmpty
                        ) ? Colors.black :
                        ColorSelect.colorB5B07A,
                        onTap: () {
                          if(formKey.currentState!.validate()) {
                            updateSizeAndWeightApi(
                                waist: waistController.text,
                                shirt: shirtController.text,
                                shoes: shoesController.text,
                                bed: bedController.text,
                                privacy: 'public',
                                id: sizeWeight!.data!.id.toString()).
                            then((value) {
                              if(value['status'] == true) {
                                // SharedPrefs().setSize('100 %');
                                Fluttertoast.showToast(
                                  msg: value['message']);
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'please update all fields');

                              }
                            })
                            ;
                          }
                        },
                        title: 'Update'
                    ),
              ),
            ],
          ),
        ));
  }
}

class WaistDialog extends StatefulWidget {
  final Function(String) onPop;
  const WaistDialog({Key? key, required this.onPop}) : super(key: key);

  @override
  State<WaistDialog> createState() => _WaistDialogState();
}
class _WaistDialogState extends State<WaistDialog> {
  int selectedSize = 0;
  List tags = ['20','22','24','26','28','30','32','34','36','38','40','44' ];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.zero,
      content: Container(
        padding: EdgeInsets.all(20),
        width: 1.sw,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Waist Size',
                style: AppTextStyle().textColor29292914w500,
              ),
              SizedBox(height: 10),
              GridView.builder(
                itemCount: tags.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.5,
                ),
                itemBuilder: (_, i) {
                  return GestureDetector(
                    onTap: () {
                      // tagsList.add(tags[i]);
                      // print(tags[i]);
                      setState(() {
                        selectedSize = i;
                      });
                      widget.onPop(tags[i]);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: selectedSize == i
                              ? ColorSelect.colorF7E641.withOpacity(0.16)
                              : ColorSelect.colorEFEFEF,
                          border: Border.all(
                            color: selectedSize == i
                                ? ColorSelect.colorF7E641
                                : Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Center(
                        child: Text(
                          tags[i],
                          style: AppTextStyle().textColor29292914w400,
                        ),
                      ),
                    ),
                  );
                  // return TContainer(
                  //   onTap: () {
                  //     if (tagsList.length < 10 && !tagsList.contains(tags[i])) {
                  //       tagsList.add(tags[i]);
                  //     } else {
                  //       tagsList.remove(tags[i]);
                  //     }
                  //     setState(() {
                  //       //print(tagsList);
                  //     });
                  //     print(tagsList);
                  //   },
                  //   title: tags[i],
                  //   selected: tagsList.contains(tags[i]
                  //   ),
                  // );
                  /*Container(
                    decoration: BoxDecoration(
                        color: selectedSize == i
                            ? ColorSelect.colorF7E641.withOpacity(0.16)
                            : ColorSelect.colorEFEFEF,
                        border: Border.all(
                          color: selectedSize == i
                              ? ColorSelect.colorF7E641
                              : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        // i == 11 ? '>44' : '${i * 2 + 20}',
                        sizes[i],
                        style: AppTextStyle().textColor29292914w400,
                      ),
                    ),
                  ),*/


                  /*Container(
                    decoration: BoxDecoration(
                        color: selectedSize == i
                            ? ColorSelect.colorF7E641.withOpacity(0.16)
                            : ColorSelect.colorEFEFEF,
                        border: Border.all(
                          color: selectedSize == i
                              ? ColorSelect.colorF7E641
                              : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        // i == 11 ? '>44' : '${i * 2 + 20}',
                        sizes[i],
                        style: AppTextStyle().textColor29292914w400,
                      ),
                    ),
                  ),*/

                },
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Privacy(),
                    ),
                  );
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Visible to",
                        style: AppTextStyle().textColor70707014w400,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Image.asset("assets/images/image46.png"),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        'Everyone',
                        style: AppTextStyle().textColor29292914w400,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Image.asset("assets/images/Vector176.png")
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShirtDialog extends StatefulWidget {
  final Function(String) onPop;
  const ShirtDialog({Key? key, required this.onPop}) : super(key: key);
  @override
  State<ShirtDialog> createState() => _ShirtDialogState();
}
class _ShirtDialogState extends State<ShirtDialog> {
  int selectedSize = 0;
  List tags = ['20','22','24','26','28','30','32','34','36','38','40','44' ];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.zero,
      content: Container(
        padding: EdgeInsets.all(20),
        width: 1.sw,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Waist Size',
                style: AppTextStyle().textColor29292914w500,
              ),
              SizedBox(height: 10),
              GridView.builder(
                itemCount: tags.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.5,
                ),
                itemBuilder: (_, i) {
                  return GestureDetector(
                    onTap: () {
                      // tagsList.add(tags[i]);
                      // print(tags[i]);
                      setState(() {
                        selectedSize = i;
                      });
                      widget.onPop(tags[i]);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: selectedSize == i
                              ? ColorSelect.colorF7E641.withOpacity(0.16)
                              : ColorSelect.colorEFEFEF,
                          border: Border.all(
                            color: selectedSize == i
                                ? ColorSelect.colorF7E641
                                : Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Center(
                        child: Text(
                          tags[i],
                          style: AppTextStyle().textColor29292914w400,
                        ),
                      ),
                    ),
                  );
                  // return TContainer(
                  //   onTap: () {
                  //     if (tagsList.length < 10 && !tagsList.contains(tags[i])) {
                  //       tagsList.add(tags[i]);
                  //     } else {
                  //       tagsList.remove(tags[i]);
                  //     }
                  //     setState(() {
                  //       //print(tagsList);
                  //     });
                  //     print(tagsList);
                  //   },
                  //   title: tags[i],
                  //   selected: tagsList.contains(tags[i]
                  //   ),
                  // );
                  /*Container(
                    decoration: BoxDecoration(
                        color: selectedSize == i
                            ? ColorSelect.colorF7E641.withOpacity(0.16)
                            : ColorSelect.colorEFEFEF,
                        border: Border.all(
                          color: selectedSize == i
                              ? ColorSelect.colorF7E641
                              : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        // i == 11 ? '>44' : '${i * 2 + 20}',
                        sizes[i],
                        style: AppTextStyle().textColor29292914w400,
                      ),
                    ),
                  ),*/


                  /*Container(
                    decoration: BoxDecoration(
                        color: selectedSize == i
                            ? ColorSelect.colorF7E641.withOpacity(0.16)
                            : ColorSelect.colorEFEFEF,
                        border: Border.all(
                          color: selectedSize == i
                              ? ColorSelect.colorF7E641
                              : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        // i == 11 ? '>44' : '${i * 2 + 20}',
                        sizes[i],
                        style: AppTextStyle().textColor29292914w400,
                      ),
                    ),
                  ),*/

                },
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Privacy(),
                    ),
                  );
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Visible to",
                        style: AppTextStyle().textColor70707014w400,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Image.asset("assets/images/image46.png"),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        'Everyone',
                        style: AppTextStyle().textColor29292914w400,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Image.asset("assets/images/Vector176.png")
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShoesDialog extends StatefulWidget {
  final Function(String) onPop;
  const ShoesDialog({Key? key, required this.onPop}) : super(key: key);
  @override
  State<ShoesDialog> createState() => _ShoesDialogState();
}
class _ShoesDialogState extends State<ShoesDialog> {
  int selectedSize = 0;
  List tags = ['6','7','8','9','10','11',];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.zero,
      content: Container(
        padding: EdgeInsets.all(20),
        width: 1.sw,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Waist Size',
                style: AppTextStyle().textColor29292914w500,
              ),
              SizedBox(height: 10),
              GridView.builder(
                itemCount: tags.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.5,
                ),
                itemBuilder: (_, i) {
                  return GestureDetector(
                    onTap: () {
                      // tagsList.add(tags[i]);
                      // print(tags[i]);
                      setState(() {
                        selectedSize = i;
                      });
                      widget.onPop(tags[i]);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: selectedSize == i
                              ? ColorSelect.colorF7E641.withOpacity(0.16)
                              : ColorSelect.colorEFEFEF,
                          border: Border.all(
                            color: selectedSize == i
                                ? ColorSelect.colorF7E641
                                : Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Center(
                        child: Text(
                          tags[i],
                          style: AppTextStyle().textColor29292914w400,
                        ),
                      ),
                    ),
                  );
                  // return TContainer(
                  //   onTap: () {
                  //     if (tagsList.length < 10 && !tagsList.contains(tags[i])) {
                  //       tagsList.add(tags[i]);
                  //     } else {
                  //       tagsList.remove(tags[i]);
                  //     }
                  //     setState(() {
                  //       //print(tagsList);
                  //     });
                  //     print(tagsList);
                  //   },
                  //   title: tags[i],
                  //   selected: tagsList.contains(tags[i]
                  //   ),
                  // );
                  /*Container(
                    decoration: BoxDecoration(
                        color: selectedSize == i
                            ? ColorSelect.colorF7E641.withOpacity(0.16)
                            : ColorSelect.colorEFEFEF,
                        border: Border.all(
                          color: selectedSize == i
                              ? ColorSelect.colorF7E641
                              : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        // i == 11 ? '>44' : '${i * 2 + 20}',
                        sizes[i],
                        style: AppTextStyle().textColor29292914w400,
                      ),
                    ),
                  ),*/


                  /*Container(
                    decoration: BoxDecoration(
                        color: selectedSize == i
                            ? ColorSelect.colorF7E641.withOpacity(0.16)
                            : ColorSelect.colorEFEFEF,
                        border: Border.all(
                          color: selectedSize == i
                              ? ColorSelect.colorF7E641
                              : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        // i == 11 ? '>44' : '${i * 2 + 20}',
                        sizes[i],
                        style: AppTextStyle().textColor29292914w400,
                      ),
                    ),
                  ),*/

                },
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Privacy(),
                    ),
                  );
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Visible to",
                        style: AppTextStyle().textColor70707014w400,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Image.asset("assets/images/image46.png"),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        'Everyone',
                        style: AppTextStyle().textColor29292914w400,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Image.asset("assets/images/Vector176.png")
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BedsDialog extends StatefulWidget {
  final Function(String) onPop;
  const BedsDialog({Key? key, required this.onPop}) : super(key: key);
  @override
  State<BedsDialog> createState() => _BedsDialogState();
}
class _BedsDialogState extends State<BedsDialog> {
  int selectedSize = 0;
  List tags = ['Double','Single','King','Queen '];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.zero,
      content: Container(
        padding: EdgeInsets.all(20),
        width: 1.sw,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Waist Size',
                style: AppTextStyle().textColor29292914w500,
              ),
              SizedBox(height: 10),
              GridView.builder(
                itemCount: tags.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.5,
                ),
                itemBuilder: (_, i) {
                  return GestureDetector(
                    onTap: () {
                      // tagsList.add(tags[i]);
                      // print(tags[i]);
                      setState(() {
                        selectedSize = i;
                      });
                      widget.onPop(tags[i]);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: selectedSize == i
                              ? ColorSelect.colorF7E641.withOpacity(0.16)
                              : ColorSelect.colorEFEFEF,
                          border: Border.all(
                            color: selectedSize == i
                                ? ColorSelect.colorF7E641
                                : Colors.transparent,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Center(
                        child: Text(
                          tags[i],
                          style: AppTextStyle().textColor29292914w400,
                        ),
                      ),
                    ),
                  );
                  // return TContainer(
                  //   onTap: () {
                  //     if (tagsList.length < 10 && !tagsList.contains(tags[i])) {
                  //       tagsList.add(tags[i]);
                  //     } else {
                  //       tagsList.remove(tags[i]);
                  //     }
                  //     setState(() {
                  //       //print(tagsList);
                  //     });
                  //     print(tagsList);
                  //   },
                  //   title: tags[i],
                  //   selected: tagsList.contains(tags[i]
                  //   ),
                  // );
                  /*Container(
                    decoration: BoxDecoration(
                        color: selectedSize == i
                            ? ColorSelect.colorF7E641.withOpacity(0.16)
                            : ColorSelect.colorEFEFEF,
                        border: Border.all(
                          color: selectedSize == i
                              ? ColorSelect.colorF7E641
                              : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        // i == 11 ? '>44' : '${i * 2 + 20}',
                        sizes[i],
                        style: AppTextStyle().textColor29292914w400,
                      ),
                    ),
                  ),*/


                  /*Container(
                    decoration: BoxDecoration(
                        color: selectedSize == i
                            ? ColorSelect.colorF7E641.withOpacity(0.16)
                            : ColorSelect.colorEFEFEF,
                        border: Border.all(
                          color: selectedSize == i
                              ? ColorSelect.colorF7E641
                              : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Text(
                        // i == 11 ? '>44' : '${i * 2 + 20}',
                        sizes[i],
                        style: AppTextStyle().textColor29292914w400,
                      ),
                    ),
                  ),*/

                },
              ),
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Privacy(),
                    ),
                  );
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Visible to",
                        style: AppTextStyle().textColor70707014w400,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Image.asset("assets/images/image46.png"),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        'Everyone',
                        style: AppTextStyle().textColor29292914w400,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Image.asset("assets/images/Vector176.png")
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// class TContainer extends StatefulWidget {
//   final Function onTap;
//   final bool selected;
//   final String title;
//   const TContainer({
//     Key? key,
//     required this.selected,
//     required this.title,
//     required this.onTap,
//   }) : super(key: key);
//
//   @override
//   State<TContainer> createState() => _TContainerState();
// }
// class _TContainerState extends State<TContainer> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         widget.onTap();
//       },
//       child: Container(
//         decoration: BoxDecoration(
//             color: widget.selected ?
//                  ColorSelect.colorF7E641.withOpacity(0.16)
//                 : ColorSelect.colorEFEFEF,
//             border: Border.all(
//               color: widget.selected ?
//                    ColorSelect.colorF7E641
//                   : Colors.transparent,
//               width: 2,
//             ),
//             borderRadius: BorderRadius.all(Radius.circular(8))),
//
//         child: Center(
//           child: Text(widget.title,
//               style: AppTextStyle().textColor29292913w400),
//         ),
//       ),
//     );
//   }
// }
// class TabContainer extends StatelessWidget {
//   final Function onTap;
//   final bool selectedSize;
//   final String title;
//   const TabContainer({Key? key,
//     required this.onTap,
//     required this.selectedSize,
//     required this.title
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         onTap();
//       },
//       child: Container(
//         decoration: BoxDecoration(
//             color: selectedSize
//                 ? ColorSelect.colorF7E641.withOpacity(0.16)
//                 : ColorSelect.colorEFEFEF,
//             border: Border.all(
//               color: selectedSize
//                   ? ColorSelect.colorF7E641
//                   : Colors.transparent,
//               width: 2,
//             ),
//             borderRadius: BorderRadius.all(Radius.circular(8))),
//         child: Center(
//           child: Text(selectedSize ?title:title,
//             // i == 11 ? '>44' : '${i * 2 + 20}',
//             // sizes[i],
//             style: AppTextStyle().textColor29292914w400,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class ShirtSize extends StatefulWidget {
//   const ShirtSize({Key? key}) : super(key: key);
//
//   @override
//   State<ShirtSize> createState() => _ShirtSizeState();
// }
// class _ShirtSizeState extends State<ShirtSize> {
//   int selectedSize = 6;
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       insetPadding: EdgeInsets.all(16),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       elevation: 0,
//       backgroundColor: Colors.white,
//       contentPadding: EdgeInsets.zero,
//       content: Container(
//         padding: EdgeInsets.all(20),
//         width: 1.sw,
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Shirt',
//                 style: AppTextStyle().textColor29292914w500,
//               ),
//               SizedBox(height: 10),
//               GridView.builder(
//                 itemCount: 12,
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 5,
//                   mainAxisSpacing: 10,
//                   crossAxisSpacing: 10,
//                   childAspectRatio: 1.5,
//                 ),
//                 itemBuilder: (_, i) {
//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         selectedSize = i;
//                       });
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: selectedSize == i
//                               ? ColorSelect.colorF7E641.withOpacity(0.16)
//                               : ColorSelect.colorEFEFEF,
//                           border: Border.all(
//                             color: selectedSize == i
//                                 ? ColorSelect.colorF7E641
//                                 : Colors.transparent,
//                             width: 2,
//                           ),
//                           borderRadius: BorderRadius.all(Radius.circular(8))),
//                       child: Center(
//                         child: Text(
//                           i == 11 ? '>44' : '${i * 2 + 20}',
//                           style: AppTextStyle().textColor29292914w400,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               SizedBox(height: 20),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => Privacy(),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   color: Colors.transparent,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text(
//                         "Visible to",
//                         style: AppTextStyle().textColor70707014w400,
//                       ),
//                       SizedBox(
//                         width: 5.w,
//                       ),
//                       Image.asset("assets/images/image46.png"),
//                       SizedBox(
//                         width: 5.w,
//                       ),
//                       Text(
//                         'Everyone',
//                         style: AppTextStyle().textColor29292914w400,
//                       ),
//                       SizedBox(
//                         width: 10.w,
//                       ),
//                       Image.asset("assets/images/Vector176.png")
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class ShoeSize extends StatefulWidget {
//   // final Function(String) onPop;
//   const ShoeSize({Key? key,/* required this.onPop*/}) : super(key: key);
//
//   @override
//   State<ShoeSize> createState() => _ShoeSizeState();
// }
// class _ShoeSizeState extends State<ShoeSize> {
//   int selectedSize = 0;
//   List<String> sizes = ['6','7','8','9','10','11',];
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       insetPadding: EdgeInsets.all(16),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       elevation: 0,
//       backgroundColor: Colors.white,
//       contentPadding: EdgeInsets.zero,
//       content: Container(
//         padding: EdgeInsets.all(20),
//         width: 1.sw,
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Shoe Size',
//                 style: AppTextStyle().textColor29292914w500,
//               ),
//               SizedBox(height: 10),
//               GridView.builder(
//                 itemCount: sizes.length,
//                 // itemCount: 12,
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 5,
//                   mainAxisSpacing: 10,
//                   crossAxisSpacing: 10,
//                   childAspectRatio: 1.5,
//                 ),
//                 itemBuilder: (_, i) {
//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         selectedSize = i;
//                       });
//                       print(sizes);
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: selectedSize == i
//                               ? ColorSelect.colorF7E641.withOpacity(0.16)
//                               : ColorSelect.colorEFEFEF,
//                           border: Border.all(
//                             color: selectedSize == i
//                                 ? ColorSelect.colorF7E641
//                                 : Colors.transparent,
//                             width: 2,
//                           ),
//                           borderRadius: BorderRadius.all(Radius.circular(8))),
//                       child: Center(
//                         child: Text(
//                           // i == 11 ? '>44' : '${i * 2 + 20}',
//                           sizes[i],
//                           style: AppTextStyle().textColor29292914w400,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               SizedBox(height: 20.h),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => Privacy(),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   color: Colors.transparent,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text(
//                         "Visible to",
//                         style: AppTextStyle().textColor70707014w400,
//                       ),
//                       SizedBox(
//                         width: 5.w,
//                       ),
//                       Image.asset("assets/images/image46.png"),
//                       SizedBox(
//                         width: 5.w,
//                       ),
//                       Text(
//                         'Everyone',
//                         style: AppTextStyle().textColor29292914w400,
//                       ),
//                       SizedBox(
//                         width: 10.w,
//                       ),
//                       Image.asset("assets/images/Vector176.png")
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
// class BedSize extends StatefulWidget {
//   const BedSize({Key? key}) : super(key: key);
//
//   @override
//   State<BedSize> createState() => _BedSizeState();
// }
// class _BedSizeState extends State<BedSize> {
//   int selectedSize = 6;
//   List<String> sizes = ['20','22','24','26','28','30','32','34','36','38','40','44' ];
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       insetPadding: EdgeInsets.all(16),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       elevation: 0,
//       backgroundColor: Colors.white,
//       contentPadding: EdgeInsets.zero,
//       content: Container(
//         padding: EdgeInsets.all(20),
//         width: 1.sw,
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Shoe Size',
//                 style: AppTextStyle().textColor29292914w500,
//               ),
//               SizedBox(height: 10),
//               GridView.builder(
//                 itemCount: sizes.length,
//                 // itemCount: 12,
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 5,
//                   mainAxisSpacing: 10,
//                   crossAxisSpacing: 10,
//                   childAspectRatio: 1.5,
//                 ),
//                 itemBuilder: (_, i) {
//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         selectedSize = i;
//                       });
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: selectedSize == i
//                               ? ColorSelect.colorF7E641.withOpacity(0.16)
//                               : ColorSelect.colorEFEFEF,
//                           border: Border.all(
//                             color: selectedSize == i
//                                 ? ColorSelect.colorF7E641
//                                 : Colors.transparent,
//                             width: 2,
//                           ),
//                           borderRadius: BorderRadius.all(Radius.circular(8))),
//                       child: Center(
//                         child: Text(
//                           // i == 11 ? '>44' : '${i * 2 + 20}',
//                           sizes[i],
//                           style: AppTextStyle().textColor29292914w400,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               SizedBox(height: 20.h),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => Privacy(),
//                     ),
//                   );
//                 },
//                 child: Container(
//                   color: Colors.transparent,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Text(
//                         "Visible to",
//                         style: AppTextStyle().textColor70707014w400,
//                       ),
//                       SizedBox(
//                         width: 5.w,
//                       ),
//                       Image.asset("assets/images/image46.png"),
//                       SizedBox(
//                         width: 5.w,
//                       ),
//                       Text(
//                         'Everyone',
//                         style: AppTextStyle().textColor29292914w400,
//                       ),
//                       SizedBox(
//                         width: 10.w,
//                       ),
//                       Image.asset("assets/images/Vector176.png")
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//

