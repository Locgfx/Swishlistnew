import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/constants/decoration.dart';
import '../privacy.dart';

class HomeAddressDialogWidget extends StatelessWidget {
  const HomeAddressDialogWidget({
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
      content: SizedBox(
        width: 1.sw,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Home address',
                style: AppTextStyle().textColor29292914w500,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'House No',
                          style: AppTextStyle().textColor70707012w400,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          decoration:
                              AppTFDecoration(hint: '2850').decoration(),
                          //keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Street',
                          style: AppTextStyle().textColor70707012w400,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          decoration: AppTFDecoration(hint: 'Roger dale Rd')
                              .decoration(),
                          //keyboardType: TextInputType.text,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'City',
                          style: AppTextStyle().textColor70707012w400,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          decoration:
                              AppTFDecoration(hint: 'Houston').decoration(),
                          keyboardType: TextInputType.text,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'State',
                          style: AppTextStyle().textColor70707012w400,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          decoration:
                              AppTFDecoration(hint: 'Houston').decoration(),
                          //keyboardType: TextInputType.text,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Zip code',
                          style: AppTextStyle().textColor70707012w400,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          decoration:
                              AppTFDecoration(hint: '77042').decoration(),
                          //keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Country',
                          style: AppTextStyle().textColor70707012w400,
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          decoration: AppTFDecoration(hint: 'United States')
                              .decoration(),
                          //keyboardType: TextInputType.text,
                        ),
                      ],
                    ),
                  )
                ],
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
