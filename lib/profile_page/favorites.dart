import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/constants/globals/shared_prefs.dart';
import 'package:swishlist/models/favourites_model.dart';

import '../api/user_apis/favourites_api.dart';
import '../buttons/light_yellow.dart';
import '../constants/decoration.dart';
import '../constants/globals/loading.dart';
import 'favourite_add_widgets/car_edit_dialog.dart';

class Favorites extends StatefulWidget {
  const Favorites({
    Key? key,
  }) : super(key: key);
  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  void initState() {
    getFavourites();
    super.initState();
  }

  bool isLoading = false;
  FavouritesModel? favourites = FavouritesModel(
      data: Data(
    // id: '',
    // userId: '',
    cars: '',
    bikes: '',
    movies: '',
    shows: '',
    foods: '',
    gadgets: '',
    superheroes: '',
    actors: '',
    actresses: '',
    singers: '',
    players: '',
    cities: '',
    countries: '',
    restaurants: '',
    hotels: '',
    privacyStatus: '',
    createdAt: '',
  ));
  List<String> fav = [];
  double dou = 00;
  var percent = "";
  get() {
    if (favourites!.data!.cars != null || favourites!.data!.cars != '') {
      fav.add('cars');
    }
    if (favourites!.data!.bikes != null || favourites!.data!.bikes != '') {
      fav.add('bikes');
    }
    if (favourites!.data!.movies != null || favourites!.data!.movies != '') {
      fav.add('movies');
    }
    if (favourites!.data!.shows != null || favourites!.data!.shows != '') {
      fav.add('shows');
    }
    if (favourites!.data!.foods != null || favourites!.data!.foods != '') {
      fav.add('food');
    }
    if (favourites!.data!.gadgets != null || favourites!.data!.gadgets != '') {
      fav.add('gadgets');
    }
    if (favourites!.data!.superheroes != null ||
        favourites!.data!.superheroes != '') {
      fav.add('superheroes');
    }
    if (favourites!.data!.actors != null || favourites!.data!.actors != '') {
      fav.add('actors');
    }
    if (favourites!.data!.actresses != null ||
        favourites!.data!.actresses != '') {
      fav.add('actresses');
    }
    if (favourites!.data!.singers != null || favourites!.data!.singers != '') {
      fav.add('singers');
    }
    if (favourites!.data!.players != null || favourites!.data!.players != '') {
      fav.add('players');
    }
    if (favourites!.data!.cities != null || favourites!.data!.cities != '') {
      fav.add('cities');
    }
    if (favourites!.data!.countries != null ||
        favourites!.data!.countries != '') {
      fav.add('countries');
    }
    if (favourites!.data!.restaurants != null ||
        favourites!.data!.restaurants != '') {
      fav.add('restaurants');
    }
    if (favourites!.data!.hotels != null || favourites!.data!.hotels != '') {
      fav.add('hotels');
    }
    percent = ((fav.length / 15) * 100).toString().split(".").first;
    dou = (fav.length / 15);
  }

  getFavourites() {
    isLoading = true;
    var resp = getFavouritesApi();
    resp.then((value) {
      print(value);
      if (mounted) {
        if (value['status'] == true) {
          if (value['message'] == "No Favourites") {
            setState(() {
              isLoading = false;
            });
          } else {
            setState(() {
              favourites = FavouritesModel.fromJson(value);
              fields();
              get();
              isLoading = false;
            });
          }
        } else {
          setState(() {
            isLoading = false;
          });
        }
      }
    });
  }

