import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swishlist/api/address_api.dart';
import 'package:swishlist/expanded/user_all_details.dart';

import '../../buttons/light_yellow.dart';
import '../../constants/color.dart';
import '../../constants/decoration.dart';
import '../../constants/globals/loading.dart';
import '../../models/address_model.dart';
import '../../models/login_models.dart';
import '../../profile_page/favourite_add_widgets/car_edit_dialog.dart';


class ManageAddress extends StatefulWidget {

  final LoginResponse response;
  const ManageAddress({super.key,
  required this.response});


  @override
  State<ManageAddress> createState() => _ManageAddressState();
}




class _ManageAddressState extends State<ManageAddress> {
  @override

  void initState() {
   getAddress();
   fields();
    super.initState();
  }

  final streetController = TextEditingController();
  final houseController = TextEditingController();

  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final codeController = TextEditingController();
  final countryControlller = TextEditingController();

  bool isLoading = false;

  List<AddressModel> _addressList = [];


  void fields() {
    if (_addressList.isNotEmpty && _addressList[0] != null){
      streetController.text = _addressList[0].streetTwo ?? "";
      houseController.text = _addressList[0].streetOne ?? "";
      cityController.text = _addressList[0].city ?? "";
      stateController.text = _addressList[0].state ?? "";
      codeController.text = _addressList[0].zip ?? "";
      countryControlller.text = _addressList[0].country ?? "";
    }
    else{
      streetController.text = "";
      houseController.text = "";
      cityController.text = "";
      stateController.text = "";
      codeController.text = "";
      countryControlller.text  = "";
    }

  }



