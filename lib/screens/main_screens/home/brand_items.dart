import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/database/brand_fun.dart';
import 'package:inventory_management_app/models/item_model.dart';

bool isSeeAllButtonPressed = false;

class BrandItems extends StatefulWidget {
  const BrandItems({super.key});

  @override
  State<BrandItems> createState() => _BrandItemsState();
}

int selectedButtonIndex = -1;

class _BrandItemsState extends State<BrandItems> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ValueListenableBuilder(
          valueListenable: itemBrandListNotifiers,
          builder: (context, brand, child) => (isSeeAllButtonPressed == false)
              ? ListView.builder(
                  //todo: Add the see all button functions
                  itemCount: brand.length + 1,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, itemIndex) {
                    int index = itemIndex - 1;
                    if (itemIndex == 0) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedButtonIndex = index;
                              filteredItemModelList.value =
                                  itemModelListNotifiers.value
                                      .map(
                                        (e) => e,
                                      )
                                      .toList();
                            });
                            notifyAnyListeners(filteredItemModelList);
                          },
                          style: ButtonStyle(
                            fixedSize:
                               const WidgetStatePropertyAll(Size.fromHeight(45)),
                            foregroundColor: WidgetStateProperty.resolveWith(
                              (states) {
                                if (selectedButtonIndex == index) {
                                  return MyColors.white;
                                }
                                return MyColors.blackShade;
                              },
                            ),
                            // minimumSize: WidgetStatePropertyAll(Size.zero),
                            shape: WidgetStateProperty.resolveWith<
                                RoundedRectangleBorder>(
                              (states) {
                                if (selectedButtonIndex == index) {
                                  return RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: const BorderSide(
                                      color: MyColors.green,
                                    ),
                                  );
                                }
                                return RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(
                                    color: MyColors.blackShade,
                                  ),
                                );
                              },
                            ),
                            backgroundColor: WidgetStateProperty.resolveWith(
                              (Set<WidgetState> states) {
                                if (selectedButtonIndex == index) {
                                  return MyColors.green;
                                }
                                return MyColors.white;
                              },
                            ),
                          ),
                          child: const Text('All'),
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              selectedButtonIndex = index;
                              filteredItemModelList.value =
                                  itemModelListNotifiers.value
                                      .where((item) =>
                                          item.brandId == brand[index].id)
                                      .toList();
                            });
                            notifyAnyListeners(filteredItemModelList);
                          },
                          style: ButtonStyle(
                            foregroundColor: WidgetStateProperty.resolveWith(
                              (states) {
                                if (selectedButtonIndex == index) {
                                  return MyColors.white;
                                }
                                return MyColors.blackShade;
                              },
                            ),
                            // minimumSize: WidgetStatePropertyAll(Size.zero),
                            shape: WidgetStateProperty.resolveWith<
                                RoundedRectangleBorder>(
                              (states) {
                                if (selectedButtonIndex == index) {
                                  return RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: const BorderSide(
                                      color: MyColors.green,
                                    ),
                                  );
                                }
                                return RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(
                                    color: MyColors.blackShade,
                                  ),
                                );
                              },
                            ),
                            backgroundColor: WidgetStateProperty.resolveWith(
                              (Set<WidgetState> states) {
                                if (selectedButtonIndex == index) {
                                  return MyColors.green;
                                }
                                return MyColors.white;
                              },
                            ),
                          ),
                          child: Text(brand[index].itemBrandName),
                        ),
                      );
                    }
                  },
                )
              : Wrap(
                  children: [],
                )),
    );
  }
}
