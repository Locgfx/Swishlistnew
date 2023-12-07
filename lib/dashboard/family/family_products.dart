import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/dashboard/friends/profile_chat.dart';
import 'package:swishlist/dashboard/friends/widget/appbar_icon.dart';
import 'package:swishlist/models/friend_product_model.dart';

import '../../api/family_member_apis/family_products_api.dart';
import '../../api/user_apis/friends_api.dart';
import '../../constants/globals/globals.dart';
import '../../constants/globals/loading.dart';
import '../../constants/urls.dart';
import '../../family_members/family_don_want_products.dart';
import '../../family_members/family_have_products.dart';
import '../../family_members/family_member_all_details.dart';
import '../../family_members/family_product_details.dart';
import '../../family_members/family_want_products.dart';
import '../../models/add_friend_model.dart';
import '../../models/family_member_product_model.dart';
import '../friends/friends_notifications.dart';
import '../products/widget/manuallyaddbottomsheetwidget.dart';

class FamilyMemberProduct extends StatefulWidget {
  final String familyName;
  final String familyUserName;
  final String familyId;
  final String familyPhoto;
  final String id;

  const FamilyMemberProduct({
    Key? key,
    required this.familyName,
    required this.familyUserName,
    required this.familyId,
    required this.familyPhoto,
    required this.id,
  }) : super(key: key);

  @override
  State<FamilyMemberProduct> createState() => _FamilyMemberProductState();
}

class _FamilyMemberProductState extends State<FamilyMemberProduct> {
  List imageList = ["assets/images/image11.png", "assets/images/image10.png"];
  List itemNameList = [
    "MorePro Fitness Tracker, Heart Rate Monitor Blood Pressure ...",
    "RESPAWN 110 Racing Style Gaming Chair, Reclining Ergon..."
  ];
  List itemPrice = ["87.29", "127.99"];
  List popList = ['Send Profile', 'Notification', 'Block', 'Unfriend'];

  @override
  void initState() {
    print(widget.familyId);
    //getProducts();
    getWantProducts();
    //getFriends();
    getDontWantProducts();
    getHaveProducts();
    super.initState();
  }

  bool isLoading = false;
  // List <FriendProductModel> products = [];
  //FriendProductModel? products;
  //List<FriendProductModel> haveProducts2 = [];
  // FriendModel?  haveProducts = FriendModel();

  /*getProducts() {
    isLoading = true;
    var resp = getFamilyProductsApi(familyId: widget.familyId);
    resp.then((value) {
      if (value['status'] == true) {
        setState(() {
          products = FriendProductModel.fromJson(value);
          // for(var v in value["data"]) {
          //   haveProducts.add(FriendProductModel.fromJson(v));
          // }
          // for(var v in haveProducts){
          //   if(v.data.want){
          //     haveProducts2.add(v);
          //   }
          // }
          // print(haveProducts2);
          isLoading = false;
        });
      } else {
        isLoading = false;
        setState(() {});
      }
      // haveProducts2.clear();
    });
  }*/

  List<FamilyMemberProductModel> wantProducts = [];
  List<FamilyMemberProductModel> wantProductsType = [];

  getWantProducts(){
    isLoading = true;
    var resp =  getFamilyProductsApi(member_id: widget.familyId);
    resp.then((value) {
      if(value['error'] == false){
        setState(() {
          for(var v in value['data']){
            wantProducts.add( FamilyMemberProductModel.fromJson(v));
          }
          for(var q in wantProducts){
            if(q.type == 'want'){
              wantProductsType.add(q);

            }
          }
          print(wantProducts);
          isLoading = false;
        });

      }else{
        setState(() {
          isLoading = false;
        });
      }
    });

  }

  List<FamilyMemberProductModel> dontWantProducts = [];
  List<FamilyMemberProductModel> dontWantProductsType = [];

  getDontWantProducts(){
    isLoading = true;
    var resp =  getFamilyProductsApi(member_id: widget.familyId);
    resp.then((value) {
      if(value['error'] == false){
        setState(() {
          for(var v in value['data']){
            dontWantProducts.add( FamilyMemberProductModel.fromJson(v));
          }
          for(var q in dontWantProducts){
            if(q.type == 'dont_want'){
              dontWantProductsType.add(q);

            }
          }
          isLoading = false;
        });

      }else{
        setState(() {
          isLoading = false;
        });
      }
    });

  }