  getAddress(){
    isLoading = true;
    var resp = getAddressApi();
    resp.then((value) {
      _addressList.clear();
      if(value['error'] == false){
        setState(() {
          for(var v in value['data']){
            _addressList.add(AddressModel.fromJson(v));
          }
          isLoading = false;
          print(_addressList);
        });


        fields();
      }
      else{
setState(() {
  isLoading = false;
});
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 100),
                child: Text(
                  "Address",
                  style: AppTextStyle().textColor29292916w500,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),

            ],
          ),
          leadingWidth: 40,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: SvgPicture.asset(
                "assets/icons/arrowback.svg",
              ),
            ),
          )),
      backgroundColor: Colors.white,
      body: isLoading
          ? Loading()
      :
      Column(
     crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Stack(
            children: [
              Container(
                height: 8.h,
                width: 360.w,
                decoration: BoxDecoration(
                    color: Colors.cyanAccent.withOpacity(0.28),

                    //Color(0xffC09B3D).withOpacity(0.28),
                    borderRadius:
                    BorderRadius.all(Radius.circular(12))),
              ),
              Row(
                children: [
                  Container(
                    height: 8.h,
                    width: 360.w,
                    decoration: BoxDecoration(
                      color:
                      Colors.cyanAccent
                      //ColorSelect.colorC09B3D,
                    ),
                  ),
                ],
              )
            ],
          ),

          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),

                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                    _addressList.isEmpty ?
                        1:
                    _addressList.length,
                    itemBuilder: (BuildContext ctx, i) {
                      return



                        Column(
                          children: [
                            SizedBox(
                              height: 20.h,
                            ),

                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return NameEditDialogWidget(
                                      title: 'House No',
                                      addTextField: TextFormField(
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(25),
                                        ],
                                        onChanged: (v) {

                                        },
                                        onEditingComplete: () {

                                        },
                                        controller: houseController,
                                        cursorColor: ColorSelect.colorF7E641,
                                        decoration:
                                        AppTFDecoration(hint: 'House no')
                                            .decoration(),
                                        //keyboardType: TextInputType.phone,
                                      ),
                                    );
                                  },
                                );
                              },
                              child: _addressList.isNotEmpty  ?
                              Row(
                                children: [
                                  Text(
                                    "House No",
                                    style: AppTextStyle().textColor70707014w400,
                                  ),
                                  Spacer(),
                                  houseController.text.isEmpty
                                      ?
                                  Text(
                                    _addressList[i].streetOne.toString() ==
                                        '' ||
                                        _addressList[i].streetOne == null
                                        ?
                                    '+ Add'
                                        : _addressList[i].streetOne
                                        .toString(),
                                    style: _addressList[i].streetOne == ''
                                        ? AppTextStyle().textColorD5574514w500
                                        : AppTextStyle()
                                        .textColor29292914w400,
                                  )
                                      : Text(
                                    houseController.text,
                                    style:
                                    AppTextStyle().textColor29292914w400,
                                  ),

                                ],
                              ) :

                              Row(
                                children: [
                                  Text(
                                    "House No",
                                    style: AppTextStyle().textColor70707014w400,
                                  ),
                                  Spacer(),
                                  houseController.text.isEmpty
                                      ?
                                  Text(

                                    '+ Add'
                                      ,
                                    style:AppTextStyle()
                                        .textColor29292914w400,
                                  )
                                      : Text(
                                    houseController.text,
                                    style:
                                    AppTextStyle().textColor29292914w400,
                                  ),

                                ],
                              )


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
                                    return NameEditDialogWidget(
                                      title: 'Street',
                                      addTextField: TextFormField(
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(25),
                                        ],
                                        onChanged: (v) {
                                          setState(() {

                                          });
                                        },
                                        onEditingComplete: () {

                                        },
                                        controller: streetController,
                                        cursorColor: ColorSelect.colorF7E641,
                                        decoration:
                                        AppTFDecoration(hint: 'Street')
                                            .decoration(),
                                        //keyboardType: TextInputType.phone,
                                      ),
                                    );
                                  },
                                );
                              },
                              child:  _addressList.isNotEmpty ?
                              Row(
                                children: [
                                  Text(
                                    "Street",
                                    style: AppTextStyle().textColor70707014w400,
                                  ),
                                  Spacer(),
                                  streetController.text.isEmpty
                                      ?
                                  Text(
                                    _addressList[i].streetTwo.toString() ==
                                        '' ||
                                        _addressList[i].streetTwo == null
                                        ?
                                    '+ Add'
                                        : _addressList[i].streetTwo
                                        .toString(),
                                    style: _addressList[i].streetTwo == ''
                                        ? AppTextStyle().textColorD5574514w500
                                        : AppTextStyle()
                                        .textColor29292914w400,
                                  )
                                      : Text(
                                    streetController.text,
                                    style:
                                    AppTextStyle().textColor29292914w400,
                                  ),

                                ],
                              )
                                  :

                              Row(
                                children: [
                                  Text(
                                    "Street",
                                    style: AppTextStyle().textColor70707014w400,
                                  ),
                                  Spacer(),
                                  streetController.text.isEmpty
                                      ?
                                  Text(

                                    '+ Add',

                                    style:
                                    AppTextStyle()
                                        .textColor29292914w400,
                                  )
                                      : Text(
                                    streetController.text,
                                    style:
                                    AppTextStyle().textColor29292914w400,
                                  ),

                                ],
                              )

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
                                    return NameEditDialogWidget(
                                      title: 'City',
                                      addTextField: TextFormField(
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(25),
                                        ],
                                        onChanged: (v) {
                                          setState(() {

                                          });
                                        },
                                        onEditingComplete: () {

                                        },
                                        controller: cityController,
                                        cursorColor: ColorSelect.colorF7E641,
                                        decoration:
                                        AppTFDecoration(hint: 'City')
                                            .decoration(),
                                        //keyboardType: TextInputType.phone,
                                      ),
                                    );
                                  },
                                );
                              },
                              child:
                              _addressList.isNotEmpty ?
                              Row(
                                children: [
                                  Text(
                                    "City",
                                    style: AppTextStyle().textColor70707014w400,
                                  ),
                                  Spacer(),
                                  cityController.text.isEmpty
                                      ?
                                  Text(
                                    _addressList[i].city.toString() ==
                                        '' ||
                                        _addressList[i].city == null
                                        ?
                                    '+ Add'
                                        : _addressList[i].city
                                        .toString(),
                                    style: _addressList[i].city == ''
                                        ? AppTextStyle().textColorD5574514w500
                                        : AppTextStyle()
                                        .textColor29292914w400,
                                  )
                                      : Text(
                                    cityController.text,
                                    style:
                                    AppTextStyle().textColor29292914w400,
                                  ),

                                ],
                              )

                                  :
                              Row(
                                children: [
                                  Text(
                                    "City",
                                    style: AppTextStyle().textColor70707014w400,
                                  ),
                                  Spacer(),
                                  cityController.text.isEmpty
                                      ?
                                  Text(

                                    '+ Add',

                                    style: AppTextStyle()
                                        .textColor29292914w400,
                                  )
                                      : Text(
                                    cityController.text,
                                    style:
                                    AppTextStyle().textColor29292914w400,
                                  ),

                                ],
                              )

                            ),
                            //
                            //
                            SizedBox(
                              height: 20.h,
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return NameEditDialogWidget(
                                      title: 'State',
                                      addTextField: TextFormField(
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(25),
                                        ],
                                        onChanged: (v) {
                                          setState(() {

                                          });
                                        },
                                        onEditingComplete: () {

                                        },
                                        controller: stateController,
                                        cursorColor: ColorSelect.colorF7E641,
                                        decoration:
                                        AppTFDecoration(hint: 'State')
                                            .decoration(),
                                        //keyboardType: TextInputType.phone,
                                      ),
                                    );
                                  },
                                );
                              },
                              child: _addressList.isNotEmpty ?
                               Row(
                                children: [
                                  Text(
                                    "State",
                                    style: AppTextStyle().textColor70707014w400,
                                  ),
                                  Spacer(),
                                  stateController.text.isEmpty
                                      ?
                                  Text(
                                    _addressList[0].state.toString() ==
                                        '' ||
                                        _addressList[0].state == null
                                        ?
                                    '+ Add'
                                        : _addressList[0].state
                                        .toString(),
                                    style: _addressList[0].state == ''
                                        ? AppTextStyle().textColorD5574514w500
                                        : AppTextStyle()
                                        .textColor29292914w400,
                                  )
                                      : Text(
                                    stateController.text,
                                    style:
                                    AppTextStyle().textColor29292914w400,
                                  ),

                                ],
                              )
                                  :

                              Row(
                                children: [
                                  Text(
                                    "State",
                                    style: AppTextStyle().textColor70707014w400,
                                  ),
                                  Spacer(),
                                  stateController.text.isEmpty
                                      ?
                                  Text(

                                    '+ Add',

                                    style:  AppTextStyle()
                                        .textColor29292914w400,
                                  )
                                      : Text(
                                    stateController.text,
                                    style:
                                    AppTextStyle().textColor29292914w400,
                                  ),

                                ],
                              )
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
                                    return NameEditDialogWidget(
                                      title: 'Zip Code',
                                      addTextField: TextFormField(
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(25),
                                        ],
                                        onChanged: (v) {
                                          setState(() {

                                          });
                                        },
                                        onEditingComplete: () {

                                        },
                                        controller: codeController,
                                        cursorColor: ColorSelect.colorF7E641,
                                        decoration:
                                        AppTFDecoration(hint: 'Code')
                                            .decoration(),
                                        //keyboardType: TextInputType.phone,
                                      ),
                                    );
                                  },
                                );
                              },
                              child:  _addressList.isNotEmpty ?
                              Row(
                                children: [
                                  Text(
                                    "Zip Code",
                                    style: AppTextStyle().textColor70707014w400,
                                  ),
                                  Spacer(),
                                  codeController.text.isEmpty
                                      ?
                                  Text(
                                    _addressList[0].zip.toString() ==
                                        '' ||
                                        _addressList[0].zip == null
                                        ?
                                    '+ Add'
                                        : _addressList[0].zip
                                        .toString(),
                                    style: _addressList[0].zip == ''
                                        ? AppTextStyle().textColorD5574514w500
                                        : AppTextStyle()
                                        .textColor29292914w400,
                                  )
                                      : Text(
                                    codeController.text,
                                    style:
                                    AppTextStyle().textColor29292914w400,
                                  ),

                                ],
                              )
                                  :
                              Row(
                                children: [
                                  Text(
                                    "Zip Code",
                                    style: AppTextStyle().textColor70707014w400,
                                  ),
                                  Spacer(),
                                  codeController.text.isEmpty
                                      ?
                                  Text(

                                    '+ Add',

                                    style: AppTextStyle()
                                        .textColor29292914w400,
                                  )
                                      : Text(
                                    codeController.text,
                                    style:
                                    AppTextStyle().textColor29292914w400,
                                  ),

                                ],
                              )

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
                                    return NameEditDialogWidget(
                                      title: 'Country',
                                      addTextField: TextFormField(
                                        keyboardType: TextInputType.text,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(25),
                                        ],
                                        onChanged: (v) {
                                          setState(() {

                                          });
                                        },
                                        onEditingComplete: () {

                                        },
                                        controller: countryControlller,
                                        cursorColor: ColorSelect.colorF7E641,
                                        decoration:
                                        AppTFDecoration(hint: 'Country')
                                            .decoration(),

                                      ),
                                    );
                                  },
                                );
                              },
                              child: _addressList.isNotEmpty ?
                              Row(
                                children: [
                                  Text(
                                    "Country",
                                    style: AppTextStyle().textColor70707014w400,
                                  ),
                                  Spacer(),
                                  countryControlller.text.isEmpty
                                      ?
                                  Text(
                                    _addressList[0].country.toString() ==
                                        '' ||
                                        _addressList[0].country == null
                                        ?
                                    '+ Add'
                                        : _addressList[0].country
                                        .toString(),
                                    style: _addressList[0].country == ''
                                        ? AppTextStyle().textColorD5574514w500
                                        : AppTextStyle()
                                        .textColor29292914w400,
                                  )
                                      : Text(
                                    countryControlller.text,
                                    style:
                                    AppTextStyle().textColor29292914w400,
                                  ),

                                ],
                              )
                                  :
                              Row(
                                children: [
                                  Text(
                                    "Country",
                                    style: AppTextStyle().textColor70707014w400,
                                  ),
                                  Spacer(),
                                  countryControlller.text.isEmpty
                                      ?
                                  Text(

                                    '+ Add',

                                    style:  AppTextStyle()
                                        .textColor29292914w400,
                                  )
                                      : Text(
                                    countryControlller.text,
                                    style:
                                    AppTextStyle().textColor29292914w400,
                                  ),

                                ],
                              )

                            ),


                            //SizedBox(height: 300,),
