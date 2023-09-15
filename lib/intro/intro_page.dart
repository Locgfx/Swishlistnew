import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:swishlist/intro/intro_2.dart';
import 'package:swishlist/intro/intro_3.dart';
import 'package:swishlist/intro/intro_4.dart';
import 'package:swishlist/intro/intro_5.dart';
import 'package:swishlist/intro/intro_final.dart';
import '../constants/color.dart';
import '../welcome/welcome.dart';
import 'intro_1.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final pageController = PageController();
  bool animate1 = false;
  bool animate2 = true;
  bool animate3 = true;
  bool animate4 = true;
  bool animate5 = true;
  double percent = 0.1;
  double percent1 = 0.0;
  double percent2 = 0.0;
  double percent3 = 0.0;
  double percent4 = 0.0;
  double percent5 = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Stack(
                children: [
                  CircularPercentIndicator(
                    radius: 100,
                    lineWidth: 10,
                    animation: true,
                    startAngle: 60,
                    percent: percent,
                    animateFromLastPercent: animate1,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: percent1 == 0.0
                        ? ColorSelect.colorEDEDF1
                        : ColorSelect.colorF7E641,
                    backgroundColor: Colors.transparent,
                  ),
                  CircularPercentIndicator(
                    radius: 100,
                    lineWidth: 10,
                    animation: true,
                    startAngle: 120,
                    percent: percent,
                    animateFromLastPercent: animate2,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: percent2 == 0.0
                        ? ColorSelect.colorEDEDF1
                        : ColorSelect.colorF7E641,
                    backgroundColor: Colors.transparent,
                  ),
                  CircularPercentIndicator(
                    radius: 100,
                    lineWidth: 10,
                    animation: true,
                    startAngle: 180,
                    percent: percent,
                    animateFromLastPercent: animate3,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: percent3 == 0.0
                        ? ColorSelect.colorEDEDF1
                        : ColorSelect.colorF7E641,
                    backgroundColor: Colors.transparent,
                  ),
                  CircularPercentIndicator(
                    radius: 100,
                    lineWidth: 10,
                    animation: true,
                    startAngle: 240,
                    percent: percent,
                    animateFromLastPercent: animate4,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: percent4 == 0.0
                        ? ColorSelect.colorEDEDF1
                        : ColorSelect.colorF7E641,
                    backgroundColor: Colors.transparent,
                  ),
                  CircularPercentIndicator(
                    radius: 100,
                    lineWidth: 10,
                    animation: true,
                    startAngle: 300,
                    percent: percent,
                    animateFromLastPercent: animate5,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: percent5 == 0.0
                        ? ColorSelect.colorEDEDF1
                        : ColorSelect.colorF7E641,
                    backgroundColor: Colors.transparent,
                  ),
                  CircularPercentIndicator(
                    radius: 100,
                    lineWidth: 10,
                    animation: true,
                    percent: percent,
                    animateFromLastPercent: true,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: ColorSelect.colorF7E641,
                    backgroundColor: Colors.transparent,
                    center: GestureDetector(
                      onTap: () {
                        if (pageController.page == 0) {
                          pageController.animateToPage(
                            1,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.fastOutSlowIn,
                          );
                          setState(() {
                            percent = 0.10001;
                            percent1 = 0.1;
                          });
                        } else if (pageController.page == 1) {
                          pageController.animateToPage(
                            2,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.fastOutSlowIn,
                          );
                          setState(() {
                            percent = 0.10000;
                            animate1 = true;
                            animate2 = false;
                            percent2 = 0.1;
                          });
                        } else if (pageController.page == 2) {
                          pageController.animateToPage(
                            3,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.fastOutSlowIn,
                          );
                          setState(() {
                            percent = 0.10001;
                            animate2 = true;
                            animate3 = false;
                            percent3 = 0.1;
                          });
                        } else if (pageController.page == 3) {
                          pageController.animateToPage(
                            4,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.fastOutSlowIn,
                          );
                          setState(() {
                            animate3 = true;
                            animate4 = false;
                            percent4 = 0.1;
                            percent = 0.10000;
                          });
                          /*Future.delayed(Duration(milliseconds: 500), () {
                            percent = 0.2;
                            setState(() {});
                          });*/
                        } else if (pageController.page == 4) {
                          pageController.animateToPage(
                            5,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.fastOutSlowIn,
                          );
                          setState(() {
                            animate4 = true;
                            animate5 = false;
                            percent1 = 0.0;
                            percent2 = 0.0;
                            percent3 = 0.0;
                            percent4 = 0.0;
                            percent5 = 0.0;
                            percent = 1;
                          });
                          /*Future.delayed(Duration(milliseconds: 500), () {
                            percent = 0.3;
                            setState(() {});
                          });*/
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Welcome(),
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorSelect.colorF7E641),
                        child: Icon(
                          percent == 0.2
                              ? Icons.done
                              : Icons.arrow_forward_ios_rounded,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                Intro2(
                  onBackTap: () {
                    /*pageController.previousPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                    );
                    setState(() {
                      animate1 = false;
                      animate2 = true;
                      animate3 = true;
                      percent = 0.10000;
                      percent1 = 0.1;
                    });*/
                  },
                ),
                Intro3(
                  onBackTap: () {
                    pageController.previousPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                    );
                    setState(() {
                      animate1 = false;
                      animate2 = true;
                      animate3 = true;
                      percent = 0.10000;
                      percent1 = 0.0;
                    });
                  },
                ),
                Intro1(
                  onBackTap: () {
                    pageController.previousPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                    );
                    setState(() {
                      animate2 = false;
                      animate3 = true;
                      animate4 = true;
                      percent = 0.10001;
                      percent2 = 0.0;
                    });
                  },
                ),
                Intro4(
                  onBackTap: () {
                    pageController.previousPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                    );
                    setState(() {
                      animate3 = false;
                      animate4 = true;
                      animate5 = true;
                      percent = 0.10000;
                      percent3 = 0.0;
                    });
                  },
                ),
                Intro5(
                  onBackTap: () {
                    pageController.previousPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                    );
                    setState(() {
                      animate4 = false;
                      animate5 = true;
                      percent = 0.10001;
                      percent4 = 0.0;
                    });
                  },
                ),
                IntroFinal(
                  onBackTap: () {
                    pageController.previousPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                    );
                    setState(() {
                      percent = 0.10000;
                      animate5 = false;
                      percent1 = 0.1;
                      percent2 = 0.1;
                      percent3 = 0.1;
                      percent4 = 0.1;
                      percent5 = 0.0;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
