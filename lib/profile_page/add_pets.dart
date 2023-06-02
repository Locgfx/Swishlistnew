
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:swishlist/buttons/light_yellow.dart';
import 'package:swishlist/constants/globals/shared_prefs.dart';
import 'package:swishlist/profile_page/pets.dart';
import 'dart:io';
import '../../constants/color.dart';
import '../api/user_apis/pets_api.dart';

class AddPets extends StatefulWidget {
  const AddPets({Key? key}) : super(key: key);

  @override
  State<AddPets> createState() => _AddPetsState();
}

class _AddPetsState extends State<AddPets> {
  final nameController = TextEditingController();
  final typeController = TextEditingController();
  final originController = TextEditingController();
  final privacyController = TextEditingController();
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // File imageFile = File("");
  File pickedImage = File("");
  final ImagePicker _imgPicker = ImagePicker();
  String networkImage = '';
  String dateFormat ='';

  clearImage() {
    setState(() {
      pickedImage = File('');
    });
  }

  @override
  void initState() {
    clearImage();
    super.initState();
  }

  // void _petTypeBottomSheet() {
  //   showModalBottomSheet(
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //             topRight: Radius.circular(20), topLeft: Radius.circular(20)),
  //       ),
  //       context: context,
  //       builder: (context) => PetTypeBottomSheet(
  //         puppyType: "",
  //         onPop: (val) {},
  //       ));
  // }