//SizedBox(height: MediaQuery.of(context).size.height,),


                          ],
                        );
                    },
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          _addressList.isEmpty  ?
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 16),
            child: LightYellowButtonWithText(
                size: 15,
                backgroundColor: MaterialStateProperty.all(
                    ColorSelect.colorF7E641),
                textStyleColor: Colors.black,
                onTap: () {
                  postAddressApi(houseNo: houseController.text,
                      street: streetController.text,
                      city: cityController.text,
                      state: stateController.text,
                      zip: codeController.text,
                      country: countryControlller.text).then((value) {
                    if (value['error'] == false) {
                      Fluttertoast.showToast(msg: value['message']);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) =>
                              UserAllDetails(
                                  response: widget.response)));
                    }
                  });
                },
                title: 'Add'),
          ) :
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 24),
            child: LightYellowButtonWithText(
                size: 15,
                backgroundColor: MaterialStateProperty.all(
                    ColorSelect.colorF7E641),
                textStyleColor: Colors.black,
                onTap: () {


                  updateAddressApi(
                      id: _addressList[0].id.toString(),
                      houseNo: houseController.text,
                      street: streetController.text,
                      city: cityController.text,
                      state: stateController.text,
                      zip: codeController.text,
                      country: countryControlller.text).then((value) {
                    if (value['error'] == false) {
                      Fluttertoast.showToast(msg: value['message']);
                      Navigator.pop(context);
                    } else {
                      Fluttertoast.showToast(msg: value['message']);
                    }
                  });
                },
                title: 'Update'),
          )

        ],
      ),

    );
  }
}