  void fields() {
    carController.text = favourites!.data!.cars ?? '';
    bikesController.text = favourites!.data!.bikes ?? '';
    moviesController.text = favourites!.data!.movies ?? '';
    showsController.text = favourites!.data!.shows ?? '';
    foodController.text = favourites!.data!.foods ?? '';
    gadgetsController.text = favourites!.data!.gadgets ?? '';
    superheroesController.text = favourites!.data!.superheroes ?? '';
    actorController.text = favourites!.data!.actors ?? '';
    actressController.text = favourites!.data!.actresses ?? '';
    singersController.text = favourites!.data!.singers ?? '';
    playersController.text = favourites!.data!.players ?? '';
    citiesController.text = favourites!.data!.cities ?? '';
    countriesController.text = favourites!.data!.countries ?? '';
    restaurantsController.text = favourites!.data!.restaurants ?? '';
    hotelsController.text = favourites!.data!.hotels ?? '';
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

  @override
  Widget build(BuildContext context) {
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
                              favourites!.data!.completePercent.toString() ==
                                          "" ||
                                      favourites!.data!.completePercent == null
                                  ? "0"
                                  : favourites!.data!.completePercent
                                      .toString()
                                      .split(".")
                                      .first,
                              // sizeWeight!.data!.completePercent
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
                )
              ],
            ),
          ],
        ),
        leadingWidth: 40,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
            (favourites!.data!.hotels.toString() == '')
                ? postFavouriteApi(
                        car: carController.text,
                        bike: bikesController.text,
                        movies: moviesController.text,
                        shows: showsController.text,
                        food: foodController.text,
                        gadgets: gadgetsController.text,
                        superheroes: superheroesController.text,
                        actors: actorController.text,
                        singer: singersController.text,
                        actress: actressController.text,
                        player: playersController.text,
                        cities: citiesController.text,
                        countries: countriesController.text,
                        restaurants: restaurantsController.text,
                        hotels: hotelsController.text,
                        privacy: 'public')
                    .then((value) async {
                    if (value['status'] == true) {
                      SharedPrefs().setFavourites('100 %');

                      Navigator.pop(context);
                      // setState(() {
                      //   isLoading ? Loading() : getFavourites();
                      // });
                    } else {}
                  })
                : updateFavouriteApi(
                        car: carController.text,
                        bike: bikesController.text,
                        movies: moviesController.text,
                        shows: showsController.text,
                        food: foodController.text,
                        gadgets: gadgetsController.text,
                        superheroes: superheroesController.text,
                        actors: actorController.text,
                        singer: singersController.text,
                        actress: actressController.text,
                        player: playersController.text,
                        cities: citiesController.text,
                        countries: countriesController.text,
                        restaurants: restaurantsController.text,
                        hotels: hotelsController.text,
                        privacy: 'public',
                        id: favourites!.data!.id.toString())
                    .then((value) async {
                    if (value['status'] == true) {
                      setState(() {
                        // isLoading ? Loading() : getFavourites();
                      });
                      // Navigator.pop(context);

                      Fluttertoast.showToast(msg: value['message']);
                    } else {
                      Fluttertoast.showToast(msg: 'please update all fields');
                    }
                  });
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
                    percent: (fav.length / 15),
                    backgroundColor: Color(0xffD55745).withOpacity(0.28),
                    progressColor: ColorSelect.colorD55745,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40.h,
                        ),
                        Text(
                          "Things",
                          style: AppTextStyle().textColor29292914w600,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Car',
                                  addTextField: TextFormField(
                                    onChanged: (v) {
                                      setState(() {});
                                      if (!fav.contains("cars")) {
                                        setState(() {
                                          fav.add('cars');
                                        });
                                      }
                                      print(carController);
                                    },
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
                          child: Row(
                            children: [
                              Text(
                                "Cars",
                                style: AppTextStyle().textColor70707014w400,
                              ),
                              Spacer(),
                              carController.text.isEmpty
                                  ? Text(
                                      favourites!.data!.cars.toString() == "" ||
                                              favourites!.data!.cars == null
                                          ? "+ Add"
                                          : favourites!.data!.cars.toString(),
                                      style: favourites!.data!.cars == ''
                                          ? AppTextStyle().textColorD5574514w500
                                          : AppTextStyle()
                                              .textColor29292914w400,
                                    )
                                  : Text(
                                      carController.text,
                                      style:
                                          AppTextStyle().textColor29292914w400,
                                    )
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
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Bike',
                                  addTextField: TextFormField(
                                    onChanged: (v) {
                                      setState(() {});
                                      if (!fav.contains("bikes")) {
                                        setState(() {
                                          fav.add('bikes');
                                        });
                                      }
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
                          child: Row(
                            children: [
                              Text(
                                "Bikes",
                                style: AppTextStyle().textColor70707014w400,
                              ),
                              Spacer(),
                              bikesController.text.isEmpty
                                  ? Text(
                                      favourites!.data!.bikes.toString() ==
                                                  "" ||
                                              favourites!.data!.bikes == null
                                          ? "+ Add"
                                          : favourites!.data!.bikes.toString(),
                                      style: favourites!.data!.bikes == ''
                                          ? AppTextStyle().textColorD5574514w500
                                          : AppTextStyle()
                                              .textColor29292914w400,
                                    )
                                  : Text(
                                      bikesController.text,
                                      style:
                                          AppTextStyle().textColor29292914w400,
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
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Movies',
                                  addTextField: TextFormField(
                                    onChanged: (v) {
                                      setState(() {});
                                      if (!fav.contains("movies")) {
                                        setState(() {
                                          fav.add('movies');
                                        });
                                      }
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
                          child: Row(
                            children: [
                              Text(
                                "Movies",
                                style: AppTextStyle().textColor70707014w400,
                              ),
                              Spacer(),
                              moviesController.text.isEmpty
                                  ? Text(
                                      favourites!.data!.movies.toString() ==
                                                  "" ||
                                              favourites!.data!.movies == null
                                          ? "+ Add"
                                          : favourites!.data!.movies.toString(),
                                      style: favourites!.data!.movies == ''
                                          ? AppTextStyle().textColorD5574514w500
                                          : AppTextStyle()
                                              .textColor29292914w400,
                                    )
                                  : Text(
                                      moviesController.text,
                                      style:
                                          AppTextStyle().textColor29292914w400,
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
                          // child: MoviesWidget(favourites: favourites!),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Show',
                                  addTextField: TextFormField(
                                    onChanged: (v) {
                                      setState(() {});
                                      if (!fav.contains("shows")) {
                                        setState(() {
                                          fav.add('shows');
                                        });
                                      }
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
                          child: Row(
                            children: [
                              Text(
                                "Shows",
                                style: AppTextStyle().textColor70707014w400,
                              ),
                              Spacer(),
                              showsController.text.isEmpty
                                  ? Text(
                                      favourites!.data!.shows.toString() ==
                                                  "" ||
                                              favourites!.data!.shows == null
                                          ? "+ Add"
                                          : favourites!.data!.shows.toString(),
                                      style: favourites!.data!.shows == ''
                                          ? AppTextStyle().textColorD5574514w500
                                          : AppTextStyle()
                                              .textColor29292914w400,
                                    )
                                  : Text(
                                      showsController.text,
                                      style:
                                          AppTextStyle().textColor29292914w400,
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
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Food',
                                  addTextField: TextFormField(
                                    onChanged: (v) {
                                      setState(() {});
                                      if (!fav.contains("foods")) {
                                        setState(() {
                                          fav.add('foods');
                                        });
                                      }
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
                          child: Row(
                            children: [
                              Text(
                                "Food",
                                style: AppTextStyle().textColor70707014w400,
                              ),
                              Spacer(),
                              foodController.text.isEmpty
                                  ? Text(
                                      favourites!.data!.foods.toString() ==
                                                  "" ||
                                              favourites!.data!.foods == null
                                          ? "+ Add"
                                          : favourites!.data!.foods.toString(),
                                      style: favourites!.data!.foods == ''
                                          ? AppTextStyle().textColorD5574514w500
                                          : AppTextStyle()
                                              .textColor29292914w400,
                                    )
                                  : Text(
                                      foodController.text,
                                      style:
                                          AppTextStyle().textColor29292914w400,
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
                          // child: FoodRowWidget(favourites: favourites!,)
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Gadgets',
                                  addTextField: TextFormField(
                                    onChanged: (v) {
                                      setState(() {});
                                      if (!fav.contains("gadgets")) {
                                        setState(() {
                                          fav.add('gadgets');
                                        });
                                      }
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
                          child: Row(
                            children: [
                              Text(
                                "Gadgets",
                                style: AppTextStyle().textColor70707014w400,
                              ),
                              Spacer(),
                              gadgetsController.text.isEmpty
                                  ? Text(
                                      favourites!.data!.gadgets.toString() ==
                                                  "" ||
                                              favourites!.data!.gadgets == null
                                          ? "+ Add"
                                          : favourites!.data!.gadgets
                                              .toString(),
                                      style: favourites!.data!.gadgets == ''
                                          ? AppTextStyle().textColorD5574514w500
                                          : AppTextStyle()
                                              .textColor29292914w400,
                                    )
                                  : Text(
                                      gadgetsController.text,
                                      style:
                                          AppTextStyle().textColor29292914w400,
                                    )
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
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return NameEditDialogWidget(
                                    title: 'SuperHeroes',
                                    addTextField: TextFormField(
                                      onChanged: (v) {
                                        setState(() {});
                                        if (!fav.contains("superheroes")) {
                                          setState(() {
                                            fav.add('superheroes');
                                          });
                                        }
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
                            child: Row(
                              children: [
                                Text(
                                  "Superheroes",
                                  style: AppTextStyle().textColor70707014w400,
                                ),
                                Spacer(),
                                superheroesController.text.isEmpty
                                    ? Text(
                                        // "Deadpool",
                                        favourites!.data!.superheroes
                                                        .toString() ==
                                                    "" ||
                                                favourites!.data!.superheroes ==
                                                    null
                                            ? "+ Add"
                                            : favourites!.data!.superheroes
                                                .toString(),
                                        style:
                                            favourites!.data!.superheroes == ''
                                                ? AppTextStyle()
                                                    .textColorD5574514w500
                                                : AppTextStyle()
                                                    .textColor29292914w400,
                                      )
                                    : Text(
                                        superheroesController.text,
                                        style: AppTextStyle()
                                            .textColor29292914w400,
                                      ),
                              ],
                            )),
                        // child: SuperherosRowWidget(favourites: favourites!)),
                        SizedBox(
                          height: 20.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Actors',
                                  addTextField: TextFormField(
                                    onChanged: (v) {
                                      setState(() {});
                                      if (!fav.contains("actors")) {
                                        setState(() {
                                          fav.add('actors');
                                        });
                                      }
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
                          child: Row(
                            children: [
                              Text(
                                "Actors",
                                style: AppTextStyle().textColor70707014w400,
                              ),
                              Spacer(),
                              actorController.text.isEmpty
                                  ? Text(
                                      favourites!.data!.actors.toString() ==
                                                  "" ||
                                              favourites!.data!.actors == null
                                          ? "+ Add"
                                          : favourites!.data!.actors.toString(),
                                      style: favourites!.data!.actors == ''
                                          ? AppTextStyle().textColorD5574514w500
                                          : AppTextStyle()
                                              .textColor29292914w400,
                                      // "+ Add",
                                      // style: AppTextStyle().textColorD5574514w500,
                                    )
                                  : Text(
                                      actorController.text,
                                      style:
                                          AppTextStyle().textColor29292914w400,
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
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Actress',
                                  addTextField: TextFormField(
                                    onChanged: (v) {
                                      setState(() {});
                                      if (!fav.contains("actresses")) {
                                        setState(() {
                                          fav.add('actresses');
                                        });
                                      }
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
                          child: Row(
                            children: [
                              Text(
                                "Actresses",
                                style: AppTextStyle().textColor70707014w400,
                              ),
                              Spacer(),
                              actressController.text.isEmpty
                                  ? Text(
                                      favourites!.data!.actresses.toString() ==
                                                  "" ||
                                              favourites!.data!.actresses ==
                                                  null
                                          ? "+ Add"
                                          : favourites!.data!.actresses
                                              .toString(),
                                      style: favourites!.data!.actresses == ''
                                          ? AppTextStyle().textColorD5574514w500
                                          : AppTextStyle()
                                              .textColor29292914w400,
                                      // "+ Add",
                                      // style: AppTextStyle().textColorD5574514w500,
                                    )
                                  : Text(
                                      actressController.text,
                                      style:
                                          AppTextStyle().textColor29292914w400,
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
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Singers',
                                  addTextField: TextFormField(
                                    controller: singersController,
                                    onChanged: (v) {
                                      setState(() {});
                                      if (!fav.contains("singers")) {
                                        setState(() {
                                          fav.add('singers');
                                        });
                                      }
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
                          child: Row(
                            children: [
                              Text(
                                "Singers",
                                style: AppTextStyle().textColor70707014w400,
                              ),
                              Spacer(),
                              singersController.text.isEmpty
                                  ? Text(
                                      favourites!.data!.singers.toString() ==
                                                  "" ||
                                              favourites!.data!.singers == null
                                          ? "+ Add"
                                          : favourites!.data!.singers
                                              .toString(),
                                      style: favourites!.data!.singers == ''
                                          ? AppTextStyle().textColorD5574514w500
                                          : AppTextStyle()
                                              .textColor29292914w400,
                                    )
                                  : Text(
                                      singersController.text,
                                      style:
                                          AppTextStyle().textColor29292914w400,
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
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Players',
                                  addTextField: TextFormField(
                                    onChanged: (v) {
                                      setState(() {});
                                      if (!fav.contains("players")) {
                                        setState(() {
                                          fav.add('players');
                                        });
                                      }
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
                          child: Row(
                            children: [
                              Text(
                                "Players",
                                style: AppTextStyle().textColor70707014w400,
                              ),
                              Spacer(),
                              playersController.text.isEmpty
                                  ? Text(
                                      favourites!.data!.players.toString() ==
                                                  "" ||
                                              favourites!.data!.players == null
                                          ? "+ Add"
                                          : favourites!.data!.players
                                              .toString(),
                                      style: favourites!.data!.players == ''
                                          ? AppTextStyle().textColorD5574514w500
                                          : AppTextStyle()
                                              .textColor29292914w400,
                                      // "+ Add",
                                      // style: AppTextStyle().textColorD5574514w500,
                                    )
                                  : Text(
                                      playersController.text,
                                      style:
                                          AppTextStyle().textColor29292914w400,
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
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Cities',
                                  addTextField: TextFormField(
                                    onChanged: (v) {
                                      setState(() {});
                                      if (!fav.contains("cities")) {
                                        setState(() {
                                          fav.add('cities');
                                        });
                                      }
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
                          child: Row(
                            children: [
                              Text(
                                "Cities",
                                style: AppTextStyle().textColor70707014w400,
                              ),
                              Spacer(),
                              citiesController.text.isEmpty
                                  ? Text(
                                      favourites!.data!.cities.toString() ==
                                                  "" ||
                                              favourites!.data!.cities == null
                                          ? "+ Add"
                                          : favourites!.data!.cities.toString(),
                                      style: favourites!.data!.cities == ''
                                          ? AppTextStyle().textColorD5574514w500
                                          : AppTextStyle()
                                              .textColor29292914w400,
                                    )
                                  : Text(
                                      citiesController.text,
                                      style:
                                          AppTextStyle().textColor29292914w400,
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
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Countries',
                                  addTextField: TextFormField(
                                    controller: countriesController,
                                    onChanged: (v) {
                                      setState(() {});
                                      if (!fav.contains("countries")) {
                                        setState(() {
                                          fav.add('countries');
                                        });
                                      }
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
                          child: Row(
                            children: [
                              Text(
                                "Countries",
                                style: AppTextStyle().textColor70707014w400,
                              ),
                              Spacer(),
                              countriesController.text.isEmpty
                                  ? Text(
                                      favourites!.data!.countries.toString() ==
                                                  "" ||
                                              favourites!.data!.countries ==
                                                  null
                                          ? "+ Add"
                                          : favourites!.data!.countries
                                              .toString(),
                                      style: favourites!.data!.countries == ''
                                          ? AppTextStyle().textColorD5574514w500
                                          : AppTextStyle()
                                              .textColor29292914w400,
                                    )
                                  : Text(
                                      countriesController.text,
                                      style:
                                          AppTextStyle().textColor29292914w400,
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
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Restaurant',
                                  addTextField: TextFormField(
                                    onChanged: (v) {
                                      setState(() {});
                                      if (!fav.contains("restaurants")) {
                                        setState(() {
                                          fav.add('restaurants');
                                        });
                                      }
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
                          child: Row(
                            children: [
                              Text(
                                "Restaurants",
                                style: AppTextStyle().textColor70707014w400,
                              ),
                              Spacer(),
                              restaurantsController.text.isEmpty
                                  ? Text(
                                      favourites!.data!.restaurants
                                                      .toString() ==
                                                  "" ||
                                              favourites!.data!.restaurants ==
                                                  null
                                          ? "+ Add"
                                          : favourites!.data!.restaurants
                                              .toString(),
                                      style: favourites!.data!.restaurants == ''
                                          ? AppTextStyle().textColorD5574514w500
                                          : AppTextStyle()
                                              .textColor29292914w400,
                                    )
                                  : Text(
                                      restaurantsController.text,
                                      style:
                                          AppTextStyle().textColor29292914w400,
                                    )
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
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NameEditDialogWidget(
                                  title: 'Hotel',
                                  addTextField: TextFormField(
                                    onChanged: (v) {
                                      setState(() {});
                                      if (!fav.contains("hotels")) {
                                        setState(() {
                                          fav.add('hotels');
                                        });
                                      }
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
                          child: Row(
                            children: [
                              Text(
                                "Hotels",
                                style: AppTextStyle().textColor70707014w400,
                              ),
                              Spacer(),
                              hotelsController.text.isEmpty
                                  ? Text(
                                      favourites!.data!.hotels.toString() ==
                                                  "" ||
                                              favourites!.data!.hotels == null
                                          ? "+ Add"
                                          : favourites!.data!.hotels.toString(),
                                      style: favourites!.data!.hotels == ''
                                          ? AppTextStyle().textColorD5574514w500
                                          : AppTextStyle()
                                              .textColor29292914w400,
                                    )
                                  : Text(
                                      hotelsController.text,
                                      style:
                                          AppTextStyle().textColor29292914w400,
                                    ),
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
                        (favourites!.data!.hotels.toString() == '')
                            ? LightYellowButtonWithText(
                                backgroundColor: (carController
                                            .text.isNotEmpty &&
                                        bikesController.text.isNotEmpty &&
                                        moviesController.text.isNotEmpty &&
                                        showsController.text.isNotEmpty &&
                                        foodController.text.isNotEmpty &&
                                        gadgetsController.text.isNotEmpty &&
                                        superheroesController.text.isNotEmpty &&
                                        actorController.text.isNotEmpty &&
                                        singersController.text.isNotEmpty &&
                                        actressController.text.isNotEmpty &&
                                        playersController.text.isNotEmpty &&
                                        citiesController.text.isNotEmpty &&
                                        countriesController.text.isNotEmpty &&
                                        restaurantsController.text.isNotEmpty &&
                                        hotelsController.text.isNotEmpty)
                                    ? MaterialStateProperty.all(
                                        ColorSelect.colorF7E641)
                                    : MaterialStateProperty.all(
                                        ColorSelect.colorFCF5B6),
                                textStyleColor: (carController
                                            .text.isNotEmpty &&
                                        bikesController.text.isNotEmpty &&
                                        moviesController.text.isNotEmpty &&
                                        showsController.text.isNotEmpty &&
                                        foodController.text.isNotEmpty &&
                                        gadgetsController.text.isNotEmpty &&
                                        superheroesController.text.isNotEmpty &&
                                        actorController.text.isNotEmpty &&
                                        singersController.text.isNotEmpty &&
                                        actressController.text.isNotEmpty &&
                                        playersController.text.isNotEmpty &&
                                        citiesController.text.isNotEmpty &&
                                        countriesController.text.isNotEmpty &&
                                        restaurantsController.text.isNotEmpty &&
                                        hotelsController.text.isNotEmpty)
                                    ? Colors.black
                                    : ColorSelect.colorB5B07A,
                                onTap: () {
                                  if (carController.text.isNotEmpty &&
                                      bikesController.text.isNotEmpty &&
                                      moviesController.text.isNotEmpty &&
                                      showsController.text.isNotEmpty &&
                                      foodController.text.isNotEmpty &&
                                      gadgetsController.text.isNotEmpty &&
                                      superheroesController.text.isNotEmpty &&
                                      actorController.text.isNotEmpty &&
                                      singersController.text.isNotEmpty &&
                                      actressController.text.isNotEmpty &&
                                      playersController.text.isNotEmpty &&
                                      citiesController.text.isNotEmpty &&
                                      countriesController.text.isNotEmpty &&
                                      restaurantsController.text.isNotEmpty &&
                                      hotelsController.text.isNotEmpty) {
                                    postFavouriteApi(
                                            car: carController.text,
                                            bike: bikesController.text,
                                            movies: moviesController.text,
                                            shows: showsController.text,
                                            food: foodController.text,
                                            gadgets: gadgetsController.text,
                                            superheroes:
                                                superheroesController.text,
                                            actors: actorController.text,
                                            singer: singersController.text,
                                            actress: actressController.text,
                                            player: playersController.text,
                                            cities: citiesController.text,
                                            countries: countriesController.text,
                                            restaurants:
                                                restaurantsController.text,
                                            hotels: hotelsController.text,
                                            privacy: 'public')
                                        .then((value) async {
                                      if (value['status'] == true) {
                                        SharedPrefs().setFavourites('100 %');

                                        Navigator.pop(context);
                                        // setState(() {
                                        //   isLoading ? Loading() : getFavourites();
                                        // });
                                        Fluttertoast.showToast(
                                            msg: value['message']);
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                                'please fill all details field' /*value['message']*/);
                                      }
                                    });
                                  }
                                },
                                title: 'Add')
                            : LightYellowButtonWithText(
                                backgroundColor: (carController
                                            .text.isNotEmpty &&
                                        bikesController.text.isNotEmpty &&
                                        moviesController.text.isNotEmpty &&
                                        showsController.text.isNotEmpty &&
                                        foodController.text.isNotEmpty &&
                                        gadgetsController.text.isNotEmpty &&
                                        superheroesController.text.isNotEmpty &&
                                        actorController.text.isNotEmpty &&
                                        singersController.text.isNotEmpty &&
                                        actressController.text.isNotEmpty &&
                                        playersController.text.isNotEmpty &&
                                        citiesController.text.isNotEmpty &&
                                        countriesController.text.isNotEmpty &&
                                        restaurantsController.text.isNotEmpty &&
                                        hotelsController.text.isNotEmpty)
                                    ? MaterialStateProperty.all(
                                        ColorSelect.colorF7E641)
                                    : MaterialStateProperty.all(
                                        ColorSelect.colorFCF5B6),
                                textStyleColor: (carController
                                            .text.isNotEmpty &&
                                        bikesController.text.isNotEmpty &&
                                        moviesController.text.isNotEmpty &&
                                        showsController.text.isNotEmpty &&
                                        foodController.text.isNotEmpty &&
                                        gadgetsController.text.isNotEmpty &&
                                        superheroesController.text.isNotEmpty &&
                                        actorController.text.isNotEmpty &&
                                        singersController.text.isNotEmpty &&
                                        actressController.text.isNotEmpty &&
                                        playersController.text.isNotEmpty &&
                                        citiesController.text.isNotEmpty &&
                                        countriesController.text.isNotEmpty &&
                                        restaurantsController.text.isNotEmpty &&
                                        hotelsController.text.isNotEmpty)
                                    ? Colors.black
                                    : ColorSelect.colorB5B07A,
                                onTap: () {
                                  updateFavouriteApi(
                                          car: carController.text,
                                          bike: bikesController.text,
                                          movies: moviesController.text,
                                          shows: showsController.text,
                                          food: foodController.text,
                                          gadgets: gadgetsController.text,
                                          superheroes:
                                              superheroesController.text,
                                          actors: actorController.text,
                                          singer: singersController.text,
                                          actress: actressController.text,
                                          player: playersController.text,
                                          cities: citiesController.text,
                                          countries: countriesController.text,
                                          restaurants:
                                              restaurantsController.text,
                                          hotels: hotelsController.text,
                                          privacy: 'public',
                                          id: favourites!.data!.id.toString())
                                      .then((value) async {
                                    if (value['status'] == true) {
                                      setState(() {
                                        // isLoading ? Loading() : getFavourites();
                                      });
                                      // Navigator.pop(context);

                                      Fluttertoast.showToast(
                                          msg: value['message']);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: 'please update all fields');
                                    }
                                  });
                                },
                                title: 'Update'),
                        SizedBox(
                          height: 20.h,
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
