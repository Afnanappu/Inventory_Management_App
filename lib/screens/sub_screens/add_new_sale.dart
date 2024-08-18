import 'package:flutter/material.dart';
import 'package:inventory_management_app/widgets/appbar/app_bar_for_sub_with_edit.dart';

// ignore: must_be_immutable
class SaleAddNew extends StatelessWidget {
  const SaleAddNew({super.key});
  // var dt;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.maxFinite, 60),
        child: AppBarForSubWithEdit(
          title: 'Add Sale',
          isAddIcon: false,
        ),
      ),
      // body: Column(
      //   children: [
      //     Row(
      //       children: [
      //         Expanded(
      //             child: Container(
      //           decoration: BoxDecoration(
      //             border: Border(
      //               right: BorderSide(color: MyColors.lightGrey),
      //             ),
      //           ),
      //           child: Text('Invoice No. \n1'),
      //         )),
      //         Expanded(
      //             child: Container(
      //           child: Column(
      //             children: [
      //               Text('Date'),
      //               TextButton(
      //                   onPressed: () {
                          
      //                   },
      //                   child: Text(dt)),
      //                   SfDateRangePicker(
      //                       selectionMode: DateRangePickerSelectionMode.single,
      //                       onSelectionChanged:
      //                           (dateRangePickerSelectionChangedArgs) {
      //                         dt = dateRangePickerSelectionChangedArgs.value;
      //                         print(
      //                             'Selected date: ${dateRangePickerSelectionChangedArgs.value}');
      //                       },
      //                     ),

      //             ],
      //           ),
      //         )),
      //       ],
      //     )
      //   ],
      // ),
       body: const Center(child: Text('New sale'),),
    );
  }
}
