import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/constants/globals/shared_prefs.dart';
import 'package:swishlist/expanded/user_all_details.dart';
import 'package:swishlist/models/favourites_model.dart';
import 'package:swishlist/models/login_models.dart';

import '../api/user_apis/favourites_api.dart';
import '../buttons/light_yellow.dart';
import '../constants/decoration.dart';
import '../constants/globals/loading.dart';
import 'favourite_add_widgets/car_edit_dialog.dart';

class Favorites extends StatefulWidget {

  final LoginResponse response;
  const Favorites({
    Key? key,
    required this.response,
  }) : super(key: key);
  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  void initState() {
    getFavourites();
    fields();
    super.initState();
  }

  bool isLoading = false;

  // FavouritesModel? favourites = FavouritesModel(
  //     data: FavouriteData(
  //   // id: '',
  //   // userId: '',
  //   cars: '',
  //   bikes: '',
  //   movies: '',
  //   shows: '',
  //   foods: '',
  //   gadgets: '',
  //   superheroes: '',
  //   actors: '',
  //   actresses: '',
  //   singers: '',
  //   players: '',
  //   cities: '',
  //   countries: '',
  //   restaurants: '',
  //   hotels: '',
  //   privacyStatus: '',
  //   createdAt: '',
  // ));


  // FavouritesModel? favourites ;

  List<String> cars = [];
  List<String> bikes = [];
  List<String> movies = [];
  List<String> shows = [];
  List<String> food = [];
  List<String> gadgets = [];
  List<String> superheroes = [];
  List<String> actors = [];
  List<String> actresses = [];
  List<String> singers = [];
  List<String> players = [];
  List<String> cities = [];
  List<String> countries = [];
  List<String> restaurants = [];
  List<String> hotels = [];





  // favComplete = favourites.data?.complete;
  // parsedPercent = double.tryParse(complete?.replaceAll('%', '') ?? '0') ?? 0.0;




  FavouritesModel favourites = FavouritesModel();

  getFavourites() async {
    isLoading = true;
    var resp = getFavouritesApi();
    resp.then((value) {
     // print('abcdefghjkl ${value}');
      if(value['error'] == false){
        setState(() {
          favourites = FavouritesModel.fromJson(value);
          isLoading = false;
          print('qwertty${favourites}');
        });
        fields();
      }else{
        setState(() {
          isLoading = false;
        });
      }

    });
  }

 /* void fields() {
    //carController.text = favourites.data?.cars.toString() ?? '' ;
    // shirtController.text = sizeWeight!.data!.shirt ?? '';
    // shoeController.text = sizeWeight!.data!.shoe ?? '';
    // bedController.text = sizeWeight!.data!.bed ?? '';
  }
*/


  // List<String> fav = [];
  // double dou = 00;
  // var percent = "";

  // get() {
  //   if (favourites!.data.cars != null || favourites!.data.cars != '') {
  //     fav.add('cars');
  //   }
  //   if (favourites!.data.bikes != null || favourites!.data.bikes != '') {
  //     fav.add('bikes');
  //   }
  //   if (favourites!.data.movies != null || favourites!.data.movies != '') {
  //     fav.add('movies');
  //   }
  //   if (favourites!.data.shows != null || favourites!.data.shows != '') {
  //     fav.add('shows');
  //   }
  //   if (favourites!.data.foods != null || favourites!.data.foods != '') {
  //     fav.add('food');
  //   }
  //   if (favourites!.data.gadgets != null || favourites!.data.gadgets != '') {
  //     fav.add('gadgets');
  //   }
  //   if (favourites!.data.superheroes != null ||
  //       favourites!.data.superheroes != '') {
  //     fav.add('superheroes');
  //   }
  //   if (favourites!.data.actors != null || favourites!.data.actors != '') {
  //     fav.add('actors');
  //   }
  //   if (favourites!.data.actresses != null ||
  //       favourites!.data.actresses != '') {
  //     fav.add('actresses');
  //   }
  //   if (favourites!.data.singers != null || favourites!.data.singers != '') {
  //     fav.add('singers');
  //   }
  //   if (favourites!.data.players != null || favourites!.data.players != '') {
  //     fav.add('players');
  //   }
  //   if (favourites!.data.cities != null || favourites!.data.cities != '') {
  //     fav.add('cities');
  //   }
  //   if (favourites!.data.countries != null ||
  //       favourites!.data.countries != '') {
  //     fav.add('countries');
  //   }
  //   if (favourites!.data.restaurants != null ||
  //       favourites!.data.restaurants != '') {
  //     fav.add('restaurants');
  //   }
  //   if (favourites!.data.hotels != null || favourites!.data.hotels != '') {
  //     fav.add('hotels');
  //   }
  //   percent = ((fav.length / 15) * 100).toString().split(".").first;
  //   dou = (fav.length / 15);
  // }

  // getFavourites() {
  //   isLoading = true;
  //   var resp = getFavouritesApi();
  //   resp.then((value) {
  //     print(value);
  //     if (mounted) {
  //       if (value['status'] == true) {
  //         if (value['message'] == "No Favourites") {
  //           setState(() {
  //             isLoading = false;
  //           });
  //         } else {
  //           setState(() {
  //             favourites = FavouritesModel.fromJson(value);
  //             fields();
  //             get();
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

