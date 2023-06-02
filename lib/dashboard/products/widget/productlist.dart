import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/color.dart';

class ProductListWidget extends StatelessWidget {
  const ProductListWidget({
    Key? key,
    required this.imageList,
    required this.itemNameList,
    required this.itemPrice,
  }) : super(key: key);

  final List imageList;
  final List itemNameList;
  final List itemPrice;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 2,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, i) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16,
              ),
              Container(
                margin: EdgeInsets.only(left: 16),
                height: 135,
                width: 173,
                decoration: BoxDecoration(
                    color: ColorSelect.colorFFFFFF,
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                  child: Image.asset(imageList[i]),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: SizedBox(
                  width: 173.w,
                  child: Text(
                    itemNameList[i],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: AppTextStyle().textColor29292912w400,
                  ),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  itemPrice[i],
                  style: AppTextStyle().textColor29292914w500,
                ),
              ),
            ],
          );
        });
  }
}
