import 'package:flutter/material.dart';
import 'package:childcaresoftware/constants/color.dart';
import 'package:childcaresoftware/widgets/widgets.dart';

class AffiliationDialog extends StatefulWidget {
  final Function(dynamic) onSave;
  final dynamic item;

  const AffiliationDialog({Key? key, required this.onSave, this.item}) : super(key: key);

  @override
  _AffiliationDialogState createState() => _AffiliationDialogState();
}

class _AffiliationDialogState extends State<AffiliationDialog> {
  final TextEditingController affiliate = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // If you want to prepopulate the TextField with an item value:
    if (widget.item != null) {
      affiliate.text = widget.item['affiliate'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          'Add Affiliations',
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
                controller: affiliate,
                decoration: const InputDecoration(labelText: 'Affiliate'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
              ),
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
                width: 90,
                label: 'Add',
                height: 40,
                onPress: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    widget.onSave({
                      'affiliate': affiliate.text,
                    });
                    Navigator.of(context).pop();
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

  @override
  void dispose() {
    affiliate.dispose();
    super.dispose();
  }
}
