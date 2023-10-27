import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/constants/globals/shared_prefs.dart';
import 'package:swishlist/constants/urls.dart';
import 'package:swishlist/models/profile_model.dart';
import 'package:swishlist/profile_page/privacy.dart';
import 'package:swishlist/profile_page/widgets/date_picker.dart';

import '../api/user_apis/profile_apis.dart';
import '../buttons/light_yellow.dart';
import '../constants/decoration.dart';
import '../constants/globals/loading.dart';
import 'favourite_add_widgets/car_edit_dialog.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key? key}) : super(key: key);
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool checkedMale = false;
  bool checkedFemale = false;
  bool checkedOther = false;
  bool isLoading = false;

  @override
  void initState() {
    getProfile();
    print(profile!.data!.name!.toString());
    // downloadAndSaveImage();

    super.initState();
  }
  //
  // late String localImagePath;
  //
  // Future<void> downloadAndSaveImage() async {
  //   final documentDirectory = await getApplicationDocumentsDirectory();
  //   final filePath = '${documentDirectory.path}/image.png';
  //   File file = File(filePath);
  //   await file.writeAsString(profile!.data!.user!.photo.toString());
  //   if (mounted) {
  //     setState(() {
  //       localImagePath = filePath;
  //     });
  //   }
  // }

  ProfileModel? profile = ProfileModel(
    data: ProfileData(
      name: '',
      gender: '',
      dob: '',
      occupation: '',
      relationStatus: '',
      email: '',
      phone: '',
      alternatePhone: '',
      homeAddress: '',
      workAddress: '',
      privacyStatus: '',
      createdAt: '',
      completePercent: '',
      user: ProfileUser(
        name: '',
        username: '',
        email: '',
        phone: '',
        type: '',
        photo: '',
      ),
    ),
  );

  getProfile() {
    isLoading = true;
    var resp = getProfileDetails();
    resp.then((value) {
      print(value);
      if (mounted) {
        if (value['status'] == true) {
          if (value['message'] == "No Profile") {
            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {
              profile = ProfileModel.fromJson(value);
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
    nameController.text = profile!.data!.name ?? '';
    genderController.text = profile!.data!.gender ?? '';
    dobFormat = profile!.data!.dob ?? '';
    occupationController.text = profile!.data!.occupation ?? '';
    relationStatus.text = profile!.data!.relationStatus ?? '';
    emailController.text = profile!.data!.email ?? '';
    phoneController.text = profile!.data!.phone ?? '';
    alternateNo.text = profile!.data!.alternatePhone ?? '';
    homeController.text = profile!.data!.homeAddress ?? '';
    workController.text = profile!.data!.workAddress ?? '';

    // pickedImage = (localImagePath) as File;
    //pickedImage = File(pickedImage.path ?? '');
  }

  double dou = 00;
  var percent = "";
  List<String> pro = [];

  get() {
    if (profile!.data!.name != null || profile!.data!.name != '') {
      pro.add('name');
    }
    if (profile!.data!.gender != null || profile!.data!.gender != '') {
      pro.add('gender');
    }
    if (profile!.data!.dob != null || profile!.data!.dob != '') {
      pro.add('dob');
    }
    if (profile!.data!.occupation != null || profile!.data!.occupation != '') {
      pro.add('occupation');
    }
    if (profile!.data!.relationStatus != null ||
        profile!.data!.relationStatus != '') {
      pro.add('relation_status');
    }
    if (profile!.data!.email != null || profile!.data!.email != '') {
      pro.add('email');
    }
    if (profile!.data!.phone != null || profile!.data!.phone != '') {
      pro.add('phone');
    }
    if (profile!.data!.alternatePhone != null ||
        profile!.data!.alternatePhone != '') {
      pro.add('alternate_phone');
    }
    if (profile!.data!.homeAddress != null ||
        profile!.data!.homeAddress != '') {
      pro.add('home_address');
    }
    if (profile!.data!.workAddress != null ||
        profile!.data!.workAddress != '') {
      pro.add('work_address');
    }
    percent = ((pro.length / 10) * 100).toString().split(".").first;
    dou = (pro.length / 10);
  }

  File pickedImage = File("");

  final ImagePicker _imgPicker = ImagePicker();

  String networkImage = '';
  final nameController = TextEditingController();
  final genderController = TextEditingController();
  final dobController = TextEditingController();
  final occupationController = TextEditingController();
  final relationStatus = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final alternateNo = TextEditingController();
  final homeController = TextEditingController();
  final workController = TextEditingController();
  String dobFormat = '';
  // GlobalKey<FormState>  formKey = GlobalKey<FormState>();

  String? completePercent;
  double parsedPercent = 0.0;
  double normalizedPercent = 0.0;

  ProfileModel? response;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '';
  String _emailError = '';

  bool _isValid = false;

  void _validateEmail(String email) {
    if (isValidEmail(email)) {
      Fluttertoast.showToast(
        msg: "Valid email: $email",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      Fluttertoast.showToast(
        msg: "Invalid email: $email",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  bool isValidEmail(String email) {
    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegExp.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    completePercent = profile?.data?.completePercent;
    parsedPercent = double.tryParse(completePercent ?? '0') ?? 0.0;
    normalizedPercent = parsedPercent / 100.0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Profile",
              style: AppTextStyle().textColor29292916w500,
            ),
            SizedBox(
              height: 5.h,
            ),
            isLoading
                ? SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        profile!.data!.completePercent.toString() == "" ||
                                profile!.data!.completePercent == null
                            ? "0"
                            : profile!.data!.completePercent
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
          ],
        ),
        leadingWidth: 40,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
              // profile!.data!.toString().isEmpty
              // (profile!.data!.completePercent.toString() == '' ||
              //         profile!.data!.name.toString() == '' ||
              //         profile!.data!.email.toString() == '' ||
              //         profile!.data!.workAddress.toString() == '' ||
              //         profile!.data!.homeAddress.toString() == '' ||
              //         profile!.data!.completePercent.toString() == '' ||
              //         profile!.data!.alternatePhone.toString() == '' ||
              //         profile!.data!.relationStatus.toString() == '' ||
              //         profile!.data!.gender.toString() == '' ||
              //         profile!.data!.dob.toString() == '' ||
              //         profile!.data!.occupation.toString() == '' ||
              //         profile!.data!.phone.toString() == '')
              updateProfile(
                      name: nameController.text,
                      gender: genderController.text,
                      dob: dobFormat,
                      occupation: occupationController.text,
                      relationStatus: relationStatus.text,
                      email: emailController.text,
                      phone: phoneController.text,
                      alternateNo: alternateNo.text,
                      homeAddress: homeController.text,
                      workAddress: workController.text,
                      privacyStatus: 'public',
                      id: profile!.data!.id.toString(),
                      photo: profile!.data!.user!.photo!.isEmpty
                          ? pickedImage.isAbsolute
                              ? pickedImage.path
                              : ''
                          : profile!.data!.user!.photo!)
                  .then((value) {
                print(pickedImage);
                if (value['status'] == true) {
                  Navigator.pop(context);
                  // setState(() {
                  //   // isLoading ? Loading() :getProfile();
                  // });
                  Fluttertoast.showToast(msg: value['message']);
                } else {
                  Fluttertoast.showToast(msg: value['message']);
                }
              });
            },
            child: SvgPicture.asset(
              "assets/icons/arrowback.svg",
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: isLoading
          ? Loading()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LinearPercentIndicator(
                    curve: Curves.linear,
                    width: 1.sw,
                    padding: EdgeInsets.zero,
                    lineHeight: 8.0,
                    percent: normalizedPercent,
                    backgroundColor: Color(0xff66D340).withOpacity(0.28),
                    progressColor: ColorSelect.color66D340,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                pickedImage.isAbsolute
                                    ? Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey.shade200,
                                        ),
                                        clipBehavior: Clip.hardEdge,
                                        child: Image.file(
                                          pickedImage,
                                          width: 1.sw,
                                          height: 420,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey.shade200,
                                        ),
                                        clipBehavior: Clip.hardEdge,
                                        child: CachedNetworkImage(
                                          imageUrl: baseUrl +
                                              profile!.data!.user!.photo
                                                  .toString(),
                                          /* baseUrl+profile!.data!.user!.photo! == '' ?
                              'add photo' :*/
                                          // '$baseUrl${SharedPrefs().getUserPhoto()}',
                                          // baseUrl+profile!.data!.user!.photo.toString(),
                                          // SharedPrefs()
                                          //         .getUserPhoto()
                                          //         .toString()
                                          //         .contains('https')
                                          //     ? SharedPrefs()
                                          //         .getUserPhoto()
                                          //         .toString()
                                          //     : '$baseUrl${SharedPrefs().getUserPhoto()}',
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                                  "assets/icons/userico.jpg"),
                                          progressIndicatorBuilder: (a, b, c) =>
                                              Opacity(
                                            opacity: 0.3,
                                            child: Shimmer.fromColors(
                                              baseColor: Colors.black12,
                                              highlightColor: Colors.white,
                                              child: Container(
                                                width: 50,
                                                height: 50,
                                                //margin: EdgeInsets.symmetric(horizontal: 24),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                Positioned(
                                  top: 60,
                                  right: 0.0,
                                  child: GestureDetector(
                                    onTap: () async {
                                      XFile? v = await _imgPicker.pickImage(
                                          source: ImageSource.gallery);
                                      if (v != null) {
                                        setState(
                                          () {
                                            pickedImage = File(v.path);
                                          },
                                        );
                                      }
                                      print(pickedImage);
                                    },
                                    child: Image.asset(
                                      'assets/images/Frame1000002710.png',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 40.h),
                        GestureDetector(
                          onTap: () {
                            // print(profile!.data!.user!.photo.toString());
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Name',
                                  addTextField: TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(20),
                                    ],
                                    onChanged: (v) {
                                      setState(() {});
                                      if (!pro.contains("name")) {
                                        setState(() {
                                          pro.add('name');
                                        });
                                      }
                                    },
                                    onEditingComplete: () {
                                      Navigator.pop(context);
                                    },
                                    controller: nameController,
                                    cursorColor: ColorSelect.colorF7E641,
                                    decoration: AppTFDecoration(hint: 'Name')
                                        .decoration(),
                                    //keyboardType: TextInputType.phone,
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Text(
                                  "Name",
                                  style: AppTextStyle().textColor70707014w400,
                                ),
                                Spacer(),
                                nameController.text.isEmpty
                                    ? Text(
                                        profile!.data!.name.toString() == "" ||
                                                profile!.data!.name == null
                                            ? "+ Add"
                                            : profile!.data!.name.toString(),
                                        style: profile!.data!.name == ''
                                            ? AppTextStyle()
                                                .textColorD5574514w500
                                            : AppTextStyle()
                                                .textColor29292914w400,
                                      )
                                    : Text(
                                        nameController.text,
                                        style: AppTextStyle()
                                            .textColor29292914w400,
                                      ),
                              ],
                            ),
                          ),
                          // child: NameRowWidget(profile: profile!,),
                        ),

                        SizedBox(
                          height: 20.h,
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CheckBoxWidget(
                                    gender: genderController.text,
                                    onPop: (val) {
                                      setState(() {});
                                      if (!pro.contains("gender")) {
                                        setState(() {
                                          Navigator.pop(context);
                                          pro.add('gender');
                                        });
                                      }
                                      setState(() {
                                        genderController.text = val;
                                      });
                                    },
                                  );
                                });
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Text(
                                  "Gender",
                                  style: AppTextStyle().textColor70707014w400,
                                ),
                                Spacer(),
                                genderController.text.isEmpty
                                    ? Text(
                                        profile!.data!.gender.toString() ==
                                                    "" ||
                                                profile!.data!.gender == null
                                            ? "+ Add"
                                            : profile!.data!.gender.toString(),
                                        style:
                                            profile!.data!.gender.toString() ==
                                                    ''
                                                ? AppTextStyle()
                                                    .textColorD5574514w500
                                                : AppTextStyle()
                                                    .textColor29292914w400,
                                      )
                                    : Text(
                                        genderController.text,
                                        style: AppTextStyle()
                                            .textColor29292914w400,
                                      ),
                                // SizedBox(
                                //   width: 5.w,
                                // ),
                                // Image.asset("assets/images/image461.png"),
                                // SizedBox(
                                //   width: 20.w,
                                // ),
                                // SvgPicture.asset("assets/icons/forwordarrow.svg")
                              ],
                            ),
                          ),
                          // child: GenderRowWidget(profile: profile!,),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Dob',
                                  addTextField: TextFormField(
                                    onChanged: (v) {
                                      setState(() {});
                                      if (!pro.contains('dob')) {
                                        setState(() {
                                          pro.add('dob');
                                        });
                                      }
                                    },
                                    onEditingComplete: () {
                                      Navigator.pop(context);
                                    },
                                    controller: dobController,
                                    cursorColor: ColorSelect.colorF7E641,
                                    decoration: AppTFDecoration(hint: 'Dob')
                                        .decoration(),
                                    readOnly: true,
                                    onTap: () {
                                      setState(
                                        () async {
                                          DateTime? pickedDate =
                                              await showDialog(
                                            context: context,
                                            builder: (_) => DatePickerWidget(
                                              onPop: (date) {
                                                setState(() {});
                                                dobController.text =
                                                    DateFormat.yMMMd()
                                                        .format(date);
                                                dobFormat =
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(date);
                                              },
                                              maximumDate: 2023,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    //keyboardType: TextInputType.phone,
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Text(
                                  "Date of birth",
                                  style: AppTextStyle().textColor70707014w400,
                                ),
                                Spacer(),
                                dobController.text.isEmpty
                                    ? Text(
                                        profile!.data!.dob.toString() == "" ||
                                                profile!.data!.dob == null
                                            ? "+ Add"
                                            : profile!.data!.dob.toString(),
                                        style: profile!.data!.dob == ''
                                            ? AppTextStyle()
                                                .textColorD5574514w500
                                            : AppTextStyle()
                                                .textColor29292914w400,
                                      )
                                    : Text(
                                        dobController.text,
                                        style: AppTextStyle()
                                            .textColor29292914w400,
                                      )
                                // SizedBox(
                                //   width: 5.w,
                                // ),
                                // Image.asset("assets/images/image461.png"),
                                // SizedBox(
                                //   width: 20.w,
                                // ),
                                // SvgPicture.asset("assets/icons/forwordarrow.svg")
                              ],
                            ),
                          ),
                        ),
                        // DateOfBirthWidget(profile: profile!,),
                        SizedBox(
                          height: 20.h,
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Occupation',
                                  addTextField: TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(25),
                                    ],
                                    onChanged: (v) {
                                      setState(() {});
                                      if (!pro.contains("occupation")) {
                                        setState(() {
                                          pro.add('occupation');
                                        });
                                      }
                                    },
                                    onEditingComplete: () {
                                      Navigator.pop(context);
                                    },
                                    controller: occupationController,
                                    cursorColor: ColorSelect.colorF7E641,
                                    decoration:
                                        AppTFDecoration(hint: 'Occupation')
                                            .decoration(),
                                    //keyboardType: TextInputType.phone,
                                  ),
                                );
                              },
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                "Occupation",
                                style: AppTextStyle().textColor70707014w400,
                              ),
                              Spacer(),
                              occupationController.text.isEmpty
                                  ? Text(
                                      profile!.data!.occupation.toString() ==
                                                  '' ||
                                              profile!.data!.occupation == null
                                          ? '+ Add'
                                          : profile!.data!.occupation
                                              .toString(),
                                      style: profile!.data!.occupation == ''
                                          ? AppTextStyle().textColorD5574514w500
                                          : AppTextStyle()
                                              .textColor29292914w400,
                                    )
                                  : Text(
                                      occupationController.text,
                                      style:
                                          AppTextStyle().textColor29292914w400,
                                    ),
                              // SizedBox(
                              //   width: 5.w,
                              // ),
                              // Image.asset("assets/images/image46.png"),
                              // SizedBox(
                              //   width: 20.w,
                              // ),
                              // SvgPicture.asset("assets/icons/forwordarrow.svg")
                            ],
                          ),
                          // child: OccupationRowWidget(profile: profile!)
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return RelationShipCheckBox(
                                  onPop: (val) {
                                    if (!pro.contains("relation_status")) {
                                      setState(() {
                                        pro.add('relation_status');
                                      });
                                    }
                                    setState(() {
                                      relationStatus.text = val;
                                    });
                                  },
                                  relation: relationStatus.text,
                                );
                              },
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                "Relationship Status",
                                style: AppTextStyle().textColor70707014w400,
                              ),
                              Spacer(),
                              SizedBox(
                                width: 5.w,
                              ),
                              relationStatus.text.isEmpty
                                  ? Text(
                                      profile!.data!.relationStatus
                                                      .toString() ==
                                                  '' ||
                                              profile!.data!.relationStatus ==
                                                  null
                                          ? '+ Add'
                                          : profile!.data!.relationStatus
                                              .toString(),
                                      style: profile!.data!.relationStatus == ''
                                          ? AppTextStyle().textColorD5574514w500
                                          : AppTextStyle()
                                              .textColor29292914w400,
                                    )
                                  : Text(
                                      relationStatus.text,
                                      style:
                                          AppTextStyle().textColor29292914w400,
                                    ),
                              // Image.asset("assets/images/information1.png"),
                              // SizedBox(
                              //   width: 20.w,
                              // ),
                              // SvgPicture.asset("assets/icons/forwordarrow.svg")
                            ],
                          ),
                        ),
                        // RelationshipStatusRowWidget(profile:profile!),
                        SizedBox(height: 40.h),
                        Text(
                          "Contact",
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
                                return NameEditDialogWidget(
                                  title: 'Email',
                                  addTextField: TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(25),
                                    ],

                                    onChanged: (v) {
                                      setState(() {});
                                      if (!pro.contains("email")) {
                                        setState(() {
                                          pro.add('email');
                                        });
                                      }
                                    },
                                    onEditingComplete: () {
                                      Navigator.pop(context);
                                    },
                                    controller: emailController,
                                    cursorColor: ColorSelect.colorF7E641,
                                    decoration: AppTFDecoration(hint: 'Email')
                                        .decoration(),
                                    //keyboardType: TextInputType.phone,
                                  ),
                                );
                              },
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                "Email",
                                style: AppTextStyle().textColor70707014w400,
                              ),
                              Spacer(),
                              emailController.text.isEmpty
                                  ? Text(
                                      profile!.data!.user!.email.toString() ==
                                                  '' ||
                                              profile!.data!.email == null
                                          ? "+ Add"
                                          : profile!.data!.user!.email
                                              .toString(),
                                      // '${SharedPrefs().getEmail()}',
                                      style: profile!.data!.email == ''
                                          ? AppTextStyle().textColorD5574514w500
                                          : AppTextStyle()
                                              .textColor29292914w400,
                                    )
                                  : Text(
                                      emailController.text,
                                      style:
                                          AppTextStyle().textColor29292914w400,
                                    )
                            ],
                          ),
                          // child: EmailRowWidget(profile:profile!),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'phone no',
                                  addTextField: Form(
                                    key: _formKey,
                                    child: TextFormField(
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(10),
                                      ],
                                      keyboardType: TextInputType.number,
                                      onChanged: (v) {
                                        setState(() {});
                                        if (!pro.contains("phone")) {
                                          setState(() {
                                            pro.add('phone');
                                          });
                                        }
                                      },
                                      onEditingComplete: () {
                                        Navigator.pop(context);
                                      },
                                      controller: phoneController,
                                      cursorColor: ColorSelect.colorF7E641,
                                      decoration:
                                          AppTFDecoration(hint: 'phone no')
                                              .decoration(),
                                      //keyboardType: TextInputType.phone,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                "Phone",
                                style: AppTextStyle().textColor70707014w400,
                              ),
                              Spacer(),
                              phoneController.text.isEmpty
                                  ? Text(
                                      profile!.data!.phone.toString() == '' ||
                                              profile!.data!.phone == null
                                          ? '+ Add'
                                          : profile!.data!.phone.toString(),
                                      // profile!.data!.user!.phone.toString() == ''?
                                      // '+ Add' :
                                      // profile!.data!.user!.phone.toString(),
                                      style: profile!.data!.phone == ''
                                          ? AppTextStyle().textColorD5574514w500
                                          : AppTextStyle()
                                              .textColor29292914w400,
                                    )
                                  : Text(
                                      phoneController.text,
                                      style:
                                          AppTextStyle().textColor29292914w400,
                                    )
                            ],
                          ),
                          // child: PhoneRowWidget(profile:profile!),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Alternate phone no',
                                  addTextField: TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(10),
                                    ],
                                    keyboardType: TextInputType.number,
                                    onChanged: (v) {
                                      setState(() {});
                                      if (!pro.contains("alternate_phone")) {
                                        setState(() {
                                          pro.add('alternate_phone');
                                        });
                                      }
                                    },
                                    onEditingComplete: () {
                                      Navigator.pop(context);
                                    },
                                    controller: alternateNo,
                                    cursorColor: ColorSelect.colorF7E641,
                                    decoration: AppTFDecoration(
                                            hint: 'Alternate phone no')
                                        .decoration(),
                                    //keyboardType: TextInputType.phone,
                                  ),
                                );
                              },
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                "Alternate Phone no",
                                style: AppTextStyle().textColor70707014w400,
                              ),
                              Spacer(),
                              alternateNo.text.isEmpty
                                  ? Text(
                                      profile!.data!.alternatePhone
                                                      .toString() ==
                                                  '' ||
                                              profile!.data!.alternatePhone ==
                                                  null
                                          ? '+ Add'
                                          : profile!.data!.alternatePhone
                                              .toString(),
                                      // profile!.data!.user!.phone.toString() == ''?
                                      // '+ Add' :
                                      // profile!.data!.user!.phone.toString(),
                                      style: profile!.data!.alternatePhone == ''
                                          ? AppTextStyle().textColorD5574514w500
                                          : AppTextStyle()
                                              .textColor29292914w400,
                                    )
                                  : Text(
                                      alternateNo.text,
                                      style:
                                          AppTextStyle().textColor29292914w400,
                                    )
                            ],
                          ),
                          // child: PhoneRowWidget(profile:profile!),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        // GestureDetector(
                        //   onTap: () {
                        //     showDialog(
                        //       context: context,
                        //       builder: (BuildContext context) {
                        //         return NameEditDialogWidget(
                        //           title: 'Alternate phone no',
                        //           addTextField: TextFormField(
                        //             keyboardType: TextInputType.number,
                        //             onChanged: (v) {
                        //               setState(() {});
                        //               if (!pro.contains("alternate_phone")) {
                        //                 setState(() {
                        //                   pro.add('alternate_phone');
                        //                 });
                        //               }
                        //             },
                        //             onEditingComplete: () {
                        //               Navigator.pop(context);
                        //             },
                        //             controller: alternateNo,
                        //             cursorColor: ColorSelect.colorF7E641,
                        //             decoration: AppTFDecoration(
                        //                     hint: 'Alternate phone no')
                        //                 .decoration(),
                        //             //keyboardType: TextInputType.phone,
                        //           ),
                        //         );
                        //       },
                        //     );
                        //   },
                        //   child: Row(
                        //     children: [
                        //       Text(
                        //         "Alternate phone no",
                        //         style: AppTextStyle().textColor70707014w400,
                        //       ),
                        //       Spacer(),
                        //       alternateNo.text.isEmpty
                        //           ? Text(
                        //               profile!.data!.alternatePhone
                        //                               .toString() ==
                        //                           '' ||
                        //                       profile!.data!.alternatePhone ==
                        //                           null
                        //                   ? '+ Add'
                        //                   : profile!.data!.alternatePhone
                        //                       .toString(),
                        //               style: profile!.data!.alternatePhone == ''
                        //                   ? AppTextStyle().textColorD5574514w500
                        //                   : AppTextStyle()
                        //                       .textColor29292914w400,
                        //             )
                        //           : Text(
                        //               alternateNo.text,
                        //               style:
                        //                   AppTextStyle().textColor29292914w400,
                        //             )
                        //     ],
                        //   ),
                        //   // child: AlternatePhoneRowWidget(profile:profile!),
                        // ),
                        SizedBox(
                          height: 40.h,
                        ),
                        Text(
                          "Addresses",
                          style: AppTextStyle().textColor29292914w600,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Home",
                          style: AppTextStyle().textColor70707014w400,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Home Address',
                                  addTextField: TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(70),
                                    ],
                                    onChanged: (v) {
                                      setState(() {});
                                      if (!pro.contains("home_address")) {
                                        setState(() {
                                          pro.add('home_address');
                                        });
                                      }
                                    },
                                    onEditingComplete: () {
                                      Navigator.pop(context);
                                    },
                                    controller: homeController,
                                    cursorColor: ColorSelect.colorF7E641,
                                    decoration:
                                        AppTFDecoration(hint: 'Home Address')
                                            .decoration(),
                                    //keyboardType: TextInputType.phone,
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Column(
                              children: [
                                homeController.text.isEmpty
                                    ? Text(
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        profile!.data!.homeAddress.toString() ==
                                                    '' ||
                                                profile!.data!.homeAddress ==
                                                    null
                                            ? '+ Add'
                                            : profile!.data!.homeAddress
                                                .toString(),
                                        style: profile!.data!.homeAddress == ''
                                            ? AppTextStyle()
                                                .textColorD5574514w500
                                            : AppTextStyle()
                                                .textColor29292914w400,
                                      )
                                    : Text(
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        homeController.text,
                                        style: AppTextStyle()
                                            .textColor29292914w400,
                                      )
                                // Spacer(),
                                // Image.asset("assets/images/image462.png"),
                                // SizedBox(width: 20.w),
                                // SvgPicture.asset("assets/icons/forwordarrow.svg")
                              ],
                            ),
                          ),
                          // child: AddressRowWidget(profile:profile!),
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
                                return NameEditDialogWidget(
                                  title: 'Work Address',
                                  addTextField: TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(70),
                                    ],
                                    onChanged: (v) {
                                      setState(() {});
                                      if (!pro.contains("work_address")) {
                                        setState(() {
                                          pro.add('work_address');
                                        });
                                      }
                                    },
                                    onEditingComplete: () {
                                      Navigator.pop(context);
                                    },
                                    controller: workController,
                                    cursorColor: ColorSelect.colorF7E641,
                                    decoration:
                                        AppTFDecoration(hint: 'Work Address')
                                            .decoration(),
                                    onTap: () {},
                                    //keyboardType: TextInputType.phone,
                                  ),
                                );
                              },
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Work",
                                    style: AppTextStyle().textColor70707014w400,
                                  ),
                                  Spacer(),
                                  SizedBox(width: 5.w),

                                  // Image.asset("assets/images/information1.png"),
                                  // SizedBox(width: 20.w),
                                  // SvgPicture.asset("assets/icons/forwordarrow.svg")
                                ],
                              ),
                              workController.text.isEmpty
                                  ? Text(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      profile!.data!.workAddress.toString() ==
                                                  '' ||
                                              profile!.data!.workAddress == null
                                          ? '+ Add'
                                          : profile!.data!.workAddress
                                              .toString(),
                                      style: profile!.data!.workAddress == ''
                                          ? AppTextStyle().textColorD5574514w500
                                          : AppTextStyle()
                                              .textColor29292914w400,
                                    )
                                  : Text(
                                      workController.text,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          AppTextStyle().textColor29292914w400,
                                    ),
                            ],
                          ),

                          // child: WorkRowWidget(profile:profile!),
                        ),

                        SizedBox(height: 30),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child:
                                // child: (profile!.data!.occupation.toString() == '')
                                //     ?
                                LightYellowButtonWithText(
                                    size: 16,
                                    backgroundColor: MaterialStateProperty.all(
                                        ColorSelect.colorF7E641),
                                    textStyleColor: Colors.black,
                                    onTap: () {
                                      //print(localImagePath);
                                      postProfile(
                                        name: nameController.text,
                                        gender: genderController.text,
                                        dob: dobFormat,
                                        occupation: occupationController.text,
                                        relationStatus: relationStatus.text,
                                        email: emailController.text,
                                        phone: phoneController.text,
                                        alternateNo: alternateNo.text,
                                        homeAddress: homeController.text,
                                        workAddress: workController.text,
                                        privacyStatus: 'public',
                                        photo:
                                            // localImagePath

                                            pickedImage.path.isEmpty
                                                ? pickedImage.path
                                                : '',
                                      ).then(
                                        (value) async {
                                          if (value['status'] == true) {
                                            SharedPrefs().setPPercent('100 %');
                                            Navigator.pop(context);
                                            Fluttertoast.showToast(
                                                msg: value['message']);
                                          } else {
                                            Fluttertoast.showToast(
                                                msg: value['message']);
                                          }
                                        },
                                      );
                                    },
                                    title: 'Add')
                            //     :
                            // LightYellowButtonWithText(
                            //     size: 15,
                            //     backgroundColor: MaterialStateProperty.all(
                            //         ColorSelect.colorF7E641),
                            //     textStyleColor: Colors.black,
                            //     onTap: () {
                            //       updateProfile(
                            //               name: nameController.text,
                            //               gender: genderController.text,
                            //               dob: dobFormat,
                            //               occupation:
                            //                   occupationController.text,
                            //               relationStatus:
                            //                   relationStatus.text,
                            //               email: emailController.text,
                            //               phone: phoneController.text,
                            //               alternateNo: alternateNo.text,
                            //               homeAddress: homeController.text,
                            //               workAddress: workController.text,
                            //               privacyStatus: 'public',
                            //               id: profile!.data!.id.toString(),
                            //               photo: pickedImage.isAbsolute
                            //                   ? pickedImage.path
                            //                   : '')
                            //           .then((value) {
                            //         print(pickedImage);
                            //         if (value['status'] == true) {
                            //           SharedPrefs()
                            //               .setName(nameController.text);
                            //           SharedPrefs()
                            //               .setEmail(emailController.text);
                            //           Navigator.pop(context);
                            //           // setState(() {
                            //           //   // isLoading ? Loading() :getProfile();
                            //           // });
                            //           Fluttertoast.showToast(
                            //               msg: value['message']);
                            //         } else {
                            //           Fluttertoast.showToast(
                            //               msg: value['message']);
                            //         }
                            //       });
                            //     },
                            //     title: 'Update')
                            ),
                        SizedBox(height: 25.h)
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  AlertDialog buildAlertDialog(BuildContext context, final String puppyOrigin,
      final Function(String) onPop) {
    int _gIndex = 0;
    return AlertDialog(
        insetPadding: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        content: Container(
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          width: 1.sw,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gender',
                  style: AppTextStyle().textColor29292914w500,
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.grey,
                      activeColor: ColorSelect.colorF7E641,
                      //fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: checkedMale,
                      shape: CircleBorder(),
                      onChanged: (value) {
                        setState(() {
                          checkedMale = value!;
                        });
                      },
                    ),
                    Text('Male', style: AppTextStyle().textColor29292914w500)
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.grey,
                      activeColor: ColorSelect.colorF7E641,
                      //fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: checkedFemale,
                      shape: CircleBorder(),
                      onChanged: (value) {
                        setState(() {
                          checkedFemale = value!;
                        });
                      },
                    ),
                    Text('Female', style: AppTextStyle().textColor29292914w500)
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.grey,
                      activeColor: ColorSelect.colorF7E641,
                      //fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: checkedOther,
                      shape: CircleBorder(),
                      onChanged: (value) {
                        setState(() {
                          checkedOther = value!;
                        });
                      },
                    ),
                    Text('Other', style: AppTextStyle().textColor29292914w500)
                  ],
                ),
                SizedBox(height: 20),
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
                )
              ],
            ),
          ),
        ));
  }
}

