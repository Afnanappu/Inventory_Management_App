import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/constants/font_styles.dart';
import 'package:inventory_management_app/widgets/buttons.dart';
import 'package:inventory_management_app/widgets/snack_bar_messanger.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _userPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  _formField(context: context, text: 'Username', controller: _userController, validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Field is empty';
                    }else if(value != 'a'){
                      return "Username doesn't match";
                    }
                    else{
                      return null;
                    }
                  }),
                  _formField(context: context, text: 'Password', controller: _userPassword, validator: (value){
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

  Widget _formField({required BuildContext context, required String text, required TextEditingController controller, String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: TextFormField(
        controller: controller,
        validator: validator,
        cursorOpacityAnimates: true,
        cursorColor: MyColors.blackShade,
        enableInteractiveSelection: true,
        keyboardType: TextInputType.text,
        cursorHeight: 18,
        onTapOutside: (event) {
          //To remove the focus.
          // ignore: use_build_context_synchronously
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          fillColor: MyColors.lightGrey,
          filled: true,
          hintText: text,
          contentPadding: const EdgeInsets.only(left: 20),
          hintFadeDuration: const Duration(milliseconds: 200),
          hintStyle: MyFontStyle.smallLightGrey,
        ),
      ),
    );
  }
}
