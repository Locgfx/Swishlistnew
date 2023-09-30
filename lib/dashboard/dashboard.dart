import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:swishlist/constants/globals/globals.dart';
import 'package:swishlist/dashboard/products/products_page.dart';
import 'package:swishlist/dashboard/search/home_etsy_products.dart';

import '../constants/color.dart';
import '../models/login_models.dart';
import 'activities/activities.dart';
import 'friends/friends.dart';

class Dashboard extends StatefulWidget {
  final LoginResponse response;
  const Dashboard({
    Key? key,
    required this.response,
  }) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  int pageIndex = 0;
  final _one = GlobalKey();
  final _second = GlobalKey();
  final _third = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ExitApp(
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
              color: ColorSelect.colorFFFFFF,
              boxShadow: [
                BoxShadow(
                  blurRadius: 148,
                  spreadRadius: 0,
                  color: Colors.black.withOpacity(0.08),
                  offset: Offset(0, 0),
                ),
              ],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: SingleChildScrollView(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    selectedIndex = pageIndex = 0;
                    _pageController.jumpToPage(
                      pageIndex,
                    );
                    pageIndex = 0;
                    setState(() {});
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          pageIndex == 0
                              ? "assets/images/home.png"
                              : "assets/images/home.png",
                          color: pageIndex == 0
                              ? Color(0xff292929)
                              : Color(0xff707070),
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(height: 8),
                        Text("Home",
                            style: AppTextStyle()
                                .textColor29292912w500
                                .copyWith(
                                    color: pageIndex == 0
                                        ? Color(0xff292929)
                                        : Color(0xff707070))),
                        SizedBox(height: 6),
                        Container(
                          width: 20,
                          height: 4,
                          decoration: BoxDecoration(
                            color: pageIndex == 0
                                ? ColorSelect.colorF7E641
                                : Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = pageIndex = 1;
                      _pageController.jumpToPage(
                        pageIndex,
                      );
                      pageIndex = 1;
                    });
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          pageIndex == 1
                              // ? "assets/images/Etsy Logo.png"
                              // : "assets/images/Etsy Logo.png",
                              ? "assets/icons/4xstoreicon.png"
                              : "assets/icons/4xstoreicon.png",
                          color: pageIndex == 1
                              ? Color(0xff292929)
                              : Color(0xff707070),
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(height: 8),
                        Text("Products",
                            style: AppTextStyle()
                                .textColor29292912w500
                                .copyWith(
                                    color: pageIndex == 1
                                        ? Color(0xff292929)
                                        : Color(0xff707070))),
                        SizedBox(height: 6),
                        Container(
                          width: 20,
                          height: 4,
                          decoration: BoxDecoration(
                            color: pageIndex == 1
                                ? ColorSelect.colorF7E641
                                : Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = pageIndex = 2;
                      _pageController.jumpToPage(
                        pageIndex,
                      );
                      pageIndex = 2;
                    });
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          pageIndex == 2
                              ? "assets/images/notification-pngrepo-com.png"
                              : "assets/images/notification-pngrepo-com.png",
                          color: pageIndex == 2
                              ? Color(0xff292929)
                              : Color(0xff707070),
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(height: 8),
                        Text("notification",
                            style: AppTextStyle()
                                .textColor29292912w500
                                .copyWith(
                                    color: pageIndex == 2
                                        ? Color(0xff292929)
                                        : Color(0xff707070))),
                        SizedBox(height: 6),
                        Container(
                          width: 20,
                          height: 4,
                          decoration: BoxDecoration(
                            color: pageIndex == 2
                                ? ColorSelect.colorF7E641
                                : Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = pageIndex = 3;
                      _pageController.jumpToPage(
                        pageIndex,
                      );
                      pageIndex = 3;
                    });
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          pageIndex == 3
                              ? "assets/icons/4xfriendsicon.png"
                              : "assets/icons/4xfriendsicon.png",
                          color: pageIndex == 3
                              ? Color(0xff292929)
                              : Color(0xff707070),
                          height: 24,
                          width: 24,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Friends",
                          /*AppLoaclizations.of(context)!
                                .translate("Kids")
                                .toString(),*/
                          style: AppTextStyle().textColor29292912w500.copyWith(
                                color: pageIndex == 3
                                    ? Color(0xff292929)
                                    : Color(0xff707070),
                              ),
                        ),
                        SizedBox(height: 6),
                        Container(
                          width: 20,
                          height: 4,
                          decoration: BoxDecoration(
                            color: pageIndex == 3
                                ? ColorSelect.colorF7E641
                                : Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TextFieldUnFocusOnTap(
          child: Stack(
            children: [
              PageView(
                controller: _pageController,
                onPageChanged: (page) {
                  setState(
                    () {
                      pageIndex = page;
                    },
                  );
                },
                children: [
                  ShowCaseWidget(
                    builder: Builder(
                      builder: (context) => ProductsPage(
                        response: widget.response,
                      ),
                    ),
                  ),
                  // ProductsPage(response: widget.response, productKey: _one),
                  // AllEtsyProducts(),
                  // Search(),
                  HomeEtsyProducts(),
                  // ShowCaseWidget(
                  //   builder: Builder(
                  //     builder: (context) => Search(),
                  //   ),
                  // ),
                  Activities(),
                  ShowCaseWidget(
                    builder: Builder(
                      builder: (context) => Friends(),
                    ),
                  ),
                  // ProductsPage(
                  //   response: widget.response,
                  // ),
                  // // AllEtsyProducts(),
                  // Search(),
                  // Activities(),
                  // Friends(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> showExitPopup(context) async {
  return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Exit App'),
          content: Text('Do you want to exit an App?'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              //return false when click on "NO"
              child: Text('No'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Yes'),
            ),
          ],
        ),
      ) ??
      false;
}

class ExitApp extends StatefulWidget {
  final Widget child;
  ExitApp({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<ExitApp> createState() => _ExitAppState();
}

class _ExitAppState extends State<ExitApp> {
  DateTime? _currentBackPressTime;
  DateTime _lastExitTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();

        if (_currentBackPressTime == null ||
            now.difference(_currentBackPressTime!) > Duration(seconds: 2)) {
          _currentBackPressTime = now;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Press back button again to exit'),
            ),
          );
          return false;
        }

        return true;
      },
      child: widget.child,
    );
  }
}
