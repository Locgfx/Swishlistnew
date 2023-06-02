import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/constants/urls.dart';
import 'package:swishlist/models/login_models.dart';

import '../../constants/color.dart';
import '../../constants/globals/shared_prefs.dart';

class UserImageRowWidget extends StatefulWidget {
  final LoginResponse response;
  const UserImageRowWidget({
    Key? key,
    required this.response,
  }) : super(key: key);

  @override
  State<UserImageRowWidget> createState() => _UserImageRowWidgetState();
}

class _UserImageRowWidgetState extends State<UserImageRowWidget> {
  var percent = "";
  bool profile = false;
  bool size = false;
  bool favourite = false;
  // final String bh=  percent* 10;

  double dou = 00;
  List <String> per = [];

  _sharedPrefs(){
    if(SharedPrefs().getPPercent() == '100 %') {
      per.add('profile');
    }
    if(SharedPrefs().getSetSize() == '100 %') {
      per.add('Size');

    }
    if(SharedPrefs().getFavourites() == '100 %') {
      per.add('favourites');

    }
    percent = ((per.length / 3)*100).toString().split(".").first ;
    dou = (per.length / 3);
  }



  @override
  void initState() {
    _sharedPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            CircularPercentIndicator(
              circularStrokeCap: CircularStrokeCap.round,
              radius: 40.0,
              lineWidth: 5.0,
              percent: dou,
              backgroundColor: ColorSelect.colorEDEDF1,
              progressColor: Colors.black,
              center:Container(
                height: 40,
                width: 40,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    shape: BoxShape.circle
                ),
                child: CachedNetworkImage(
                 /* imageUrl: baseUrl+widget.response.data.photo.toString(),*/
                  imageUrl: /* widget.response.data.photo.isEmpty ?*/
                  '$baseUrl${SharedPrefs().getUserPhoto()}',
                  /*baseUrl+widget.response.data.photo.toString(),*/
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error,),
                  progressIndicatorBuilder:  (a,b,c) =>
                      Opacity(
                        opacity: 0.3,
                        child: Shimmer.fromColors(
                          baseColor: Colors.black12,
                          highlightColor: Colors.white,
                          child: Container(
                            width: 40,
                            height: 40,
                            //margin: EdgeInsets.symmetric(horizontal: 24),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle
                            ),
                          ),
                        ),
                      ),
                ),
              ),
              // center: Image.asset('assets/images/Rectangle1072.png'),
            ),
          ],
        ),
        SizedBox(
          width: 20.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '${SharedPrefs().getName()}',
                  // "Michael Scott",
                  style: AppTextStyle().textColor29292916w500,
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Container(
              // height: 30,
              // width: 120.w,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: ColorSelect.colorF8F1AA,
                  borderRadius: BorderRadius.all(Radius.circular(80))),
              child: Center(
                child: Text(
                  // 'percent'
                  "$percent% completed",
                  style: AppTextStyle().textColor70707014w400,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
