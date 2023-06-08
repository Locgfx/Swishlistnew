import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants/color.dart';

class UserRowWidget extends StatelessWidget {
  final String familyName;
  final String familyUsername;
  final String familyPhoto;
  final String familyRelation;
  final String id;
  final Widget? widget;
  const UserRowWidget({
    Key? key,
    required this.familyName,
    required this.familyUsername,
    required this.familyPhoto,
    required this.familyRelation,
    this.widget,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorSelect.colorEDEDF1,
                ),
                child: CachedNetworkImage(
                  imageUrl: familyPhoto,
                  // imageUrl: baseUrl+familyModel2[i].familyMemberUser!.photo.toString(),
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) =>
                      Icon(Icons.error),
                  progressIndicatorBuilder: (a,b,c) =>
                      Opacity(
                        opacity: 0.3,
                        child: Shimmer.fromColors(
                          baseColor: Colors.black12,
                          highlightColor: Colors.white,
                          child: Container(
                            width: 50,
                            height: 50,
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
              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        familyName,
                        // "Jan Levinson",
                        style: AppTextStyle().textColor29292914w500,
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Container(
                        height: 30.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                            color: ColorSelect.colorF6E3DB,
                            borderRadius: BorderRadius.all(Radius.circular(80))),
                        child: Center(
                          child: Text(
                            familyRelation,
                            // " Wife",
                            style: AppTextStyle().textColor29292912w400,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    familyUsername,
                    // "JanLovey22",
                    style: AppTextStyle().textColor70707014w400,
                  )
                ],
              ),
              
            ],
          ),
        ),
        

        // Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: widget
        ),
        // Padding(
        //   padding: const EdgeInsets.only(right: 30),
        //   child: Icon(Icons.more_vert),
        // ),
      ],
    );
  }
}

class MangedByMeWidget extends StatelessWidget {
  const MangedByMeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.grey,
          backgroundImage: AssetImage('assets/images/Rectangle319.png'),
        ),
        SizedBox(
          width: 10.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Jan Levinson",
                  style: AppTextStyle().textColor29292914w500,
                ),
                SizedBox(
                  width: 20.w,
                ),
                Container(
                  height: 30.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                      color: ColorSelect.colorF6E3DB,
                      borderRadius: BorderRadius.all(Radius.circular(80))),
                  child: Center(
                    child: Text(
                      " Wife",
                      style: AppTextStyle().textColor29292912w400,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "JanLovey22",
              style: AppTextStyle().textColor70707014w400,
            )
          ],
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 30),
          child: Icon(Icons.more_vert),
        ),
      ],
    );
  }
}
