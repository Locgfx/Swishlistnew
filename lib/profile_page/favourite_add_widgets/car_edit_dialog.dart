import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color.dart';

class NameEditDialogWidget extends StatelessWidget {
  final String title;
  final Widget addTextField;
  const NameEditDialogWidget({
    Key? key,
    required this.title,
    required this.addTextField,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
              Text(
                // 'Name',
                title,
                style: AppTextStyle().textColor29292914w500,
              ),
              SizedBox(height: 10.h),
              addTextField,
              // TextFormField(
              //   cursorColor: ColorSelect.colorF7E641,
              //   decoration: AppTFDecoration(hint: 'Harry Wilson').decoration(),
              //   //keyboardType: TextInputType.phone,
              // ),
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
              //     padding: const EdgeInsets.only(top: 20),
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
      ),
    );
  }
}
