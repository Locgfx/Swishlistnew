import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/buttons/yellow_button.dart';
import '../../api/user_apis/activities_api.dart';
import '../../api/user_apis/activity_store_model.dart';
import '../../constants/color.dart';
import '../../constants/globals/loading.dart';
import '../../constants/urls.dart';
import '../../models/activity1_model.dart';
import 'friendwants.dart';

class Activities extends StatefulWidget {
  const Activities({Key? key}) : super(key: key);

  @override
  State<Activities> createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  @override
  void initState() {
    getActivity();
    super.initState();
  }

  Activity1? activity1;
  ActivityStoreModel? activityStore;
  bool isLoading = false;
  getActivity() {
    isLoading = true;
    activity().then((value) {
      if (value.status) {
        setState(() {
          activity1 = value;
          isLoading = false;
          //print(activity1!.data.length);
        });
      } else {
        isLoading = false;
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading ? Loading(): SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 52,
              ),
              Text(
                "Activities",
                style: AppTextStyle().ubuntu29292924w700,
              ),
              activity1!.data!.isEmpty ?
              Column(
                children: [
                  SizedBox(height: 100),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Image.asset("assets/images/empty activity.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60,right: 60,top:24 ),
                    child: Text(
                      "Share your profile and add friends & family to see their activities",
                      maxLines: 2,
                      style: AppTextStyle().roboto29292914w500,
                      textAlign: TextAlign.center,),
                  ),
                  SizedBox(height: 40),
                ],
              ):
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    "This week",
                    style: AppTextStyle().textColor70707012w500,
                  ),
                  SizedBox(height: 11),


                      MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        removeBottom: true,
                        child: ListView.separated(
                          itemCount: activity1!.data!.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, i) {
                            // print(activity1!.data.length);
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FriendWants()));
                              },
                              child: Container(
                                color: Colors.transparent,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 48,
                                          height: 48,
                                          decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            shape: BoxShape.circle,
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                            baseUrl+activity1!.data![i].user!.photo.toString(),
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
                                                      // width: 50,
                                                      // height: 50,
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
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${activity1!.data![i].user!.name} shared 1 product with you",
                                                style: AppTextStyle()
                                                    .robotocolor1F1F1F13w400,
                                              ),
                                              Text(
                                                  DateTime.now()
                                                  .difference(
                                                  DateTime.parse(
                                                      activity1!
                                                          .data![i].createdAt.toString()))
                                                  .inMinutes <=
                                                  59
                                                  ? "${DateTime.now().difference(DateTime.parse(activity1!
                                                      .data![i].createdAt.toString())).inMinutes} min ago"
                                                  : DateTime.now()
                                                  .difference(DateTime
                                                  .parse(activity1!
                                                      .data![i].createdAt.toString()))
                                                  .inHours <=
                                                  23
                                                  ? "${DateTime.now().difference(DateTime.parse(activity1!
                                                      .data![i].createdAt.toString())).inHours} hr ago"
                                                  : "${DateTime.now().difference(DateTime.parse(activity1!
                                                      .data![i].createdAt.toString())).inDays} days ago"),

                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Container(
                                          height: 52,
                                          width: 52,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(8),
                                              border: Border.all(
                                                  width: 1,
                                                  color:
                                                  ColorSelect.colorDCDCE6)),
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 8),
                                              child: Image.asset(
                                                  "assets/images/image10.png"),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 16,
                            );
                          },
                        ),
                      ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Earlier",
                    style: AppTextStyle().textColor70707012w500,
                  ),
                  SizedBox(
                    height: 12,
                  ),

                      MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        removeBottom: true,
                        child: ListView.separated(
                          itemCount: activity1!.data!.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, i) {
                            return Container(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.grey,
                                          backgroundImage: NetworkImage(
                                              '${baseUrl}${activity1!.data![i].user!.photo}')
                                        //AssetImage('assets/images/Rectangle3194.png'),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${activity1!.data![i].user!.name} shared 1 product with you",
                                              style: AppTextStyle()
                                                  .robotocolor1F1F1F13w400,
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                                DateTime.now()
                                                    .difference(
                                                    DateTime.parse(
                                                        activity1!
                                                            .data![i].createdAt.toString()))
                                                    .inMinutes <=
                                                    59
                                                    ? "${DateTime.now().difference(DateTime.parse(activity1!
                                                    .data![i].createdAt.toString())).inMinutes} min ago"
                                                    : DateTime.now()
                                                    .difference(DateTime
                                                    .parse(activity1!
                                                    .data![i].createdAt.toString()))
                                                    .inHours <=
                                                    23
                                                    ? "${DateTime.now().difference(DateTime.parse(activity1!
                                                    .data![i].createdAt.toString())).inHours} hr ago"
                                                    : "${DateTime.now().difference(DateTime.parse(activity1!
                                                    .data![i].createdAt.toString())).inDays} days ago"),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      SizedBox(
                                        //Todo: padding length for device responsive
                                        height: 36,
                                        width: 64,
                                        child: YellowButtonWithText(
                                          backgroundColor:
                                          MaterialStateProperty.all(
                                              ColorSelect.colorF7E641),
                                          textStyleColor: ColorSelect.color292929,
                                          title: 'Add',
                                          onTap: () {
                                            postActivityApi(
                                                leadUserid: activity1!.data![i].leadUserId.toString(),
                                                productId: activity1!.data![i].productId.toString())
                                                .then((value) {
                                              print(value);
                                              if(value['status'] == true) {
                                                setState(() {
                                                  isLoading ? Loading() : getActivity();
                                                 Fluttertoast.showToast(
                                                            msg: 'Activity added successfully');
                                                });
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg:
                                                    'Activity failed');
                                                }
                                              }
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 16,
                            );
                          },
                        ),
                      ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}