  void _petOriginBottomSheet() {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        ),
        context: context,
        builder: (context) => PetOriginBottomSheet(
          onPop: (val) {},
          puppyOrigin: '',
        ));
  }
  // void _privacyStatusBottomSheet() {
  //   showModalBottomSheet(
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //             topRight: Radius.circular(20), topLeft: Radius.circular(20)),
  //       ),
  //       context: context,
  //       builder: (context) => PrivacyStatusBottomSheet(
  //         onPop: (val) {},
  //         privacyStatus: '',
  //       ));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(children: [
          Text(
            "Add Pets",
            style: AppTextStyle().textColor29292916w500,
          ),
        ]),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset('assets/images/Vector190.png')
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Enter pet details",
                  style: AppTextStyle().textColor29292924w700,
                ),
                // SizedBox(height: 8,),
                // Text(
                //   "Fill the details of product you own already.",
                //   style: AppTextStyle().textColor70707014w400,
                // ),
                SizedBox(height: 28,),
                Stack(
                  children: [
                    Container(
                      height: 246.h,
                      width: 328.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          width: 1,
                          color: ColorSelect.colorA3A3A3,
                        ),
                      ),
                      child:  pickedImage.path.isEmpty ? Center(
                        child: GestureDetector(
                            onTap: () async {
                              XFile? v = await _imgPicker.pickImage(
                                  source: ImageSource.gallery
                              );
                              if (v != null) {
                                setState(() {
                                  pickedImage = File(v.path);
                                },);
                              }
                              print(pickedImage);
                            },
                            child:  Container(
                              height: 44.h,
                              width: 144.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  width: 1,
                                  color: ColorSelect.colorA3A3A3,
                                ),
                              ),
                              child: Center(
                                child: Row(
                                  children: [
                                    SizedBox(width: 24),
                                    Image.asset("assets/images/image-add.png"),
                                    SizedBox(width: 10),
                                    Text("Add image")
                                  ],
                                ),
                              ),
                            )

                        ),
                      ): Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Image.file(
                          pickedImage,
                          width: 1.sw,
                          height: 420,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: GestureDetector(
                        onTap: (){
                          clearImage();
                          setState(() {
                            // pickedImage = '' as String;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(microseconds: 300),
                          height: pickedImage.path.isEmpty ?0:32,
                          width: pickedImage.path.isEmpty ?0:32,
                          decoration: BoxDecoration(
                              color: ColorSelect.colorF7E641,
                              shape: BoxShape.circle,
                              image: DecorationImage(image: AssetImage('assets/icons/iconcross.png'))
                          ),
                        ),
                      ),
                    ),
                    // Positioned(
                    //   top: 60,
                    //   bottom: 60,
                    //   left: 10,
                    //   right: 10,
                    //   child: Center(
                    //     child: GestureDetector(
                    //       onTap: () async {
                    //         XFile? v = await _imgPicker.pickImage(
                    //             source: ImageSource.gallery
                    //         );
                    //         if (v != null) {
                    //           setState(() {
                    //             pickedImage = File(v.path);
                    //           },);
                    //         }
                    //         print(pickedImage);
                    //       },
                    //       child:  Container(
                    //         height: 44.h,
                    //         width: 144.w,
                    //         decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(8),
                    //             border: Border.all(
                    //                 width: 1,
                    //                 color: ColorSelect.colorA3A3A3,
                    //             ),
                    //         ),
                    //         child: Center(
                    //           child: Row(
                    //             children: [
                    //               SizedBox(width: 24),
                    //               Image.asset("assets/images/image-add.png"),
                    //               SizedBox(width: 10),
                    //               Text("Add image")
                    //             ],
                    //           ),
                    //         ),
                    //       )
                    //       // Stack(
                    //       //   children: [
                    //       //     Container(
                    //       //       height: 246.h,
                    //       //       width: 328.w,
                    //       //       clipBehavior:Clip.hardEdge,
                    //       //       decoration: BoxDecoration(
                    //       //         borderRadius: BorderRadius.circular(8),
                    //       //         border: Border.all(
                    //       //           width: 2,
                    //       //           color: ColorSelect.colorA3A3A3,
                    //       //         ),
                    //       //       ),
                    //       //       child: Image.file(
                    //       //         pickedImage,
                    //       //         width: 1.sw,
                    //       //         height: 420,
                    //       //         fit: BoxFit.contain,
                    //       //       ),
                    //       //     ),
                    //       //     Positioned(
                    //       //       right: 0,
                    //       //       top: 0,
                    //       //       child: Container(
                    //       //         height: 32,
                    //       //         width: 32,
                    //       //         decoration: BoxDecoration(
                    //       //           color: ColorSelect.colorF7E641,
                    //       //           shape: BoxShape.circle,
                    //       //           image: DecorationImage(image: AssetImage('assets/icons/iconcross.png'))
                    //       //         ),
                    //       //       ),
                    //       //     ),
                    //       //   ],
                    //       // ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  width: 328.w,
                  height: 52.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ColorSelect.colorEDEDF1,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onChanged: (v) {
                              setState(() {});
                            },
                            controller: nameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Name of the pet",
                                hintStyle: AppTextStyle().textColor70707014w400
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  width: 328.w,
                  height: 52.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ColorSelect.colorEDEDF1
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onTap:() {
                              // showModalBottomSheet(
                              //     shape: const RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.only(
                              //           topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                              //     ),
                              //     context: context,
                              //     builder: (context) => PetTypeBottomSheet(
                              //       puppyType: typeController.text,
                              //       onPop: (val) {
                              //         setState(() {
                              //           typeController.text = val;
                              //         });
                              //       },
                              //     ));

                            },
                            onChanged: (v) {
                              setState(() {});
                            },
                            controller: typeController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Type of the pet",
                                hintStyle: AppTextStyle().textColor70707014w400,
                              // suffixIconConstraints: BoxConstraints(maxHeight: 40,maxWidth: 40),
                              // suffixIcon: Padding(
                              //   padding: const EdgeInsets.only(right: 15.0),
                              //   child: Image.asset('assets/images/down-arrow.png',height: 25,),
                              // )
                            ),
                            keyboardType: TextInputType.text,
                            // readOnly: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  width: 328.w,
                  height: 52.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ColorSelect.colorEDEDF1),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onChanged: (v) {
                              setState(() {
                              });
                            },
                            controller: originController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Origin",
                                hintStyle: AppTextStyle().textColor70707014w400,
                                // suffixIconConstraints: BoxConstraints(maxHeight: 40,maxWidth: 40),
                      // suffixIcon: Padding(
                      //   padding: const EdgeInsets.only(right: 15.0),
                      //   child: Image.asset('assets/images/down-arrow.png',height: 25,),
                      // ),
                            ),
                            // readOnly: true,
                            onTap: () {
                              // showModalBottomSheet(
                              //     shape: const RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.only(
                              //           topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                              //     ),
                              //     context: context,
                              //     builder: (context) => PetOriginBottomSheet(
                              //       onPop: (val) {
                              //         setState(() {
                              //           originController.text = val;
                              //         });
                              //       },
                              //       puppyOrigin: originController.text,
                              //     ));

                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  width: 328.w,
                  height: 52.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ColorSelect.colorEDEDF1
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            onChanged: (v) {
                              setState(() {
                              });
                            },
                            controller: privacyController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Privacy Status",
                                hintStyle: AppTextStyle().textColor70707014w400,
                                suffixIconConstraints: BoxConstraints(maxHeight: 40,maxWidth: 40),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: Image.asset('assets/images/down-arrow.png',height: 25,),
                                )
                            ),
                            keyboardType: TextInputType.text,
                            readOnly: true,
                            onTap: () {
                              // _privacyStatusBottomSheet();
                              showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                  ),
                                  context: context,
                                  builder: (context) => PrivacyStatusBottomSheet(
                                    onPop: (val) {
                                      setState(() {
                                        privacyController.text = val;
                                      });
                                    },
                                    privacyStatus: privacyController.text,
                                  ));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Container(
                //   width: 328.w,
                //   height: 52.h,
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(8),
                //       color: ColorSelect.colorEDEDF1
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.only(left: 12),
                //     child: Row(
                //       children: [
                //         Expanded(
                //           child: TextFormField(
                //             onChanged: (v) {
                //               setState(() {});
                //             },
                //             controller: dateController,
                //             keyboardType: TextInputType.text,
                //             readOnly: true,
                //             onTap: ()  {
                //               setState(() async {
                //                 DateTime? pickedDate = await showDialog(
                //                   context: context,
                //                   builder: (_) => DatePickerWidget(onPop: (date) {
                //                     dateController.text=DateFormat.yMMMd().format(date);
                //                     dateFormat = DateFormat('yyyy-MM-dd').format(date) ;
                //                   },
                //                   ),
                //                 );
                //               });
                //               //
                //               // DateTime? pickedDate = await showDatePicker(
                //               //     context: context,
                //               //     initialDate: DateTime.now(),
                //               //     firstDate: DateTime(1950),
                //               //     //DateTime.now() - not to allow to choose before today.
                //               //     lastDate: DateTime(2100));
                //               //
                //               // if (pickedDate != null) {
                //               //   print(
                //               //       pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                //               //   String formattedDate =
                //               //   DateFormat('yyyy-MM-dd').format(pickedDate);
                //               //   print(
                //               //       formattedDate); //formatted date output using intl package =>  2021-03-16
                //               //   setState(() {
                //               //     dateController.text =
                //               //         formattedDate; //set output date to TextField value.
                //               //   });
                //               // } else {}
                //             },
                //             decoration: InputDecoration(
                //                 border: InputBorder.none,
                //                 hintText: "Date Purchased",
                //                 hintStyle: AppTextStyle().textColor70707014w400,
                //                 suffixIcon:
                //                 Image.asset("assets/images/calendarimg.png")),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(height: 56),
                SizedBox(
                  width: 328.w,
                  height: 52.h,
                  child: /*isLoading ?
                  LoadingLightYellowButton():*/
                  LightYellowButtonWithText(
                    onTap: () {
                      if(formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        if (networkImage.isNotEmpty ||
                            pickedImage.isAbsolute) {
                          postPetsApi(
                            name: nameController.text,
                            type: typeController.text,
                            origin: originController.text,
                            privacyStatus: privacyController.text,
                            photo: pickedImage.isAbsolute
                                ?  pickedImage.path
                                : '',).then((value) async {
                            if(value['status'] == true ) {
                              SharedPrefs().setPets('100 %');
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) =>Pets()));
                              Fluttertoast.showToast(
                                  msg:value['message']);
                            } else {
                              Fluttertoast.showToast(
                                  msg:value['message']);
                            }},
                          );
                        }
                      }
                    },
                    backgroundColor:(
                        nameController.text.isNotEmpty &&
                            typeController.text.isNotEmpty ||
                            originController.text.isNotEmpty
                    ) ? MaterialStateProperty.all(ColorSelect.colorF7E641)
                        : MaterialStateProperty.all(ColorSelect.colorFCF5B6),
                    textStyleColor: nameController.text.isNotEmpty &&
                        typeController.text.isNotEmpty ||
                        originController.text.isNotEmpty ?
                    Colors.black :
                    ColorSelect.colorB5B07A,
                    title: 'Add',
                  ),
                ),
                SizedBox(height: 24)
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class PetTypeBottomSheet extends StatefulWidget {
  final String puppyType;
  final Function(String) onPop;
  const PetTypeBottomSheet(
      {Key? key, required this.puppyType, required this.onPop})
      : super(key: key);

  @override
  State<PetTypeBottomSheet> createState() => _PetTypeBottomSheet();
}

