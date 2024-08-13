import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/constants/font_styles.dart';
import 'package:inventory_management_app/widgets/app_bar_for_sub_with_edit.dart';
import 'package:inventory_management_app/widgets/buttons.dart';
import 'package:inventory_management_app/widgets/snack_bar_messenger.dart';
import 'package:inventory_management_app/widgets/text_form_field.dart';

class BusinessProfile extends StatelessWidget {
   BusinessProfile({super.key});

  final _formKey = GlobalKey<FormState>();

  final _businessName = TextEditingController();
  final _phoneNo = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(preferredSize:const Size(double.maxFinite, 60), child: AppBarForSubWithEdit(title: 'Business Profile', onPressed: (){})),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(35),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/splash logo black.png'),
                  const SizedBox(
                    height: 30,
                  ),
                  const Row(
                    children: [
                      Text(
                        'Login',
                        style: MyFontStyle.main,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  customFormField(context: context, text: 'Username', controller: _businessName, validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Field is empty';
                    }else if(value != 'a'){
                      return "Username doesn't match";
                    }
                    else{
                      return null;
                    }
                  }),
                  customFormField(context: context, text: 'Password', controller: _phoneNo, validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Field is empty';
                    }else if(value != '1'){
                      return "Password doesn't match";
                    }
                    else{
                      return null;
                    }
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MyButton(
                        color: MyColors.green,
                        text: 'Login',
                        function: () {
                          if(_formKey.currentState!.validate()){
                            CustomSnackBarMessage(context: context, message: 'Login successfully completed', color: MyColors.green);
                          Navigator.of(context)
                              .pushReplacementNamed('/MainHomeScreen');
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}