import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/constants/urls.dart';
import 'package:swishlist/dashboard/products/productalready.dart';
import 'package:swishlist/dashboard/products/productdontwant.dart';
import 'package:swishlist/dashboard/products/wantproducts.dart';
import 'package:swishlist/dashboard/products/widget/manuallyaddbottomsheetwidget.dart';
import 'package:swishlist/expanded/add_family_member.dart';
import 'package:swishlist/expanded/manage_family_members.dart';
import 'package:swishlist/expanded/member_settings.dart';
import 'package:swishlist/expanded/user_all_details.dart';
import 'package:swishlist/expanded/widgets/expanded_section_row_option.dart';
import '../../api/user_apis/products_api.dart';
import '../../constants/color.dart';
import '../../constants/globals/shared_prefs.dart';
import '../../models/login_models.dart';
import '../../models/product_model.dart';
import '../../models/product_type_model.dart';

class ProductsPage extends StatefulWidget {
  final LoginResponse response;
  const ProductsPage({Key? key, 
    required this.response,
   
  }) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();
  }
  bool showBox = true;
  bool showExpandedScreen = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child:  isLoading ? Center(
          child: LoadingAnimationWidget.inkDrop(
            size: 40, color: ColorSelect.colorF7E641,
          ),
        ):SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                      top: 250,
                      left: 0,
                      child: Image.asset("assets/images/Rectangle356.png")),
                  Positioned(
                      top: 600,
                      left: 0,
                      child: Image.asset("assets/images/Rectangle3564.png")),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(left: 16,bottom: 10),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showBox = true;
                            });
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            clipBehavior: Clip.none,
                            children: [
                             /* CircularPercentIndicator(
                                circularStrokeCap: CircularStrokeCap.round,
                                radius: 65,
                                lineWidth: 5,
                                percent: .100,
                                animateFromLastPercent: true,
                                backgroundColor: ColorSelect.colorEDEDF1,
                                progressColor: Colors.black,
                                center:*/ Container(
                                margin: EdgeInsets.only(left: 16),
                                  height: 50,
                                  width: 50,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: '$baseUrl${SharedPrefs().getUserPhoto()}',
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                    progressIndicatorBuilder:  (a,b,c) =>
                                        Opacity(
                                          opacity: 0.3,
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.black12,
                                            highlightColor: Colors.white,
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              //margin: EdgeInsets.symmetric(horizontal: 24),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle
                                              ),
                                            ),
                                          ),
                                        ),
                                  ),
                                ),
                              // ),
                              // Positioned(
                              //   bottom: -5,
                              //   child: Container(
                              //     padding: EdgeInsets.all(5),
                              //     decoration: BoxDecoration(
                              //       color: ColorSelect.colorF7E641,
                              //       borderRadius: BorderRadius.all(
                              //         Radius.circular(80),
                              //       ),
                              //     ),
                              //     child: Text(
                              //       " 25% ",
                              //       style: AppTextStyle().textColor29292910w500,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showExpandedScreen = !showExpandedScreen;
                              showBox = false;
                            });
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                    '${SharedPrefs().getName()}',
                                      // "Michael Scott",
                                      style:
                                          AppTextStyle().textColor29292916w500r,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    showExpandedScreen
                                        ? SvgPicture.asset(
                                            'assets/icons/Vector458.svg')
                                        : SvgPicture.asset(
                                            "assets/icons/Vector4581.svg",
                                          ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                   /* '${SharedPrefs().getUsername()}' == 'null' ?
                                    'Add your Username' :*/
                                    '${SharedPrefs().getUsername()}',
                                    // "Micheal139",
                                    style: AppTextStyle().textColor70707014w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        if (showExpandedScreen)
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => MemberSettings(response: widget.response,),
                                ),
                              );
                            },
                            child: Container(
                              color: Colors.transparent,
                              padding: EdgeInsets.all(16),
                              child: Icon(Icons.more_vert),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              if (!showBox)
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.fastOutSlowIn,
                  width: 1.sw,
                  height: showExpandedScreen ? 300.h : 0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.only(left: 16, top: 20, bottom: 20),
                  margin: EdgeInsets.only(top: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        OptionRowFamily(
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AddFamilyMember(),
                              ),
                            );
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorSelect.colorEDEDF1,
                                  ),
                                  padding: EdgeInsets.all(15),
                                  child: SvgPicture.asset(
                                    'assets/icons/Union.svg',
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Add family member',
                                  style: AppTextStyle().textColor29292914w500,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        OptionRow(
                          icon: 'userpro',
                          label: 'Manage family members',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ManageFamilyMembers(),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        OptionRow(
                          icon: 'setting',
                          label: 'Settings',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MemberSettings(response: widget.response,),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              if (showBox)
                Container(
                  width: 1.sw,
                  color: Colors.transparent,
                  margin: EdgeInsets.only(left: 16),
                  child: Stack(
                    children: [
                      SizedBox(
                        width: 1.sw,
                        child: Image.asset(
                          'assets/images/bbox.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Positioned(
                        top: 50.h,
                        left: 20,
                        child: Text(
                          "Let your friends know about you!",
                          style: AppTextStyle().textColorFFFFFF14w400,
                        ),
                      ),
                      Positioned(
                        top: 90.h,
                        left: 20,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => UserAllDetails(response: widget.response,),
                              ),
                            );
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: EdgeInsets.only(
                                right: 10,
                                bottom: 10
                            ),
                            child: Text(
                              "Add Details",
                              style: AppTextStyle().textColorF7E64114w400,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 42,
                        top: 45,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              showBox = false;
                            });
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            color: Colors.grey.withOpacity(0.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16),
                child: Row(children: [
                  Text(
                    "I want",
                    style: AppTextStyle().textColor29292924w700,
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WantProducts(
                                    isUser: true,
                                  )));
                    },
                    child: Text(
                      "View all",
                      style: AppTextStyle().textColor29292914w500,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return ManuallyAddBottomSheetWidget(/*model: widget.model,*/);
                          });
                    },
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                          color: ColorSelect.colorF7E641,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(child: Icon(Icons.add)),
                    ),
                  ),
                ]),
              ),
              IWantProductListWidget(),
              SizedBox(
                height: 68,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(children: [
                  Text(
                    "I don’t want",
                    style: AppTextStyle().textColor29292924w700,
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Productdontwant(
                            isUser: true,
                            // model:widget.model ,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      "View all",
                      style: AppTextStyle().textColor29292914w500,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return ManuallyAddBottomSheetWidget(/*model: widget.model,*/);
                          });
                    },
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                          color: ColorSelect.colorF7E641,
                          borderRadius: BorderRadius.circular(8)),
                      child: Center(child: Icon(Icons.add)),
                    ),
                  ),
                ]),
              ),
              NotWantProductListWidget(),
              SizedBox(
                height: 68,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(children: [
                  Text(
                    "I already have",
                    style: AppTextStyle().textColor29292924w700,
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductAlready()));
                    },
                    child: Text(
                      "View all",
                      style: AppTextStyle().textColor29292914w500,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return ManuallyAddBottomSheetWidget();
                          });
                    },
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                          color: ColorSelect.colorF7E641,
                          borderRadius: BorderRadius.circular(8)
                      ),
                      child: Center(child: Icon(Icons.add)),
                    ),
                  ),
                ],
                ),
              ), AlreadyProductListWidget(),
              SizedBox(height: 132)
            ],
          ),
        ),
      ),
    );
  }
}
//
class AlreadyProductListWidget extends StatefulWidget {
  const AlreadyProductListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AlreadyProductListWidget> createState() => _AlreadyProductListWidgetState();
}
class _AlreadyProductListWidgetState extends State<AlreadyProductListWidget> {
  @override
  void initState() {
    getHaveProducts();
    super.initState();
  }
  bool isLoading = false;
  GetProductModel? getProducts;
   List<ProductTypeModel> haveProducts = [];
   List<ProductTypeModel> haveProducts2 = [];

