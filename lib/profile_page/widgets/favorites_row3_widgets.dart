import 'package:flutter/material.dart';

import '../../constants/color.dart';
import '../../models/favourites_model.dart';

class CitiesRowWidget extends StatelessWidget {
  final FavouritesModel favourites;
  const CitiesRowWidget({
    Key? key, required this.favourites,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Cities",
          style: AppTextStyle().textColor70707014w400,
        ),
        Spacer(),
        Text(
          favourites.data!.cities!.toString() == "" ?
          "+ Add" :
          favourites.data!.cities!.toString(),
          style: favourites.data!.cars! == '' ? AppTextStyle().textColorD5574514w500 :
          AppTextStyle().textColor29292914w400,
        ),
        // Text(
        //   "+ Add",
        //   style: AppTextStyle().textColorD5574514w500,
        // ),
      ],
    );
  }
}

class CountriesRowWidget extends StatelessWidget {
  final FavouritesModel favourites;
  const CountriesRowWidget({
    Key? key, required this.favourites,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Countries",
          style: AppTextStyle().textColor70707014w400,
        ),
        Spacer(),
        Text(
          favourites.data!.countries!.toString() == "" ?
          "+ Add" :
          favourites.data!.countries!.toString(),
          style: favourites.data!.cars! == '' ? AppTextStyle().textColorD5574514w500 :
          AppTextStyle().textColor29292914w400,
        ),
        // Text(
        //   "+ Add",
        //   style: AppTextStyle().textColorD5574514w500,
        // ),
      ],
    );
  }
}

class RestaurantsRowWidget extends StatelessWidget {
  final FavouritesModel favourites;
  const RestaurantsRowWidget({
    Key? key, required this.favourites,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Restaurants",
          style: AppTextStyle().textColor70707014w400,
        ),
        Spacer(),
        Text(
          favourites.data!.restaurants!.toString() == "" ?
          "+ Add" :
          favourites.data!.restaurants!.toString(),
          style: favourites.data!.cars! == '' ? AppTextStyle().textColorD5574514w500 :
          AppTextStyle().textColor29292914w400,
        ),
        // Text(
        //   "+ Add",
        //   style: AppTextStyle().textColorD5574514w500,
        // ),
      ],
    );
  }
}

class HotelRowWidget extends StatelessWidget {
  final FavouritesModel favourites;
  const HotelRowWidget({
    Key? key, required this.favourites,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Hotels",
          style: AppTextStyle().textColor70707014w400,
        ),
        Spacer(),
        Text(
          favourites.data!.hotels!.toString() == "" ?
          "+ Add" :
          favourites.data!.hotels!.toString(),
          style: favourites.data!.cars! == '' ? AppTextStyle().textColorD5574514w500 :
          AppTextStyle().textColor29292914w400,
        ),
        // Text(
        //   "+ Add",
        //   style: AppTextStyle().textColorD5574514w500,
        // ),
      ],
    );
  }
}
