import 'dart:io';

import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/constants/font_styles.dart';
import 'package:inventory_management_app/functions/pick_image.dart';
import 'package:inventory_management_app/models/profile_model.dart';
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
    (ProfileModel.profile.name != null)
        ? _businessName.text = ProfileModel.profile.name!
        : null;
    (ProfileModel.profile.phone != null)
        ? _phoneNo.text = ProfileModel.profile.phone!
        : null;
    (ProfileModel.profile.email != null)
        ? _email.text = ProfileModel.profile.email!
        : null;
    (ProfileModel.profile.address != null)
        ? _address.text = ProfileModel.profile.address!
        : null;
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
                  GestureDetector(
                    onTap: () async {
                      if(isEditable == true){
                        await pickImageFromFile().then(
                        (value) {
                          ProfileModel.profile.image = value;
                        },
                      );
                      setState(() {});
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: MyColors.lightGrey,
                      backgroundImage: (ProfileModel.profile.image != null)
                          ? FileImage(File(ProfileModel.profile.image!))
                          : null,
                      radius: 76,
                      child: (ProfileModel.profile.image == null)
                          ? const Text(
                              'No image selected',
                              style: MyFontStyle.smallLightGrey,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  customFormField(
                    context: context,
                    labelText: 'Business name',
                    controller: _businessName,
                    isFormEnabled: isEditable,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Field is empty';
                      } else {
                        return null;
                      }
                    },
                  ),
                  customFormField(
                      context: context,
                      labelText: 'Phone no',
                      controller: _phoneNo,
                      keyboardType: TextInputType.phone,
                      isFormEnabled: isEditable,
                      
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
                      labelText: 'Email',
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      isFormEnabled: isEditable,
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
                      labelText: 'Address',
                      controller: _address,
                      keyboardType: TextInputType.streetAddress,
                      isFormEnabled: isEditable,
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
                              ProfileModel.profile.name = _businessName.text;
                              ProfileModel.profile.phone = _phoneNo.text;
                              ProfileModel.profile.email = _email.text;
                              ProfileModel.profile.address = _address.text;
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
