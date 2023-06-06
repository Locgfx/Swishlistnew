import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:swishlist/api/user_apis/event_date_api.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/expanded/user_details.dart';
import 'package:swishlist/profile_page/add_date_events.dart';
import 'package:swishlist/profile_page/widgets/date_picker.dart';
import 'package:swishlist/profile_page/widgets/upcoming_row_widgets.dart';

import '../buttons/light_yellow.dart';
import '../constants/globals/loading.dart';
import '../models/date_and_events_model.dart';
import '../models/date_and_events_model.dart';

class DateAndEvents extends StatefulWidget {
  const DateAndEvents({Key? key}) : super(key: key);

  @override
  State<DateAndEvents> createState() => _DateAndEventsState();
}

class _DateAndEventsState extends State<DateAndEvents> {
  @override
  void initState() {
    getAllEvent();
    getUpcomingEvent();
    super.initState();
  }
  bool isLoading = false;
  List<Data>  event2 = [];
  EventModel? event;
  EventModel? eventUpcoming;
  
  List<Data>  eventUpcoming2 = [];
  // EventModel eM = EventModel();
  List<int> selectedItems = [];


  // EventModel? event2;

  // getAllEvent() {
  //   isLoading = true;
  //   var resp = getDateAndEventApi();
  //   resp.then((value) {
  //     if (value['status'] == true) {
  //       setState(() {
  //         event = EventModel.fromJson(value);
  //         isLoading = false;
  //       });
  //     } else {
  //       setState(() {
  //         isLoading = false;
  //       });
  //     }
  //   });
  // }

  getAllEvent() {
    isLoading = true;
    var resp = getDateAndEventApi();
    resp.then((value) {
      if(value['status'] == true) {
        setState(() {
          event = EventModel.fromJson(value);
          // for (var v in event!.data! ) {
          //   if (v.type == "all") {
          //     event2.add(v);
          //   }
          // }
          isLoading = false;
        });
      } else{
        isLoading = false;
      }
    });
  }

  getUpcomingEvent() {
    isLoading = true;
    var resp = getDateAndEventApi();
    resp.then((value) {
      if(value['status'] == true) {
        setState(() {
          eventUpcoming = EventModel.fromJson(value);
          for (var v in eventUpcoming!.data! ) {
           if (v.type == "upcoming") {
              eventUpcoming2.add(v);
           }
          }
          isLoading = false;
        });
      } else{
        isLoading = false;
      }
    });
  }

