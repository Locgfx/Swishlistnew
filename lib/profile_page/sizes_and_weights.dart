import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/constants/globals/shared_prefs.dart';

import '../api/user_apis/sizes_and_weight_api.dart';
import '../buttons/light_yellow.dart';
import '../constants/globals/loading.dart';
import '../models/login_models.dart';
import '../models/sizes_and_weight_model.dart';

class SizeAndWeights extends StatefulWidget {
  final LoginResponse response;
  const SizeAndWeights({
    Key? key,
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
      data: SizeData(
    waist: '',
    shirt: '',
    shoes: '',
    bed: '',
  ));
  getSizedWeight() {
    isLoading = true;
    var resp = getSizeAndWeightApi();
    resp.then((value) {
      print(value);
      if (mounted) {
        if (value['status'] == true) {
          if (value['message'] == 'No Size Weight') {
            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {
              sizeWeight = SizesAndWeightModel.fromJson(value);
              get();
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
    waistController.text = sizeWeight!.data!.waist ?? '';
    shirtController.text = sizeWeight!.data!.shirt ?? '';
    shoesController.text = sizeWeight!.data!.shoes ?? '';
    bedController.text = sizeWeight!.data!.bed ?? '';
  }

  List<String> siz = [];
  double dou = 00;
  var percent = "";

  get() {
    if (sizeWeight!.data!.waist != null || sizeWeight!.data!.waist != '') {
      siz.add('waist');
    }
    if (sizeWeight!.data!.shirt != null || sizeWeight!.data!.shirt != '') {
      siz.add('shirt');
    }
    if (sizeWeight!.data!.shoes != null || sizeWeight!.data!.shoes != '') {
      siz.add('shoes');
    }
    if (sizeWeight!.data!.bed != null || sizeWeight!.data!.bed != '') {
      siz.add('bed');
    }
    percent = ((siz.length / 4) * 100).toString().split(".").first;
    dou = (siz.length / 4);
  }

  int selectedSize = 0;
  bool selected = false;
  TextEditingController waistController = TextEditingController();
  final shirtController = TextEditingController();
  final shoesController = TextEditingController();
  final bedController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool showInput = false;

  String? completePercent;
  double parsedPercent = 0.0;
  double normalizedPercent = 0.0;

  @override
  Widget build(BuildContext context) {
    completePercent = sizeWeight?.data?.completePercent;
    parsedPercent = double.tryParse(completePercent ?? '0') ?? 0.0;
    normalizedPercent = parsedPercent / 100.0;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    child: isLoading
                        ? SizedBox()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                sizeWeight!.data!.completePercent.toString() ==
                                            "" ||
                                        sizeWeight!.data!.completePercent ==
                                            null
                                    ? "0"
                                    : sizeWeight!.data!.completePercent
                                        .toString()
                                        .split(".")
                                        .first,
                                // sizeWeight!.data!.completePercent
                                //     .toString()
                                //     .split(".")
                                //     .first,
                                style: AppTextStyle().textColor70707012w400,
                              ),
                              Text(
                                "%  Percent",
                                style: AppTextStyle().textColor70707012w400,
                              )
                            ],
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
                Navigator.pop(context);
                (sizeWeight!.data!.waist.toString() == '')
                    ? postSizeAndWeightApi(
                            waist: waistController.text,
                            shirt: shirtController.text,
                            shoes: shoesController.text,
                            bed: bedController.text,
                            privacy: 'public')
                        .then((value) async {
                        if (value['status'] == true) {
                          SharedPrefs().setSize('100 %');
                          // setState(() {
                          //   isLoading ? Loading(): getSizedWeight();
                          // });
                          Navigator.pop(context);
                          Fluttertoast.showToast(msg: value['message']);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Please fill all details fields");
                        }
                      })
                    : updateSizeAndWeightApi(
                            waist: waistController.text,
                            shirt: shirtController.text,
                            shoes: shoesController.text,
                            bed: bedController.text,
                            privacy: 'public',
                            id: sizeWeight!.data!.id.toString())
                        .then((value) {
                        if (value['status'] == true) {
                          // SharedPrefs().setSize('100 %');
                          // Fluttertoast.showToast(msg: value['message']);
                        } else {
                          // Fluttertoast.showToast(
                          //     msg: 'please update all fields');
                        }
                      });

                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => UserAllDetails(
                //               response: widget.response,
                //             )));
              },
              child: Image.asset('assets/images/Vector190.png'),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: isLoading
            ? Loading()
            : Form(
                key: formKey,
                child: Column(
                  children: [
                    LinearPercentIndicator(
                      curve: Curves.linear,
                      width: 1.sw,
                      padding: EdgeInsets.zero,
                      lineHeight: 8.0,
                      percent: normalizedPercent,
                      backgroundColor: Color(0xff576ACC).withOpacity(0.28),
                      progressColor: ColorSelect.color576ACC,
                    ),
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
                                height: 10.h,
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return WaistDialog(
                                        onPop: (val) {
                                          setState(() {
                                            Navigator.pop(context);
                                            waistController.text = val;
                                          });
                                          if (!siz.contains('waist')) {
                                            setState(() {
                                              siz.add('waist');
                                            });
                                          }
                                        },
                                        title: 'waist',
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Waist",
                                        style: AppTextStyle()
                                            .textColor70707014w400,
                                      ),
                                      Spacer(),
                                      waistController.text.isNotEmpty
                                          ? Text(
                                              waistController.text,
                                              style: AppTextStyle()
                                                  .textColor29292914w400,
                                            )
                                          : Text(
                                              sizeWeight!.data!.waist
                                                              .toString() ==
                                                          "" ||
                                                      sizeWeight!.data!.waist ==
                                                          null
                                                  ? "+ Add"
                                                  : sizeWeight!.data!.waist
                                                      .toString(),
                                              style: sizeWeight!.data!.waist ==
                                                      ''
                                                  ? AppTextStyle()
                                                      .textColorD5574514w500
                                                  : AppTextStyle()
                                                      .textColor29292914w400,
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
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ShirtDialog(
                                        onPop: (val) {
                                          setState(() {
                                            Navigator.pop(context);
                                            shirtController.text = val;
                                          });
                                          if (!siz.contains('shirt')) {
                                            setState(() {
                                              siz.add('shirt');
                                            });
                                          }
                                        },
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Shirt",
                                        style: AppTextStyle()
                                            .textColor70707014w400,
                                      ),
                                      Spacer(),
                                      shirtController.text.isNotEmpty
                                          ? Text(
                                              shirtController.text,
                                              style: AppTextStyle()
                                                  .textColor29292914w400,
                                            )
                                          : Text(
                                              sizeWeight!.data!.shirt
                                                              .toString() ==
                                                          "" ||
                                                      sizeWeight!.data!.shirt ==
                                                          null
                                                  ? "+ Add"
                                                  : sizeWeight!.data!.shirt
                                                      .toString(),
                                              style: sizeWeight!.data!.shirt ==
                                                      ''
                                                  ? AppTextStyle()
                                                      .textColorD5574514w500
                                                  : AppTextStyle()
                                                      .textColor29292914w400,
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
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ShoesDialog(
                                        onPop: (val) {
                                          setState(() {
                                            Navigator.pop(context);
                                            shoesController.text = val;
                                          });
                                          if (!siz.contains('shoes')) {
                                            setState(() {
                                              siz.add('shoes');
                                            });
                                          }
                                        },
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Shoes",
                                        style: AppTextStyle()
                                            .textColor70707014w400,
                                      ),
                                      Spacer(),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      shoesController.text.isNotEmpty
                                          ? Text(
                                              shoesController.text,
                                              style: AppTextStyle()
                                                  .textColor29292914w400,
                                            )
                                          : Text(
                                              sizeWeight!.data!.shoes
                                                              .toString() ==
                                                          "" ||
                                                      sizeWeight!.data!.shoes ==
                                                          null
                                                  ? "+ Add"
                                                  : sizeWeight!.data!.shoes
                                                      .toString(),
                                              style: sizeWeight!.data!.shoes ==
                                                      ''
                                                  ? AppTextStyle()
                                                      .textColorD5574514w500
                                                  : AppTextStyle()
                                                      .textColor29292914w400,
                                            ),
                                      // Image.asset("assets/images/information2.png"),
                                      // SizedBox(
                                      //   width: 20.w,
                                      // ),
                                      // Image.asset("assets/images/Vector175.png"),
                                    ],
                                  ),
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
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return BedsDialog(
                                        onPop: (val) {
                                          setState(() {
                                            Navigator.pop(context);
                                            bedController.text = val;
                                          });
                                          if (!siz.contains('bed')) {
                                            setState(() {
                                              siz.add('bed');
                                            });
                                          }
                                        },
                                      );
                                    },
                                  );
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "Bed",
                                      style:
                                          AppTextStyle().textColor70707014w400,
                                    ),
                                    Spacer(),
                                    bedController.text.isNotEmpty
                                        ? Text(
                                            bedController.text,
                                            style: AppTextStyle()
                                                .textColor29292914w400,
                                          )
                                        : Text(
                                            sizeWeight!.data!.bed.toString() ==
                                                        "" ||
                                                    sizeWeight!.data!.bed ==
                                                        null
                                                ? "+ Add"
                                                : sizeWeight!.data!.bed
                                                    .toString(),
                                            style: sizeWeight!.data!.bed == ''
                                                ? AppTextStyle()
                                                    .textColorD5574514w500
                                                : AppTextStyle()
                                                    .textColor29292914w400,
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
                          left: 16, right: 16, bottom: 40),
                      child: sizeWeight!.data!.bed.toString() == ''
                          ? LightYellowButtonWithText(
                              size: 16,
                              backgroundColor: MaterialStateProperty.all(
                                  ColorSelect.colorF7E641),
                              //         :
                              // MaterialStateProperty.all(
                              //     ColorSelect.colorFCF5B6),
                              textStyleColor: Colors.black,
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  postSizeAndWeightApi(
                                          waist: waistController.text,
                                          shirt: shirtController.text,
                                          shoes: shoesController.text,
                                          bed: bedController.text,
                                          privacy: 'public')
                                      .then((value) async {
                                    if (value['status'] == true) {
                                      Navigator.pop(context);
                                      SharedPrefs().setSize('100 %');
                                      // setState(() {
                                      //   isLoading ? Loading(): getSizedWeight();
                                      // });
                                      Fluttertoast.showToast(
                                          msg: value['message']);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Please fill all details fields");
                                    }
                                  });
                                }
                              },
                              title: 'Save')
                          : LightYellowButtonWithText(
                              size: 16,
                              backgroundColor:
                                  // (waistController.text.isNotEmpty &&
                                  //         shirtController.text.isNotEmpty &&
                                  //         shoesController.text.isNotEmpty &&
                                  //         bedController.text.isNotEmpty)
                                  MaterialStateProperty.all(
                                      ColorSelect.colorF7E641),
                              //     :
                              // MaterialStateProperty.all(
                              //     ColorSelect.colorFCF5B6),
                              textStyleColor: Colors.black,
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  updateSizeAndWeightApi(
                                          waist: waistController.text,
                                          shirt: shirtController.text,
                                          shoes: shoesController.text,
                                          bed: bedController.text,
                                          privacy: 'public',
                                          id: sizeWeight!.data!.id.toString())
                                      .then((value) {
                                    if (value['status'] == true) {
                                      Navigator.pop(context);
                                      // SharedPrefs().setSize('100 %');
                                      Fluttertoast.showToast(
                                          msg: value['message']);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: 'please update all fields');
                                    }
                                  });
                                }
                              },
                              title: 'Update'),
                    ),
                  ],
                ),
              ));
  }
}

