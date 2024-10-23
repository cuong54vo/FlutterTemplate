import 'package:flutter/material.dart';
import 'package:childcaresoftware/constants/color.dart';

class DropdownLabel extends StatelessWidget {
  const DropdownLabel({
    Key? key,
    this.label,
    this.hint = 'Select a value',
    this.value = '',
    this.labelStyle,
    this.valueStyle,
    this.isReadOnly = false,
    this.rate = const [5, 5],
    this.action,
    this.valueList = const [],
    this.backgroundColor = Colors.transparent,
    this.borderColor = Colors.transparent,
  }) : super(key: key);

  final String? label;
  final String hint;
  final String value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;
  final bool isReadOnly;
  final List<int> rate;
  final ValueChanged<String?>? action;
  final List<dynamic> valueList;
  final Color backgroundColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Color.fromRGBO(235, 238, 241, 1), spreadRadius: 1),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: rate[0],
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                label!,
                style: labelStyle,
              ),
            ),
          ),
          Expanded(
            flex: rate[1],
            child: IgnorePointer(
              ignoring: isReadOnly,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                    color: borderColor,
                    style: BorderStyle.solid,
                    width: 0.8,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: Container(
                    color: backgroundColor,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: DropdownButton<String>(
                      value: value.isEmpty ? null : value,
                      isExpanded: true,
                      hint: Text(hint),
                      items: valueList.map((dynamic value) {
                        return DropdownMenuItem<String>(
                          value: value.toString(),
                          child: Text(
                            value.toString(),
                            style: valueStyle,
                          ),
                        );
                      }).toList(),
                      onChanged: (selectedValue) {
                        action!(selectedValue);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
