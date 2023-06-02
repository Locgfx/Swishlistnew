import 'package:flutter/material.dart';
import 'package:swishlist/models/favourites_model.dart';

import '../../constants/color.dart';

class SuperherosRowWidget extends StatelessWidget {
  final FavouritesModel favourites;
  const SuperherosRowWidget({
    Key? key, required this.favourites,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Superheroes",
          style: AppTextStyle().textColor70707014w400,
        ),
        Spacer(),
        Text(
          // "Deadpool",
          favourites.data!.superheroes!.toString() == '' ?
          '+ Add' :
          favourites.data!.superheroes!.toString(),
          style: favourites.data!.cars! == '' ? AppTextStyle().textColorD5574514w500 :
          AppTextStyle().textColor29292914w400,
        ),
      ],
    );
  }
}

class ActorsRowWidget extends StatelessWidget {
  final FavouritesModel favourites;
  const ActorsRowWidget({
    Key? key, required this.favourites,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Actors",
          style: AppTextStyle().textColor70707014w400,
        ),
        Spacer(),
        Text(
          favourites.data!.actors!.toString() == ""?
          "+ Add" :
          favourites.data!.actors!.toString(),
          style: favourites.data!.cars! == '' ? AppTextStyle().textColorD5574514w500 :
          AppTextStyle().textColor29292914w400,
          // "+ Add",
          // style: AppTextStyle().textColorD5574514w500,
        ),
      ],
    );
  }
}

class ActressesRowWidget extends StatelessWidget {
  final FavouritesModel favourites;
  const ActressesRowWidget({
    Key? key, required this.favourites,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Actresses",
          style: AppTextStyle().textColor70707014w400,
        ),
        Spacer(),
        Text(
          favourites.data!.actresses!.toString() == "" ?
          "+ Add" :
          favourites.data!.actresses!.toString(),
          style: favourites.data!.cars! == '' ? AppTextStyle().textColorD5574514w500 :
          AppTextStyle().textColor29292914w400,
          // "+ Add",
          // style: AppTextStyle().textColorD5574514w500,
        ),
      ],
    );
  }
}

class SingersRowWidget extends StatelessWidget {
  final FavouritesModel favourites;
  const SingersRowWidget({
    Key? key, required this.favourites,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Singers",
          style: AppTextStyle().textColor70707014w400,
        ),
        Spacer(),
        Text(
          favourites.data!.singers!.toString() == ""?
          "+ Add" :
          favourites.data!.singers!.toString(),
          style: favourites.data!.cars! == '' ? AppTextStyle().textColorD5574514w500 :
          AppTextStyle().textColor29292914w400,
        ),
      ],
    );
  }
}

class PlayersRowWidget extends StatelessWidget {
  final FavouritesModel favourites;
  const PlayersRowWidget({
    Key? key, required this.favourites,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Players",
          style: AppTextStyle().textColor70707014w400,
        ),
        Spacer(),
        Text(
          favourites.data!.players!.toString() == "" ?
          "+ Add" :
          favourites.data!.players!.toString(),
          style: favourites.data!.cars! == '' ? AppTextStyle().textColorD5574514w500 :
          AppTextStyle().textColor29292914w400,
          // "+ Add",
          // style: AppTextStyle().textColorD5574514w500,
        ),
      ],
    );
  }
}
