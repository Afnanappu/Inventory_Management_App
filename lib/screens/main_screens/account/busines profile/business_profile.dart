import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/widgets/appbar/app_bar_for_sub_with_edit.dart';
import 'package:inventory_management_app/widgets/buttons.dart';
import 'package:inventory_management_app/widgets/snack_bar_messenger.dart';
import 'package:inventory_management_app/widgets/text_form_field.dart';

class AccountProfile extends StatefulWidget {
  const AccountProfile({super.key});

  @override
  State<AccountProfile> createState() => _AccountProfileState();
}

class _AccountProfileState extends State<AccountProfile> {
  final _formKey = GlobalKey<FormState>();

  final _businessName = TextEditingController();

  final _phoneNo = TextEditingController();
  final _email = TextEditingController();
  final _address = TextEditingController();

  bool isEditable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.maxFinite, 60),
        child: AppBarForSubWithEdit(
          title: 'Business Profile',
          onPressed: () {
            setState(() {
              isEditable = true;
            });
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(35),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundColor: MyColors.lightGrey,
                    backgroundImage: AssetImage(
                      'assets/shop logo.jpeg',
                    ),
                    radius: 76,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  customFormField(
                      context: context,
                      text: 'Business name',
                      controller: _businessName,
                      enabled: isEditable,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field is empty';
                        } else {
                          return null;
                        }
                      }),
                  customFormField(
                      context: context,
                      text: 'Phone no',
                      controller: _phoneNo,
                      enabled: isEditable,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field is empty';
                        } else if (value.length != 10) {
                          return 'Enter a valid phone no';
                        } else {
                          return null;
                        }
                      }),
                  customFormField(
                      context: context,
                      text: 'Email',
                      controller: _email,
                      enabled: isEditable,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field is empty';
                        } else if (!value.contains('@') &&
                            !value.contains('.')) {
                          return 'Enter a valid email';
                        } else {
                          return null;
                        }
                      }),
                  customFormField(
                      context: context,
                      text: 'Address',
                      controller: _address,
                      enabled: isEditable,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Field is empty';
                        } else {
                          return null;
                        }
                      }),
                  (isEditable == true)
                      ? MyButton(
                          color: MyColors.green,
                          text: 'Save',
                          function: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isEditable = false;
                              });
                              CustomSnackBarMessage(
                                context: context,
                                message: 'Profile changed successfully',
                                color: MyColors.green,
                              );
                            }
                          },
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
