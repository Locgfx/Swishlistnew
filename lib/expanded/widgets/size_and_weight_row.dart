import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../api/user_apis/sizes_and_weight_api.dart';
import '../../constants/color.dart';
import '../../models/sizes_and_weight_model.dart';

class SizeAndWeightRowWidget extends StatefulWidget {
  SizeAndWeightRowWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SizeAndWeightRowWidget> createState() => _SizeAndWeightRowWidgetState();
}

class _SizeAndWeightRowWidgetState extends State<SizeAndWeightRowWidget> {
  double dou = 00;
  var sizePercent = "";
  List<String> per = [];

  // _sharedPrefs() {
  //   if (SharedPrefs().getSetSize() == '100 %') {
  //     per.add('profile');
  //     sizePercent = ((per.length / 1) * 100).toString().split(".").first;
  //     dou = (per.length / 1);
  //   }
  // }''

  String? completePercent;
  double parsedPercent = 0.0;
  double normalizedPercent = 0.0;

  bool isLoading = false;

  // SizesAndWeightModel? sizeWeight = SizesAndWeightModel(
  //     data: SizeData(
  //       shoe: '',
  //   privacy: '',
  //   complete: '',
  //   id: 0,
  //   waist: '',
  //   shirt: '',
  //
  //   bed: '',
  // ), error: true, message: '');

  // getSizedWeight() {
  //   isLoading = true;
  //   var resp = getSizeAndWeightApi();
  //   resp.then((value) {
  //     print(value);
  //     if (mounted) {
  //       if (value['status'] == true) {
  //         if (value['message'] == 'No Size Weight') {
  //           setState(() {
  //             isLoading = false;
  //           });
  //         } else {
  //           setState(() {
  //             sizeWeight = SizesAndWeightModel.fromJson(value);
  //             isLoading = false;
  //           });
  //         }
  //       } else {
  //         setState(() {
  //           isLoading = false;
  //         });
  //       }
  //     }
  //   });
  // }


  SizesAndWeightModel? sizeWeight;

  getSizedWeight(){
    isLoading = true;
    var resp = getSizeAndWeightApi();
    resp.then((value) {
      if(value.error == false){
        setState(() {
          sizeWeight = value;

          // get();
          // fields();
          isLoading = false;
        });

      }else{
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  void initState() {
    // _sharedPrefs();
    getSizedWeight();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    completePercent = sizeWeight!.data?.complete;
    parsedPercent = double.tryParse(completePercent ?? '0') ?? 0.0;
    normalizedPercent = parsedPercent / 100.0;
    return Row(
      children: [
        CircularPercentIndicator(
          circularStrokeCap: CircularStrokeCap.round,
          radius: 40.w,
          lineWidth: 2.w,
          percent: normalizedPercent,
          backgroundColor: Color(0xff576ACC).withOpacity(0.28),
          center: Image.asset('assets/images/zoomin.png'),
          progressColor: ColorSelect.color576ACC,
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Sizes and weights",
              style: AppTextStyle().textColor29292914w400,
            ),
            isLoading
                ? SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        sizeWeight!.data?.complete.toString() == "" ||
                                sizeWeight!.data?.complete == null
                            ? "0"
                            : sizeWeight!.data!.complete
                                .toString()
                                .split(".")
                                .first,
                        // sizeWeight!.data.completePercent
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
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 27),
          child: SvgPicture.asset("assets/icons/forwordarrow.svg"),
        )
      ],
    );
  }
}
