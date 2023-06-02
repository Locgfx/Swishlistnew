import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/color.dart';
import '../../models/favourites_model.dart';

class CarRowWidget extends StatelessWidget {
  final FavouritesModel favourites;
  const CarRowWidget({
    Key? key,
    required this.favourites,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Cars",
          style: AppTextStyle().textColor70707014w400,
        ),
        Spacer(),
        Text(
          favourites.data!.cars!.toString() == "" ?
          "+ Add" :
          favourites.data!.cars!.toString(),
          style:favourites.data!.cars! == '' ?
          AppTextStyle().textColorD5574514w500:
          AppTextStyle().textColor29292914w400,
        ),
        // Image.asset("assets/images/information3.png"),
        // SizedBox(
        //   width: 20.w,
        // ),
        // Image.asset("assets/images/Vector175.png"),
      ],
    );
  }
}

class BikesRowWidget extends StatelessWidget {
  final FavouritesModel favourites;
  const BikesRowWidget({
    Key? key, required this.favourites,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Bikes",
          style: AppTextStyle().textColor70707014w400,
        ),
        Spacer(),
        Text(
          favourites.data!.bikes!.toString() == "" ?
          "+ Add" :
          favourites.data!.bikes!.toString(),
          style: favourites.data!.cars! == '' ? AppTextStyle().textColorD5574514w500 :
          AppTextStyle().textColor29292914w400,
        ),
        // Image.asset("assets/images/information3.png"),
        // SizedBox(
        //   width: 20.w,
        // ),
        // Image.asset("assets/images/Vector175.png"),
      ],
    );
  }
}

class MoviesWidget extends StatelessWidget {
  final FavouritesModel favourites;
  const MoviesWidget({
    Key? key,
    required this.favourites,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Movies",
          style: AppTextStyle().textColor70707014w400,
        ),
        Spacer(),
        Text(
        favourites.data!.movies!.toString() == ""
          ?'+ Add' :
        favourites.data!.movies!.toString(),
          style: favourites.data!.cars! == '' ? AppTextStyle().textColorD5574514w500 :
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
    );
  }
}

class ShowsRowWidget extends StatelessWidget {
  final FavouritesModel favourites;
  const ShowsRowWidget({
    Key? key, required this.favourites,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Shows",
          style: AppTextStyle().textColor70707014w400,
        ),
        Spacer(),
        Text(
        favourites.data!.shows!.toString() == ""
            ? "+ Add" :
        favourites.data!.shows!.toString(),
          style: favourites.data!.cars! == '' ? AppTextStyle().textColorD5574514w500 :
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
    );
  }
}

class FoodRowWidget extends StatelessWidget {
  final FavouritesModel favourites;
  const FoodRowWidget({
    Key? key, required this.favourites,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Food",
          style: AppTextStyle().textColor70707014w400,
        ),
        Spacer(),
        Text(
          favourites.data!.foods!.toString() == "" ?
          "+ Add" :
          favourites.data!.foods!.toString()
          ,
          style: favourites.data!.cars! == '' ? AppTextStyle().textColorD5574514w500 :
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
    );
  }
}

class GadgetsRowWidget extends StatelessWidget {
  final FavouritesModel favourites;
  const GadgetsRowWidget({
    Key? key, required this.favourites,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Gadgets",
          style: AppTextStyle().textColor70707014w400,
        ),
        Spacer(),
        Text(
          favourites.data!.gadgets!.toString() == "" ?
          '+ Add' :
          favourites.data!.gadgets!.toString(),
          style: favourites.data!.cars! == '' ? AppTextStyle().textColorD5574514w500 :
          AppTextStyle().textColor29292914w400,
        ),
        // Image.asset("assets/images/information3.png"),
        // SizedBox(
        //   width: 20.w,
        // ),
        // Image.asset("assets/images/Vector175.png"),
      ],
    );
  }
}
