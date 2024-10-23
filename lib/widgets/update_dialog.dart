import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:childcaresoftware/commons/utils.dart';
import 'package:childcaresoftware/commons/version_check.dart';
import 'package:childcaresoftware/constants/color.dart';
import 'package:childcaresoftware/widgets/widgets.dart';

class UpdateDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(12),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      child: Container(
        width: double.infinity,
        decoration: new BoxDecoration(
          color: AppColors.WHITE,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.PRIMARY,
            width: 3.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Icon(
                Icons.help_outline,
                color: AppColors.POSITIVE_BUTTON_COLOR,
                size: 60,
              ),
              Text(
                'There is a newer version of app available. Please update it now.',
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.PRIMARY, fontSize: 20),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Button(
                    label: 'Update Now',
                    onPress: () => {Utils.launchURL(APP_STORE_URL)},
                    height: 40,
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Button(
                    label: 'Later',
                    onPress: () => {Navigator.of(context).pop()},
                    height: 40,
                    color: AppColors.RED,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