  getHaveProducts() {
    isLoading = true;
    var resp = getProductsApi();
    resp.then((value) {
      if (value['status'] == true) {
        setState(() {
        });
        setState(() {
          for(var v in value["data"]){
            haveProducts.add(ProductTypeModel.fromJson(v));
          }
          for(var v in haveProducts){
            if(v.type! == "have"){
              haveProducts2.add(v);
              setState(() {

              });
            }
          }
          isLoading = false;
        });
      } else {
        isLoading = false;
        setState(() {
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Center(
      child: LoadingAnimationWidget.newtonCradle(
        size: 20, color: ColorSelect.colorF7E641,
      )
    ):SizedBox(
      height: 200,
      child:(haveProducts2.isNotEmpty) ?Padding(
        padding: const EdgeInsets.only(right: 8),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: haveProducts2.length,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Expanded(
                    flex: 4,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductAlready()));
                      },
                      child: Container(
                        width: 173,
                        height: 129,
                        margin: EdgeInsets.only(left: 16),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: ColorSelect.colorE0E0E0, width: 1),
                            color: ColorSelect.colorFFFFFF,
                            borderRadius: BorderRadius.circular(12)),
                        child: CachedNetworkImage(
                          imageUrl: haveProducts2[i].photo.toString().contains("https") ?
                          haveProducts2[i].photo.toString() :
                          baseUrl+haveProducts2[i].photo.toString(),
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error,size: 40,),
                          progressIndicatorBuilder:  (a,b,c) =>
                              Opacity(
                                opacity: 0.3,
                                child: Shimmer.fromColors(
                                  baseColor: Colors.black12,
                                  highlightColor: Colors.white,
                                  child: Container(
                                    width: 173,
                                    height: 129,
                                    decoration: BoxDecoration(
                                        border:
                                        Border.all(color: ColorSelect.colorE0E0E0, width: 1),
                                        color: ColorSelect.colorFFFFFF,
                                        borderRadius: BorderRadius.circular(12)),
                                  ),
                                ),
                              ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: SizedBox(
                        width: 170.w,
                        child: Text(
                          haveProducts2[i].name.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: AppTextStyle().textColor29292912w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        '\$ ${haveProducts2[i].price.toString()}',
                        style: AppTextStyle().textColor29292914w500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ):isLoading ? Center(
       child: LoadingAnimationWidget.waveDots(
        size: 70,
        color: ColorSelect.colorF7E641),
       ): Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline,color: Colors.black,size: 80,),
            // Image.asset("assets/images/delivery.png",height: 100,),
            SizedBox(height: 5),
            Text('Add Products',
              style: AppTextStyle().textColor29292914w500,)
          ],
        ),
      )
    );
  }
}

class IWantProductListWidget extends StatefulWidget {
   IWantProductListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<IWantProductListWidget> createState() => _IWantProductListWidgetState();
}
class _IWantProductListWidgetState extends State<IWantProductListWidget> {

