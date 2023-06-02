import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/constants/urls.dart';
import 'package:swishlist/expanded/widgets/Profile_data_and_all_uesr_data.dart';
import 'package:swishlist/expanded/widgets/user_image_row.dart';
import 'package:swishlist/profile_page/account.dart';
import 'package:swishlist/profile_page/date_and_events.dart';
import 'package:swishlist/profile_page/favorites.dart';
import 'package:swishlist/profile_page/my_interests.dart';
import 'package:swishlist/profile_page/pets.dart';
import 'package:swishlist/profile_page/privacy.dart';
import 'package:swishlist/profile_page/profile.dart';
import 'package:swishlist/profile_page/sizes_and_weights.dart';
import 'package:swishlist/profile_page/widgets/popup_menu_widget.dart';
import '../api/login_signup_apis/logout_api.dart';
import '../api/user_apis/interest_api.dart';
import '../constants/globals/loading.dart';
import '../constants/globals/shared_prefs.dart';
import '../login/login.dart';
import '../models/favourites_model.dart';
import '../models/interest_model.dart';
import '../models/login_models.dart';

class UserAllDetails extends StatefulWidget {
  final LoginResponse response;
  const UserAllDetails({Key? key,
      required this.response,

  }) : super(key: key);

  @override
  State<UserAllDetails> createState() => _UserAllDetailsState();
}

class _UserAllDetailsState extends State<UserAllDetails> {
  @override
  void initState() {
    getInterest();
    super.initState();
  }

  List<String>? elements = [''];
  bool isLoading = false;
  InterestModel? _interest;
  getInterest() {
    isLoading = true;
    var resp = getInterestApi();
    resp.then((value) {
      if (value ['status'] == true) {
        setState(() {
          _interest = InterestModel.fromJson(value);
         elements =  _interest?.data!.interest!.split(",");
          isLoading= false;
        });
      } else {
        isLoading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: false,
            title: Text(
              // '${SharedPrefs().getName()}',
              // '${SharedPrefs().getUsername()}' == "null" ?
              // "Please Add Your Username" :
              '${SharedPrefs().getUsername()}',
              // "MichieMaster34",
              style: AppTextStyle().textColor29292916w500,
            ),
            leadingWidth: 40,
            leading: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(
                  "assets/icons/arrowback.svg",
                ),
              ),
            ),
            actions: [
              Popupmen(menuList: [
                PopupMenuItem(
                  child: ListTile(
                    title: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Account()));
                      },
                      child: Text(
                        'Account',
                        style: AppTextStyle().textColor39393914w500,
                      ),
                    ),
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    title: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Privacy()));
                      },
                      child: Text(
                        'Privacy',
                        style: AppTextStyle().textColor39393914w500,
                      ),
                    ),
                  ),
                ),
                PopupMenuItem(
                  child: GestureDetector(
                    onTap: () {
                      SharedPrefs().setLoginFalse();
                      // SharedPrefs().clearPrefs();
                      // logoutApi().then((value) {
                      //   if(value['status'] == true) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Login(),
                            ),
                          );
                      //     Fluttertoast.showToast(
                      //         msg: 'Logout successful');
                      //   } else {
                      //     Fluttertoast.showToast(
                      //         msg: 'Logout failed');
                      //   }
                      // });

                    },
                    child: ListTile(
                      title: Text(
                        'Log out',
                        style: AppTextStyle().textColor39393914w500,
                      ),
                    ),
                  ),
                ),
              ], icon: SvgPicture.asset('assets/icons/more-vertical.svg'))
            ],
          ),
          body:/* isLoading ? Loading():*/ SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserImageRowWidget(response: widget.response,),
                  SizedBox(
                    height: 20.h,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>
                                MyInterests(response: widget.response, id: _interest!.data!.id.toString(),)));
                        print(_interest!.data!.id);
                      },
                      child: Row(
                        children: [
                          Text(
                            "My Interests",
                            style: AppTextStyle().textColor29292914w600,
                          ),
                          Spacer(),
                          Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child:
                                  SvgPicture.asset("assets/icons/Vectoredit.svg")
                          ),
                        ],
                      ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  //InterestRow1Widget(),
                  // Builder(
                  //   builder: (BuildContext context) {
                  //     return  Wrap(
                  //           children: interest!.data!.interest!.map((context) => chipBox(name:context)).toList(),
                  //         );
                  // //   },
                  // // ),
                  // _interest!.data!.interest!.isEmpty ?
                  // Text('hi'):
                   isLoading == true ?
                       // SizedBox()
                   Text(
                     "Add Your Interest",
                     style: AppTextStyle().textColor29292914w400,
                   ):
                    Wrap(
                       children: elements!.map((e) => chipBox(name:e)).toList(),
                     ),

                  // SizedBox(height: 10.h,),
                  // InterestRow2Widget(),
                  // SizedBox(height: 10.h,),
                  // InterestRow3Widget(),
                  SizedBox(
                    height: 30.h,
                  ),
                  InkWell(
                     highlightColor: Colors.transparent,
                     splashColor: Colors.transparent,
                     onTap: () {
                      Navigator.push(context,
                           MaterialPageRoute(builder: (context) => Profile()));
                    },
                    child: ProfileRowWidget(),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) =>
                      SizeAndWeights(response: widget.response,)));
                    },
                      child: SizeAndWeightRowWidget()),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                     highlightColor: Colors.transparent,
                     splashColor: Colors.transparent,   onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Favorites()));
                    },
                    child: FavoritesRowWidget(),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                     highlightColor: Colors.transparent,
                     splashColor: Colors.transparent,
                     onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context) => Pets())
                      );
                    },
                    child: PetsRowWidget(),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  InkWell(
                     highlightColor: Colors.transparent,
                     splashColor: Colors.transparent,
                     onTap: () {
                       Navigator.push(context,
                          MaterialPageRoute(builder: (context) => DateAndEvents()));
                    },
                    child: DateAndEventsRowWidget(),
                  )
                ],
              ),
            ),
          ),
        ),
        // if (isLoading) Loading(),
      ],
    );
  }
  Container chipBox({required String name}) {
    return Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(48),
              ),
              color: ColorSelect.colorCBE0FA),
          padding: EdgeInsets.all(10),
          child: Text(name,
            style: AppTextStyle().textColor29292914w400,
          ),
        );
  }
}

