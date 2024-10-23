import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:childcaresoftware/constants/color.dart';
import 'package:childcaresoftware/models/user_register.dart';
import 'package:childcaresoftware/widgets/widgets.dart';

class TagCustom extends StatefulWidget {
  const TagCustom({
    Key? key,
    required this.title,
    required this.action,
    required this.remove,
    required this.hint,
    this.requiredLenght = 0,
    this.toast = '',
    this.isReload = false,
    this.suggestions = const [],
    required this.change,
  }) : super(key: key);

  final String title;
  final String hint;
  final String toast;
  final int requiredLenght;
  final Function(dynamic) action;
  final Function(dynamic) remove;
  final bool isReload;
  final List<String> suggestions;
  final Function(dynamic) change;

  @override
  _TagCustomState createState() => _TagCustomState();
}

class _TagCustomState extends State<TagCustom> with SingleTickerProviderStateMixin {
  final List<String> _list = [];
  double _fontSize = 18;
  late List<String> _items;

  @override
  void initState() {
    super.initState();
    _items = _list.toList();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isReload) {
      setState(() {
        _items = [];
      });
    }
    
    return Container(
      child: !widget.isReload ? _tags : _buildTextField(),
    );
  }

  Widget _buildTextField() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: TextFormField(
              style: TextStyle(fontSize: 18),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                filled: true,
                fillColor: AppColors.WHITE,
                hintText: widget.hint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: AppColors.BLACK),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget get _tags {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Tags(
        symmetry: false,
        verticalDirection: VerticalDirection.up,
        textDirection: TextDirection.ltr,
        heightHorizontalScroll: 60 * (_fontSize / 14),
        textField: _textField,
        itemCount: _items.length,
        itemBuilder: (index) {
          final item = _items[index];
          return GestureDetector(
            child: ItemTags(
              padding: const EdgeInsets.all(7.0),
              key: Key(index.toString()),
              index: index,
              title: item,
              pressEnabled: false,
              activeColor: AppColors.PRIMARY_SECOND,
              combine: ItemTagsCombine.onlyText,
              removeButton: ItemTagsRemoveButton(
                backgroundColor: AppColors.PRIMARY,
                onRemoved: () {
                  widget.remove(index);
                  setState(() {
                    _items.removeAt(index);
                  });
                  return true;
                },
              ),
              textScaleFactor: utf8.encode(item.substring(0, 1)).length > 2 ? 0.8 : 1,
              textStyle: TextStyle(fontSize: _fontSize),
            ),
          );
        },
      ),
    );
  }

  TagsTextField get _textField {
    return TagsTextField(
      suggestions: widget.suggestions.isEmpty ? null : widget.suggestions,
      suggestionTextColor: AppColors.DEEP_GREY,
      autofocus: true,
      inputDecoration: InputDecoration(
        suffixText: (_items.length + 1).toString(),
        counterText: "",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: AppColors.BLACK),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
      ),
      width: double.infinity,
      textStyle: TextStyle(fontSize: _fontSize),
      maxLength: widget.requiredLenght > 0 ? widget.requiredLenght : 100,
      hintText: widget.hint,
      enabled: true,
      constraintSuggestion: true,
      onChanged: (String str) {
        widget.change(str);
      },
      onSubmitted: (String str) {
        if (widget.requiredLenght > 0 && str.length != widget.requiredLenght) {
          Fluttertoast.showToast(
            msg: widget.toast,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: AppColors.GREY_COLOR,
            textColor: AppColors.WHITE,
            fontSize: 18.0,
          );
        } else {
          widget.action(str);
          setState(() {
            _items.add(str);
          });
        }
      },
    );
  }
}

class TagText extends StatelessWidget {
  const TagText({
    Key? key,
    required this.action,
    this.label = '',
    this.value = '',
    this.icon,
    this.isBorder = false,
    this.backgroundColor = AppColors.GREEN_BUTTON,
    this.color = AppColors.WHITE,
    this.valueColor = AppColors.WHITE,
    this.radius = 5,
    this.height = 40,
    this.width,
    this.borderColor,
  }) : super(key: key);

  final String label;
  final String value;
  final IconData? icon;
  final bool isBorder;
  final Function action;
  final Color backgroundColor;
  final Color color;
  final double radius;
  final double height;
  final double? width;
  final Color? borderColor;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => action(),
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border: borderColor != null
                ? Border.all(color: borderColor!, width: 1)
                : null,
            color: backgroundColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(width: 5),
              Text(
                label.toUpperCase(),
                style: TextStyle(color: color, fontSize: 16),
              ),
              Text(
                value,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: valueColor, fontSize: 16),
              ),
              if (icon != null)
                Icon(
                  icon,
                  size: 16,
                  color: color,
                ),
              const SizedBox(width: 5),
            ],
          ),
        ),
      ),
    );
  }
}
