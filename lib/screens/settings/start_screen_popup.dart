import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:childcaresoftware/constants/color.dart';
import 'package:childcaresoftware/models/models.dart';
import 'package:childcaresoftware/widgets/widgets.dart';
import 'package:intl/intl.dart';
import 'package:childcaresoftware/repositories/repositories.dart';
import 'package:childcaresoftware/service_locator.dart';

class StartScreenPopup extends StatefulWidget {
  final String startScreen;
  final Function(Map<String, String>) action;

  const StartScreenPopup({
    Key? key,
    required this.action,
    required this.startScreen,
  }) : super(key: key);

  @override
  StartScreenPopupState createState() => StartScreenPopupState();
}

class StartScreenPopupState extends State<StartScreenPopup> {
  late StartScreenMode startScreenMode;

  @override
  void initState() {
    super.initState();

    print(widget.startScreen);

    switch (widget.startScreen) {
      case '0':
        startScreenMode = StartScreenMode.schedule;
        break;
      case '1':
        startScreenMode = StartScreenMode.jobs;
        break;
      case '2':
        startScreenMode = StartScreenMode.alerts;
        break;
      default:
        startScreenMode = StartScreenMode.schedule;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          'Screen List',
          style: TextStyle(color: AppColors.PRIMARY, fontSize: 20),
        ),
      ),
      content: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildRadioListTile('Schedule', StartScreenMode.schedule),
              _buildRadioListTile('Jobs', StartScreenMode.jobs),
              _buildRadioListTile('Alerts', StartScreenMode.alerts),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Button(
                label: 'OK',
                onPress: () {
                  String indexScreen;
                  if (startScreenMode == StartScreenMode.schedule) {
                    indexScreen = '0';
                  } else if (startScreenMode == StartScreenMode.jobs) {
                    indexScreen = '1';
                  } else {
                    indexScreen = '2';
                  }
                  widget.action({'startScreen': indexScreen});
                  Navigator.of(context).pop();
                },
                width: 100,
                height: 40,
              ),
              Button(
                label: 'Cancel',
                onPress: () => Navigator.of(context).pop(),
                width: 100,
                height: 40,
                color: AppColors.RED,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRadioListTile(String title, StartScreenMode value) {
    return ListTile(
      visualDensity: VisualDensity(horizontal: -4, vertical: -4),
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      leading: Radio<StartScreenMode>(
        value: value,
        groupValue: startScreenMode,
        activeColor: AppColors.PRIMARY,
        onChanged: (StartScreenMode? newValue) {
          if (newValue != null) {
            setState(() {
              startScreenMode = newValue;
            });
          }
        },
      ),
    );
  }
}
