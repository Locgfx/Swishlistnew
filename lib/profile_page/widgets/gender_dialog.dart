import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/color.dart';

class GenderDialog extends StatefulWidget {
  final String gender;
  final Function(String) onPop;
  const GenderDialog(
      {Key? key, required this.gender, required this.onPop})
      : super(key: key);

  @override
  State<GenderDialog> createState() => _GenderDialog();
}

class _GenderDialog extends State<GenderDialog> {
  int _gIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
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
                'Select Gender',
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
                    widget.onPop("Male");
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
                          'Male',
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
                    widget.onPop("Female");
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
                          'Female',
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
                    widget.onPop("Others");
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
                          'Others',
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
    );
  }

  @override
  void initState() {
    if (widget.gender == "Male") {
      _gIndex = 0;
    } else if (widget.gender == "Female") {
      _gIndex = 1;
    } else {
      _gIndex = 2;
    }
    super.initState();
  }
}
