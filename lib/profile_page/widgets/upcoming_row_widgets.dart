import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swishlist/models/date_and_events_model.dart';

import '../../constants/color.dart';

class UpcomingRowWidget extends StatelessWidget {
  final EventModel eventDate;
  const UpcomingRowWidget({
    Key? key,
    required this.eventDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Trip to America",
          style: AppTextStyle().textColor70707014w400,
        ),
        Spacer(),
        eventDate.data!.isEmpty ?
        Container(height: 20):
        Text(eventDate.data![0].date!.toString()== '' ?
          "add event date" :
        eventDate.data![0].date!.toString(),
          // eventDate.data!.date!,
          style: AppTextStyle().textColor29292914w400,
        ),
        SizedBox(
          width: 5.w,
        ),
        Image.asset("assets/images/image46.png"),
        SizedBox(
          width: 20.w,
        ),
        Image.asset("assets/images/Vector175.png"),
      ],
    );
  }
}