  final nameController = TextEditingController();
  final typeController = TextEditingController();
  final dateController = TextEditingController();
  String dateFormat ='';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 100),
                    child: Text(
                      "Date and Events",
                      style: AppTextStyle().textColor29292916w500,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(right: 140),
                  //   child: Text(
                  //     "60% Completed",
                  //     style: AppTextStyle().textColor70707012w400,
                  //   ),
                  // )
                ],
              ),
              selectedItems.isEmpty  ? SizedBox() : GestureDetector(
                onTap: () {
                  setState(() {
                    isLoading = true;
                  });
                  for (var v in selectedItems) {
                      deleteEventAndDate(
                          id: v.toString()
                      ).then((value) async {
                        print(selectedItems.toString());
                        if(value['status'] == true) {
                          setState(() {
                            event!.data!.removeWhere((element) => element.id == v);
                          });
                          Fluttertoast.showToast(msg: value['message']);
                        } else {
                          Fluttertoast.showToast(msg: value['message']);
                        }
                        setState(() {
                          isLoading = false;
                          selectedItems.clear();
                        },);
                      });

                  }
                },
                child: Container(
                  width: 36,
                  height: 36,
                  color: Colors.transparent,
                  child: Image.asset('assets/images/del.png'),
                ),
              )
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
      body:  isLoading ? Loading(): SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 8.h,
                  width: 360.w,
                  decoration: BoxDecoration(
                      color: ColorSelect.colorBA54DE,
                      borderRadius: BorderRadius.all(Radius.circular(0))),
                ),
                Row(
                  children: [
                    Container(
                      height: 8.h,
                      width: 216.w,
                      decoration: BoxDecoration(
                          color: ColorSelect.colorBA54DE,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(0))),
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog (
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [

                                        Text(
                                          "Enter details",
                                          style: AppTextStyle().textColor29292924w700,
                                        ),
                                        SizedBox(height: 25,),
                                        // Text(
                                        //   "Fill the details of product you own already.",
                                        //   style: AppTextStyle().textColor70707014w400,
                                        // ),

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
                                                        hintText: "Name of event",
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
                                                      showModalBottomSheet(
                                                          shape: const RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.only(
                                                                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                                                          ),
                                                          context: context,
                                                          builder: (context) => EventTypeBottomSheet(
                                                            eventType: typeController.text,
                                                            onPop: (val) {
                                                              setState(() {
                                                                typeController.text = val;
                                                              });
                                                            },
                                                          ));
                                                    },
                                                    onChanged: (v) {
                                                      setState(() {});
                                                    },
                                                    controller: typeController,
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        hintText: "Type of the Event",
                                                        hintStyle: AppTextStyle().textColor70707014w400,
                                                        suffixIconConstraints: BoxConstraints(maxHeight: 40,maxWidth: 40),
                                                        suffixIcon: Padding(
                                                          padding: const EdgeInsets.only(right: 15.0),
                                                          child: Image.asset('assets/images/down-arrow.png',height: 25,),
                                                        )
                                                    ),
                                                    keyboardType: TextInputType.text,
                                                    readOnly: true,
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
                                                    controller: dateController,
                                                    keyboardType: TextInputType.text,
                                                    readOnly: true,
                                                    onTap: ()  {
                                                      setState(() async {
                                                        DateTime? pickedDate = await showDialog(
                                                          context: context,
                                                          builder: (_) => DatePickerWidget(
                                                            onPop: (date) {
                                                              dateController.text=DateFormat.yMMMd().format(date);
                                                              dateFormat = DateFormat('yyyy-MM-dd').format(date) ;
                                                            }, maximumDate: 2030,
                                                          ),
                                                        );
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                        hintText: "Enter Date",
                                                        hintStyle: AppTextStyle().textColor70707014w400,
                                                        suffixIcon:
                                                        Image.asset("assets/images/calendarimg.png")),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 30),
                                        LightYellowButtonWithText(
                                          onTap: () {
                                            if(nameController.text.isNotEmpty &&
                                                typeController.text.isNotEmpty &&
                                                dateController.text.isNotEmpty) {
                                              postDateAndEventApi(
                                                  name: nameController.text,
                                                  date: dateFormat,
                                                  type: typeController.text,
                                                  privacy: 'public').then((value) async {
                                                if(value['status'] == true) {
                                                  Fluttertoast.showToast(msg: value['message']);
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                } else {
                                                  Fluttertoast.showToast(msg:'Please fill all details fields');
                                                }
                                              });
                                            }


                                          },
                                          backgroundColor :/*:(
                                              nameController.text.isNotEmpty &&
                                                  typeController.text.isNotEmpty ||
                                                  dateController.text.isNotEmpty
                                          ) ? MaterialStateProperty.all(ColorSelect.colorF7E641)
                                              // :*/ MaterialStateProperty.all(ColorSelect.colorF7E641),
                                          textStyleColor: /*nameController.text.isNotEmpty &&
                                              typeController.text.isNotEmpty ||
                                              dateController.text.isNotEmpty ?*/
                                          Colors.black, /*:
                                          ColorSelect.colorB5B07A,*/
                                          title: 'save',
                                        ),

                                        SizedBox(height: 24)
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                      // Navigator.push(
                      //     context, MaterialPageRoute(builder: (_) =>
                      //     AddDateAndEvents()));

                    },
                    child: Text(
                      '+ Add Events',
                      style: AppTextStyle().textColorBA54DE14w500,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Upcoming",
                    style: AppTextStyle().textColor29292914w600,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  eventUpcoming2.isEmpty ?
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline,color: Colors.black,size: 80,),
                        // Image.asset("assets/images/delivery.png",height: 100,),
                        SizedBox(height: 5),
                        Text('No Activities Found',
                          style: AppTextStyle().textColor29292914w500,)
                      ],
                    ),
                  ) :
                  ListView.separated(
                    padding: EdgeInsets.only(bottom: 30),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: eventUpcoming2.length,
                    // itemCount: 6,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  eventUpcoming2[i].name.toString(),
                                  style:/*selectedItems.contains(eventUpcoming2[i].id!) ?
                                  AppTextStyle().textColorD5574514w500:*/
                                  AppTextStyle().textColor70707014w400,
                                ),
                                Spacer(),
                                Text(
                                  eventUpcoming2[i].date.toString(),
                                  style: /*selectedItems.contains(eventUpcoming2[i].id!) ?
                                  AppTextStyle().textColorD5574514w500:*/
                                  AppTextStyle().textColor29292914w400,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }, separatorBuilder: (BuildContext context, int index) => SizedBox(height: 16,),
                  ),
                 /* UpcomingRowWidget(eventDate: event!,),*/

            //       Row(
            //         children: [
            //           GestureDetector(
            //             onTap: () {
            //               showDialog(
            //                 context: context,
            //                 builder: (BuildContext context) {
            //                   return AlertDialog(
            //                     insetPadding: EdgeInsets.only(left: 20, right: 20),
            //                     shape: RoundedRectangleBorder(
            //                       borderRadius: BorderRadius.circular(12),
            //                     ),
            //                     elevation: 0,
            //                     backgroundColor: Colors.white,
            //                     content: SizedBox(
            //                       width: 1.sw,
            //                       child: SingleChildScrollView(
            //                         child: Column(
            //                           crossAxisAlignment: CrossAxisAlignment.start,
            //                           children: [
            //                             Column(
            //                               crossAxisAlignment: CrossAxisAlignment.start,
            //                               children: [
            //
            //                                 Text(
            //                                   "Enter details",
            //                                   style: AppTextStyle().textColor29292924w700,
            //                                 ),
            //                                 SizedBox(height: 25,),
            //                                 // Text(
            //                                 //   "Fill the details of product you own already.",
            //                                 //   style: AppTextStyle().textColor70707014w400,
            //                                 // ),
            //                                 Container(
            //                                   width: 328.w,
            //                                   height: 52.h,
            //                                   decoration: BoxDecoration(
            //                                     borderRadius: BorderRadius.circular(8),
            //                                     color: ColorSelect.colorEDEDF1,
            //                                   ),
            //                                   child: Padding(
            //                                     padding: const EdgeInsets.only(left: 12),
            //                                     child: Row(
            //                                       children: [
            //                                         Expanded(
            //                                           child: TextFormField(
            //                                             onChanged: (v) {
            //                                               setState(() {});
            //                                             },
            //                                             controller: nameController,
            //                                             keyboardType: TextInputType.text,
            //                                             decoration: InputDecoration(
            //                                                 border: InputBorder.none,
            //                                                 hintText: "Name of event",
            //                                                 hintStyle: AppTextStyle().textColor70707014w400
            //                                             ),
            //                                           ),
            //                                         ),
            //                                       ],
            //                                     ),
            //                                   ),
            //                                 ),
            //                                 SizedBox(height: 12),
            //                                 Container(
            //                                   width: 328.w,
            //                                   height: 52.h,
            //                                   decoration: BoxDecoration(
            //                                       borderRadius: BorderRadius.circular(8),
            //                                       color: ColorSelect.colorEDEDF1
            //                                   ),
            //                                   child: Padding(
            //                                     padding: const EdgeInsets.only(left: 12),
            //                                     child: Row(
            //                                       children: [
            //                                         Expanded(
            //                                           child: TextFormField(
            //                                             onTap:() {
            //                                               showModalBottomSheet(
            //                                                   shape: const RoundedRectangleBorder(
            //                                                     borderRadius: BorderRadius.only(
            //                                                         topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            //                                                   ),
            //                                                   context: context,
            //                                                   builder: (context) => EventTypeBottomSheet(
            //                                                     eventType: typeController.text,
            //                                                     onPop: (val) {
            //                                                       setState(() {
            //                                                         typeController.text = val;
            //                                                       });
            //                                                     },
            //                                                   ));
            //
            //                                             },
            //                                             onChanged: (v) {
            //                                               setState(() {});
            //                                             },
            //                                             controller: typeController,
            //                                             decoration: InputDecoration(
            //                                                 border: InputBorder.none,
            //                                                 hintText: "Type of the Event",
            //                                                 hintStyle: AppTextStyle().textColor70707014w400,
            //                                                 suffixIconConstraints: BoxConstraints(maxHeight: 40,maxWidth: 40),
            //                                                 suffixIcon: Padding(
            //                                                   padding: const EdgeInsets.only(right: 15.0),
            //                                                   child: Image.asset('assets/images/down-arrow.png',height: 25,),
            //                                                 )
            //                                             ),
            //                                             keyboardType: TextInputType.text,
            //                                             readOnly: true,
            //                                           ),
            //                                         ),
            //                                       ],
            //                                     ),
            //                                   ),
            //                                 ),
            //                                 SizedBox(height: 12),
            //                                 Container(
            //                                   width: 328.w,
            //                                   height: 52.h,
            //                                   decoration: BoxDecoration(
            //                                       borderRadius: BorderRadius.circular(8),
            //                                       color: ColorSelect.colorEDEDF1
            //                                   ),
            //                                   child: Padding(
            //                                     padding: const EdgeInsets.only(left: 12),
            //                                     child: Row(
            //                                       children: [
            //                                         Expanded(
            //                                           child: TextFormField(
            //                                             onChanged: (v) {
            //                                               setState(() {
            //
            //                                               });
            //                                             },
            //                                             controller: dateController,
            //                                             keyboardType: TextInputType.text,
            //                                             readOnly: true,
            //                                             onTap: ()  {
            //                                               setState(() async {
            //                                                 DateTime? pickedDate = await showDialog(
            //                                                   context: context,
            //                                                   builder: (_) => DatePickerWidget(onPop: (date) {
            //                                                     dateController.text=DateFormat.yMMMd().format(date);
            //                                                     dateFormat = DateFormat('yyyy-MM-dd').format(date) ;
            //                                                   },
            //                                                   ),
            //                                                 );
            //                                               });
            //                                               //
            //                                               // DateTime? pickedDate = await showDatePicker(
            //                                               //     context: context,
            //                                               //     initialDate: DateTime.now(),
            //                                               //     firstDate: DateTime(1950),
            //                                               //     //DateTime.now() - not to allow to choose before today.
            //                                               //     lastDate: DateTime(2100));
            //                                               //
            //                                               // if (pickedDate != null) {
            //                                               //   print(
            //                                               //       pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
            //                                               //   String formattedDate =
            //                                               //   DateFormat('yyyy-MM-dd').format(pickedDate);
            //                                               //   print(
            //                                               //       formattedDate); //formatted date output using intl package =>  2021-03-16
            //                                               //   setState(() {
            //                                               //     dateController.text =
            //                                               //         formattedDate; //set output date to TextField value.
            //                                               //   });
            //                                               // } else {}
            //                                             },
            //                                             decoration: InputDecoration(
            //                                                 border: InputBorder.none,
            //                                                 hintText: "Date Purchased",
            //                                                 hintStyle: AppTextStyle().textColor70707014w400,
            //                                                 suffixIcon:
            //                                                 Image.asset("assets/images/calendarimg.png")),
            //                                           ),
            //                                         ),
            //                                       ],
            //                                     ),
            //                                   ),
            //                                 ),
            //
            //                                 SizedBox(height: 30),
            //                                 // event!.data.toString() =='' ?
            //                                 // LightYellowButtonWithText(
            //                                 //   onTap: () {
            //                                 //     if(nameController.text.isNotEmpty &&
            //                                 //         typeController.text.isNotEmpty &&
            //                                 //         dateController.text.isNotEmpty) {
            //                                 //       postDateAndEventApi(
            //                                 //           name: nameController.text,
            //                                 //           date: dateFormat,
            //                                 //           type: typeController.text,
            //                                 //           privacy: 'public').then((value) async {
            //                                 //         if(value['status'] == true) {
            //                                 //           Fluttertoast.showToast(msg: value['message']);
            //                                 //         } else {
            //                                 //           Fluttertoast.showToast(msg: value['message']);
            //                                 //         }
            //                                 //       });
            //                                 //     }
            //                                 //
            //                                 //
            //                                 //   },
            //                                 //   backgroundColor:(
            //                                 //       nameController.text.isNotEmpty &&
            //                                 //           typeController.text.isNotEmpty ||
            //                                 //           dateController.text.isNotEmpty
            //                                 //   ) ? MaterialStateProperty.all(ColorSelect.colorF7E641)
            //                                 //       : MaterialStateProperty.all(ColorSelect.colorFCF5B6),
            //                                 //   textStyleColor: nameController.text.isNotEmpty &&
            //                                 //       typeController.text.isNotEmpty ||
            //                                 //       dateController.text.isNotEmpty ?
            //                                 //   Colors.black :
            //                                 //   ColorSelect.colorB5B07A,
            //                                 //   title: 'Add',
            //                                 // ):
            //                                 LightYellowButtonWithText(
            //                                   onTap: () {
            //                                     if(nameController.text.isNotEmpty &&
            //                                         typeController.text.isNotEmpty &&
            //                                         dateController.text.isNotEmpty) {
            //                                       postDateAndEventApi(
            //                                           name: nameController.text,
            //                                           date: dateFormat,
            //                                           type: typeController.text,
            //                                           privacy: 'public').then((value) async {
            //                                         if(value['status'] == true) {
            //                                           Fluttertoast.showToast(msg: value['message']);
            //                                           Navigator.pop(context);
            //                                         } else {
            //                                           Fluttertoast.showToast(msg:'Please fill all details fields');
            //                                         }
            //                                       });
            //                                     }
            //
            //
            //                                   },
            //                                   backgroundColor:(
            //                                       nameController.text.isNotEmpty &&
            //                                           typeController.text.isNotEmpty ||
            //                                           dateController.text.isNotEmpty
            //                                   ) ? MaterialStateProperty.all(ColorSelect.colorF7E641)
            //                                       : MaterialStateProperty.all(ColorSelect.colorFCF5B6),
            //                                   textStyleColor: nameController.text.isNotEmpty &&
            //                                       typeController.text.isNotEmpty ||
            //                                       dateController.text.isNotEmpty ?
            //                                   Colors.black :
            //                                   ColorSelect.colorB5B07A,
            //                                   title: 'save',
            //                                 ),
            //
            //                                 SizedBox(height: 24)
            //                               ],
            //                             ),
            //
            //                           ],
            //                         ),
            //                       ),
            //                     ),
            //                   );
            //                 },
            //               );
            // },
            //             child: Text(
            //               "+ Add more",
            //               style: AppTextStyle().textColorBA54DE14w500,
            //             ),
            //           ),
            //           Spacer(),
            //           Image.asset("assets/images/Vector175.png"),
            //         ],
            //       ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Text(
                    "All",
                    style: AppTextStyle().textColor29292914w600,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  event!.data!.isEmpty ?
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline,color: Colors.black,size: 80,),
                        // Image.asset("assets/images/delivery.png",height: 100,),
                        SizedBox(height: 5),
                        Text('No Activities Found',
                          style: AppTextStyle().textColor29292914w500,),
                        SizedBox(height: 30),
                      ],
                    ),
                  ) :
                  ListView.separated(
                    padding: EdgeInsets.only(bottom: 30),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: event!.data!.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                        onLongPress: () {
                          if (selectedItems.isEmpty) {
                            setState(() {
                              selectedItems.add(event!.data![i].id!);
                            });
                          }
                        },
                        onTap: () {
                          if (selectedItems.contains(event!.data![i].id!)) {
                            setState(() {
                              selectedItems.remove(event!.data![i].id!);
                            });
                          } else {
                            setState(() {
                              selectedItems.add(event!.data![i].id!);
                            });
                          }
                        },
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  event!.data![i].name.toString(),
                                  style: selectedItems.contains(event!.data![i].id!) ?
                                  AppTextStyle().textColorD5574514w500:
                                  AppTextStyle().textColor70707014w400,
                                ),
                                Spacer(),
                                Text(
                                  event!.data![i].date.toString(),
                                  style: selectedItems.contains(event!.data![i].id!) ?
                                  AppTextStyle().textColorD5574514w500:
                                  AppTextStyle().textColor29292914w400,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }, separatorBuilder: (BuildContext context, int index) => SizedBox(height: 16,),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
