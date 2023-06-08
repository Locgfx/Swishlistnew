import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swishlist/constants/color.dart';
import '../products/products_page.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({Key? key}) : super(key: key);

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSelect.colorFDFAE3,
        elevation: 0,
        title: TextFormField(
          cursorColor: ColorSelect.colorF7E641,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search product, username and more"),
          keyboardType: TextInputType.text,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/images/etsyimg.png",
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                      text: ("Search"),
                      style: AppTextStyle().textColor0D0D0F14w400,
                    ),
                    TextSpan(
                      text: (" Rose234"),
                      style: AppTextStyle().textColor0D0D0F14w600,
                    ),
                    TextSpan(
                      text: " on Etsy",
                      style: AppTextStyle().textColor0D0D0F14w400,
                    ),
                  ])),
                ],
              ),
              SizedBox(
                height: 27,
              ),
              Row(
                children: [
                  Image.asset(
                    "assets/images/amazonimg.png",
                    height: 24,
                    width: 24,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: ("Show"),
                          style: AppTextStyle().textColor0D0D0F14w400,
                        ),
                        TextSpan(
                          text: (" Rose234"),
                          style: AppTextStyle().textColor0D0D0F14w600,
                        ),
                        TextSpan(
                          text: " on Amazon",
                          style: AppTextStyle().textColor0D0D0F14w400,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 34),
              SizedBox(
                height: 220,
                child: IWantProductListWidget(
            /*      imageList: imageList,
                  itemNameList: itemNameList,
                  itemPrice: itemPrice,*/
                ),
              ),
              SizedBox(height: 34),
              Text(
                "Users",
                style: AppTextStyle().textColor90909B12w400,
              ),
              SizedBox(
                height: 16,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.grey,
                            backgroundImage:
                                AssetImage('assets/images/Rectangle3194.png'),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Jan Levinson",
                            style: AppTextStyle().textColor29292914w500,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "JanLev23X0",
                            style: AppTextStyle().textColor70707014w400,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 22,
                  )
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                "Recent searches",
                style: AppTextStyle().textColor90909B12w400,
              ),
              SizedBox(
                height: 18,
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "AnthonyXyzu84",
                              style: AppTextStyle().textColor0D0D0F12w400,
                            ),
                            Spacer(),
                            Icon(Icons.close)
                          ],
                        ),
                        SizedBox(
                          height: 19,
                        )
                      ],
                    );
                  }),
              SizedBox(
                height: 34,
              ),
              Text(
                "Recently Opened",
                style: AppTextStyle().textColor90909B12w400,
              ),
              SizedBox(
                height: 12,
              ),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.grey,
                                  backgroundImage: AssetImage(
                                      'assets/images/Rectangle3194.png'),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Jan Levinson",
                                  style: AppTextStyle().textColor29292914w500,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "JanLev23X0",
                                  style: AppTextStyle().textColor70707014w400,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 22,
                        )
                      ],
                    );
                  },
              )
            ],
          ),
        ),
      ),
    );
  }
}
