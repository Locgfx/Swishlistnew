import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/api/user_apis/family_apis.dart';
import 'package:swishlist/constants/urls.dart';
import 'package:swishlist/models/family_model.dart';
import '../../constants/color.dart';

class OptionRow extends StatelessWidget {
  final String icon;
  final String label;
  final Function onTap;
  const OptionRow({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorSelect.colorEDEDF1,
                  ),
                  padding: EdgeInsets.all(8),
                  child: SvgPicture.asset('assets/icons/$icon.svg'),
                ),
                SizedBox(width: 8),
                Text(
                  label,
                  style: AppTextStyle().textColor29292914w500,
                ),
              ],
            ),
            Container(
              width: 32,
              height: 16,
              padding: EdgeInsets.only(right: 16),
              color: Colors.transparent,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OptionRowFamily extends StatefulWidget {
  // final String img;
  // final String name;
  // final String userName;
  // final String tag;
   OptionRowFamily({
    Key? key,
    // required this.img,
    // required this.name,
    // required this.userName,
    // required this.tag,
  }) : super(key: key);

  @override
  State<OptionRowFamily> createState() => _OptionRowFamilyState();
}

class _OptionRowFamilyState extends State<OptionRowFamily> {

  @override
  void initState() {
    getFamilyMember();
    super.initState();
  }
  bool isLoading = false;
  GetFamilyModel? familyModel;
  List<GetFamilyModel> familyModel1 = [];
  List<Data> familyModel2 = [];

  getFamilyMember() {
    isLoading = true;
    var resp = getFamilyMemberApi();
    resp.then((value) {
      if(value['status'] == true) {
        setState(() {
          familyModel = GetFamilyModel.fromJson(value);
          for (var v in familyModel!.data! ) {
            if (v.status == "accepted") {
              familyModel2.add(v);
            }
          }
          isLoading = false;
        });
      } else{
        isLoading = false;
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return isLoading ? Center(
      child: LoadingAnimationWidget.waveDots(
        size: 40,
        color: ColorSelect.colorF7E641,
      ),
    ): ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: familyModel2.length,
      shrinkWrap: true,
      itemBuilder: (context, i) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorSelect.colorEDEDF1,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: baseUrl+familyModel2[i].familyMemberUser!.photo.toString(),
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error),
                      progressIndicatorBuilder:  (a,b,c) =>
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
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            familyModel2[i].familyMemberUser!.name.toString(),
                            // widget.name,
                            style: AppTextStyle().textColor29292914w500,
                          ),
                          SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                                color:ColorSelect.colorF6E3DB,
                                borderRadius: BorderRadius.circular(80)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 6),
                              child: Text(familyModel2[i].relation.toString(),
                                style: AppTextStyle().textColor29292912w400,),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        familyModel2[i].familyMemberUser!.username.toString(),
                        // widget.userName,
                        style: AppTextStyle().textColor70707014w400,
                      ),
                    ],
                  ),

                ],
              ),
              // Container(
              //   padding: EdgeInsets.all(16),
              // /*  child: Icon(
              //     Icons.more_vert,
              //     color: Colors.black,
              //   ),*/
              // ),
            ],
          ),
        );
      },
    );
  }
}
