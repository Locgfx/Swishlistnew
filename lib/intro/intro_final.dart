import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/color.dart';

class IntroFinal extends StatefulWidget {
  final Function onBackTap;
  const IntroFinal({Key? key, required this.onBackTap}) : super(key: key);

  @override
  State<IntroFinal> createState() => _IntroFinalState();
}

class _IntroFinalState extends State<IntroFinal> with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController animationController1;
  late AnimationController animationController2;
  late AnimationController animationController3;
  late Animation<double> _animation;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;

  @override
  void dispose() {
    animationController.dispose();
    animationController1.dispose();
    animationController2.dispose();
    animationController3.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..stop(canceled: true);
    animationController1 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..forward(from: 0.0).then((value) => animationController2
        .forward()
        .then((value) => animationController3.forward()));
    animationController2 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animationController3 = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation1 = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: animationController1,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _animation2 = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: animationController2,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _animation3 = Tween<double>(
      begin: 0,
      end: 4,
    ).animate(
      CurvedAnimation(
        parent: animationController3,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _animation = Tween<double>(
      begin: 1,
      end: 5,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    //animationController.forward();
  }

  late AnimationController animationContro =
      AnimationController(vsync: this, duration: const Duration(seconds: 10))
        ..repeat(reverse: true);
  late Animation<double> animate =
      CurvedAnimation(parent: animationContro, curve: Curves.fastOutSlowIn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leadingWidth: 40,
        leading: GestureDetector(
          onTap: () {
            widget.onBackTap();
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
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 123.h,
            ),
            FadeTransition(
              opacity: _animation1,
              child: Text(
                "Let's",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    fontSize: 50.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorSelect.colorF7E641,
                  ),
                ),
              ),
            ),
            FadeTransition(
              opacity: _animation2,
              child: Text(
                "Get",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    fontSize: 50.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorSelect.colorF7E641,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            FadeTransition(
                opacity: _animation3,
                child: ScaleTransition(
                  scale: animate,
                  child: AnimatedDefaultTextStyle(
                      child: Text('Swishing!'),
                      style: AppTextStyle().textColorF7E64150w700,
                      duration: Duration(seconds: 40)),
                )
                /*ScaleTransition(
                scale: _animation,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text(
                      "Swishing!",
                      style: AppTextStyle().textColorF7E64120w700,
                    ),
                  ),
                ),
              ),*/
                ),

            /*   TweenAnimationBuilder(
              tween: Tween<double>(begin: 1,end: 30),
              duration: Duration(seconds: 5), builder: (BuildContext context, double value, Widget? child) {
                return Text("jiknn",
                  style:TextStyle(
                  fontSize: value,
                  )); },
            ),*/

            /*_scale(),*/
            Spacer(),
          ],
        ),
      ),
    );
  }
}