  List<FamilyMemberProductModel> haveProducts = [];
  List<FamilyMemberProductModel> haveProductsType = [];


  getHaveProducts(){
    isLoading = true;
    var resp =  getFamilyProductsApi(member_id: widget.familyId);
    resp.then((value) {
      if(value['error'] == false){
        setState(() {
          for(var v in value['data']){
            haveProducts.add( FamilyMemberProductModel.fromJson(v));
          }
          for(var q in  haveProducts){
            if(q.type == 'have'){
              haveProductsType.add(q);

            }
          }
          isLoading = false;
        });

      }else{
        setState(() {
          isLoading = false;
        });
      }
    });

  }


  // FriendModel friendList = FriendModel();
  // getFriends() {
  //   isLoading = true;
  //   // friendList.clear();
  //   var resp = getFriendsApi();
  //   resp.then((value) {
  //     if (mounted) {
  //       if (value['status'] == true) {
  //         setState(() {
  //           friendList = FriendModel.fromJson(value);
  //           // for (var v in value) {
  //           //   friendList.add(ModelFriend.fromJson(v));
  //           // }
  //           isLoading = false;
  //         });
  //       } else {
  //         setState(() {
  //           isLoading = false;
  //         });
  //
  //         // isLoading = false;
  //       }
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned(
              top: 250.h,
              left: 0,
              child: Image.asset("assets/images/Rectangle356.png")),
          Positioned(
              top: 500.h,
              left: 0,
              child: Image.asset("assets/images/Rectangle3564.png")),
          Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Row(
                children: [
                  Text(
                    widget.familyUserName,
                    // "AndyAngie3260",
                    style: AppTextStyle().textColor39393916w500,
                  ),
                  Spacer(),
                  AppBarIcon(
                      onTap: () {
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProfileChatPage(
                              chatId: ,

                              friendId: widget.familyId,
                              name: widget.familyName,
                              friendImage: widget.familyPhoto,
                              selectedItems: [],
                            ),
                          ),
                        );*/
                      },
                      iconName: '4xchat'),
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 16, left: 180),
                                child: Material(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(
                                            width: 1,
                                            color: ColorSelect.colorECEDF0),
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          // ListTile(
                                          //   title: GestureDetector(
                                          //     onTap: () {
                                          //       setState(() {
                                          //         Share.share(
                                          //             'Share your friend details');
                                          //       });
                                          //     },
                                          //     child: Text(
                                          //       'Send Profile',
                                          //       style:
                                          //           // AppTextStyle().textColorBA505014w500
                                          //           AppTextStyle()
                                          //               .textColor39393914w500,
                                          //     ),
                                          //   ),
                                          // ),
                                          ListTile(
                                            title: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            FriendNotification()));
                                              },
                                              child: Text(
                                                'Notification',
                                                style:
                                                    // AppTextStyle().textColorBA505014w500
                                                    AppTextStyle()
                                                        .textColor39393914w500,
                                              ),
                                            ),
                                          ),
                                          ListTile(
                                            title: GestureDetector(
                                              onTap: () {
                                                   deleteFriendApi(id: widget.id)
                                                    .then((value) {
                                                  if (value['status'] == true) {
                                                    Fluttertoast.showToast(
                                                        msg: value['message']);
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                  } else {
                                                    Fluttertoast.showToast(
                                                        msg: value['message']);
                                                  }
                                                });
                                              },
                                              child: Text(
                                                'Unfriend',
                                                style:
                                                    // AppTextStyle().textColorBA505014w500
                                                    AppTextStyle()
                                                        .textColor39393914w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // margin: EdgeInsets.only(
                                    //     right: 10,
                                    //     top: 10,
                                    //     left: 60,
                                    //     bottom: 6004
                                    // ),
                                    // ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        child: Image.asset("assets/images/4xdot.png")),
                  )
                ],
              ),
              leading: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset('assets/images/Vector190.png')),
              ),
            ),
            backgroundColor: Colors.transparent,
            body: isLoading
                ? Loading()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Stack(
                            clipBehavior: Clip.hardEdge,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  "assets/images/Rectangle1112.png",
                                  height: 80,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => FamilyMemberDetails(
                                        familyName: widget.familyName,
                                        familyUserName: widget.familyUserName,
                                        familyPhoto: widget.familyPhoto,
                                        familyMemberId: widget.familyId,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 1.sw,
                                  padding: EdgeInsets.all(16),
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          width: 1,
                                          color: ColorSelect.colorA3A3A3)),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 48,
                                              height: 48,
                                              clipBehavior: Clip.hardEdge,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey,
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl: widget.familyPhoto
                                                        .contains('http')
                                                    ? widget.familyPhoto
                                                    : baseUrl +
                                                        widget.familyPhoto,
                                                fit: BoxFit.cover,
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                                progressIndicatorBuilder:
                                                    (a, b, c) => Opacity(
                                                  opacity: 0.3,
                                                  child: Shimmer.fromColors(
                                                    baseColor: Colors.black12,
                                                    highlightColor:
                                                        Colors.white,
                                                    child: Container(
                                                      width: 48,
                                                      height: 48,
                                                      //margin: EdgeInsets.symmetric(horizontal: 24),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          shape:
                                                              BoxShape.circle),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                widget.familyName,
                                                // 'Friend Name',
                                                overflow: TextOverflow.ellipsis,
                                                style: AppTextStyle()
                                                    .textColor29292916w500r,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Profile',
                                            style: AppTextStyle()
                                                .textColor70707014w400,
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              color: Colors.black,
                                              size: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${widget.familyName} want',
                                  // 'Friend Name wants',
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyle().textColor29292920w700,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => FamilyWantProducts(
                                        familyName: widget.familyName,
                                        familyId: widget.familyId,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 10, top: 10, bottom: 10),
                                  color: Colors.transparent,
                                  child: Text(
                                    'View All',
                                    style: AppTextStyle().textColor29292914w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12),
                       wantProductsType.isEmpty
                       // products!.data!.want!.isEmpty
                            ? AddProductError(
                                addButton: SizedBox(),
                                image: 'assets/images/Asset 1product 1.png',
                                tap: () {
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context) {
                                        return ManuallyAddBottomSheetWidget(
                                          productType:
                                              '', /*model: widget.model,*/
                                        );
                                      });
                                },
                              )
                            : SizedBox(
                                height: 220,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: wantProductsType.length,
                                    //products!.data!.want!.length,
                                    // itemCount: 2,
                                    shrinkWrap: true,
                                    itemBuilder: (context, i) {
                                      double price = double.tryParse(
                                        wantProductsType[i].price.toString()
                                          // products!
                                          //     .data!.want![i].price
                                          //     .toString()
                                      )
                                          ??
                                          0.0;
                                      double normalizedPercent = price / 100.0;
                                      return Container(
                                        color: Colors.transparent,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 16),
                                            Expanded(
                                              flex: 4,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              FamilyProductDetail(
                                                                name: wantProductsType[i].name.toString(),
                                                                // products!
                                                                //     .data!
                                                                //     .want![i]
                                                                //     .name
                                                                //     .toString(),
                                                                price: wantProductsType[i].price.toString(),
                                                                // products!
                                                                //     .data!
                                                                //     .want![i]
                                                                //     .price
                                                                //     .toString(),
                                                                link: wantProductsType[i].url.toString(),
                                                                // products!
                                                                //     .data!
                                                                //     .want![i]
                                                                //     .link
                                                                //     .toString(),
                                                                image:
                                                                    wantProductsType[i].photo.toString().contains('http') ?
                                                                        wantProductsType[i].photo.toString()
                                                                    :
                                                                        baseUrl + wantProductsType[i].photo.toString(),
                                                                // products!
                                                                //         .data!
                                                                //         .want![
                                                                //             i]
                                                                //         .photo
                                                                //         .toString()
                                                                //         .contains(
                                                                //             'http')
                                                                //     ? products!
                                                                //         .data!
                                                                //         .want![
                                                                //             i]
                                                                //         .photo
                                                                //         .toString()
                                                                //     : baseUrl +
                                                                //         products!
                                                                //             .data!
                                                                //             .want![i]
                                                                //             .photo
                                                                //             .toString(),
                                                                purchaseDate: wantProductsType[i].purchasedOn.toString(),
                                                                // products!
                                                                //     .data!
                                                                //     .want![i]
                                                                //     .purchasedDate
                                                                //     .toString(),
                                                                id: wantProductsType[i].id.toString(),
                                                                // products!
                                                                //     .data!
                                                                //     .want![i]
                                                                //     .id
                                                                //     .toString(),
                                                                type: '',
                                                                // products!
                                                                //     .data!
                                                                //     .want![i]
                                                                //     .type
                                                                //     .toString(),
                                                                productId: '',
                                                              )));
                                                  // Navigator.push(
                                                  //   context,
                                                  //   MaterialPageRoute(
                                                  //     builder: (context) =>
                                                  //         WantProducts(
                                                  //       isUser: true,
                                                  //     ),
                                                  //   ),
                                                  // );
                                                },
                                                child: Container(
                                                  width: 173,
                                                  height: 129,
                                                  margin:
                                                      EdgeInsets.only(left: 16),
                                                  clipBehavior: Clip.hardEdge,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: ColorSelect
                                                              .colorE0E0E0,
                                                          width: 1),
                                                      color: ColorSelect
                                                          .colorFFFFFF,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        wantProductsType[i].photo.toString().contains('https') ?
                                                            wantProductsType[i].photo.toString() :
                                                            wantProductsType[i].photo.toString(),
                                                    // products!.data!
                                                    //         .want![i].photo
                                                    //         .toString()
                                                    //         .contains("https")
                                                    //     ? products!.data!
                                                    //         .want![i].photo
                                                    //         .toString()
                                                    //     : products!.data!
                                                    //         .want![i].photo
                                                    //         .toString(),
                                                    fit: BoxFit.cover,
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(
                                                      Icons.error,
                                                      size: 40,
                                                    ),
                                                    progressIndicatorBuilder:
                                                        (a, b, c) => Opacity(
                                                      opacity: 0.3,
                                                      child: Shimmer.fromColors(
                                                        baseColor:
                                                            Colors.black12,
                                                        highlightColor:
                                                            Colors.white,
                                                        child: Container(
                                                          width: 173,
                                                          height: 129,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  color: ColorSelect
                                                                      .colorE0E0E0,
                                                                  width: 1),
                                                              color: ColorSelect
                                                                  .colorFFFFFF,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12)),
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
                                                padding: const EdgeInsets.only(
                                                    left: 16),
                                                child: SizedBox(
                                                  width: 173,
                                                  child: Text(
                                                    wantProductsType[i].name.toString(),
                                                    // products!
                                                    //     .data!.want![i].name
                                                    //     .toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    style: AppTextStyle()
                                                        .textColor29292912w400,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 16),
                                                child: Text(
                                                  //'\$ ${normalizedPercent}',
                                                  wantProducts[i].price.toString(),
                                                  style: AppTextStyle()
                                                      .textColor29292914w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                )),
                        SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${widget.familyName} does not want',
                                  // 'Friend Name does not want',
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyle().textColor29292920w700,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => FamilyDontWantProducts(
                                        familyId: widget.familyId,
                                        familyName: widget.familyName,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 10, top: 10, bottom: 10),
                                  color: Colors.transparent,
                                  child: Text(
                                    'View All',
                                    style: AppTextStyle().textColor29292914w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12),
                        dontWantProductsType.isEmpty
                        //products!.data!.dontWant!.isEmpty
                            ? AddProductError(
                                addButton: SizedBox(),
                                image: 'assets/images/addproducts2.png',
                                tap: () {
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context) {
                                        return ManuallyAddBottomSheetWidget(
                                          productType:
                                              '', /*model: widget.model,*/
                                        );
                                      });
                                },
                              )
                            : SizedBox(
                                height: 220,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: dontWantProductsType.isEmpty
                                  //products!.data!.dontWant!.isEmpty
                                      ? AddProductImage(
                                          image:
                                              'assets/images/Asset 1product 1.png',
                                          txt: 'Add Product',
                                          buttonTxt: 'Add Product',
                                          tap: () {},
                                          buttonIcon: 'assets/images/plus.png',
                                        )
                                      : ListView.builder(
                                          // physics: NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemCount:dontWantProductsType.length,
                                              //products!.data!.dontWant!.length,
                                          // itemCount: 2,
                                          shrinkWrap: true,
                                          itemBuilder: (context, i) {
                                            double price = double.tryParse(
                                                dontWantProductsType[i]
                                                        .price
                                                        .toString()) ??
                                                0.0;
                                            double normalizedPercent =
                                                price / 100.0;
                                            return Container(
                                              color: Colors.transparent,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 16),
                                                  Expanded(
                                                    flex: 4,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        FamilyProductDetail(
                                                                          name: dontWantProductsType[i].name.toString(),
                                                                          // products!
                                                                          //     .data!
                                                                          //     .dontWant![i]
                                                                          //     .name
                                                                          //     .toString(),
                                                                          price: dontWantProductsType[i].price.toString(),
                                                                          // products!
                                                                          //     .data!
                                                                          //     .dontWant![i]
                                                                          //     .price
                                                                          //     .toString(),
                                                                          link: dontWantProductsType[i].url.toString(),
                                                                          // products!
                                                                          //     .data!
                                                                          //     .dontWant![i]
                                                                          //     .link
                                                                          //     .toString(),
                                                                          image: dontWantProductsType[i].photo.toString().contains('http')
                                                                            ?
                                                                          dontWantProductsType[i].photo.toString()
                                                                          :
                                                                               baseUrl + dontWantProductsType[i].photo.toString(),
                                                                          // products!.data!.dontWant![i].photo.toString().contains('http')
                                                                          //     ? products!.data!.dontWant![i].photo.toString()
                                                                          //     : baseUrl + products!.data!.dontWant![i].photo.toString(),
                                                                          purchaseDate: dontWantProductsType[i].purchasedOn.toString(),
                                                                          // products!
                                                                          //     .data!
                                                                          //     .dontWant![i]
                                                                          //     .purchasedDate
                                                                          //     .toString(),
                                                                          id: dontWantProductsType[i].id.toString(),
                                                                          // products!
                                                                          //     .data!
                                                                          //     .dontWant![i]
                                                                          //     .id
                                                                          //     .toString(),
                                                                          type: '',
                                                                          // products!
                                                                          //     .data!
                                                                          //     .dontWant![i]
                                                                          //     .type
                                                                          //     .toString(),
                                                                          productId:
                                                                              '',
                                                                        )));
                                                        // Navigator.push(
                                                        //     context,
                                                        //     MaterialPageRoute(
                                                        //         builder:
                                                        //             (context) =>
                                                        //                 FriendProductDetail(
                                                        //                   response:
                                                        //                       widget.response,
                                                        //                   name: products!
                                                        //                       .data!
                                                        //                       .dontWant![i]
                                                        //                       .name
                                                        //                       .toString(),
                                                        //                   price: products!
                                                        //                       .data!
                                                        //                       .dontWant![i]
                                                        //                       .price
                                                        //                       .toString(),
                                                        //                   link: products!
                                                        //                       .data!
                                                        //                       .dontWant![i]
                                                        //                       .link
                                                        //                       .toString(),
                                                        //                   image: products!.data!.dontWant![i].photo.toString().contains('http')
                                                        //                       ? products!.data!.dontWant![i].photo.toString()
                                                        //                       : baseUrl + products!.data!.dontWant![i].photo.toString(),
                                                        //                   purchaseDate: products!
                                                        //                       .data!
                                                        //                       .dontWant![i]
                                                        //                       .purchasedDate
                                                        //                       .toString(),
                                                        //                   id: products!
                                                        //                       .data!
                                                        //                       .dontWant![i]
                                                        //                       .id
                                                        //                       .toString(),
                                                        //                   type: products!
                                                        //                       .data!
                                                        //                       .dontWant![i]
                                                        //                       .type
                                                        //                       .toString(),
                                                        //                   productId:
                                                        //                       '',
                                                        //                 )));
                                                        // Navigator.push(
                                                        //   context,
                                                        //   MaterialPageRoute(
                                                        //     builder: (context) => WantProducts(
                                                        //       isUser: true,
                                                        //     ),
                                                        //   ),
                                                        // );
                                                      },
                                                      child: Container(
                                                        width: 173,
                                                        height: 129,
                                                        margin: EdgeInsets.only(
                                                            left: 16),
                                                        clipBehavior:
                                                            Clip.hardEdge,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: ColorSelect
                                                                    .colorE0E0E0,
                                                                width: 1),
                                                            color: ColorSelect
                                                                .colorFFFFFF,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                          dontWantProductsType[i].photo.toString().contains('https') ?
                                                          dontWantProductsType[i].photo.toString() :
                                                          dontWantProductsType[i].photo.toString(),
                                                          // products!
                                                          //         .data!
                                                          //         .dontWant![i]
                                                          //         .photo
                                                          //         .toString()
                                                          //         .contains(
                                                          //             "https")
                                                          //     ? products!
                                                          //         .data!
                                                          //         .dontWant![i]
                                                          //         .photo
                                                          //         .toString()
                                                          //     : products!
                                                          //         .data!
                                                          //         .dontWant![i]
                                                          //         .photo
                                                          //         .toString(),
                                                          fit: BoxFit.cover,
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(
                                                            Icons.error,
                                                            size: 40,
                                                          ),
                                                          progressIndicatorBuilder:
                                                              (a, b, c) =>
                                                                  Opacity(
                                                            opacity: 0.3,
                                                            child: Shimmer
                                                                .fromColors(
                                                              baseColor: Colors
                                                                  .black12,
                                                              highlightColor:
                                                                  Colors.white,
                                                              child: Container(
                                                                width: 173,
                                                                height: 129,
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        color: ColorSelect
                                                                            .colorE0E0E0,
                                                                        width:
                                                                            1),
                                                                    color: ColorSelect
                                                                        .colorFFFFFF,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12)),
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
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 16),
                                                      child: SizedBox(
                                                        width: 173,
                                                        child: Text(
                                                          dontWantProductsType[i].name.toString(),
                                                          // products!.data!
                                                          //     .dontWant![i].name
                                                          //     .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2,
                                                          style: AppTextStyle()
                                                              .textColor29292912w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 4),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 16),
                                                      child: Text(
                                                        //'\$ ${normalizedPercent}',
                                                          dontWantProductsType[i].price.toString(),
                                                        style: AppTextStyle()
                                                            .textColor29292914w500,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                )),
                        SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '${widget.familyName} have',
                                  // 'Friend Name does not want',
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyle().textColor29292920w700,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => FamilyHaveProducts(
                                        familyId: widget.familyId,
                                        familyName: widget.familyName,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 10, top: 10, bottom: 10),
                                  color: Colors.transparent,
                                  child: Text(
                                    'View All',
                                    style: AppTextStyle().textColor29292914w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 12),
                        haveProductsType.isEmpty
                        //products!.data!.have!.isEmpty
                            ? AddProductError(
                                addButton: SizedBox(),
                                image: 'assets/images/addproduct3.png',
                                tap: () {
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context) {
                                        return ManuallyAddBottomSheetWidget(
                                          productType:
                                              '', /*model: widget.model,*/
                                        );
                                      });
                                },
                              )
                            : SizedBox(
                                height: 220,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child:
                                  haveProductsType.isEmpty
                                  //products!.data!.have!.isEmpty
                                      ? AddProductImage(
                                          image:
                                              'assets/images/Asset 1product 1.png',
                                          txt: 'Add Product',
                                          buttonTxt: 'Add Product',
                                          tap: () {},
                                          buttonIcon: 'assets/images/plus.png',
                                        )
                                      : ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: haveProductsType.length,
                                             // products!.data!.have!.length,
                                          // itemCount: 2,
                                          shrinkWrap: true,
                                          itemBuilder: (context, i) {
                                            double price = double.tryParse(
                                                    haveProductsType[i].price
                                                        .toString()) ??
                                                0.0;
                                            double normalizedPercent =
                                                price / 100.0;
                                            return Container(
                                              color: Colors.transparent,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 16),
                                                  Expanded(
                                                    flex: 4,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        FamilyProductDetail(
                                                                          name: haveProductsType[i].name.toString(),
                                                                          // products!
                                                                          //     .data!
                                                                          //     .have![i]
                                                                          //     .name
                                                                          //     .toString(),
                                                                          price: haveProductsType[i].price.toString(),
                                                                          // products!
                                                                          //     .data!
                                                                          //     .have![i]
                                                                          //     .price
                                                                          //     .toString(),
                                                                          link: haveProductsType[i].url.toString(),
                                                                          // products!
                                                                          //     .data!
                                                                          //     .have![i]
                                                                          //     .link
                                                                          //     .toString(),
                                                                          image: haveProductsType[i].photo.toString().contains('http') ?
                                                                              haveProductsType[i].photo.toString() :
                                                                              baseUrl + haveProductsType[i].photo.toString(),
                                                                          // products!.data!.have![i].photo.toString().contains('http')
                                                                          //     ? products!.data!.have![i].photo.toString()
                                                                          //     : baseUrl + products!.data!.have![i].photo.toString(),
                                                                          purchaseDate: haveProductsType[i].purchasedOn.toString(),
                                                                          // products!
                                                                          //     .data!
                                                                          //     .have![i]
                                                                          //     .purchasedDate
                                                                          //     .toString(),
                                                                          id: haveProductsType[i].id.toString(),
                                                                          // products!
                                                                          //     .data!
                                                                          //     .have![i]
                                                                          //     .id
                                                                          //     .toString(),
                                                                          type: '',
                                                                          // products!
                                                                          //     .data!
                                                                          //     .have![i]
                                                                          //     .type
                                                                          //     .toString(),
                                                                          productId:
                                                                              '',
                                                                        )));
                                                        // Navigator.push(
                                                        //     context,
                                                        //     MaterialPageRoute(
                                                        //         builder:
                                                        //             (context) =>
                                                        //                 FriendProductDetail(
                                                        //                   response:
                                                        //                       widget.response,
                                                        //                   name: products!
                                                        //                       .data!
                                                        //                       .have![i]
                                                        //                       .name
                                                        //                       .toString(),
                                                        //                   price: products!
                                                        //                       .data!
                                                        //                       .have![i]
                                                        //                       .price
                                                        //                       .toString(),
                                                        //                   link: products!
                                                        //                       .data!
                                                        //                       .have![i]
                                                        //                       .link
                                                        //                       .toString(),
                                                        //                   image: products!.data!.have![i].photo.toString().contains('http')
                                                        //                       ? products!.data!.have![i].photo.toString()
                                                        //                       : baseUrl + products!.data!.have![i].photo.toString(),
                                                        //                   purchaseDate: products!
                                                        //                       .data!
                                                        //                       .have![i]
                                                        //                       .purchasedDate
                                                        //                       .toString(),
                                                        //                   id: products!
                                                        //                       .data!
                                                        //                       .have![i]
                                                        //                       .id
                                                        //                       .toString(),
                                                        //                   type: products!
                                                        //                       .data!
                                                        //                       .have![i]
                                                        //                       .type
                                                        //                       .toString(),
                                                        //                   productId:
                                                        //                       '',
                                                        //                 )));
                                                        // Navigator.push(
                                                        //   context,
                                                        //   MaterialPageRoute(
                                                        //     builder: (context) => WantProducts(
                                                        //       isUser: true,
                                                        //     ),
                                                        //   ),
                                                        // );
                                                      },
                                                      child: Container(
                                                        width: 173,
                                                        height: 129,
                                                        margin: EdgeInsets.only(
                                                            left: 16),
                                                        clipBehavior:
                                                            Clip.hardEdge,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: ColorSelect
                                                                    .colorE0E0E0,
                                                                width: 1),
                                                            color: ColorSelect
                                                                .colorFFFFFF,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                          haveProductsType[i].photo.toString().contains('https') ?
                                                          haveProductsType[i].photo.toString() :
                                                          baseUrl + haveProductsType[i].photo.toString(),
                                                          // products!
                                                          //         .data!
                                                          //         .have![i]
                                                          //         .photo
                                                          //         .toString()
                                                          //         .contains(
                                                          //             "https")
                                                          //     ? products!
                                                          //         .data!
                                                          //         .have![i]
                                                          //         .photo
                                                          //         .toString()
                                                          //     : products!
                                                          //         .data!
                                                          //         .have![i]
                                                          //         .photo
                                                          //         .toString(),
                                                          fit: BoxFit.cover,
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Icon(
                                                            Icons.error,
                                                            size: 40,
                                                          ),
                                                          progressIndicatorBuilder:
                                                              (a, b, c) =>
                                                                  Opacity(
                                                            opacity: 0.3,
                                                            child: Shimmer
                                                                .fromColors(
                                                              baseColor: Colors
                                                                  .black12,
                                                              highlightColor:
                                                                  Colors.white,
                                                              child: Container(
                                                                width: 173,
                                                                height: 129,
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        color: ColorSelect
                                                                            .colorE0E0E0,
                                                                        width:
                                                                            1),
                                                                    color: ColorSelect
                                                                        .colorFFFFFF,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12)),
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
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 16),
                                                      child: SizedBox(
                                                        width: 173,
                                                        child: Text(
                                                          haveProductsType[i].name.toString(),
                                                          // products!.data!
                                                          //     .have![i].name
                                                          //     .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2,
                                                          style: AppTextStyle()
                                                              .textColor29292912w400,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 4),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 16),
                                                      child: Text(
                                                       // '\$ ${normalizedPercent}',
                                                        haveProductsType[i].price.toString(),
                                                        style: AppTextStyle()
                                                            .textColor29292914w500,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                )),
                        SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