class WaistDialog extends StatefulWidget {
  final Function(String) onPop;
  final String title;
  const WaistDialog({Key? key, required this.onPop, required this.title})
      : super(key: key);

  @override
  State<WaistDialog> createState() => _WaistDialogState();
}

class _WaistDialogState extends State<WaistDialog> {
  int selectedSize = 0;
  List tags = [
    '20',
    '22',
    '24',
    '26',
    '28',
    '30',
    '32',
    '34',
    '36',
    '38',
    '40',
    '44'
  ];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                widget.title,
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
                },
              ),
              SizedBox(height: 20.h),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (_) => Privacy(),
              //       ),
              //     );
              //   },
              //   child: Container(
              //     color: Colors.transparent,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       children: [
              //         Text(
              //           "Visible to",
              //           style: AppTextStyle().textColor70707014w400,
              //         ),
              //         SizedBox(
              //           width: 5.w,
              //         ),
              //         Image.asset("assets/images/image46.png"),
              //         SizedBox(
              //           width: 5.w,
              //         ),
              //         Text(
              //           'Everyone',
              //           style: AppTextStyle().textColor29292914w400,
              //         ),
              //         SizedBox(
              //           width: 10.w,
              //         ),
              //         Image.asset("assets/images/Vector176.png")
              //       ],
              //     ),
              //   ),
              // ),
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
  List tags = [
    '20',
    '22',
    '24',
    '26',
    '28',
    '30',
    '32',
    '34',
    '36',
    '38',
    '40',
    '44'
  ];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                'Shirt Size',
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
                },
              ),
              SizedBox(height: 20.h),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (_) => Privacy(),
              //       ),
              //     );
              //   },
              //   child: Container(
              //     color: Colors.transparent,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       children: [
              //         Text(
              //           "Visible to",
              //           style: AppTextStyle().textColor70707014w400,
              //         ),
              //         SizedBox(
              //           width: 5.w,
              //         ),
              //         Image.asset("assets/images/image46.png"),
              //         SizedBox(
              //           width: 5.w,
              //         ),
              //         Text(
              //           'Everyone',
              //           style: AppTextStyle().textColor29292914w400,
              //         ),
              //         SizedBox(
              //           width: 10.w,
              //         ),
              //         Image.asset("assets/images/Vector176.png")
              //       ],
              //     ),
              //   ),
              // ),
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
  List tags = [
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
  ];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                'Shoes Size',
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
                },
              ),
              SizedBox(height: 20.h),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (_) => Privacy(),
              //       ),
              //     );
              //   },
              //   child: Container(
              //     color: Colors.transparent,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       children: [
              //         Text(
              //           "Visible to",
              //           style: AppTextStyle().textColor70707014w400,
              //         ),
              //         SizedBox(
              //           width: 5.w,
              //         ),
              //         Image.asset("assets/images/image46.png"),
              //         SizedBox(
              //           width: 5.w,
              //         ),
              //         Text(
              //           'Everyone',
              //           style: AppTextStyle().textColor29292914w400,
              //         ),
              //         SizedBox(
              //           width: 10.w,
              //         ),
              //         Image.asset("assets/images/Vector176.png")
              //       ],
              //     ),
              //   ),
              // ),
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
  List tags = ['Double', 'Single', 'King', 'Queen '];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                'Bed Size',
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
                },
              ),
              SizedBox(height: 20.h),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.pop(context);
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (_) => Privacy(),
              //       ),
              //     );
              //   },
              //   child: Container(
              //     color: Colors.transparent,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.end,
              //       children: [
              //         Text(
              //           "Visible to",
              //           style: AppTextStyle().textColor70707014w400,
              //         ),
              //         SizedBox(
              //           width: 5.w,
              //         ),
              //         Image.asset("assets/images/image46.png"),
              //         SizedBox(
              //           width: 5.w,
              //         ),
              //         Text(
              //           'Everyone',
              //           style: AppTextStyle().textColor29292914w400,
              //         ),
              //         SizedBox(
              //           width: 10.w,
              //         ),
              //         Image.asset("assets/images/Vector176.png")
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
