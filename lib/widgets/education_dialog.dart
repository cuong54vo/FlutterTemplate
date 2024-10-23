import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:childcaresoftware/commons/dialogs.dart';
import 'package:childcaresoftware/constants/color.dart';
import 'package:childcaresoftware/widgets/widgets.dart';

class EducationDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onSave;
  final Map<String, dynamic>? item;

  const EducationDialog({Key? key, required this.onSave, this.item}) : super(key: key);

  @override
  _EducationDialogState createState() => _EducationDialogState();
}

class _EducationDialogState extends State<EducationDialog> {
  bool isAttending = false;
  final format = DateFormat('MM/y');
  final TextEditingController school = TextEditingController();
  final TextEditingController degree = TextEditingController();
  final TextEditingController major = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  final TextEditingController description = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      isAttending = widget.item!['current'] == 1;
      school.text = widget.item!['school'] ?? '';
      degree.text = widget.item!['degree'] ?? '';
      major.text = widget.item!['major'] ?? '';
      startDate = DateFormat('MM/yyyy').parse(widget.item!['from']);
      endDate = DateFormat('MM/yyyy').parse(widget.item!['to']);
      description.text = widget.item!['description'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          widget.item != null ? 'Edit Education' : 'Add Education',
          style: TextStyle(color: AppColors.PRIMARY, fontSize: 20),
        ),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: school,
                decoration: InputDecoration(labelText: 'School Name'),
                validator: (value) => value?.isEmpty == true ? 'This field is required' : null,
              ),
              TextFormField(
                controller: degree,
                decoration: InputDecoration(labelText: 'Degree'),
                validator: (value) => value?.isEmpty == true ? 'This field is required' : null,
              ),
              TextFormField(
                controller: major,
                decoration: InputDecoration(labelText: 'Major or Field of Study'),
                validator: (value) => value?.isEmpty == true ? 'This field is required' : null,
              ),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.all(0),
                leading: Transform.translate(
                  offset: Offset(-2.0, 0.0),
                  child: Icon(
                    isAttending ? Icons.check_box : Icons.check_box_outline_blank,
                    color: AppColors.PRIMARY,
                  ),
                ),
                title: Transform.translate(
                  offset: Offset(-20.0, 0.0),
                  child: Text("Currently Attending", style: TextStyle(color: AppColors.GREY_COLOR, fontSize: 16)),
                ),
                onTap: () {
                  endDate = DateTime.now();
                  setState(() {
                    isAttending = !isAttending;
                  });
                },
              ),
              // Start Date Picker
              // Uncomment and update the date picker logic if needed.
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
                width: 90,
                label: widget.item != null ? 'Save' : 'Add',
                height: 40,
                onPress: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    if (startDate != null && endDate != null && startDate!.isAfter(endDate!)) {
                      Dialogs.showErrorDialog(context, 'Please select start date before end date');
                    } else {
                      widget.onSave({
                        'school': school.text,
                        'degree': degree.text,
                        'major': major.text,
                        'current': isAttending,
                        'from': DateFormat('MM/yyyy').format(startDate!),
                        'to': isAttending ? 'Current' : DateFormat('MM/yyyy').format(endDate!),
                        'description': description.text,
                      });
                      Navigator.of(context).pop();
                    }
                  }
                },
              ),
              Button(
                width: 90,
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
}