  @override
  void initState() {
    getWantProducts();
    super.initState();
  }
  bool isLoading = false;
  GetProductModel ? getProducts;
  List<ProductTypeModel> wantProducts = [];
  List<ProductTypeModel> wantProducts2 = [];

  getWantProducts() {
    isLoading = true;
    var resp = getProductsApi();
    resp.then((value) {
      if(value['status'] == true) {
        setState(() {
          for (var v in value['data']){
            wantProducts.add(ProductTypeModel.fromJson(v));
          }
          for (var v in wantProducts){
            if(v.type! == "want") {
              wantProducts2.add(v);
              wantProducts2.removeWhere((element) => element.id == v);
            }
          }
          isLoading = false;
        });
      } else{
        isLoading = false;
        // wantProducts2.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: (wantProducts2.isNotEmpty) ? Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount:wantProducts2.length,
          // itemCount: 2,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Expanded(
                    flex:4,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WantProducts(
                                  isUser: true,
                                ),
                             ),
                          );},
                      child: Container(
                        width: 173,
                        height: 129,
                        margin: EdgeInsets.only(left: 16),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            border:
                            Border.all(color: ColorSelect.colorE0E0E0, width: 1),
                            color: ColorSelect.colorFFFFFF,
                            borderRadius: BorderRadius.circular(12)),
                        child: CachedNetworkImage(
                          imageUrl: wantProducts2[i].photo.toString().contains("https") ?
                          wantProducts2[i].photo.toString() :
                          baseUrl+wantProducts2[i].photo.toString(),
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error,size: 40,),
                          progressIndicatorBuilder:  (a,b,c) =>
                              Opacity(
                                opacity: 0.3,
                                child: Shimmer.fromColors(
                                  baseColor: Colors.black12,
                                  highlightColor: Colors.white,
                                  child: Container(
                                    width: 173,
                                    height: 129,
                                    decoration: BoxDecoration(
                                        border:
                                        Border.all(color: ColorSelect.colorE0E0E0, width: 1),
                                        color: ColorSelect.colorFFFFFF,
                                        borderRadius: BorderRadius.circular(12)),
                                  ),

                                ),
                              ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: SizedBox(
                        width: 170.w,
                        child: Text(
                          wantProducts2[i].name.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: AppTextStyle().textColor29292912w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        '\$ ${wantProducts2[i].price.toString()}',
                        style: AppTextStyle().textColor29292914w500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ) :isLoading ? Center(
        child: LoadingAnimationWidget.waveDots(
          size: 70,
          color: ColorSelect.colorF7E641,
        ),
      ): Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline,color: Colors.black,size: 80,),
            SizedBox(height: 5),
            Text('Add Products',
            style: AppTextStyle().textColor29292914w500,)
          ],
        ),
      )
    ) ;
  }
}

