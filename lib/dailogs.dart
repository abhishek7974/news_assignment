import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_assignment/app_colors.dart';

class Dialogs {

  static Future<void> errorDialog(BuildContext context, String err) async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(
            Icons.error_outline,
            size: 45,
            color: AppColor.primaryColor,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                err,
                style: const TextStyle(
                    fontSize: 17, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                child: const Text(
                  'Back',
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }
  
  static Future<void> successDialog(BuildContext context, String message) async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(
            Icons.check_circle_outline,
            size: 45,
            color: AppColor.successColor,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                style: const TextStyle(
                    fontSize: 17, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                child: const Text(
                  'Back',
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> successDialogAccept(BuildContext context, String message) async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(
            Icons.check_circle_outline,
            size: 45,
            color: AppColor.successColor,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                style: const TextStyle(
                    fontSize: 17, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                child: const Text(
                  'Ok',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor,),
                    
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> errorDialogReject(BuildContext context, String err) async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(
            Icons.error_outline,
            size: 45,
            color: AppColor.primaryColor,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                err,
                style: const TextStyle(
                    fontSize: 17, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                child: const Text(
                  'Ok',
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primaryColor),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<bool?> logoutDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context){
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Do you want to logout?'),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text('Cancel', style: TextStyle(color: AppColor.subTextColor),)),
            TextButton(onPressed: () => Navigator.of(context).pop(true), child: Text('Yes', style: TextStyle(color: AppColor.primaryColor))),
          ],
        );
      },
    );
  }

}
