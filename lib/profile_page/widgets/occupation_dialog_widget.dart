import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/constants/decoration.dart';

import '../privacy.dart';

class OccupationDialogWidget extends StatelessWidget {
  const OccupationDialogWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        insetPadding: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        contentPadding: EdgeInsets.zero,
        content: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: 1.sw,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Occupation',
                    style: AppTextStyle().textColor29292914w500,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    cursorColor: ColorSelect.colorF7E641,
                    decoration:
                        AppTFDecoration(hint: 'UI/UX Designer').decoration(),
                    //keyboardType: TextInputType.phone,
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
                      //padding: const EdgeInsets.only(top: 20),
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
          ),
        ));
  }
}