class NotWantProductListWidget extends StatefulWidget {
  const NotWantProductListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<NotWantProductListWidget> createState() => _NotWantProductListWidgetState();
}

class _NotWantProductListWidgetState extends State<NotWantProductListWidget> {
  @override
  void initState() {
    getNotWant();
    super.initState();
  }
  bool isLoading = false;
  GetProductModel? getProducts;
  List<ProductTypeModel>  notWant = [];
  List<ProductTypeModel>  notWant2 = [];
  getNotWant() {
    isLoading = true;
    var resp = getProductsApi();
    resp.then((value) {
      if(value['status'] == true) {
        setState(() {
          for(var v in value["data"]){
            notWant.add(ProductTypeModel.fromJson(v));
          }
          for(var v in notWant) {
            if(v.type! == "dont_want") {
              notWant2.add(v);
            }
          }
          isLoading = false;
          // notWant2.clear();
        });
      } else {
        isLoading = false;
      }
    });

  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: (notWant2.isNotEmpty) ? Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: notWant2.length,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Expanded(
                    flex: 4,
                    child: GestureDetector(
                      onTap:() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Productdontwant(
                              isUser: true,
                              // model:widget.model ,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 173,
                        height: 129,
                        margin: EdgeInsets.only(left: 16),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            border:
                            Border.all(color: ColorSelect.colorE0E0E0, width: 1),
                            color: ColorSelect.colorFFFFFF,
                            borderRadius: BorderRadius.circular(12)),
                        child: CachedNetworkImage(
                          imageUrl: notWant2[i].photo.toString().contains("https") ?
                          notWant2[i].photo.toString() :
                          baseUrl+notWant2[i].photo.toString(),
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error,size: 40,),
                          progressIndicatorBuilder:  (a,b,c) =>
                              Opacity(
                                opacity: 0.3,
                                child: Shimmer.fromColors(
                                  baseColor: Colors.black12,
                                  highlightColor: Colors.white,
                                  child: Container(
                                    width: 173,
                                    height: 129,
                                    decoration: BoxDecoration(
                                        border:
                                        Border.all(color: ColorSelect.colorE0E0E0, width: 1),
                                        color: ColorSelect.colorFFFFFF,
                                        borderRadius: BorderRadius.circular(12)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  SizedBox(height: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: SizedBox(
                        width: 170.w,
                        child: Text(
                          notWant2[i].name.toString(),
                          // widget.itemNameList[i],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: AppTextStyle().textColor29292912w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 4),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        '\$ ${notWant2[i].price.toString()}',
                        // widget.itemPrice[i],
                        style: AppTextStyle().textColor29292914w500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ) :isLoading ? Center(
          child: LoadingAnimationWidget.waveDots(
          size: 70,
           color: ColorSelect.colorF7E641,
          ),
    ): Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline,color: Colors.black,size: 80,),
            // Image.asset("assets/images/delivery.png",height: 100,),
            SizedBox(height: 5),
            Text('Add Products',
              style: AppTextStyle().textColor29292914w500,)
          ],
        ),
      )
    );
  }
}