  void fields() {
    cars = favourites.data?.cars ?? [];
     bikes = favourites.data?.bikes ?? [];
    movies = favourites.data?.movies ?? [];
    shows = favourites.data?.shows ?? [];
    food = favourites.data?.foods ?? [];
    gadgets = favourites.data?.gadgets ?? [];
    superheroes = favourites.data?.superheroes ?? [];
    actors = favourites.data?.actors ?? [];
    actresses = favourites.data?.actresses ?? [];
    singers = favourites.data?.singers ?? [];
    players = favourites.data?.players ?? [];
    cities = favourites.data?.cities ?? [];
    countries = favourites.data?.countries ?? [];
    restaurants = favourites.data?.restaurants ?? [];
    hotels = favourites.data?.hotels ?? [];
  }


  final carController = TextEditingController();
  final bikesController = TextEditingController();
  final moviesController = TextEditingController();
  final showsController = TextEditingController();
  final foodController = TextEditingController();
  final gadgetsController = TextEditingController();
  final superheroesController = TextEditingController();
  final actorController = TextEditingController();
  final actressController = TextEditingController();
  final singersController = TextEditingController();
  final playersController = TextEditingController();
  final citiesController = TextEditingController();
  final countriesController = TextEditingController();
  final restaurantsController = TextEditingController();
  final hotelsController = TextEditingController();

  bool index1 = false;

  // String? completePercent;
  // double parsedPercent = 0.0;
  // double normalizedPercent = 0.0;

  String? favComplete;
  double parsedPercent = 0.0;


