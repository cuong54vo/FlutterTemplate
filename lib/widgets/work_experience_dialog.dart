import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:childcaresoftware/commons/dialogs.dart';
import 'package:childcaresoftware/constants/color.dart';
import 'package:childcaresoftware/widgets/widgets.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class WorkExperiencePopupState extends StatefulWidget {
  final Function(dynamic) action;
  final Map<String, dynamic>? itemUpdate;

  const WorkExperiencePopupState({Key? key, required this.action, this.itemUpdate}) : super(key: key);
  
  @override
  WorkExperiencePopup createState() => WorkExperiencePopup();
}

class WorkExperiencePopup extends State<WorkExperiencePopupState> {
  bool isWorking = false;
  final format = DateFormat('MM/y');
  final TextEditingController position = TextEditingController();
  final TextEditingController company = TextEditingController();
  final TextEditingController description = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    if (widget.itemUpdate != null) {
      isWorking = widget.itemUpdate!['current'] == 1;
      position.text = widget.itemUpdate!['position'] ?? '';
      company.text = widget.itemUpdate!['company'] ?? '';
      description.text = widget.itemUpdate!['description'] ?? '';
      startDate = DateFormat('MM/yyyy').parse(widget.itemUpdate!['from']);
      endDate = DateFormat('MM/yyyy').parse(widget.itemUpdate!['to']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          widget.itemUpdate != null ? 'Edit Work Experience' : 'Add Work Experience',
          style: TextStyle(color: AppColors.PRIMARY, fontSize: 20),
        ),
      ),
      content: Container(
        height: 300,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: position,
                decoration: InputDecoration(labelText: 'Position'),
              ),
              TextFormField(
                controller: company,
                decoration: InputDecoration(labelText: 'Company'),
              ),
              _buildDatePicker('From (mm/yyyy)', (date) {
                setState(() {
                  startDate = date;
                });
              }, startDate),
              _buildDatePicker('To (mm/yyyy)', (date) {
                setState(() {
                  endDate = date;
                });
              }, endDate, isWorking: !isWorking),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.all(0),
                leading: Transform.translate(
                  offset: Offset(-2.0, 0.0),
                  child: Icon(
                    isWorking ? Icons.check_box : Icons.check_box_outline_blank,
                    color: AppColors.PRIMARY,
                  ),
                ),
                title: Text("I currently work here",
                    style: TextStyle(color: AppColors.GREY_COLOR, fontSize: 16)),
                onTap: () {
                  setState(() {
                    isWorking = !isWorking;
                    if (isWorking) {
                      endDate = null; // Reset endDate if currently working
                    }
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20),
                child: TextFormField(
                  controller: description,
                  decoration: InputDecoration(labelText: 'Description (Optional)'),
                  maxLines: 2,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Button(
                label: widget.itemUpdate != null ? 'Save' : 'Add',
                onPress: _handleSave,
                height: 40,
              ),
              Button(
                label: 'Cancel',
                onPress: () => Navigator.of(context).pop(),
                height: 40,
                color: AppColors.RED,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker(String label, Function(DateTime?) onChanged, DateTime? initialDate, {bool isWorking = false}) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Icon(Icons.calendar_today, color: AppColors.GREY_COLOR, size: 20.0),
              Text(label, style: TextStyle(color: AppColors.GREY_COLOR)),
            ],
          ),
          Container(
            height: 30,
            child: GestureDetector(
              onTap: () async {
                final date = await showMonthPicker(
                  context: context,
                  firstDate: DateTime(1900),
                  initialDate: initialDate ?? DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (date != null) {
                  onChanged(date);
                }
              },
              child: Text(
                initialDate != null ? DateFormat('MM/yyyy').format(initialDate) : 'Select Date',
                style: TextStyle(color: AppColors.GREY_COLOR),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSave() {
    if (position.text.isEmpty ||
        company.text.isEmpty ||
        startDate == null ||
        (isWorking == false && endDate == null)) {
      Dialogs.showErrorDialog(context, 'Please complete all the fields');
    } else if (startDate!.isAfter(endDate ?? DateTime.now())) {
      Dialogs.showErrorDialog(context, 'Please select start date before end date');
    } else {
      widget.action({
        'position': position.text,
        'company': company.text,
        'description': description.text,
        'current': isWorking,
        'startDate': DateFormat('MM/yyyy').format(startDate!),
        'endDate': isWorking ? 'Current' : DateFormat('MM/yyyy').format(endDate!),
      });
      Navigator.of(context).pop();
    }
  }
}
