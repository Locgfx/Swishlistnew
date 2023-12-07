import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/constants/urls.dart';
import 'package:swishlist/models/pets_models.dart';
import 'package:swishlist/profile_page/add_pets.dart';

import '../api/user_apis/pets_api.dart';
import '../constants/globals/loading.dart';
import '../expanded/user_all_details.dart';

class Pets extends StatefulWidget {
  const Pets({Key? key}) : super(key: key);

  @override
  State<Pets> createState() => _PetsState();
}

class _PetsState extends State<Pets> {
  @override
  void initState() {
    getPets();
    super.initState();
  }

  List<int> selectedItems = [];
  bool isLoading = false;
  // PetsModel? pets;


  List<PetModel> pets = [];

  getPets(){
    isLoading = true;
    var resp = getPetsAPi();
    pets.clear();
    resp.then((value){

      if(value['error'] == false){
        setState(() {
          for(var v in value['data']){
            pets.add(PetModel.fromJson(v));
          }

          print('hhhh$pets');

          isLoading = false;
        });
      }else{
        setState(() {

          isLoading = false;
        });
      }
    });
  }
  //
  // getPets() {
  //   isLoading = true;
  //   var resp = getPetsAPi();
  //   resp.then((value) {
  //     if (value['status'] == true) {
  //       setState(() {
  //         pets = PetsModel.fromJson(value);
  //         isLoading = false;
  //       });
  //     } else {
  //       setState(() {
  //         isLoading = false;
  //       });
  //     }
  //   });
  // }
  //
  // @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 140),
                  child: Text(
                    "Pets",
                    style: AppTextStyle().textColor29292916w500,
                  ),
                ),
              ],
            ),
            selectedItems.isEmpty
                ? SizedBox()
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        isLoading = true;
                      });
                      for (var v in selectedItems) {
                        deletePetsApi(id: v.toString()).then((value) async {
                          print(v);
                          print(selectedItems.toString());
                          if (value['error'] == false) {
                            setState(() {
                              pets
                                  .removeWhere((element) => element.id == v);
                            });
                            Fluttertoast.showToast(msg: value['message']);
                          } else {
                            Fluttertoast.showToast(msg: value['message']);
                          }
                          setState(() {
                            isLoading = false;
                            selectedItems.clear();
                          });
                        });
                      }
                    },
                    child: Container(
                      width: 36,
                      height: 36,
                      color: Colors.transparent,
                      child: Image.asset('assets/images/del.png'),
                    ),
                  ),
          ],
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
      ),
      backgroundColor: Colors.white,
      body: isLoading
          ? Loading()
          : RefreshIndicator(
              displacement: 500,
              backgroundColor: Colors.white,
              color: ColorSelect.colorF7E641,
              strokeWidth: 3,
              onRefresh: () {
                setState(() {
                  isLoading = true;
                });
                return getPets();
              },
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 8.h,
                          width: 360.w,
                          decoration: BoxDecoration(
                              color: Color(0xffC09B3D).withOpacity(0.28),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 8.h,
                              width: 360.w,
                              decoration: BoxDecoration(
                                color: ColorSelect.colorC09B3D,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        pets.isEmpty
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => AddPets()));
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5),
                                  height: 200,
                                  width: 220,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Image.asset(
                                          'assets/images/Frame10000030453.png'),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Text(
                                        "+ Add Pets",
                                        style: AppTextStyle()
                                            .textColorC09B3D14w600,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: GridView.builder(
                                  scrollDirection: Axis.vertical,
                                  physics: ScrollPhysics(),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  itemCount: pets.length + 1,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1,
                                    mainAxisSpacing: 10,
                                  ),
                                  itemBuilder: (ctx, index) {
                                    if (index >= pets.length) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => AddPets()));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          height: 220,
                                          width: 130,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey, width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Image.asset(
                                                  'assets/images/Frame10000030453.png'),
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Text(
                                                "+ Add more",
                                                style: AppTextStyle()
                                                    .textColorC09B3D14w600,
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return GestureDetector(
                                        onLongPress: () {
                                          if (selectedItems.isEmpty) {
                                            setState(() {
                                              selectedItems
                                                  .add(pets[index].id!);
                                            });
                                          }
                                        },
                                        onTap: () {
                                          if (selectedItems.isEmpty) {
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             selectedItems()));
                                          } else {
                                            if (selectedItems.contains(
                                                pets[index].id!)) {
                                              setState(() {
                                                selectedItems.remove(
                                                    pets[index].id!);
                                              });
                                            } else {
                                              setState(() {
                                                selectedItems.add(
                                                    pets[index].id!);
                                              });
                                            }
                                          }
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          height: 300,
                                          width: 130,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: selectedItems.contains(
                                                          pets
                                                          [index].id)
                                                      ? ColorSelect.colorF7E641
                                                      : Colors.grey,
                                                  // color: Colors.grey,
                                                  width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 20.h,
                                              ),
                                              Center(
                                                child: Container(
                                                  height: 80,
                                                  width: 80,
                                                  clipBehavior: Clip.hardEdge,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.grey.shade200,
                                                  ),
                                                  child: CachedNetworkImage(
                                                    imageUrl: (
                                                        // pets[index].photo
                                                        //     .toString().contains('http') ? pets[index].photo.toString() :
                                                     pets[index].photo.toString()),
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
                                                          width: 50,
                                                          height: 50,
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  shape: BoxShape
                                                                      .circle),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // Image.asset(pets!.data[index].photo.toString()),
                                              SizedBox(
                                                height: 10.h,
                                              ),
                                              Column(
                                                children: [

                                                  Text(
                                                   
                                                    pets[index].name
                                                        .toString(),
                                                    maxLines: 5,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: AppTextStyle()
                                                        .textColor29292914w400,
                                                  ),
                                                  Text(
                                                    pets[index].type
                                                        .toString(),
                                                    style: AppTextStyle()
                                                        .textColor70707014w400,
                                                  ),
                                                  Text(
                                                    pets[index].origin
                                                        .toString(),
                                                    style: AppTextStyle()
                                                        .textColor70707014w400,
                                                  ),
                                                ],
                                              ),

                                              // Text(
                                              //   pets!.data![index].origin
                                              //       .toString(),
                                              //   style: AppTextStyle()
                                              //       .textColor70707014w400,
                                              // ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              )
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
