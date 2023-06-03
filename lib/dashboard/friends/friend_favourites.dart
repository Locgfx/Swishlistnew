import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:swishlist/constants/globals/loading.dart';

import '../../api/user_apis/friends_api.dart';
import '../../constants/color.dart';
import '../../models/friends_details_model.dart';
import 'friend_profile_page.dart';

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
      if (value ['status'] == true) {
        setState(() {
            friendDetails = FriendDetailsModel.fromJson(value);
            // if(friendDetails!.data != null) {
            //   if(friendDetails!.data!.favourite == null ) {
            //   }
            // } else {
            //   friendDetails = FriendDetailsModel(
            //       data: Data(
            //         id: 0,
            //         name: '',
            //         username: '',
            //         phone: '',
            //         email: '',
            //         photo: '',
            //         type: '',
            //         profile: Profile(
            //           id: 0,
            //           userId: 0,
            //           name: '',
            //           photo: '',
            //           gender: '',
            //           dob: '',
            //           occupation: '',
            //           relationStatus: '',
            //           email: '',
            //           phone: '',
            //           alternatePhone: '',
            //           homeAddress: '',
            //           workAddress: '',
            //           privacyStatus: '',
            //           createdAt: '',
            //         ),
            //         sizeWeight: SizeWeight(
            //           id: 0,
            //           userId: 0,
            //           waist: '',
            //           shirt: '',
            //           shoes: '',
            //           bed: '',
            //           privacyStatus: '',
            //           createdAt: '',
            //         ),
            //         interest: Interest(
            //             interest: ''
            //         ),
            //       )
            //   );
            // }
            isLoading= false;
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
      body: isLoading ? Loading() :SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: friendDetails!.data!.favourite!.isEmpty ? Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Icon(Icons.error_outline,color: Colors.black,size: 80,)),
              // Image.asset("assets/images/delivery.png",height: 100,),
              SizedBox(height: 5),
              Text('Your friend not added favourites yet',
                style: AppTextStyle().textColor29292914w500)
            ],
          ) : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
              // friendDetails!.data!.favourite![0].cars.toString(),
                "Things",
                style: AppTextStyle().textColor29292914w600,
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {
                  /*showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NameEditDialogWidget(
                        title: 'Car',
                        addTextField: TextFormField(
                          onChanged: (v) {
                            setState(() {});
                          },
                          controller: carController,
                          cursorColor: ColorSelect.colorF7E641,
                          decoration: AppTFDecoration(
                              hint: 'Car Name').decoration(),
                          //keyboardType: TextInputType.phone,
                        ),
                      );
                    },
                  );*/
                },
                child: Row(
                  children: [
                    Text(
                      "Cars",
                      style: AppTextStyle().textColor70707014w400,
                    ),
                    Spacer(),
                    Text(
                      friendDetails!.data!.favourite![0].cars.toString(),
                      // 'Car',
                      style:AppTextStyle().textColor29292914w400,
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
                onTap: () {
                /*  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NameEditDialogWidget(
                        title: 'Bike',
                        addTextField: TextFormField(
                          onChanged: (v) {
                            setState(() {});
                          },
                          controller: bikesController,
                          cursorColor: ColorSelect.colorF7E641,
                          decoration: AppTFDecoration(
                              hint: 'bike Name').decoration(),
                          //keyboardType: TextInputType.phone,
                        ),
                      );
                    },
                  );*/
                },
                child: Row(
                  children: [
                    Text(
                      "Bikes",
                      style: AppTextStyle().textColor70707014w400,
                    ),
                    Spacer(),
                    Text(
                      friendDetails!.data!.favourite![0].bikes.toString(),
                      // 'Bikes',
                      style:AppTextStyle().textColor29292914w400,
                    ),
                    // Image.asset("assets/images/information3.png"),
                    // SizedBox(
                    //   width: 20.w,
                    // ),
                    // Image.asset("assets/images/Vector175.png"),
                  ],
                ),
                // child: BikesRowWidget(favourites: favourites!,),
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {
                  // showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return NameEditDialogWidget(
                  //       title: 'Movies',
                  //       addTextField: TextFormField(
                  //         onChanged: (v) {
                  //           setState(() {});
                  //         },
                  //         controller: moviesController,
                  //         cursorColor: ColorSelect.colorF7E641,
                  //         decoration: AppTFDecoration(
                  //             hint: 'Movies Name').decoration(),
                  //         //keyboardType: TextInputType.phone,
                  //       ),
                  //     );
                  //   },
                  // );
                },child: Row(
                children: [
                  Text(
                    "Movies",
                    style: AppTextStyle().textColor70707014w400,
                  ),
                  Spacer(),
                  Text(
                    friendDetails!.data!.favourite![0].movies.toString(),
                    // 'Movies',
                    style:AppTextStyle().textColor29292914w400,
                  ),
                  // SizedBox(
                  //   width: 5.w,
                  // ),
                  // // Image.asset("assets/images/image46.png"),
                  // SizedBox(
                  //   width: 20.w,
                  // ),
                  // Image.asset("assets/images/Vector175.png"),
                ],
              ),
                // child: MoviesWidget(favourites: favourites!),
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {
                 /* showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return NameEditDialogWidget(
                        title: 'Show',
                        addTextField: TextFormField(
                          onChanged: (v) {
                            setState(() {});
                          },
                          controller: showsController,
                          cursorColor: ColorSelect.colorF7E641,
                          decoration: AppTFDecoration(
                              hint: 'Show Name').decoration(),
                          //keyboardType: TextInputType.phone,
                        ),
                      );
                    },
                  );*/
                },
                child:  Row(
                  children: [
                    Text(
                      "Shows",
                      style: AppTextStyle().textColor70707014w400,
                    ),
                    Spacer(),
                    Text(
                      friendDetails!.data!.favourite![0].shows.toString(),
                      // 'Shows',
                      style:AppTextStyle().textColor29292914w400,
                    ),
                    // SizedBox(
                    //   width: 5.w,
                    // ),
                    // // Image.asset("assets/images/image46.png"),
                    // SizedBox(
                    //   width: 20.w,
                    // ),
                    // Image.asset("assets/images/Vector175.png"),
                  ],
                ),
                // child: ShowsRowWidget(favourites: favourites!,),
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {
                  // showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return NameEditDialogWidget(
                  //       title: 'Food',
                  //       addTextField: TextFormField(
                  //         onChanged: (v){
                  //           setState(() {});
                  //         },
                  //         controller: foodController,
                  //         cursorColor: ColorSelect.colorF7E641,
                  //         decoration: AppTFDecoration(
                  //             hint: 'Food Name').decoration(),
                  //         //keyboardType: TextInputType.phone,
                  //       ),
                  //     );
                  //   },
                  // );
                },
                child:Row(
                  children: [
                    Text(
                      "Food",
                      style: AppTextStyle().textColor70707014w400,
                    ),
                    Spacer(),
                Text(
                  friendDetails!.data!.favourite![0].foods.toString(),
                  // 'Food',
                  style:AppTextStyle().textColor29292914w400,
                ),
                // / SizedBox(
                    //   width: 5.w,
                    // ),
                    // // Image.asset("assets/images/image46.png"),
                    // SizedBox(
                    //   width: 20.w,
                    // ),
                    // Image.asset("assets/images/Vector175.png"),
                  ],
                ) ,
                // child: FoodRowWidget(favourites: favourites!,)
              ),
              SizedBox(height: 20.h,),
              GestureDetector(
                onTap:() {
                  // showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return NameEditDialogWidget(
                  //       title: 'Gadgets',
                  //       addTextField: TextFormField(
                  //         onChanged: (v) {
                  //           setState(() {});
                  //         },
                  //         controller: gadgetsController,
                  //         cursorColor: ColorSelect.colorF7E641,
                  //         decoration: AppTFDecoration(
                  //             hint: 'Gadgets Name').decoration(),
                  //         //keyboardType: TextInputType.phone,
                  //       ),
                  //     );
                  //   },
                  // );
                },
                child: Row(
                  children: [
                    Text(
                      "Gadgets",
                      style: AppTextStyle().textColor70707014w400,
                    ),
                    Spacer(),
                    Text(
                      friendDetails!.data!.favourite![0].gadgets.toString(),
                      // 'Gadgets',
                      style:AppTextStyle().textColor29292914w400,
                    ),
                    // Image.asset("assets/images/information3.png"),
                    // SizedBox(
                    //   width: 20.w,
                    // ),
                    // Image.asset("assets/images/Vector175.png"),
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
                  onTap: () {
                    // showDialog(
                    //   context: context,
                    //   builder: (BuildContext context) {
                    //     return NameEditDialogWidget(
                    //       title: 'SuperHeroes',
                    //       addTextField: TextFormField(
                    //         onChanged: (v) {
                    //           setState(() {
                    //           });
                    //         },
                    //         controller: superheroesController,
                    //         cursorColor: ColorSelect.colorF7E641,
                    //         decoration: AppTFDecoration(
                    //             hint: 'SuperHeroes Name').decoration(),
                    //         //keyboardType: TextInputType.phone,
                    //       ),
                    //     );
                    //   },
                    // );
                  },
                  child: Row(
                    children: [
                      Text(
                        "Superheroes",
                        style: AppTextStyle().textColor70707014w400,
                      ),
                      Spacer(),
                      Text(
                        friendDetails!.data!.favourite![0].superheroes.toString(),
                        // 'Superheroes',
                        style:AppTextStyle().textColor29292914w400,
                      ),
                    ],
                  )
              ),
              // child: SuperherosRowWidget(favourites: favourites!)),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {
                  // showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return NameEditDialogWidget(
                  //       title: 'Actors',
                  //       addTextField: TextFormField(
                  //         onChanged: (v) {
                  //           setState(() {});
                  //         },
                  //         controller: actorController,
                  //         cursorColor: ColorSelect.colorF7E641,
                  //         decoration: AppTFDecoration(
                  //             hint: 'Actors Name').decoration(),
                  //         //keyboardType: TextInputType.phone,
                  //       ),
                  //     );
                  //   },
                  // );
                },
                child: Row(
                  children: [
                    Text(
                      "Actors",
                      style: AppTextStyle().textColor70707014w400,
                    ),
                    Spacer(),
                    Text(
                      friendDetails!.data!.favourite![0].actors.toString(),
                      // 'Actors',
                      style:AppTextStyle().textColor29292914w400,
                    ),

                  ],
                ),
                // child: ActorsRowWidget(favourites: favourites!),
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {
                  // showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return NameEditDialogWidget(
                  //       title: 'Actress',
                  //       addTextField: TextFormField(
                  //         onChanged: (v) {
                  //           setState(() {});
                  //         },
                  //         controller: actressController,
                  //         cursorColor: ColorSelect.colorF7E641,
                  //         decoration: AppTFDecoration(
                  //             hint: 'Actress Name').decoration(),
                  //         //keyboardType: TextInputType.phone,
                  //       ),
                  //     );
                  //   },
                  // );
                },
                child: Row(
                  children: [
                    Text(
                      "Actresses",
                      style: AppTextStyle().textColor70707014w400,
                    ),
                    Spacer(),
                    Text(
                      friendDetails!.data!.favourite![0].actresses.toString(),
                      // 'Actress',
                      style:AppTextStyle().textColor29292914w400,
                    ),
                  ],
                ),
                // child: ActressesRowWidget(favourites: favourites!),
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {
                  // showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return NameEditDialogWidget(
                  //       title: 'Singers',
                  //       addTextField: TextFormField(
                  //         controller: singersController,
                  //         onChanged: (v) {
                  //           setState(() {});
                  //         },
                  //         cursorColor: ColorSelect.colorF7E641,
                  //         decoration: AppTFDecoration(
                  //             hint: 'Singers Name').decoration(),
                  //         //keyboardType: TextInputType.phone,
                  //       ),
                  //     );
                  //   },
                  // );
                },
                child: Row(
                  children: [
                    Text(
                      "Singers",
                      style: AppTextStyle().textColor70707014w400,
                    ),
                    Spacer(),
                    Text(
                      friendDetails!.data!.favourite![0].singers.toString(),
                      // 'Singers',
                      style:AppTextStyle().textColor29292914w400,
                    ),
                  ],
                ),
                // child: SingersRowWidget(favourites: favourites!),
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {
                  // showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return NameEditDialogWidget(
                  //       title: 'Players',
                  //       addTextField: TextFormField(
                  //         onChanged: (v) {
                  //           setState(() {});
                  //         },
                  //         controller: playersController,
                  //         cursorColor: ColorSelect.colorF7E641,
                  //         decoration: AppTFDecoration(
                  //             hint: 'Players Name').decoration(),
                  //         //keyboardType: TextInputType.phone,
                  //       ),
                  //     );
                  //   },
                  // );
                },
                child: Row(
                  children: [
                    Text(
                      "Players",
                      style: AppTextStyle().textColor70707014w400,
                    ),
                    Spacer(),
                    Text(
                      friendDetails!.data!.favourite![0].players.toString(),
                      // 'Players',
                      style:AppTextStyle().textColor29292914w400,
                    ),
                  ],
                ),
                // child: PlayersRowWidget(favourites: favourites!),
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
                onTap: () {
                  // showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return NameEditDialogWidget(
                  //       title: 'Cities',
                  //       addTextField: TextFormField(
                  //         onChanged: (v) {
                  //           setState(() {});
                  //         },
                  //         controller: citiesController,
                  //         cursorColor: ColorSelect.colorF7E641,
                  //         decoration: AppTFDecoration(
                  //             hint: 'Cities Name').decoration(),
                  //         //keyboardType: TextInputType.phone,
                  //       ),
                  //     );
                  //   },
                  // );
                },
                child: Row(
                  children: [
                    Text(
                      "Cities",
                      style: AppTextStyle().textColor70707014w400,
                    ),
                    Spacer(),
                    Text(
                      friendDetails!.data!.favourite![0].cities.toString(),
                      // 'Cities',
                      style:AppTextStyle().textColor29292914w400,
                    ),
                    // Text(
                    //   "+ Add",
                    //   style: AppTextStyle().textColorD5574514w500,
                    // ),
                  ],
                ),
                // child: CitiesRowWidget(favourites: favourites!,),
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {
                  // showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return NameEditDialogWidget(
                  //       title: 'Countries',
                  //       addTextField: TextFormField(
                  //         controller: countriesController,
                  //         onChanged: (v) {
                  //           setState(() {});
                  //         },
                  //         cursorColor: ColorSelect.colorF7E641,
                  //         decoration: AppTFDecoration(
                  //             hint: 'Countries Name').decoration(),
                  //         //keyboardType: TextInputType.phone,
                  //       ),
                  //     );
                  //   },
                  // );
                },
                child: Row(
                  children: [
                    Text(
                      "Countries",
                      style: AppTextStyle().textColor70707014w400,
                    ),
                    Spacer(),
                    Text(
                      friendDetails!.data!.favourite![0].countries.toString(),
                      // 'Countries',
                      style:AppTextStyle().textColor29292914w400,
                    ),
                    // Text(
                    //   "+ Add",
                    //   style: AppTextStyle().textColorD5574514w500,
                    // ),
                  ],
                ),
                // child: CountriesRowWidget(favourites: favourites!,)
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {
                  // showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return NameEditDialogWidget(
                  //       title: 'Restaurant',
                  //       addTextField: TextFormField(
                  //         onChanged: (v) {
                  //           setState(() {});
                  //         },
                  //         controller: restaurantsController,
                  //         cursorColor: ColorSelect.colorF7E641,
                  //         decoration: AppTFDecoration(
                  //             hint: 'Restaurant Name').decoration(),
                  //         //keyboardType: TextInputType.phone,
                  //       ),
                  //     );
                  //   },
                  // );
                },
                child: Row(
                  children: [
                    Text(
                      "Restaurants",
                      style: AppTextStyle().textColor70707014w400,
                    ),
                    Spacer(),
                    Text(
                      friendDetails!.data!.favourite![0].restaurants.toString(),
                      // 'Restaurants',
                      style:AppTextStyle().textColor29292914w400,
                    ),
                    // Text(
                    //   "+ Add",
                    //   style: AppTextStyle().textColorD5574514w500,
                    // ),
                  ],
                ),
                // child: RestaurantsRowWidget(favourites: favourites!,)
              ),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () {
                  // showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return NameEditDialogWidget(
                  //       title: 'Hotel',
                  //       addTextField: TextFormField(
                  //         onChanged: (v) {
                  //           setState(() {});
                  //         },
                  //         controller: hotelsController,
                  //         cursorColor: ColorSelect.colorF7E641,
                  //         decoration: AppTFDecoration(
                  //             hint: 'Hotel Name').decoration(),
                  //         //keyboardType: TextInputType.phone,
                  //       ),
                  //     );
                  //   },
                  // );
                },
                child: Row(
                  children: [
                    Text(
                      "Hotels",
                      style: AppTextStyle().textColor70707014w400,
                    ),
                    Spacer(),
                    Text(
                      friendDetails!.data!.favourite![0].hotels.toString(),
                      // 'Hotels',
                      style:AppTextStyle().textColor29292914w400,
                    ),
                    // hotelsController.text.isEmpty ? Text(
                    //   favourites!.data!.hotels!.toString() == "" ?
                    //   "+ Add" :
                    //   favourites!.data!.hotels!.toString(),
                    //   style: favourites!.data!.hotels! == '' ? AppTextStyle().textColorD5574514w500 :
                    //   AppTextStyle().textColor29292914w400,
                    // ) :Text(hotelsController.text),
                    // Text(
                    //   "+ Add",
                    //   style: AppTextStyle().textColorD5574514w500,
                    // ),
                  ],
                ),
                // child: HotelRowWidget(favourites: favourites!,),
              ),
              SizedBox(
                height: 40.h,
              ),
              // LightYellowButtonWithText(
              //     backgroundColor:
              //     MaterialStateProperty.all(ColorSelect.colorF7E641),
              //     textStyleColor:Colors.black,
              //     onTap: () {
              //       postFavouriteApi(
              //           car: carController.text,
              //           bike: bikesController.text,
              //           movies: moviesController.text,
              //           shows: showsController.text,
              //           food: foodController.text,
              //           gadgets: gadgetsController.text,
              //           superheroes: superheroesController.text,
              //           actors: actorController.text,
              //           singer: singersController.text,
              //           actress: actressController.text,
              //           player: playersController.text,
              //           cities: citiesController.text,
              //           countries: countriesController.text,
              //           restaurants: restaurantsController.text,
              //           hotels: hotelsController.text,
              //           privacy: 'public').then((value) async {
              //         if(value['status'] ==  true) {
              //           Navigator.pop(context);
              //           Fluttertoast.showToast(
              //               msg: value['message']);
              //         } else {
              //           Fluttertoast.showToast(
              //               msg: value['message']);
              //         }
              //       });
              //     },
              //     title: 'Save'
              // ),
              // SizedBox(
              //   height: 20.h,
              // ),
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
