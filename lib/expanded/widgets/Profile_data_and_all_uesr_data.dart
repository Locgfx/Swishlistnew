import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../api/user_apis/favourites_api.dart';
import '../../constants/color.dart';
import '../../models/favourites_model.dart';

// class ProfileRowWidget extends StatefulWidget {
//   ProfileRowWidget({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   State<ProfileRowWidget> createState() => _ProfileRowWidgetState();
// }
//
// class _ProfileRowWidgetState extends State<ProfileRowWidget> {
//   double dou = 00;
//   var percent = "";
//   // String per = '';
//   List<String> per = [];
//
//   _sharedPrefs() {
//     if (SharedPrefs().getPPercent() == '100 %') {
//       per.add('profile');
//       percent = ((per.length / 1) * 100).toString().split(".").first;
//       dou = (per.length / 1);
//     }
//   }
//
//   @override
//   void initState() {
//     _sharedPrefs();
//     super.initState();
//   }
//
//   String? completePercent;
//   double parsedPercent = 0.0;
//   double normalizedPercent = 0.0;
//
//   @override
//   Widget build(BuildContext context) {
//     completePercent = profile?.data?.completePercent;
//     parsedPercent = double.tryParse(completePercent ?? '0') ?? 0.0;
//     normalizedPercent = parsedPercent / 100.0;
//
//     return Row(
//       children: [
//         CircularPercentIndicator(
//           circularStrokeCap: CircularStrokeCap.round,
//           radius: 40.w,
//           lineWidth: 2.w,
//           percent: dou,
//           // percent: .12,
//           backgroundColor: Color(0xff66D340).withOpacity(0.28),
//           center: Image.asset('assets/images/userimg.png'),
//           progressColor: ColorSelect.color66D340,
//         ),
//         SizedBox(width: 10.w),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Profile",
//               style: AppTextStyle().textColor29292914w400,
//             ),
//             Text(
//               percent.isEmpty
//                   ? "update your profile"
//                   : '${SharedPrefs().getPPercent()}',
//               style: AppTextStyle().textColor70707012w400,
//             )
//           ],
//         ),
//         Spacer(),
//         Padding(
//           padding: const EdgeInsets.only(right: 27),
//           child: SvgPicture.asset("assets/icons/forwordarrow.svg"),
//         )
//       ],
//     );
//   }
// }

class FavoritesRowWidget extends StatefulWidget {
  const FavoritesRowWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoritesRowWidget> createState() => _FavoritesRowWidgetState();
}

class _FavoritesRowWidgetState extends State<FavoritesRowWidget> {
  double dou = 00;
  var favPercent = "";
  List<String> per = [];

  String? completePercent;
  double parsedPercent = 0.0;
  double normalizedPercent = 0.0;

  // _sharedPrefs() {
  //   if (SharedPrefs().getFavourites() == '100 %') {
  //     per.add('profile');
  //     favPercent = ((per.length / 1) * 100).toString().split(".").first;
  //     dou = (per.length / 1);
  //   }
  // }

  bool isLoading = false;
  FavouritesModel? favourites = FavouritesModel(
      data: FavouriteData(
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

  @override
  void initState() {
    getFavourites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    completePercent = favourites?.data?.completePercent;
    parsedPercent = double.tryParse(completePercent ?? '0') ?? 0.0;
    normalizedPercent = parsedPercent / 100.0;
    return Row(
      children: [
        CircularPercentIndicator(
          circularStrokeCap: CircularStrokeCap.round,
          radius: 40.w,
          lineWidth: 2.w,
          percent: normalizedPercent,
          backgroundColor: Color(0xffD55745).withOpacity(0.28),
          center: Image.asset('assets/images/Subtract.png'),
          progressColor: ColorSelect.colorD55745,
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Favourites",
              style: AppTextStyle().textColor29292914w400,
            ),
            isLoading
                ? SizedBox()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        favourites!.data!.completePercent.toString() == "" ||
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
          ],
        ),
        Spacer(),
        Padding(
            padding: const EdgeInsets.only(right: 27),
            child: SvgPicture.asset("assets/icons/forwordarrow.svg"))
      ],
    );
  }
}

class PetsRowWidget extends StatefulWidget {
  const PetsRowWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<PetsRowWidget> createState() => _PetsRowWidgetState();
}

class _PetsRowWidgetState extends State<PetsRowWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircularPercentIndicator(
          circularStrokeCap: CircularStrokeCap.round,
          radius: 40.w,
          lineWidth: 2.w,
          percent: 0.10,
          backgroundColor: ColorSelect.colorC09B3D,
          center: Image.asset('assets/images/mdi_dog.png'),
          progressColor: ColorSelect.colorC09B3D,
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pets",
              style: AppTextStyle().textColor29292914w400,
            ),
          ],
        ),
        Spacer(),
        Padding(
            padding: const EdgeInsets.only(right: 27),
            child: SvgPicture.asset("assets/icons/forwordarrow.svg"))
      ],
    );
  }
}

class DateAndEventsRowWidget extends StatelessWidget {
  const DateAndEventsRowWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircularPercentIndicator(
          circularStrokeCap: CircularStrokeCap.round,
          radius: 40.w,
          lineWidth: 2.w,
          percent: .10,
          backgroundColor: ColorSelect.colorBA54DE,
          center: Image.asset('assets/images/agenda1.png'),
          progressColor: ColorSelect.colorBA54DE,
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Dates and Events",
              style: AppTextStyle().textColor29292914w400,
            ),
          ],
        ),
        Spacer(),
        Padding(
            padding: const EdgeInsets.only(right: 27),
            child: SvgPicture.asset("assets/icons/forwordarrow.svg"))
      ],
    );
  }
}
