import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:childcaresoftware/constants/color.dart';
import 'package:childcaresoftware/widgets/top_bar.dart';

class MultiSelectCustom extends FormField<List<dynamic>> {
  final String titleText;
  final String hintText;
  final bool required;
  final String errorText;
  final List<dynamic> value;
  final bool filterable;
  final List<dynamic> dataSource;
  final String textField;
  final String valueField;
  final Function(List<dynamic>)? change;
  final Function()? open;
  final Function()? close;
  final Widget? leading;
  final Widget? trailing;
  final int? maxLength;
  final Color inputBoxFillColor;
  final Color errorBorderColor;
  final Color enabledBorderColor;
  final String? maxLengthText;
  final Color maxLengthIndicatorColor;
  final Color? titleTextColor;
  final IconData selectIcon;
  final Color? selectIconColor;
  final Color hintTextColor;
  // modal overrides
  final Color? buttonBarColor;
  final String? cancelButtonText;
  final IconData? cancelButtonIcon;
  final Color? cancelButtonColor;
  final Color? cancelButtonTextColor;
  final String? saveButtonText;
  final IconData? saveButtonIcon;
  final Color? saveButtonColor;
  final Color? saveButtonTextColor;
  final String? deleteButtonTooltipText;
  final IconData? deleteIcon;
  final Color? deleteIconColor;
  final Color? selectedOptionsBoxColor;
  final String? selectedOptionsInfoText;
  final Color? selectedOptionsInfoTextColor;
  final IconData? checkedIcon;
  final IconData? uncheckedIcon;
  final Color? checkBoxColor;
  final Color? searchBoxColor;
  final String? searchBoxHintText;
  final Color? searchBoxFillColor;
  final IconData? searchBoxIcon;
  final String? searchBoxToolTipText;
  final bool isShowSelectedOptions;
  final List<dynamic> initialValue;
  final bool isSelectAll;

  MultiSelectCustom({
    FormFieldSetter<List<dynamic>>? onSaved,
    FormFieldValidator<List<dynamic>>? validator,
    this.initialValue = const [],
    bool autovalidate = false,
    this.titleText = 'Title',
    this.titleTextColor,
    this.hintText = 'Tap to select one or more...',
    this.hintTextColor = Colors.grey,
    this.required = false,
    this.errorText = 'Please select one or more option(s)',
    List<dynamic>? value,
    this.leading,
    this.filterable = true,
    required this.dataSource,
    required this.textField,
    required this.valueField,
    this.change,
    this.open,
    this.close,
    this.trailing,
    this.maxLength,
    this.maxLengthText,
    this.maxLengthIndicatorColor = Colors.red,
    this.inputBoxFillColor = Colors.white,
    this.errorBorderColor = Colors.red,
    this.enabledBorderColor = Colors.grey,
    this.selectIcon = Icons.arrow_downward,
    this.selectIconColor,
    this.buttonBarColor,
    this.cancelButtonText,
    this.cancelButtonIcon,
    this.cancelButtonColor,
    this.cancelButtonTextColor,
    this.saveButtonText,
    this.saveButtonIcon,
    this.saveButtonColor,
    this.saveButtonTextColor,
    this.deleteButtonTooltipText,
    this.deleteIcon,
    this.deleteIconColor,
    this.selectedOptionsBoxColor,
    this.selectedOptionsInfoText,
    this.selectedOptionsInfoTextColor,
    this.checkedIcon,
    this.uncheckedIcon,
    this.checkBoxColor,
    this.searchBoxColor,
    this.searchBoxHintText,
    this.searchBoxFillColor,
    this.searchBoxIcon,
    this.searchBoxToolTipText,
    this.isShowSelectedOptions = true,
    this.isSelectAll = true,
  }) : value = value ?? initialValue,
       super(
         onSaved: onSaved,
         validator: validator,
         initialValue: initialValue,
         builder: (FormFieldState<List<dynamic>> state) {
           List<Widget> _buildSelectedOptions(List<dynamic>? values) {
             List<Widget> selectedOptions = [];
             if (values != null) {
               values.forEach((item) {
                 var existingItem = dataSource.singleWhere(
                     (itm) => itm[valueField] == item,
                     orElse: () => null);
                 if (existingItem != null) {
                   selectedOptions.add(Chip(
                     label: Text(
                       existingItem[textField],
                       overflow: TextOverflow.ellipsis,
                       style: TextStyle(color: AppColors.BLACK),
                     ),
                     backgroundColor: AppColors.PRIMARY_SECOND,
                   ));
                 }
               });
             }
             return selectedOptions;
           }

           String nameSelected = hintText;
           if (!isSelectAll && value!.isNotEmpty) {
             for (var item in dataSource) {
               if (value[0] == item['id']) {
                 nameSelected = item['name'];
                 break;
               }
             }
           }

           return InkWell(
             onTap: () async {
               var results = await Navigator.push(
                 state.context,
                 MaterialPageRoute<List<dynamic>>(
                   builder: (BuildContext context) => SelectionModalCustom(
                     title: titleText,
                     filterable: filterable,
                     valueField: valueField,
                     textField: textField,
                     dataSource: dataSource,
                     values: value,
                     maxLength: maxLength ?? dataSource.length,
                     buttonBarColor: buttonBarColor,
                     cancelButtonText: cancelButtonText,
                     cancelButtonIcon: cancelButtonIcon,
                     cancelButtonColor: cancelButtonColor,
                     cancelButtonTextColor: cancelButtonTextColor,
                     saveButtonText: saveButtonText,
                     saveButtonIcon: saveButtonIcon,
                     saveButtonColor: saveButtonColor,
                     saveButtonTextColor: saveButtonTextColor,
                     deleteButtonTooltipText: deleteButtonTooltipText,
                     deleteIcon: deleteIcon,
                     deleteIconColor: deleteIconColor,
                     selectedOptionsBoxColor: selectedOptionsBoxColor,
                     selectedOptionsInfoText: selectedOptionsInfoText,
                     selectedOptionsInfoTextColor: selectedOptionsInfoTextColor,
                     checkedIcon: checkedIcon,
                     uncheckedIcon: uncheckedIcon,
                     checkBoxColor: checkBoxColor,
                     searchBoxColor: searchBoxColor,
                     searchBoxHintText: searchBoxHintText,
                     searchBoxFillColor: searchBoxFillColor,
                     searchBoxIcon: searchBoxIcon,
                     searchBoxToolTipText: searchBoxToolTipText,
                     isShowSelectedOptions: isShowSelectedOptions,
                     isSelectAll: isSelectAll,
                   ),
                   fullscreenDialog: true,
                 ),
               );

               if (results != null) {
                 state.didChange(results);
                 change?.call(results);
                 onSaved?.call(results);
               }
             },
             child: InputDecorator(
               decoration: InputDecoration(
                 filled: true,
                 fillColor: inputBoxFillColor,
                 contentPadding: EdgeInsets.only(left: 10.0, right: 5.0),
                 errorText: state.hasError ? state.errorText : null,
                 errorMaxLines: 50,
               ),
               isEmpty: (value!.isEmpty),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   (value.isEmpty)
                       ? Container(
                           child: Text(
                             hintText,
                             style: TextStyle(color: hintTextColor, fontSize: 16),
                           ),
                         )
                       : isSelectAll == false
                           ? Container(
                               child: Text(
                                 nameSelected,
                                 style: TextStyle(fontSize: 16),
                               ),
                             )
                           : Container(
                               child: Text(
                                 '${value.length} Selected',
                                 style: TextStyle(fontSize: 16),
                               ),
                             ),
                   Container(
                     child: Icon(Icons.arrow_drop_down, color: AppColors.BLACK),
                   )
                 ],
               ),
             ),
           );
         },
       );
}

