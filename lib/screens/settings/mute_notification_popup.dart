import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Giả định bạn đã có các lớp này
import 'package:childcaresoftware/constants/color.dart';
import 'package:childcaresoftware/models/models.dart';
import 'package:childcaresoftware/widgets/widgets.dart';
import 'package:childcaresoftware/commons/dialogs.dart';

class MuteNotificationPopup extends StatefulWidget {
  final Function(Map<String, dynamic>) action;
  final dynamic dateFilter;
  final SettingNotify settings;

  const MuteNotificationPopup({
    Key? key,
    required this.action,
    this.dateFilter,
    required this.settings,
  }) : super(key: key);

  @override
  MuteNotificationPopupState createState() => MuteNotificationPopupState();
}

class MuteNotificationPopupState extends State<MuteNotificationPopup> {
  final format = DateFormat('MM/dd/y');
  late DateTime fromDate;
  late DateTime toDate;
  late SoundMode? soundMode;

  @override
  void initState() {
    super.initState();
    soundMode = widget.settings.soundMode;
    DateTime now = DateTime.now();
    fromDate = DateTime(now.year, now.month, now.day);
    toDate = fromDate.add(const Duration(days: 7));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          'Notification',
          style: TextStyle(color: AppColors.PRIMARY, fontSize: 20),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              contentPadding: EdgeInsets.zero,
              title: const Text('On'),
              subtitle: Text('Enable sound'),
              leading: Radio<SoundMode>(
                value: SoundMode.always,
                groupValue: soundMode,
                activeColor: AppColors.PRIMARY,
                onChanged: (SoundMode? value) {
                  setState(() {
                    if (value != null) soundMode = value;
                  });
                },
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              contentPadding: EdgeInsets.zero,
              title: const Text('Off'),
              subtitle: Text('Disable sound'),
              leading: Radio<SoundMode>(
                value: SoundMode.off,
                groupValue: soundMode,
                activeColor: AppColors.PRIMARY,
                onChanged: (SoundMode? value) {
                  setState(() {
                    if (value != null) soundMode = value;
                  });
                },
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: -4, vertical: -4),
              contentPadding: EdgeInsets.zero,
              title: const Text('Off for period of time'),
              subtitle: Text('Choose period (Max 7 days)'),
              leading: Radio<SoundMode>(
                value: SoundMode.custom,
                activeColor: AppColors.PRIMARY,
                groupValue: soundMode,
                onChanged: (SoundMode? value) {
                  setState(() {
                    if (value != null) soundMode = value;
                  });
                },
              ),
            ),
            Offstage(
              offstage: soundMode != SoundMode.custom,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'From',
                          style: TextStyle(color: AppColors.GREY_COLOR, fontSize: 14),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final DateTime? date = await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                initialDate: fromDate,
                                lastDate: DateTime(2050),
                              );
                              if (date != null) {
                                setState(() {
                                  fromDate = date;
                                });
                              }
                            },
                            child: Text(
                              DateFormat('MM/dd/yyyy').format(fromDate),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.PRIMARY,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'To',
                          style: TextStyle(color: AppColors.GREY_COLOR, fontSize: 14),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final DateTime? date = await showDatePicker(
                                context: context,
                                firstDate: fromDate,
                                initialDate: toDate,
                                lastDate: DateTime(2050),
                              );
                              if (date != null) {
                                setState(() {
                                  toDate = date;
                                });
                              }
                            },
                            child: Text(
                              DateFormat('MM/dd/yyyy').format(toDate),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.PRIMARY,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (soundMode == SoundMode.custom) {
                    if (!toDate.isAfter(fromDate.subtract(const Duration(days: 1)))) {
                      Dialogs.showErrorDialog(context, 'Please select start date before end date');
                      return;
                    } else if (toDate.difference(fromDate).inDays > 7) {
                      Dialogs.showErrorDialog(context, 'Please choose period max 7 days');
                      return;
                    }
                  }
                  String fromStr = DateFormat('MM/dd/yyyy').format(fromDate);
                  String toStr = DateFormat('MM/dd/yyyy').format(toDate);
                  widget.action({
                    'soundMode': soundMode,
                    'fromDate': fromStr,
                    'toDate': toStr,
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.RED, // Sử dụng backgroundColor thay vì primary
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