class CheckBoxWidget extends StatefulWidget {
  final String gender;
  final Function(String) onPop;
  const CheckBoxWidget({Key? key, required this.gender, required this.onPop})
      : super(key: key);

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  int _gIndex = 0;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        insetPadding: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        content: Container(
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          width: 1.sw,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gender',
                  style: AppTextStyle().textColor29292914w500,
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _gIndex = 0;
                      Navigator.of(context).pop();
                      widget.onPop("male");
                    });
                  },
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _gIndex = 0;
                            Navigator.of(context).pop();
                            widget.onPop("male");
                          });
                        },
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: _gIndex == 0
                                ? ColorSelect.colorF7E641
                                : Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 1,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text('Male', style: AppTextStyle().textColor29292914w500)
                    ],
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _gIndex = 1;
                      Navigator.of(context).pop();
                      widget.onPop("female");
                    });
                  },
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _gIndex = 1;
                            Navigator.of(context).pop();
                            widget.onPop("female");
                          });
                        },
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: _gIndex == 1
                                ? ColorSelect.colorF7E641
                                : Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 1,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text('Female',
                          style: AppTextStyle().textColor29292914w500)
                    ],
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _gIndex = 2;
                      Navigator.of(context).pop();
                      widget.onPop("neutral");
                    });
                  },
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _gIndex = 2;
                            Navigator.of(context).pop();
                            widget.onPop("neutral");
                          });
                        },
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: _gIndex == 2
                                ? ColorSelect.colorF7E641
                                : Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 1,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text('Neutral',
                          style: AppTextStyle().textColor29292914w500)
                    ],
                  ),
                ),
                SizedBox(height: 20),
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
                // )
              ],
            ),
          ),
        ));
  }

  @override
  void initState() {
    if (widget.gender == "male") {
      _gIndex = 0;
    } else if (widget.gender == "female") {
      _gIndex = 1;
    } else {
      _gIndex = 2;
    }
    super.initState();
  }
}

