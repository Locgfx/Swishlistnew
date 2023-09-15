import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swishlist/constants/globals/loading.dart';

import '../../api/user_apis/friends_api.dart';
import '../../constants/color.dart';
import '../../models/friends_details_model.dart';

class FFavourites extends StatefulWidget {
  final String friendId;
  const FFavourites({Key? key, required this.friendId}) : super(key: key);

  @override
  State<FFavourites> createState() => _FFavouritesState();
}

class _FFavouritesState extends State<FFavourites> {
  List thingsDetails = [
    'Colors',
    'Sports',
    'Cars',
    'Bikes',
    'Movies',
    'Shows',
    'Food',
    'Gadgets',
  ];
  List peopleDetails = [
    'Superheroes',
    'Actors',
    'Actresses',
    'Singers',
    'Players'
  ];
  List placesValues = [
    'Cities',
    'Countries',
    'Restaurants',
  ];
  @override
  void initState() {
    getFriendDetails();
    super.initState();
  }

  bool isLoading = false;
  FriendDetailsModel? friendDetails;
  // List<String>? elements = [''];
  getFriendDetails() {
    isLoading = true;
    var resp = friendDetailsApi(friendUserId: widget.friendId);
    resp.then((value) {
      if (value['status'] == true) {
        setState(() {
          friendDetails = FriendDetailsModel.fromJson(value);
          isLoading = false;
        });
      } else {
        isLoading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset('assets/images/Vector190.png')),
        ),
        title: Text(
          "Favourites",
          style: AppTextStyle().textColor39393916w500,
        ),
        centerTitle: false,
      ),
      body: isLoading
          ? Loading()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: friendDetails!.data!.favourite!.isEmpty
                    ? Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: Colors.black,
                              size: 80,
                            ),
                            SizedBox(height: 5),
                            Text('Your friend not added favourites yet',
                                style: AppTextStyle().textColor29292914w500)
                          ],
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Things",
                            style: AppTextStyle().textColor29292914w600,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,

                            onTap: () {},
                            child: Row(
                              children: [
                                Text(
                                  "Cars",
                                  style: AppTextStyle().textColor70707014w400,
                                ),
                                Spacer(),
                                Text(
                                  friendDetails!.data!.favourite![0].cars
                                      .toString(),
                                  // 'Car',
                                  style: AppTextStyle().textColor29292914w400,
                                ),
                                // Image.asset("assets/images/information3.png"),
                                // SizedBox(
                                //   width: 20.w,
                                // ),
                                // Image.asset("assets/images/Vector175.png"),
                              ],
                            ),
                            // child: CarRowWidget(favourites: favourites!,)
                          ),
                          SizedBox(
                            height: 20.h,
                          ),

                          GestureDetector(
                            behavior: HitTestBehavior.opaque,

                            onTap: () {},
                            child: Row(
                              children: [
                                Text(
                                  "Bikes",
                                  style: AppTextStyle().textColor70707014w400,
                                ),
                                Spacer(),
                                Text(
                                  friendDetails!.data!.favourite![0].bikes
                                      .toString(),
                                  // 'Bikes',
                                  style: AppTextStyle().textColor29292914w400,
                                ),
                              ],
                            ),
                            // child: BikesRowWidget(favourites: favourites!,),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              children: [
                                Text(
                                  "Movies",
                                  style: AppTextStyle().textColor70707014w400,
                                ),
                                Spacer(),
                                Text(
                                  friendDetails!.data!.favourite![0].movies
                                      .toString(),
                                  // 'Movies',
                                  style: AppTextStyle().textColor29292914w400,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              children: [
                                Text(
                                  "Shows",
                                  style: AppTextStyle().textColor70707014w400,
                                ),
                                Spacer(),
                                Text(
                                  friendDetails!.data!.favourite![0].shows
                                      .toString(),
                                  // 'Shows',
                                  style: AppTextStyle().textColor29292914w400,
                                ),
                              ],
                            ),
                            // child: ShowsRowWidget(favourites: favourites!,),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              children: [
                                Text(
                                  "Food",
                                  style: AppTextStyle().textColor70707014w400,
                                ),
                                Spacer(),
                                Text(
                                  friendDetails!.data!.favourite![0].foods
                                      .toString(),
                                  // 'Food',
                                  style: AppTextStyle().textColor29292914w400,
                                ),
                              ],
                            ),
                            // child: FoodRowWidget(favourites: favourites!,)
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              children: [
                                Text(
                                  "Gadgets",
                                  style: AppTextStyle().textColor70707014w400,
                                ),
                                Spacer(),
                                Text(
                                  friendDetails!.data!.favourite![0].gadgets
                                      .toString(),
                                  // 'Gadgets',
                                  style: AppTextStyle().textColor29292914w400,
                                ),
                              ],
                            ),
                            // child: GadgetsRowWidget(favourites: favourites!),
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          Text(
                            "People",
                            style: AppTextStyle().textColor29292914w600,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          GestureDetector(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Text(
                                    "Superheroes",
                                    style: AppTextStyle().textColor70707014w400,
                                  ),
                                  Spacer(),
                                  Text(
                                    friendDetails!
                                        .data!.favourite![0].superheroes
                                        .toString(),
                                    // 'Superheroes',
                                    style: AppTextStyle().textColor29292914w400,
                                  ),
                                ],
                              )),
                          // child: SuperherosRowWidget(favourites: favourites!)),
                          SizedBox(
                            height: 20.h,
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,

                            onTap: () {},
                            child: Row(
                              children: [
                                Text(
                                  "Actors",
                                  style: AppTextStyle().textColor70707014w400,
                                ),
                                Spacer(),
                                Text(
                                  friendDetails!.data!.favourite![0].actors
                                      .toString(),
                                  // 'Actors',
                                  style: AppTextStyle().textColor29292914w400,
                                ),
                              ],
                            ),
                            // child: ActorsRowWidget(favourites: favourites!),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              children: [
                                Text(
                                  "Actresses",
                                  style: AppTextStyle().textColor70707014w400,
                                ),
                                Spacer(),
                                Text(
                                  friendDetails!.data!.favourite![0].actresses
                                      .toString(),
                                  // 'Actress',
                                  style: AppTextStyle().textColor29292914w400,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,

                            onTap: () {},
                            child: Row(
                              children: [
                                Text(
                                  "Singers",
                                  style: AppTextStyle().textColor70707014w400,
                                ),
                                Spacer(),
                                Text(
                                  friendDetails!.data!.favourite![0].singers
                                      .toString(),
                                  // 'Singers',
                                  style: AppTextStyle().textColor29292914w400,
                                ),
                              ],
                            ),
                            // child: SingersRowWidget(favourites: favourites!),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              children: [
                                Text(
                                  "Players",
                                  style: AppTextStyle().textColor70707014w400,
                                ),
                                Spacer(),
                                Text(
                                  friendDetails!.data!.favourite![0].players
                                      .toString(),
                                  // 'Players',
                                  style: AppTextStyle().textColor29292914w400,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          Text(
                            "Places",
                            style: AppTextStyle().textColor29292914w600,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              children: [
                                Text(
                                  "Cities",
                                  style: AppTextStyle().textColor70707014w400,
                                ),
                                Spacer(),
                                Text(
                                  friendDetails!.data!.favourite![0].cities
                                      .toString(),
                                  // 'Cities',
                                  style: AppTextStyle().textColor29292914w400,
                                ),
                              ],
                            ),
                            // child: CitiesRowWidget(favourites: favourites!,),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              children: [
                                Text(
                                  "Countries",
                                  style: AppTextStyle().textColor70707014w400,
                                ),
                                Spacer(),
                                Text(
                                  friendDetails!.data!.favourite![0].countries
                                      .toString(),
                                  // 'Countries',
                                  style: AppTextStyle().textColor29292914w400,
                                ),
                              ],
                            ),
                            // child: CountriesRowWidget(favourites: favourites!,)
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              children: [
                                Text(
                                  "Restaurants",
                                  style: AppTextStyle().textColor70707014w400,
                                ),
                                Spacer(),
                                Text(
                                  friendDetails!.data!.favourite![0].restaurants
                                      .toString(),
                                  // 'Restaurants',
                                  style: AppTextStyle().textColor29292914w400,
                                ),
                              ],
                            ),
                            // child: RestaurantsRowWidget(favourites: favourites!,)
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              children: [
                                Text(
                                  "Hotels",
                                  style: AppTextStyle().textColor70707014w400,
                                ),
                                Spacer(),
                                Text(
                                  friendDetails!.data!.favourite![0].hotels
                                      .toString(),
                                  // 'Hotels',
                                  style: AppTextStyle().textColor29292914w400,
                                ),
                              ],
                            ),
                            // child: HotelRowWidget(favourites: favourites!,),
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                        ],
                      ),
              ),
              /*   child: Container(
          constraints: BoxConstraints(maxHeight: 1.sh),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Things', style: AppTextStyle().textColor29292914w600),
              for (int i = 0; i < thingsDetails.length; i++)
                ProfileRowValue(title: thingsDetails[i], value: 'Value'),
              SizedBox(height: 24),
              Text('People', style: AppTextStyle().textColor29292914w600),
              for (int i = 0; i < peopleDetails.length; i++)
                ProfileRowValue(title: peopleDetails[i], value: 'Value'),
              SizedBox(height: 24),
              Text('Places', style: AppTextStyle().textColor29292914w600),
              for (int i = 0; i < placesValues.length; i++)
                ProfileRowValue(title: placesValues[i], value: 'Value'),
              SizedBox(height: 24),
            ],
          ),
        ),*/
            ),
    );
  }
}
