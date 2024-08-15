import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomBottomSheet {
  CustomBottomSheet({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            contentPadding: EdgeInsets.only(left: 30),
            title: const Text('Call Us'),
            leading: const Icon(Icons.call_outlined),
           
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 30),
            title: const Text('Mail Us'),
            leading: const Icon(Icons.mail_outline_outlined),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
