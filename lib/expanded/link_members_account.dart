
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:swishlist/buttons/light_yellow.dart';
import 'package:swishlist/constants/color.dart';
import 'package:swishlist/expanded/request_sent.dart';
import 'package:swishlist/models/search_model.dart';
import '../api/user_apis/family_apis.dart';
import '../api/user_apis/family_member_search_api.dart';


class LinkMembersAccount extends StatefulWidget {
  // final SearchModel search;
  const LinkMembersAccount({Key? key,
    // required this.search
  }) : super(key: key);

  @override
  State<LinkMembersAccount> createState() => _LinkMembersAccountState();
}

class _LinkMembersAccountState extends State<LinkMembersAccount> {


  SearchModel model = SearchModel();
  List<SearchModel> searchModel = [];
  final searchController = TextEditingController();
  final memberId = TextEditingController();
  final privacyStatus = TextEditingController();
  final GlobalKey _autocompleteKey = GlobalKey();
  final focus = FocusNode();

  List<SearchModel> matches = <SearchModel>[];
  // FamilyMemberModel? familyM;
  bool isLoading = false;
  getSearch(val) {
    isLoading = true;
    final resp = searchMemberApi(name: val);
    resp.then((value) {
      print(value);
      searchModel.clear();
      setState(() {
        for (var v in value['data']) {
          searchModel.add(SearchModel.fromJson(v));
        }
        isLoading = false;
      });
    });
  }

