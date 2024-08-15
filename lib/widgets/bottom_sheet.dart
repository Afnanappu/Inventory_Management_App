import 'package:flutter/material.dart';

class CustomBottomSheet {
  CustomBottomSheet({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ListTile(
            contentPadding: EdgeInsets.only(left: 30),
            title:  Text('Call Us'),
            leading:  Icon(Icons.call_outlined),
           
          ),
          ListTile(
            contentPadding:const EdgeInsets.only(left: 30),
            title: const Text('Mail Us'),
            leading: const Icon(Icons.mail_outline_outlined),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