class SelectionModalCustom extends StatefulWidget {
  final List<dynamic> dataSource;
  final List<dynamic> values;
  final bool filterable;
  final String textField;
  final String valueField;
  final String title;
  final int? maxLength;
  final Color? buttonBarColor;
  final String? cancelButtonText;
  final IconData? cancelButtonIcon;
  final Color? cancelButtonColor;
  final Color? cancelButtonTextColor;
  final String? saveButtonText;
  final IconData? saveButtonIcon;
  final Color? saveButtonColor;
  final Color? saveButtonTextColor;
  final String? deleteButtonTooltipText;
  final IconData? deleteIcon;
  final Color? deleteIconColor;
  final Color? selectedOptionsBoxColor;
  final String? selectedOptionsInfoText;
  final Color? selectedOptionsInfoTextColor;
  final IconData? checkedIcon;
  final IconData? uncheckedIcon;
  final Color? checkBoxColor;
  final Color? searchBoxColor;
  final String? searchBoxHintText;
  final Color? searchBoxFillColor;
  final IconData? searchBoxIcon;
  final String? searchBoxToolTipText;
  final bool isShowSelectedOptions;
  final bool isSelectAll;

  SelectionModalCustom({
    required this.filterable,
    required this.dataSource,
    this.title = 'Please select one or more option(s)',
    required this.values,
    required this.textField,
    required this.valueField,
    this.maxLength,
    this.buttonBarColor,
    this.cancelButtonText,
    this.cancelButtonIcon,
    this.cancelButtonColor,
    this.cancelButtonTextColor,
    this.saveButtonText,
    this.saveButtonIcon,
    this.saveButtonColor,
    this.saveButtonTextColor,
    this.deleteButtonTooltipText,
    this.deleteIcon,
    this.deleteIconColor,
    this.selectedOptionsBoxColor,
    this.selectedOptionsInfoText,
    this.selectedOptionsInfoTextColor,
    this.checkedIcon,
    this.uncheckedIcon,
    this.checkBoxColor,
    this.searchBoxColor,
    this.searchBoxHintText,
    this.searchBoxFillColor,
    this.searchBoxIcon,
    this.searchBoxToolTipText,
    this.isShowSelectedOptions = true,
    this.isSelectAll = true,
  });

  @override
  _SelectionModalCustomState createState() => _SelectionModalCustomState();
}

class _SelectionModalCustomState extends State<SelectionModalCustom> {
  List<dynamic> selectedValues = [];

  @override
  void initState() {
    super.initState();
    selectedValues = List.from(widget.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              Navigator.of(context).pop(selectedValues);
            },
          )
        ],
      ),
      body: Column(
        children: [
          // Search and filter
          if (widget.filterable) 
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: widget.searchBoxHintText ?? 'Search...',
                  filled: true,
                  fillColor: widget.searchBoxFillColor ?? Colors.grey[200],
                  border: OutlineInputBorder(),
                ),
                onChanged: (query) {
                  // Handle search logic here
                },
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.dataSource.length,
              itemBuilder: (context, index) {
                final item = widget.dataSource[index];
                final isSelected = selectedValues.contains(item[widget.valueField]);
                return ListTile(
                  title: Text(item[widget.textField]),
                  trailing: Checkbox(
                    value: isSelected,
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          selectedValues.add(item[widget.valueField]);
                        } else {
                          selectedValues.remove(item[widget.valueField]);
                        }
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