class RelationShipCheckBox extends StatefulWidget {
  final String relation;
  final Function(String) onPop;
  const RelationShipCheckBox(
      {Key? key, required this.relation, required this.onPop})
      : super(key: key);

  @override
  State<RelationShipCheckBox> createState() => _RelationShipCheckBoxState();
}

class _RelationShipCheckBoxState extends State<RelationShipCheckBox> {
  int _gIndex = 0;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      content: Container(
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        width: 1.sw,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Relation Status',
                style: AppTextStyle().textColor29292914w500,
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _gIndex = 0;
                    Navigator.of(context).pop();
                    widget.onPop("married");
                  });
                },
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _gIndex = 0;
                          Navigator.of(context).pop();
                          widget.onPop("married");
                        });
                      },
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: _gIndex == 0
                              ? ColorSelect.colorF7E641
                              : Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text('Married', style: AppTextStyle().textColor29292914w500)
                  ],
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _gIndex = 1;
                    Navigator.of(context).pop();
                    widget.onPop("single");
                  });
                },
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _gIndex = 1;
                          Navigator.of(context).pop();
                          widget.onPop("single");
                        });
                      },
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: _gIndex == 1
                              ? ColorSelect.colorF7E641
                              : Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text('Single', style: AppTextStyle().textColor29292914w500)
                  ],
                ),
              ),
              SizedBox(height: 20),
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
              //         SizedBox(width: 10.w),
              //         Image.asset("assets/images/Vector176.png")
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    if (widget.relation == "married") {
      _gIndex = 0;
    } else if (widget.relation == "single") {
      _gIndex = 1;
    }
    super.initState();
  }
}
