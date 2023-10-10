import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swishlist/buttons/yellow_button.dart';
import 'package:swishlist/constants/color.dart';

class DatePickerWidget extends StatefulWidget {
  final int maximumDate;
  final Function(DateTime) onPop;
  const DatePickerWidget({
    Key? key,
    required this.onPop,
    required this.maximumDate,
  }) : super(key: key);

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime selectedDate = DateTime.now();
  // DateTime _selectedDate;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      insetPadding: EdgeInsets.all(16),
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: 1.sw,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: 1.sw,
                height: 200,
                child: CupertinoDatePicker(
                  dateOrder: DatePickerDateOrder.dmy,
                  mode: CupertinoDatePickerMode.date,
                  minimumYear: 1950,
                  maximumYear: widget.maximumDate,
                  onDateTimeChanged: (val) {
                    setState(() {
                      selectedDate = val;
                      widget.onPop(selectedDate);
                    });
                    // tempPickedDate = dateTime
                  },
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 80,
                    child: YellowButtonWithText(
                      size: 16,
                      backgroundColor:
                          MaterialStateProperty.all(ColorSelect.colorF7E641),
                      textStyleColor: ColorSelect.color292929,
                      onTap: () {
                        setState(() {
                          selectedDate;
                        });
                        Navigator.pop(context);
                        print(selectedDate);
                      },
                      title: 'OK',
                    ),
                  ),
                  // YellowButtonWithText(
                  //   size: 16,
                  //   backgroundColor:
                  //       MaterialStateProperty.all(ColorSelect.colorF7E641),
                  //   textStyleColor: ColorSelect.color292929,
                  //   onTap: () {
                  //     setState(() {
                  //       selectedDate;
                  //     });
                  //     Navigator.pop(context);
                  //     print(selectedDate);
                  //   },
                  //   title: 'Cancel',
                  // )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

//
// class DatePick extends StatefulWidget {
//   const DatePick({Key? key}) : super(key: key);
//
//   @override
//   State<DatePick> createState() => _DatePickState();
// }
//
// class _DatePickState extends State<DatePick> {
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: Colors.transparent,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       insetPadding: EdgeInsets.all(16),
//       contentPadding: EdgeInsets.zero,
//       content: Container(
//         width: 1.sw,
//         padding: EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(
//                 width: 1.sw,
//                 height: 200,
//                 child: CupertinoDatePicker(
//                   dateOrder: DatePickerDateOrder.ymd,
//                   mode: CupertinoDatePickerMode.date,
//                   minimumYear: 1950,
//                   maximumYear: widget.maximumDate,
//                   onDateTimeChanged: (val) {
//                     setState(() {
//                       selectedDate = val;
//                       widget.onPop(selectedDate);
//                     });
//                     // tempPickedDate = dateTime
//                   },
//                 ),
//               ),
//               SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   YellowButtonWithText(
//                     size: 16,
//                     backgroundColor:
//                     MaterialStateProperty.all(ColorSelect.colorF7E641),
//                     textStyleColor: ColorSelect.color292929,
//                     onTap: () {
//                       setState(() {
//                         selectedDate;
//                       });
//                       Navigator.pop(context);
//                       print(selectedDate);
//                     },
//                     title: 'OK',
//                   ),
//                   YellowButtonWithText(
//                     size: 16,
//                     backgroundColor:
//                     MaterialStateProperty.all(ColorSelect.colorF7E641),
//                     textStyleColor: ColorSelect.color292929,
//                     onTap: () {
//                       setState(() {
//                         selectedDate;
//                       });
//                       Navigator.pop(context);
//                       print(selectedDate);
//                     },
//                     title: 'Cancel',
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