  String _selectedText = 'father';
  // List<String> suggest = ["hjihsdi", "mdkfcmsdkvh", "hdsksl", "dldsh",
  //   "hsdsdsdsp",'psdlpdslasph','dcmskcndscdh','dndhkmsd','dlpssh',
  // "mdiaksm",'ndsjh','osdmsodohh','dlpsdhh','nfdfdsnhhhd','dndfnfh','sdmhskm','lllllddd'];
  final TextEditingController _typeAheadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        height: 52.h,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        child:  isLoading ? Center(
          child: LoadingAnimationWidget.waveDots(
            size: 40,
            color: ColorSelect.colorF7E641,
          ),
        ):LightYellowButtonWithText(
          backgroundColor:(
              searchController.text.isNotEmpty &&
              _selectedText.isNotEmpty
          ) ? MaterialStateProperty.all(ColorSelect.colorF7E641)
              : MaterialStateProperty.all(ColorSelect.colorFCF5B6),
          textStyleColor: (
              searchController.text.isNotEmpty &&
                  _selectedText.isNotEmpty
          ) ?  Colors.black :
               ColorSelect.colorB5B07A,
          onTap: () {
            if(searchController.text.isNotEmpty ) {
              postFamilyMemberApi(
                  familyMemberId: memberId.text,
                  relation: _selectedText,
                  status: 'requested',
                  privacy: privacyStatus.text,
                  ).then((value) async {
                    if(value['status'] == true) {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (context) => RequestSent(name: searchController.text,)));
                      Fluttertoast.showToast(
                          msg: value['message']);
                    } else {
                      Fluttertoast.showToast(
                          msg: value['message']);
                    }
              });
            }
          },
          title: 'Send request',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: Row(
                children: [
                  Text(
                    "Link member’s account",
                    style: AppTextStyle().textColor29292916w500,
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
            SizedBox(height: 40),
            Text(
              "Link a family member's\n               account",
              style: AppTextStyle().textColor29292924w700,
            ),
            SizedBox(height: 20),
            Text(
              "Please enter the phone number or email they \n        created their SwishList account with.",
              style: AppTextStyle().textColor70707012w400,
            ),
            SizedBox(height: 60),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: 52.h,
              decoration: BoxDecoration(
              color: ColorSelect.colorEDEDF1,
              borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: TypeAheadField(
                  animationStart: 0,
                  animationDuration: Duration.zero,
                  textFieldConfiguration: TextFieldConfiguration(
                    onSubmitted: (v) {
                      setState(() {
                        searchModel.clear();
                      });
                    },
                    onChanged: (val) {
                      if(val.length >=4){
                        getSearch(val);
                      } else {
                        setState(() {
                          searchModel.clear();
                          matches.clear();
                        });
                      }
                      },
                    controller: searchController,
                      autofocus: true,
                      style: TextStyle(fontSize: 15),
                      decoration: InputDecoration(
                        hintText: 'please enter atleast 4 characters',
                          border: InputBorder.none
                      )
                  ),
                  suggestionsBoxDecoration: SuggestionsBoxDecoration(
                    color: ColorSelect.colorEDEDF1,
                  ),
                  suggestionsCallback: (pattern) {
                    print(searchController.text);
                    matches.addAll(searchModel);
                    matches.retainWhere((s){
                      return s.name!.toLowerCase().contains(pattern.toLowerCase());
                    });
                    return matches;
                  },
                  itemBuilder: (context,SearchModel i) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      child:Text(i.name.toString()),
                    );
                  },
                  onSuggestionSelected: (SearchModel suggestion) {
                    print(suggestion);
                    setState(() {
                      searchController.clear();
                      searchController.text = suggestion.name!;
                      memberId.text = suggestion.id!.toString();
                      privacyStatus.text = suggestion.privacyStatus!;
                      searchModel.clear();
                    });
                  },
                ),
              ),
            ),
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 16),
            //   height: 52.h,
            //   decoration: BoxDecoration(
            //       color: ColorSelect.colorEDEDF1,
            //       borderRadius: BorderRadius.all(Radius.circular(8))),
            //   child: Padding(
            //     padding: const EdgeInsets.only(left: 20),
            //     child: Column(
            //       children: [
            //     TextField(
            //     decoration: InputDecoration(
            //     hintText: 'Enter username',
            //         border: InputBorder.none
            //     ),
            //     controller: searchController,
            //     focusNode: focusNode,
            //     onChanged: (String value) {
            //       RawAutocomplete.onFieldSubmitted<SearchModel>(_autocompleteKey);
            //     },
            //   ),
            //         RawAutocomplete<SearchModel>(
            //           textEditingController: searchController,
            //           focusNode:focusNode ,
            //           key: _autocompleteKey,
            //           // initialValue: TextEditingValue(text: searchController.text),
            //           optionsBuilder: (TextEditingValue textEditingValue) {
            //             if (textEditingValue.text == '') {
            //               return const Iterable<SearchModel>.empty();
            //             }else{
            //               List<SearchModel> matches = <SearchModel>[];
            //               matches.addAll(searchModel);
            //
            //
            //               matches.retainWhere((s){
            //                 return s.name!.toLowerCase().contains(textEditingValue.text.toLowerCase());
            //               });
            //               return matches;
            //             }
            //           },
            //
            //           onSelected: ( selection) {
            //             print('You just selected $selection');
            //           },
            //           optionsViewBuilder: (BuildContext context, void Function(SearchModel) onSelected,
            //               Iterable<SearchModel> options) {
            //             return Column(crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Container(height: 3,width: 200,color: Colors.transparent,),
            //                 Material(
            //                     borderRadius:  BorderRadius.circular(8.0),
            //                   color: Colors.transparent,
            //                     child:SingleChildScrollView(
            //                         child: Column(
            //                           crossAxisAlignment:CrossAxisAlignment.start,
            //                           children: options.map((opt){
            //                             return InkWell(
            //                                 onTap: () {
            //                                   onSelected(opt);
            //                                 },
            //                                 child: Container(
            //                                     color: ColorSelect.colorEDEDF1,
            //                                     child:Container(
            //                                       width: 300.w,
            //                                       padding: EdgeInsets.all(10),
            //                                       child:Text(opt.name!),
            //                                     )
            //                                 ),
            //                             );
            //                           }).toList(),
            //                         ),
            //                     )
            //                 ),
            //               ],
            //             );
            //           },
            //         ),
            //       ],
            //     )
            //     // child: TextFormField(
            //     //   decoration: InputDecoration(
            //     //       border: InputBorder.none,
            //     //        hintText: "Enter name"),
            //     //       keyboardType: TextInputType.name,
            //     // ),
            //   ),
            // ),
            SizedBox(height: 20.h),
            Container(
              height: 52.h,
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: ColorSelect.colorEDEDF1,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      'Select relationship',
                      style: AppTextStyle().textColor70707014w400,
                    ),
                  ),
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Image.asset('assets/images/Vector123.png'),
                  ),
                  iconSize: 24,
                  elevation: 0,
                  underline: SizedBox(),
                  value: _selectedText,
                  items: <String> [
                    'father',
                    'mother',
                    'brother',
                    'child',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? val) {
                    setState(() {
                      _selectedText = val!;
                    });
                    print(_selectedText);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
