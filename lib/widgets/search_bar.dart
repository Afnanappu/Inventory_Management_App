import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/constants/font_styles.dart';

class SearchBarForMain extends StatelessWidget {
  const SearchBarForMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: TextField(
        cursorOpacityAnimates: true,
        cursorColor: MyColors.blackShade,
        enableInteractiveSelection: true,
        cursorHeight: 18,
        cursorRadius:const Radius.circular(20),
        keyboardType: TextInputType.text,
        onTapOutside: (event) async{
          await Future.delayed( const Duration(milliseconds: 400));
          // ignore: use_build_context_synchronously
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide.none,
          ),
          fillColor: MyColors.lightGrey,
          filled: true,
          hintText: "Search",
          contentPadding: const EdgeInsets.only(left: 20),
          hintFadeDuration: const Duration(milliseconds: 200),
          hintStyle: MyFontStyle.smallLightGreyStyle,
          //todo: Change the icon
          suffixIcon: const Padding(
            padding:  EdgeInsets.only(right: 15),
            child:  Icon(Icons.search),
          )
        ),
      ),
    );
  }
}