class _PetTypeBottomSheet extends State<PetTypeBottomSheet> {
  int _gIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          // color: k006D77,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        // height: 259.h,
        child: Column(
          children: [
            Container(
              height: 71.h,
              decoration: const BoxDecoration(
                color: ColorSelect.colorF7E641,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Center(
                child: Text(
                  'Select Puppy Type',
                  // style: kManRope_700_20_white,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20.h),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => setState(() {
                      _gIndex = 0;
                      Navigator.of(context).pop();
                      widget.onPop("Puppy");
                    }),
                    child: Container(
                      height: 44.h,
                      width: 78.w,
                      decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(5)),
                        color: _gIndex == 0 ? ColorSelect.colorF7E641 : Colors.transparent,
                      ),
                      child: Center(
                          child: Text(
                            'Puppy',
                            // style: _gIndex == 0
                            //     ? textColorF7E64114w400
                            //     : ColorSelect.colorF7E641
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  GestureDetector(
                    onTap: () => setState(() {
                      _gIndex = 1;
                      Navigator.of(context).pop();
                      widget.onPop("Dog");
                    }),
                    child: Container(
                      height: 44.h,
                      width: 78.w,
                      decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(5)),
                        color: _gIndex == 1 ? ColorSelect.colorF7E641 : Colors.transparent,
                      ),
                      child: Center(
                          child: Text(
                            'Dog',
                            // style: _gIndex == 1
                            //     ? kManRope_500_16_white
                            //     : kManRope_500_16_626A6A,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  GestureDetector(
                    onTap: () => setState(() {
                      _gIndex = 2;
                      Navigator.of(context).pop();
                      widget.onPop("Cat");
                    }),
                    child: Container(
                      height: 44.h,
                      width: 78.w,
                      decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(5)),
                        color: _gIndex == 2 ? ColorSelect.colorF7E641 : Colors.transparent,
                      ),
                      child: Center(
                          child: Text(
                            'Cat',
                            // style: _gIndex == 2
                            //     ? kManRope_500_16_white
                            //     : kManRope_500_16_626A6A,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    if (widget.puppyType == "Puppy") {
      _gIndex = 0;
    } else if (widget.puppyType == "Dog") {
      _gIndex = 1;
    } else {
      _gIndex = 2;
    }
    super.initState();
  }
}


class PetOriginBottomSheet extends StatefulWidget {
  final String puppyOrigin;
  final Function(String) onPop;
  const PetOriginBottomSheet(
      {Key? key, required this.puppyOrigin, required this.onPop})
      : super(key: key);

  @override
  State<PetOriginBottomSheet> createState() => _PetOriginBottomSheet();
}

class _PetOriginBottomSheet extends State<PetOriginBottomSheet> {
  int _gIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          // color: k006D77,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        // height: 259.h,
        child: Column(
          children: [
            Container(
              height: 71.h,
              decoration: const BoxDecoration(
                color: ColorSelect.colorF7E641,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Center(
                child: Text(
                  'Select Puppy Origin',
                  // style: kManRope_700_20_white,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20.h),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => setState(() {
                      _gIndex = 0;
                      Navigator.of(context).pop();
                      widget.onPop("American");
                    }),
                    child: Container(
                      height: 44.h,
                      width: 78.w,
                      decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(5)),
                        color: _gIndex == 0 ?
                        ColorSelect.colorF7E641 :
                        Colors.transparent,
                      ),
                      child: Center(
                          child: Text(
                            'American',
                            // style: _gIndex == 0
                            //     ? textColorF7E64114w400
                            //     : ColorSelect.colorF7E641
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  GestureDetector(
                    onTap: () => setState(() {
                      _gIndex = 1;
                      Navigator.of(context).pop();
                      widget.onPop("chinese");
                    }),
                    child: Container(
                      height: 44.h,
                      width: 78.w,
                      decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(5)),
                        color: _gIndex == 1 ? ColorSelect.colorF7E641 : Colors.transparent,
                      ),
                      child: Center(
                          child: Text(
                            'chinese',
                            // style: _gIndex == 1
                            //     ? kManRope_500_16_white
                            //     : kManRope_500_16_626A6A,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  GestureDetector(
                    onTap: () => setState(() {
                      _gIndex = 2;
                      Navigator.of(context).pop();
                      widget.onPop("Indian");
                    }),
                    child: Container(
                      height: 44.h,
                      width: 78.w,
                      decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(5)),
                        color: _gIndex == 2 ? ColorSelect.colorF7E641 : Colors.transparent,
                      ),
                      child: Center(
                          child: Text(
                            'Indian',
                            // style: _gIndex == 2
                            //     ? kManRope_500_16_white
                            //     : kManRope_500_16_626A6A,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    if (widget.puppyOrigin == "American") {
      _gIndex = 0;
    } else if (widget.puppyOrigin == "chinese") {
      _gIndex = 1;
    } else {
      _gIndex = 2;
    }
    super.initState();
  }
}


class PrivacyStatusBottomSheet extends StatefulWidget {
  final String privacyStatus;
  final Function(String) onPop;
  const PrivacyStatusBottomSheet(
      {Key? key, required this.privacyStatus, required this.onPop})
      : super(key: key);

  @override
  State<PrivacyStatusBottomSheet> createState() => _PrivacyStatusBottomSheet();
}

class _PrivacyStatusBottomSheet extends State<PrivacyStatusBottomSheet> {
  int _gIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
          // color: k006D77,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        // height: 259.h,
        child: Column(
          children: [
            Container(
              height: 71.h,
              decoration: const BoxDecoration(
                color: ColorSelect.colorF7E641,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Center(
                child: Text(
                  'Select Privacy Status',
                  // style: kManRope_700_20_white,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20.h),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => setState(() {
                      _gIndex = 0;
                      Navigator.of(context).pop();
                      widget.onPop("private");
                    }),
                    child: Container(
                      height: 44.h,
                      width: 78.w,
                      decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(5)),
                        color: _gIndex == 0 ? ColorSelect.colorF7E641 : Colors.transparent,
                      ),
                      child: Center(
                          child: Text(
                            'private',
                            // style: _gIndex == 0
                            //     ? textColorF7E64114w400
                            //     : ColorSelect.colorF7E641
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  GestureDetector(
                    onTap: () => setState(() {
                      _gIndex = 1;
                      Navigator.of(context).pop();
                      widget.onPop("friend");
                    }),
                    child: Container(
                      height: 44.h,
                      width: 78.w,
                      decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(5)),
                        color: _gIndex == 1 ? ColorSelect.colorF7E641 : Colors.transparent,
                      ),
                      child: Center(
                          child: Text(
                            'friend',
                            // style: _gIndex == 1
                            //     ? kManRope_500_16_white
                            //     : kManRope_500_16_626A6A,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  GestureDetector(
                    onTap: () => setState(() {
                      _gIndex = 2;
                      Navigator.of(context).pop();
                      widget.onPop("public");
                    }),
                    child: Container(
                      height: 44.h,
                      width: 78.w,
                      decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(5)),
                        color: _gIndex == 2 ? ColorSelect.colorF7E641 : Colors.transparent,
                      ),
                      child: Center(
                          child: Text(
                            'public',
                            // style: _gIndex == 2
                            //     ? kManRope_500_16_white
                            //     : kManRope_500_16_626A6A,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    if (widget.privacyStatus == "private") {
      _gIndex = 0;
    } else if (widget.privacyStatus == "friend") {
      _gIndex = 1;
    } else {
      _gIndex = 2;
    }
    super.initState();
  }
}