  @override
  Widget build(BuildContext context) {

    favComplete = favourites.data?.complete;
    parsedPercent = double.tryParse(favComplete?.replaceAll('%', '') ?? '0') ?? 0.0;

    // completePercent = favourites?.data?.completePercent;
    // parsedPercent = double.tryParse(completePercent ?? '0') ?? 0.0;
    // normalizedPercent = parsedPercent / 100.0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 100),
                  child: Text(
                    "Favorites",
                    style: AppTextStyle().textColor29292916w500,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 80),
                  child: isLoading
                      ? SizedBox()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(

                                (favourites.data == null || favourites.data!.complete == "" || favourites.data!.complete == null)
                                    ? "0"
                                    : favourites.data!.complete.toString().split(".").first,
                                style: AppTextStyle().textColor70707012w400,


                              /*  favourites.data!.complete ==
                                          "" ||
                                      favourites.data!.complete == null
                                  ? "0"
                                  : favourites.data!.complete
                                      .toString()
                                      .split(".")
                                      .first,*/


                            ),
                            Text(
                              "%  Percent",
                              style: AppTextStyle().textColor70707012w400,
                            )
                          ],
                        ),
                )
              ],
            ),
          ],
        ),
        leadingWidth: 40,
        leading: GestureDetector(
          onTap: () {
            //Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => UserAllDetails(response: widget.response,)));
          },
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.only(left: 20),
            child: SvgPicture.asset(
              "assets/icons/arrowback.svg",
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: isLoading
          ? Loading()
          : SingleChildScrollView(
              child: Column(
                children: [
                  LinearPercentIndicator(
                    curve: Curves.linear,
                    width: 1.sw,
                    padding: EdgeInsets.zero,
                    lineHeight: 8.0,
                    percent: parsedPercent/100,
                    backgroundColor: Color(0xffD55745).withOpacity(0.28),
                    progressColor: ColorSelect.colorD55745,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "Things",
                          style: AppTextStyle().textColor29292914w600,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Car',
                                  addTextField: TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(50),
                                    ],
                                    onChanged: (v) {
                                    },
                                    onEditingComplete: () {
                                      setState(() {
                                        cars.clear();
                                        cars.add(carController.text);
                                        print(carController.text);
                                      });
                                      Navigator.pop(context);
                                    },
                                    /*onEditingComplete: () {
                                      Navigator.pop(context);
                                    },*/
                                    controller: carController,
                                    cursorColor: ColorSelect.colorF7E641,
                                    decoration:
                                        AppTFDecoration(hint: 'Car Name')
                                            .decoration(),
                                    //keyboardType: TextInputType.phone,
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(

                              children: [
                                Expanded(
                                  child: Text(
                                    "Cars",
                                    style: AppTextStyle().textColor70707014w400,
                                  ),
                                ),
                                SizedBox(width: 8,),

                                Expanded(
                                  flex: 3,
                                  child: carController.text.isEmpty
                                      ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                    cars.isEmpty
                                                  ? "+ Add"
                                                  :
                                    favourites.data!.cars!.join(', '),
                                              style:
                                              cars.isEmpty
                                                  ? AppTextStyle()
                                                      .textColorD5574514w500
                                                  : AppTextStyle()
                                                      .textColor29292914w400,
                                            ),
                                        ],
                                      )
                                      : Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                   // width: 180,
                                            child: Text(
                                              // overflow: TextOverflow.ellipsis,
                                                carController.text,
                                                style: AppTextStyle()
                                                    .textColor29292914w400,
                                              ),
                                          ),
                                        ],
                                      ),
                                ),

                              ],
                            ),
                          ),
                          // child: CarRowWidget(favourites: favourites!,)
                        ),
                        //
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Bike',
                                  addTextField: TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(50),
                                    ],

                                    onChanged: (v) {},
                                    onEditingComplete: () {
                                      setState(() {
                                        bikes.clear();
                                        bikes.add(bikesController.text);
                                        //bikesController.clear();
                                      });
                                      // Clear the TextField

                                      // if (!fav.contains("cars")) {
                                      //   setState(() {
                                      //
                                      //     fav.add('cars');
                                      //   });
                                      // }
                                      print(bikesController);
                                      Navigator.pop(context);
                                    },
                                    controller: bikesController,
                                    cursorColor: ColorSelect.colorF7E641,
                                    decoration:
                                        AppTFDecoration(hint: 'bike Name')
                                            .decoration(),
                                    //keyboardType: TextInputType.phone,
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Bikes",
                                    style: AppTextStyle().textColor70707014w400,
                                  ),
                                ),
                                SizedBox(width: 8,),
                                //Spacer(),
                                Expanded(
                                  flex: 3,
                                  child: bikesController.text.isEmpty
                                      ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                    bikes.isEmpty
                                                  ? "+ Add"
                                                  : favourites.data!.bikes!
                                                  .join(', '),
                                              style: bikes.isEmpty
                                              //favourites.data?.bikes == ''
                                                  ? AppTextStyle()
                                                      .textColorD5574514w500
                                                  : AppTextStyle()
                                                      .textColor29292914w400,
                                            ),
                                        ],
                                      )
                                      : Column(
                                    crossAxisAlignment: CrossAxisAlignment.end ,
                                        children: [
                                          SizedBox(

                                            child: Text(
                                                bikesController.text,
                                                style: AppTextStyle()
                                                    .textColor29292914w400,
                                              ),
                                          ),
                                        ],
                                      ),
                                ),
                                // Image.asset("assets/images/information3.png"),
                                // SizedBox(
                                //   width: 20.w,
                                // ),
                                // Image.asset("assets/images/Vector175.png"),
                              ],
                            ),
                          ),
                          // child: BikesRowWidget(favourites: favourites!,),
                        ),

                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Movies',
                                  addTextField: TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(50),
                                    ],

                                    onChanged: (v) {},
                                    onEditingComplete: () {
                                      setState(() {});

                                        setState(() {
                                          movies.clear();
                                          movies.add(moviesController.text);
                                          //moviesController.clear();
                                        });
                                        // Clear the TextField

                                      // if (!fav.contains("cars")) {
                                      //   setState(() {
                                      //
                                      //     fav.add('cars');
                                      //   });
                                      // }
                                      print(moviesController);
                                      Navigator.pop(context);
                                    },
                                    controller: moviesController,
                                    cursorColor: ColorSelect.colorF7E641,
                                    decoration:
                                        AppTFDecoration(hint: 'Movies Name')
                                            .decoration(),
                                    //keyboardType: TextInputType.phone,
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Movies",
                                    style: AppTextStyle().textColor70707014w400,
                                  ),
                                ),
                                SizedBox(width: 8,),
                                //Spacer(),
                                Expanded(
                                   flex: 3,
                                  child: moviesController.text.isEmpty
                                      ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              // favourites.data?.movies.toString() ==
                                              //             "" ||
                                              //         favourites.data?.movies == null
                                    movies.isEmpty
                                                  ? "+ Add"
                                                  : favourites.data!.movies!
                                                  .join(', '),
                                              style: movies.isEmpty
                                              //favourites.data?.movies == ''
                                                  ? AppTextStyle()
                                                      .textColorD5574514w500
                                                  : AppTextStyle()
                                                      .textColor29292914w400,
                                            ),
                                        ],
                                      )
                                      : Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            child: Text(
                                                moviesController.text,
                                                style: AppTextStyle()
                                                    .textColor29292914w400,
                                              ),
                                          ),
                                        ],
                                      ),
                                )
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
                          ),
                          // child: MoviesWidget(favourites: favourites!),
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Show',
                                  addTextField: TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(50),
                                    ],

                                    onChanged: (v) {

                                    },
                                    onEditingComplete: () {


                                        setState(() {
                                          shows.clear();
                                          shows.add(showsController.text);
                                         // showsController.clear();
                                        });
                                        // Clear the TextField
                                      // if (!fav.contains("cars")) {
                                      //   setState(() {
                                      //
                                      //     fav.add('cars');
                                      //   });
                                      // }
                                      print(showsController);
                                      Navigator.pop(context);
                                    },
                                    controller: showsController,
                                    cursorColor: ColorSelect.colorF7E641,
                                    decoration:
                                        AppTFDecoration(hint: 'Show Name')
                                            .decoration(),
                                    //keyboardType: TextInputType.phone,
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Shows",
                                    style: AppTextStyle().textColor70707014w400,
                                  ),
                                ),
                                SizedBox(width: 8,),
                                //Spacer(),
                                Expanded(
                                  flex: 3,
                                  child: showsController.text.isEmpty
                                      ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              // favourites.data?.shows.toString() ==
                                              //             "" ||
                                              //         favourites.data?.shows == null
                                    shows.isEmpty
                                                  ? "+ Add"
                                                  : favourites.data!.shows!
                                                  .join(', '),
                                              style: shows.isEmpty
                                              //favourites.data?.shows == ''
                                                  ? AppTextStyle()
                                                      .textColorD5574514w500
                                                  : AppTextStyle()
                                                      .textColor29292914w400,
                                            ),
                                        ],
                                      )
                                      : Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            child: Text(
                                                showsController.text,
                                                style: AppTextStyle()
                                                    .textColor29292914w400,
                                              ),
                                          ),
                                        ],
                                      ),
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
                          ),
                          // child: ShowsRowWidget(favourites: favourites!,),
                        ),

                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Food',
                                  addTextField: TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(50),
                                    ],

                                    onChanged: (v) {

                                    },
                                    onEditingComplete: () {
                                      setState(() {});

                                        setState(() {
                                          food.clear();
                                          food.add(foodController.text);
                                         // foodController.clear();
                                        });
                                        // Clear the TextField

                                      // if (!fav.contains("cars")) {
                                      //   setState(() {
                                      //
                                      //     fav.add('cars');
                                      //   });
                                      // }
                                      print(foodController);
                                      Navigator.pop(context);
                                    },
                                    controller: foodController,
                                    cursorColor: ColorSelect.colorF7E641,
                                    decoration:
                                        AppTFDecoration(hint: 'Food Name')
                                            .decoration(),
                                    //keyboardType: TextInputType.phone,
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Food",
                                    style: AppTextStyle().textColor70707014w400,
                                  ),
                                ),
                                SizedBox(width: 8,),
                                //Spacer(),
                                Expanded(
                                  flex: 3,
                                  child: foodController.text.isEmpty
                                      ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              // favourites.data?.foods.toString() ==
                                              //             "" ||
                                              //         favourites.data?.foods == null
                                    food.isEmpty
                                                  ? "+ Add"
                                                  : favourites.data!.foods!
                                                  .join(', '),
                                              style: food.isEmpty
                                              //favourites.data?.foods == ''
                                                  ? AppTextStyle()
                                                      .textColorD5574514w500
                                                  : AppTextStyle()
                                                      .textColor29292914w400,
                                            ),
                                        ],
                                      )
                                      : Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            child: Text(
                                                foodController.text,
                                                style: AppTextStyle()
                                                    .textColor29292914w400,
                                              ),
                                          ),
                                        ],
                                      ),
                                ), // SizedBox(
                                //   width: 5.w,
                                // ),
                                // // Image.asset("assets/images/image46.png"),
                                // SizedBox(
                                //   width: 20.w,
                                // ),
                                // Image.asset("assets/images/Vector175.png"),
                              ],
                            ),
                          ),
                          // child: FoodRowWidget(favourites: favourites!,)
                        ),

                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Gadgets',
                                  addTextField: TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(50),
                                    ],

                                    onChanged: (v) {

                                    },
                                    onEditingComplete: () {


                                        setState(() {
                                          gadgets.clear();
                                          gadgets.add(gadgetsController.text);
                                          //gadgetsController.clear();
                                        });
                                        // Clear the TextField

                                      // if (!fav.contains("cars")) {
                                      //   setState(() {
                                      //
                                      //     fav.add('cars');
                                      //   });
                                      // }
                                      print(gadgetsController);
                                      Navigator.pop(context);
                                    },
                                    controller: gadgetsController,
                                    cursorColor: ColorSelect.colorF7E641,
                                    decoration:
                                        AppTFDecoration(hint: 'Gadgets Name')
                                            .decoration(),
                                    //keyboardType: TextInputType.phone,
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Gadgets",
                                    style: AppTextStyle().textColor70707014w400,
                                  ),
                                ),
                                SizedBox(width: 8,),
                                //Spacer(),
                                Expanded(
                                  flex: 3,
                                  child: gadgetsController.text.isEmpty
                                      ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              // favourites.data?.gadgets.toString() ==
                                              //             "" ||
                                              //         favourites.data?.gadgets ==
                                              //             null
                                    gadgets.isEmpty
                                                  ? "+ Add"
                                                  : favourites.data!.gadgets!
                                                  .join(', '),
                                              style: gadgets.isEmpty
                                              //favourites.data?.gadgets == ''
                                                  ? AppTextStyle()
                                                      .textColorD5574514w500
                                                  : AppTextStyle()
                                                      .textColor29292914w400,
                                            ),
                                        ],
                                      )
                                      : Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            child: Text(
                                                gadgetsController.text,
                                                style: AppTextStyle()
                                                    .textColor29292914w400,
                                              ),
                                          ),
                                        ],
                                      ),
                                )
                                // Image.asset("assets/images/information3.png"),
                                // SizedBox(
                                //   width: 20.w,
                                // ),
                                // Image.asset("assets/images/Vector175.png"),
                              ],
                            ),
                          ),
                          // child: GadgetsRowWidget(favourites: favourites!),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Text(
                          "People",
                          style: AppTextStyle().textColor29292914w600,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return NameEditDialogWidget(
                                    title: 'SuperHeroes',
                                    addTextField: TextFormField(
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(50),
                                      ],

                                      onChanged: (v) {
                                        setState(() {});

                                      },
                                      onEditingComplete: () {
                                       // if (superheroesController.text.isEmpty) {
                                          setState(() {
                                            superheroes.clear();
                                            superheroes.add(superheroesController.text);
                                            //superheroesController.clear();
                                          });
                                          // Clear the TextField
                                      //  }
                                        // if (!fav.contains("cars")) {
                                        //   setState(() {
                                        //
                                        //     fav.add('cars');
                                        //   });
                                        // }
                                        print(superheroesController);
                                        Navigator.pop(context);
                                      },
                                      controller: superheroesController,
                                      cursorColor: ColorSelect.colorF7E641,
                                      decoration: AppTFDecoration(
                                              hint: 'SuperHeroes Name')
                                          .decoration(),
                                      //keyboardType: TextInputType.phone,
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Superheroes",
                                      style: AppTextStyle().textColor70707014w400,
                                    ),
                                  ),
                                  SizedBox(width: 8,),
                                  //Spacer(),
                                  Expanded(
                                    flex: 3,
                                    child: superheroesController.text.isEmpty
                                        ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                      superheroes.isEmpty
                                                    ? "+ Add"
                                                    : favourites.data!.superheroes!
                                                    .join(', '),
                                                style:
                                                    superheroes.isEmpty
                                                    //favourites.data?.superheroes ==
                                                           // ''
                                                        ? AppTextStyle()
                                                            .textColorD5574514w500
                                                        : AppTextStyle()
                                                            .textColor29292914w400,
                                              ),
                                          ],
                                        )
                                        : Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              child: Text(
                                                  superheroesController.text,
                                                  style: AppTextStyle()
                                                      .textColor29292914w400,
                                                ),
                                            ),
                                          ],
                                        ),
                                  ),
                                ],
                              ),
                            )),
                        // child: SuperherosRowWidget(favourites: favourites!)),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Actors',
                                  addTextField: TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(50),
                                    ],

                                    onChanged: (v) {

                                    },
                                    onEditingComplete: () {

                                      //if (actorController.text.isEmpty) {
                                        setState(() {
                                          actors.clear();
;                                          actors.add(actorController.text);
                                         // actorController.clear();
                                        });

                                      print(actorController);
                                      Navigator.pop(context);
                                    },
                                    controller: actorController,
                                    cursorColor: ColorSelect.colorF7E641,
                                    decoration:
                                        AppTFDecoration(hint: 'Actors Name')
                                            .decoration(),
                                    //keyboardType: TextInputType.phone,
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Actors",
                                    style: AppTextStyle().textColor70707014w400,
                                  ),
                                ),
                                SizedBox(width: 8,),
                                //Spacer(),
                                Expanded(
                                  flex: 3,
                                  child: actorController.text.isEmpty
                                      ? Column(
                                     crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              // favourites.data?.actors.toString() ==
                                              //             "" ||
                                              //         favourites.data?.actors == null
                                    actors.isEmpty
                                                  ? "+ Add"
                                                  : favourites.data!.actors!
                                                  .join(', '),
                                              style: actors.isEmpty
                                              //favourites.data?.actors == ''
                                                  ? AppTextStyle()
                                                      .textColorD5574514w500
                                                  : AppTextStyle()
                                                      .textColor29292914w400,
                                              // "+ Add",
                                              // style: AppTextStyle().textColorD5574514w500,
                                            ),
                                        ],
                                      )
                                      : Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            child: Text(
                                                actorController.text,
                                                style: AppTextStyle()
                                                    .textColor29292914w400,
                                              ),
                                          ),
                                        ],
                                      ),
                                ),
                              ],
                            ),
                          ),
                          // child: ActorsRowWidget(favourites: favourites!),
                        ),

                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Actress',
                                  addTextField: TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(50),
                                    ],

                                    onChanged: (v) {

                                    },
                                    onEditingComplete: () {

                                      //if (actressController.text.isEmpty) {
                                        setState(() {
                                          actresses.clear();
                                          actresses.add(actressController.text);
                                          //actressController.clear();
                                        });
                                        // Clear the TextField
                                      //}
                                      // if (!fav.contains("cars")) {
                                      //   setState(() {
                                      //
                                      //     fav.add('cars');
                                      //   });
                                      // }
                                      print(actressController);
                                      Navigator.pop(context);
                                    },
                                    controller: actressController,
                                    cursorColor: ColorSelect.colorF7E641,
                                    decoration:
                                        AppTFDecoration(hint: 'Actress Name')
                                            .decoration(),
                                    //keyboardType: TextInputType.phone,
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Actresses",
                                    style: AppTextStyle().textColor70707014w400,
                                  ),
                                ),
                                SizedBox(width: 8,),
                                //Spacer(),
                                Expanded(
                                  flex: 3,
                                  child: actressController.text.isEmpty
                                      ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              // favourites.data?.actresses
                                              //                 .toString() ==
                                              //             "" ||
                                              //         favourites.data?.actresses ==
                                              //             null
                                    actresses.isEmpty
                                                  ? "+ Add"
                                                  : favourites.data!.actresses!
                                                  .join(', '),
                                              style: actresses.isEmpty
                                              //favourites.data?.actresses == ''
                                                  ? AppTextStyle()
                                                      .textColorD5574514w500
                                                  : AppTextStyle()
                                                      .textColor29292914w400,
                                              // "+ Add",
                                              // style: AppTextStyle().textColorD5574514w500,
                                            ),
                                        ],
                                      )
                                      : Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,

                                        children: [
                                          SizedBox(
                                            child: Text(
                                                actressController.text,
                                                style: AppTextStyle()
                                                    .textColor29292914w400,
                                              ),
                                          ),
                                        ],
                                      ),
                                ),
                              ],
                            ),
                          ),
                          // child: ActressesRowWidget(favourites: favourites!),
                        ),

                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Singers',
                                  addTextField: TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(50),
                                    ],

                                    controller: singersController,
                                    onChanged: (v) {

                                    },
                                    onEditingComplete: () {
                                    //  setState(() {});
                                     // if (singersController.text.isEmpty) {
                                        setState(() {
                                          singers.clear();
                                          singers.add(singersController.text);
                                          //singersController.clear();
                                        });
                                        // Clear the TextField
                                     // }
                                      // if (!fav.contains("cars")) {
                                      //   setState(() {
                                      //
                                      //     fav.add('cars');
                                      //   });
                                      // }
                                      print(singersController);
                                      Navigator.pop(context);
                                    },
                                    cursorColor: ColorSelect.colorF7E641,
                                    decoration:
                                        AppTFDecoration(hint: 'Singers Name')
                                            .decoration(),
                                    //keyboardType: TextInputType.phone,
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Singers",
                                    style: AppTextStyle().textColor70707014w400,
                                  ),
                                ),
                                SizedBox(width: 8,),
                                //Spacer(),
                                Expanded(
                                  flex: 3,
                                  child: singersController.text.isEmpty
                                      ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              // favourites.data?.singers.toString() ==
                                              //             "" ||
                                              //         favourites.data?.singers ==
                                              //             null
                                    singers.isEmpty
                                                  ? "+ Add"
                                                  : favourites.data!.singers!
                                                  .join(', '),
                                              style: singers.isEmpty
                                              //favourites.data?.singers == ''
                                                  ? AppTextStyle()
                                                      .textColorD5574514w500
                                                  : AppTextStyle()
                                                      .textColor29292914w400,
                                            ),
                                        ],
                                      )
                                      : Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            child: Text(
                                                singersController.text,
                                                style: AppTextStyle()
                                                    .textColor29292914w400,
                                              ),
                                          ),
                                        ],
                                      ),
                                ),
                              ],
                            ),
                          ),
                          // child: SingersRowWidget(favourites: favourites!),
                        ),

                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Players',
                                  addTextField: TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(50),
                                    ],
                                    onChanged: (v) {

                                    },
                                    onEditingComplete: () {
                                     // setState(() {});
                                     // if (playersController.text.isEmpty) {
                                        setState(() {
                                          players.clear();
                                          players.add(playersController.text);
                                          //playersController.clear();
                                        });
                                        // Clear the TextField
                                     //}
                                      // if (!fav.contains("cars")) {
                                      //   setState(() {
                                      //
                                      //     fav.add('cars');
                                      //   });
                                      // }
                                      print(playersController);
                                      Navigator.pop(context);
                                    },
                                    controller: playersController,
                                    cursorColor: ColorSelect.colorF7E641,
                                    decoration:
                                        AppTFDecoration(hint: 'Players Name')
                                            .decoration(),
                                    //keyboardType: TextInputType.phone,
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Players",
                                    style: AppTextStyle().textColor70707014w400,
                                  ),
                                ),
                                SizedBox(width: 8,),
                                //Spacer(),
                                Expanded(flex: 3,
                                  child: playersController.text.isEmpty
                                      ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              // favourites.data?.players.toString() ==
                                              //             "" ||
                                              //         favourites.data?.players ==
                                              //             null
                                    players.isEmpty
                                                  ? "+ Add"
                                                  : favourites.data!.players!
                                                  .join(', '),
                                              style:
                                              //favourites.data?.players == ''
                                          players.isEmpty
                                                  ? AppTextStyle()
                                                      .textColorD5574514w500
                                                  : AppTextStyle()
                                                      .textColor29292914w400,
                                              // "+ Add",
                                              // style: AppTextStyle().textColorD5574514w500,
                                            ),
                                        ],
                                      )
                                      : Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            child: Text(
                                                playersController.text,
                                                style: AppTextStyle()
                                                    .textColor29292914w400,
                                              ),
                                          ),
                                        ],
                                      ),
                                ),
                              ],
                            ),
                          ),
                          // child: PlayersRowWidget(favourites: favourites!),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Places",
                          style: AppTextStyle().textColor29292914w600,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Cities',
                                  addTextField: TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(50),
                                    ],
                                    onChanged: (v) {},
                                    onEditingComplete: () {
                                      setState(() {
                                        cities.clear();
                                        cities.add(citiesController.text);
                                        //playersController.clear();
                                      });
                                      // Clear the TextField
                                      //}
                                      // if (!fav.contains("cars")) {
                                      //   setState(() {
                                      //
                                      //     fav.add('cars');
                                      //   });
                                      // }
                                      print(citiesController);

                                      Navigator.pop(context);
                                    },

                                    controller: citiesController,
                                    cursorColor: ColorSelect.colorF7E641,
                                    decoration:
                                        AppTFDecoration(hint: 'Cities Name')
                                            .decoration(),
                                    //keyboardType: TextInputType.phone,
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Cities",
                                    style: AppTextStyle().textColor70707014w400,
                                  ),
                                ),
                                SizedBox(width: 8,),
                                //Spacer(),
                                Expanded(
                                  flex: 3,

                                  child: citiesController.text.isEmpty
                                      ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              // favourites.data?.cities.toString() ==
                                              //             "" ||
                                              //         favourites.data?.cities == null
                                    cities.isEmpty
                                                  ? "+ Add"
                                                  : favourites.data!.cities!
                                                  .join(', '),
                                              style: cities.isEmpty
                                              //favourites.data?.cities == ''
                                                  ? AppTextStyle()
                                                      .textColorD5574514w500
                                                  : AppTextStyle()
                                                      .textColor29292914w400,
                                            ),
                                        ],
                                      )
                                      : Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            child: Text(
                                                citiesController.text,
                                                style: AppTextStyle()
                                                    .textColor29292914w400,
                                              ),
                                          ),
                                        ],
                                      ),
                                ),
                                // Text(
                                //   "+ Add",
                                //   style: AppTextStyle().textColorD5574514w500,
                                // ),
                              ],
                            ),
                          ),
                          // child: CitiesRowWidget(favourites: favourites!,),
                        ),

                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Countries',
                                  addTextField: TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(50),
                                    ],
                                    controller: countriesController,
                                    onChanged: (v) {

                                    },
                                    onEditingComplete: () {
                                     // setState(() {});
                                     // if (countriesController.text.isEmpty) {
                                        setState(() {
                                          countries.clear();
                                          countries.add(countriesController.text);
                                         // countriesController.clear();
                                        });
                                        // Clear the TextField
                                     // }
                                      // if (!fav.contains("cars")) {
                                      //   setState(() {
                                      //
                                      //     fav.add('cars');
                                      //   });
                                      // }
                                      print(countriesController);
                                      Navigator.pop(context);
                                    },

                                    cursorColor: ColorSelect.colorF7E641,
                                    decoration:
                                        AppTFDecoration(hint: 'Countries Name')
                                            .decoration(),
                                    //keyboardType: TextInputType.phone,
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Countries",
                                    style: AppTextStyle().textColor70707014w400,

                                  ),
                                ),
                                SizedBox(width: 8,),
                                //Spacer(),
                                Expanded(
                                   flex: 3,
                                  child: countriesController.text.isEmpty
                                      ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              // favourites.data?.countries
                                              //                 .toString() ==
                                              //             "" ||
                                              //         favourites.data?.countries ==
                                              //             null
                                    countries.isEmpty
                                                  ? "+ Add"
                                                  : favourites.data!.countries!
                                                  .join(', '),
                                              style: countries.isEmpty
                                              //favourites.data?.countries == ''
                                                  ? AppTextStyle()
                                                      .textColorD5574514w500
                                                  : AppTextStyle()
                                                      .textColor29292914w400,
                                            ),
                                        ],
                                      )
                                      : Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [

                                          SizedBox(
                                            child: Text(
                                                countriesController.text,
                                                style: AppTextStyle()
                                                    .textColor29292914w400,
                                              ),
                                          ),
                                        ],
                                      ),
                                ),
                                // Text(
                                //   "+ Add",
                                //   style: AppTextStyle().textColorD5574514w500,
                                // ),
                              ],
                            ),
                          ),
                          // child: CountriesRowWidget(favourites: favourites!,)
                        ),

                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Restaurant',
                                  addTextField: TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(50),
                                    ],
                                    onChanged: (v) {
                                      //setState(() {});

                                    },
                                    onEditingComplete: () {

                                        setState(() {
                                          restaurants.clear();
                                          restaurants.add(restaurantsController.text);
                                          //restaurantsController.clear();
                                        });
                                        // Clear the TextField

                                      // if (!fav.contains("cars")) {
                                      //   setState(() {
                                      //
                                      //     fav.add('cars');
                                      //   });
                                      // }
                                      print(restaurantsController);
                                      Navigator.pop(context);
                                    },

                                    controller: restaurantsController,
                                    cursorColor: ColorSelect.colorF7E641,
                                    decoration:
                                        AppTFDecoration(hint: 'Restaurant Name')
                                            .decoration(),
                                    //keyboardType: TextInputType.phone,
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Restaurants",
                                    style: AppTextStyle().textColor70707014w400,
                                  ),
                                ),
                                SizedBox(width: 8,),
                                //Spacer(),
                                Expanded(
                                  flex: 3,
                                  child: restaurantsController.text.isEmpty
                                      ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              // favourites.data?.restaurants
                                              //                 .toString() ==
                                              //             "" ||
                                              //         favourites.data?.restaurants ==
                                              //             null
                                    restaurants.isEmpty
                                                  ? "+ Add"
                                                  : favourites.data!.restaurants!
                                                  .join(', '),
                                              style: restaurants.isEmpty
                                                  //favourites.data?.restaurants == ''
                                                      ? AppTextStyle()
                                                          .textColorD5574514w500
                                                      : AppTextStyle()
                                                          .textColor29292914w400,
                                            ),
                                        ],
                                      )
                                      : Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            child: Text(
                                                restaurantsController.text,
                                                style: AppTextStyle()
                                                    .textColor29292914w400,
                                              ),
                                          ),
                                        ],
                                      ),
                                )
                                // Text(
                                //   "+ Add",
                                //   style: AppTextStyle().textColorD5574514w500,
                                // ),
                              ],
                            ),
                          ),
                          // child: RestaurantsRowWidget(favourites: favourites!,)
                        ),

                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Hotel',
                                  addTextField: TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(50),
                                    ],
                                    onChanged: (v) {

                                    },
                                    onEditingComplete: () {
                                   //   setState(() {});
                                     // if (hotelsController.text.isEmpty) {
                                        setState(() {
                                          hotels.clear();
                                          hotels.add(hotelsController.text);
                                          //hotelsController.clear();
                                        });
                                        // Clear the TextField
                                      //}
                                      // if (!fav.contains("cars")) {
                                      //   setState(() {
                                      //
                                      //     fav.add('cars');
                                      //   });
                                      // }
                                      print(hotelsController);
                                      Navigator.pop(context);
                                    },
                                    controller: hotelsController,
                                    cursorColor: ColorSelect.colorF7E641,
                                    decoration:
                                        AppTFDecoration(hint: 'Hotel Name')
                                            .decoration(),
                                    //keyboardType: TextInputType.phone,
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(

                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Hotels",
                                    style: AppTextStyle().textColor70707014w400,
                                  ),
                                ),
                                SizedBox(width: 8,),
                                // Spacer(),
                                Expanded(
                                  flex: 3,
                                  child: hotelsController.text.isEmpty
                                      ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              // favourites.data?.hotels.toString() ==
                                              //             "" ||
                                              //         favourites.data?.hotels == null
                                    hotels.isEmpty
                                                  ? "+ Add"
                                                  : favourites.data!.hotels!
                                                  .join(', '),
                                              style: hotels.isEmpty
                                              //favourites.data?.hotels == ''
                                                  ? AppTextStyle()
                                                      .textColorD5574514w500
                                                  : AppTextStyle()
                                                      .textColor29292914w400,
                                            ),
                                        ],
                                      )
                                      : Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              hotelsController.text,

                                              style: AppTextStyle()
                                                  .textColor29292914w400,
                                            ),
                                        ],
                                      ),
                                ),
                                // Text(
                                //   "+ Add",
                                //   style: AppTextStyle().textColorD5574514w500,
                                // ),
                              ],
                            ),
                          ),
                          // child: HotelRowWidget(favourites: favourites!,),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        // (favourites!.data!.hotels.toString() == '')
                        //     ?
                        LightYellowButtonWithText(
                                size: 15,
                                backgroundColor: MaterialStateProperty.all(
                                    ColorSelect.colorF7E641),
                                textStyleColor: Colors.black,
                                onTap: () {
                                  postFavouriteApi(
                                          car: cars,
                                          bike: bikes,
                                          movies: movies,
                                          shows: shows,
                                          food: food,
                                          gadgets: gadgets,
                                          superheroes:
                                              superheroes,
                                          actors: actors,
                                          singer: singers,
                                          actress: actresses,
                                          player: players,
                                          cities: cities,
                                          countries: countries,
                                          restaurants:
                                              restaurants,
                                          hotels: hotels,
                                          privacy: 'friend')
                                      .then((value) async {

                                        print(cars);
                                        print(bikes);
                                    if (value['error'] == false) {
                                      //SharedPrefs().setFavourites('100 %');

                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            // Your new route/widget here
                                            return UserAllDetails(
                                              response: widget.response,
                                            );
                                          },
                                        ),
                                      );
                                      // setState(() {
                                      //   isLoading ? Loading() : getFavourites();
                                      // });
                                      Fluttertoast.showToast(
                                          msg: value['message']);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg:
                                              //'please fill all details field'
                                        value['message']
                                      );
                                    }
                                  });
                                },
                                title: 'Add'),
                            // : LightYellowButtonWithText(
                            //     size: 15,
                            //     backgroundColor: MaterialStateProperty.all(
                            //         ColorSelect.colorF7E641),
                            //     textStyleColor: Colors.black,
                            //     onTap: () {
                            //       updateFavouriteApi(
                            //               car: carController.text,
                            //               bike: bikesController.text,
                            //               movies: moviesController.text,
                            //               shows: showsController.text,
                            //               food: foodController.text,
                            //               gadgets: gadgetsController.text,
                            //               superheroes:
                            //                   superheroesController.text,
                            //               actors: actorController.text,
                            //               singer: singersController.text,
                            //               actress: actressController.text,
                            //               player: playersController.text,
                            //               cities: citiesController.text,
                            //               countries: countriesController.text,
                            //               restaurants:
                            //                   restaurantsController.text,
                            //               hotels: hotelsController.text,
                            //               privacy: 'public',
                            //               id: favourites!.data!.id.toString())
                            //           .then((value) async {
                            //         if (value['status'] == true) {
                            //           Navigator.of(context).pushReplacement(
                            //             MaterialPageRoute(
                            //               builder: (BuildContext context) {
                            //                 // Your new route/widget here
                            //                 return UserAllDetails(
                            //                   response: widget.response,
                            //                 );
                            //               },
                            //             ),
                            //           );
                            //           setState(() {
                            //             // isLoading ? Loading() : getFavourites();
                            //           });
                            //           // Navigator.pop(context);
                            //
                            //           Fluttertoast.showToast(
                            //               msg: value['message']);
                            //         } else {
                            //           Fluttertoast.showToast(
                            //               msg: 'please update all fields');
                            //         }
                            //       });
                            //     },
                            //     title: 'Update'),
                        SizedBox(
                          height: 40.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
