import 'package:flutter/material.dart';
import 'package:swishlist/constants/color.dart';

class SearchFilters extends StatefulWidget {
  const SearchFilters({Key? key}) : super(key: key);

  @override
  State<SearchFilters> createState() => _SearchFiltersState();
}

class _SearchFiltersState extends State<SearchFilters> {
  int selectedSortBy = 0;
  List sortByOptions = [
    'Title',
    'Price',
    'Date Added',
    'Views',
  ];
  List storeOptions = [
    'Amazon',
    'Etsy',
  ];
  int selectedStoreOption = 0;
  List priceOptions = [
    'Under \$200',
    '\$200-\$500',
    '\$500-\$2000',
    'Above \$2000',
  ];
  int selectedPriceOption = 0;
  List dateAddedOptions = [
    'This year',
    'Today',
    'This week',
    'This month',
  ];
  int selectedDateAddedOption = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Search Filters',
                    style: AppTextStyle().textColor29292924w700,
                  ),
                  Container(
                    color: Colors.transparent,
                    child: Text(
                      'Clear',
                      style: AppTextStyle().textColor29292914w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                SizedBox(width: 16),
                Text(
                  'Sort By',
                  style: AppTextStyle().textColor70707014w400,
                ),
              ],
            ),
            SizedBox(height: 8),
            Container(
              height: 40,
              padding: const EdgeInsets.only(left: 16),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (_, i) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSortBy = i;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: selectedSortBy == i
                            ? ColorSelect.colorF7E641
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(80),
                        border: Border.all(
                          width: 1,
                          color: selectedSortBy == i
                              ? ColorSelect.colorF7E641
                              : ColorSelect.kD1D1D1,
                        ),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Text(
                              sortByOptions[i],
                              style: AppTextStyle().textColor38383814w400,
                            ),
                            if (selectedSortBy == i) SizedBox(width: 8),
                            if (selectedSortBy == i)
                              Container(
                                width: 24,
                                height: 24,
                                //padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black.withOpacity(0.16)),
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                SizedBox(width: 16),
                Text(
                  'Store',
                  style: AppTextStyle().textColor70707014w400,
                ),
              ],
            ),
            SizedBox(height: 8),
            Container(
              height: 40,
              padding: const EdgeInsets.only(left: 16),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (_, i) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedStoreOption = i;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: selectedStoreOption == i
                            ? ColorSelect.colorF7E641
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(80),
                        border: Border.all(
                          width: 1,
                          color: selectedStoreOption == i
                              ? ColorSelect.colorF7E641
                              : ColorSelect.kD1D1D1,
                        ),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Text(
                              storeOptions[i],
                              style: AppTextStyle().textColor38383814w400,
                            ),
                            if (selectedStoreOption == i) SizedBox(width: 8),
                            if (selectedStoreOption == i)
                              Container(
                                width: 24,
                                height: 24,
                                //padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black.withOpacity(0.16)),
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                SizedBox(width: 16),
                Text(
                  'Price',
                  style: AppTextStyle().textColor70707014w400,
                ),
              ],
            ),
            SizedBox(height: 8),
            Container(
              height: 40,
              padding: const EdgeInsets.only(left: 16),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: priceOptions.length,
                itemBuilder: (_, i) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPriceOption = i;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: selectedPriceOption == i
                            ? ColorSelect.colorF7E641
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(80),
                        border: Border.all(
                          width: 1,
                          color: selectedPriceOption == i
                              ? ColorSelect.colorF7E641
                              : ColorSelect.kD1D1D1,
                        ),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Text(
                              priceOptions[i],
                              style: AppTextStyle().textColor38383814w400,
                            ),
                            if (selectedPriceOption == i) SizedBox(width: 8),
                            if (selectedPriceOption == i)
                              Container(
                                width: 24,
                                height: 24,
                                //padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black.withOpacity(0.16)),
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                SizedBox(width: 16),
                Text(
                  'Date Added',
                  style: AppTextStyle().textColor70707014w400,
                ),
              ],
            ),
            SizedBox(height: 8),
            Container(
              height: 40,
              padding: const EdgeInsets.only(left: 16),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: dateAddedOptions.length,
                itemBuilder: (_, i) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDateAddedOption = i;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      margin: EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: selectedDateAddedOption == i
                            ? ColorSelect.colorF7E641
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(80),
                        border: Border.all(
                          width: 1,
                          color: selectedDateAddedOption == i
                              ? ColorSelect.colorF7E641
                              : ColorSelect.kD1D1D1,
                        ),
                      ),
                      child: Center(
                        child: Row(
                          children: [
                            Text(
                              dateAddedOptions[i],
                              style: AppTextStyle().textColor38383814w400,
                            ),
                            if (selectedDateAddedOption == i)
                              SizedBox(width: 8),
                            if (selectedDateAddedOption == i)
                              Container(
                                width: 24,
                                height: 24,
                                //padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black.withOpacity(0.16)),
                                child: Icon(
                                  Icons.clear,
                                  color: Colors.black,
                                  size: 15,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