/*
Column(
children: [
Row(
children: [
Text(
"House No",
style: AppTextStyle().textColor70707014w400,
),
Spacer(),
houseController.text.isEmpty
?
Text(
_addressList[0].streetOne.toString() ==
'' ||
_addressList[0].streetOne == null
?
'+ Add'
    : _addressList[
0
].streetOne
    .toString(),
style: _addressList[0].streetOne == ''
? AppTextStyle().textColorD5574514w500
    : AppTextStyle()
    .textColor29292914w400,
)
    : Text(
houseController.text,
style:
AppTextStyle().textColor29292914w400,
),

],
),
Row(
children: [
Text(
"House No",
style: AppTextStyle().textColor70707014w400,
),
Spacer(),
houseController.text.isEmpty
?
Text(
_addressList[0].streetTwo.toString() ==
'' ||
_addressList[0].streetTwo == null
?
'+ Add'
    : _addressList[
0
].streetTwo
    .toString(),
style: _addressList[0].streetTwo == ''
? AppTextStyle().textColorD5574514w500
    : AppTextStyle()
    .textColor29292914w400,
)
    : Text(
houseController.text,
style:
AppTextStyle().textColor29292914w400,
),

],
),
Row(
children: [
Text(
"House No",
style: AppTextStyle().textColor70707014w400,
),
Spacer(),
houseController.text.isEmpty
?
Text(
_addressList[0].city.toString() ==
'' ||
_addressList[0].city == null
?
'+ Add'
    : _addressList[
0
].city
    .toString(),
style: _addressList[0].city == ''
? AppTextStyle().textColorD5574514w500
    : AppTextStyle()
    .textColor29292914w400,
)
    : Text(
houseController.text,
style:
AppTextStyle().textColor29292914w400,
),

],
),
Row(
children: [
Text(
"House No",
style: AppTextStyle().textColor70707014w400,
),
Spacer(),
houseController.text.isEmpty
?
Text(
_addressList[0].state.toString() ==
'' ||
_addressList[0].state == null
?
'+ Add'
    : _addressList[
0
].state
    .toString(),
style: _addressList[0].state == ''
? AppTextStyle().textColorD5574514w500
    : AppTextStyle()
    .textColor29292914w400,
)
    : Text(
houseController.text,
style:
AppTextStyle().textColor29292914w400,
),

],
),
Row(
children: [
Text(
"House No",
style: AppTextStyle().textColor70707014w400,
),
Spacer(),
houseController.text.isEmpty
?
Text(
_addressList[0].zip.toString() ==
'' ||
_addressList[0].zip == null
?
'+ Add'
    : _addressList[
0
].zip
    .toString(),
style: _addressList[0].zip == ''
? AppTextStyle().textColorD5574514w500
    : AppTextStyle()
    .textColor29292914w400,
)
    : Text(
houseController.text,
style:
AppTextStyle().textColor29292914w400,
),

],
),
Row(
children: [
Text(
"House No",
style: AppTextStyle().textColor70707014w400,
),
Spacer(),
houseController.text.isEmpty
?
Text(
_addressList[0].country.toString() ==
'' ||
_addressList[0].country == null
?
'+ Add'
    : _addressList[
0
].country
    .toString(),
style: _addressList[0].country == ''
? AppTextStyle().textColorD5574514w500
    : AppTextStyle()
    .textColor29292914w400,
)
    : Text(
houseController.text,
style:
AppTextStyle().textColor29292914w400,
),

],
),
],
);
*/
