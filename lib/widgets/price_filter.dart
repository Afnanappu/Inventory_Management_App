import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/screen_size.dart';

class PriceFilter extends StatefulWidget {
  const PriceFilter({super.key});

  @override
  State<PriceFilter> createState() => _PriceFilterState();
}

bool isVisible = false;

class _PriceFilterState extends State<PriceFilter> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _textFieldForPrice(context, hintText: 'From'),
        _textFieldForPrice(context, hintText: 'To'),
        IconButton(
          onPressed: () {
            setState(() {
              (isVisible == false) ? isVisible = true : isVisible = false;
            });
          },
          icon: const Tooltip(
            message: 'Price filter',
            preferBelow: false,
            child:  Icon(
              Icons.filter_alt_outlined,
              size: 28,
              semanticLabel: 'Price filter',
            ),
          ),
        ),
      ],
    );
  }
}

Widget _textFieldForPrice(BuildContext context, {required String hintText}) {
  return Visibility(
    visible: isVisible,
    child: SizedBox(
      height: 30,
      width: MyScreenSize.screenWidth * 0.3,
      child: TextField(
        keyboardType: TextInputType.number,
        onTapOutside: (event) {
          // Focus.of(context).unfocus();
        },
        decoration: InputDecoration(
          hintText: hintText,
        ),
      ),
    ),
  );
}
