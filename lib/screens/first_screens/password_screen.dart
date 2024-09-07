import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:inventory_management_app/constants/colors.dart';
import 'package:inventory_management_app/screens/main_home_screen.dart';
import 'package:inventory_management_app/screens/main_screens/home_screen.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  final String password = '1234';

  @override
  void initState() {
    for (int i = 0; i < 4; i++) {
      _controllers[i].addListener(
        () {
          if (_controllers[i].text.length == 1) {
            if (i < 3) {
              _focusNodes[i + 1].requestFocus();
            } else {
              _focusNodes[i].unfocus();
              _checkPassword();
            }
          }
        },
      );
    }
    super.initState();
  }

  void _checkPassword() {
    final enteredPassword = _controllers
        .map(
          (e) => e.text,
        )
        .join();

    if (enteredPassword == password) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) =>  MainHomeScreen()));

      log('Password is correct, Login to the app');
    } else {
      log('Password $enteredPassword is incorrect, try $password');
    }
  }

  @override
  void dispose() {
    for (var element in _controllers) {
      element.dispose();
    }
    for (var element in _focusNodes) {
      element.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Enter password'),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                4,
                (index) => _passwordBox(
                  _controllers[index],
                  _focusNodes[index],
                  index,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _passwordBox(
      TextEditingController controller, FocusNode focusNode, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 50,
        width: 50,
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          autofocus: true,
          canRequestFocus: true,
          cursorHeight: 30,
          cursorColor: MyColors.blackShade,
          cursorRadius: const Radius.circular(30),
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,

          // if the user press the backspace and if the field is empty and not fist it will got to one step back
          onChanged: (value) {
            if (value.isEmpty && index > 0) {
              _focusNodes[index - 1].requestFocus();
            }
          },
          maxLength: 1,
          decoration: const InputDecoration(
            counterText: '',
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: MyColors.red,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(255, 39, 170, 61),
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ),
    );
  }
}
