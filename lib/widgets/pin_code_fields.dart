import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;

class PinCodeTextField extends StatefulWidget {
  final int length;
  final bool obsecureText;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onCompleted;
  final PinCodeFieldShape shape;
  final TextStyle textStyle;
  final Color backgroundColor;
  final BorderRadius? borderRadius;
  final double fieldHeight;
  final double fieldWidth;
  final MainAxisAlignment mainAxisAlignment;
  final Color activeColor;
  final Color selectedColor;
  final Color inactiveColor;
  final Color disabledColor;
  final double borderWidth;
  final AnimationType animationType;
  final Duration animationDuration;
  final Curve animationCurve;
  final TextInputType textInputType;
  final bool autoFocus;
  final FocusNode? focusNode;
  final List<TextInputFormatter> inputFormatters;
  final bool enabled;
  final String dialogTitle;
  final String dialogContent;
  final String affirmativeText;
  final String negativeText; // Fixed typo
  final TextEditingController? controller;

  const PinCodeTextField({
    Key? key,
    required this.length,
    this.controller,
    this.obsecureText = false,
    required this.onChanged,
    this.onCompleted,
    this.backgroundColor = Colors.white,
    this.borderRadius,
    this.fieldHeight = 50,
    this.fieldWidth = 40,
    this.activeColor = Colors.green,
    this.selectedColor = Colors.blue,
    this.inactiveColor = Colors.red,
    this.disabledColor = Colors.grey,
    this.borderWidth = 2,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.animationDuration = const Duration(milliseconds: 150),
    this.animationCurve = Curves.easeInOut,
    this.shape = PinCodeFieldShape.underline,
    this.animationType = AnimationType.slide,
    this.textInputType = TextInputType.visiblePassword,
    this.autoFocus = false,
    this.focusNode,
    this.enabled = true,
    this.inputFormatters = const <TextInputFormatter>[],
    this.dialogContent = "Do you want to paste this code?",
    this.dialogTitle = "Paste Code",
    this.affirmativeText = "Paste",
    this.negativeText = "Cancel", // Fixed typo
    this.textStyle = const TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
  }) : super(key: key);

  @override
  _PinCodeTextFieldState createState() => _PinCodeTextFieldState();
}

class _PinCodeTextFieldState extends State<PinCodeTextField> {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  late List<String> _inputList;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _textEditingController = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _inputList = List.filled(widget.length, "");

    _focusNode.addListener(() {
      setState(() {});
    });

    _textEditingController.addListener(() {
      final currentText = _textEditingController.text;
      if (widget.enabled && _inputList.join("") != currentText) {
        if (currentText.length >= widget.length) {
          widget.onCompleted?.call(currentText);
          _focusNode.unfocus();
        }
        widget.onChanged(currentText);
        _setTextToInput(currentText);
      }
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _setTextToInput(String data) {
    final replaceInputList = List.filled(widget.length, "");
    for (int i = 0; i < widget.length; i++) {
      replaceInputList[i] = data.length > i ? data[i] : "";
    }
    setState(() {
      _selectedIndex = data.length;
      _inputList = replaceInputList;
    });
  }

  Color _getColorFromIndex(int index) {
    if (!widget.enabled) return widget.disabledColor;
    if (_selectedIndex == index && _focusNode.hasFocus) return widget.selectedColor;
    return _selectedIndex > index ? widget.activeColor : widget.inactiveColor;
  }

  Future<void> _showPasteDialog(String pastedText) async {
    final formattedPastedText = pastedText.trim().substring(0, min(pastedText.trim().length, widget.length));
    return showDialog(
      context: context,
      builder: (context) {
        return Platform.isAndroid
            ? AlertDialog(
                title: Text(widget.dialogTitle),
                content: Text('${widget.dialogContent} "$formattedPastedText"?'),
                actions: _getActionButtons(formattedPastedText),
              )
            : CupertinoAlertDialog(
                title: Text(widget.dialogTitle),
                content: Text('${widget.dialogContent} "$formattedPastedText"?'),
                actions: _getActionButtons(formattedPastedText),
              );
      },
    );
  }

  List<Widget> _getActionButtons(String pastedText) {
    return [
      if (Platform.isAndroid)
        TextButton(
          child: Text(widget.negativeText),
          onPressed: () => Navigator.pop(context),
        ),
      if (Platform.isAndroid)
        TextButton(
          child: Text(widget.affirmativeText),
          onPressed: () {
            _textEditingController.text = pastedText;
            Navigator.pop(context);
          },
        ),
      if (Platform.isIOS)
        CupertinoDialogAction(
          child: Text(widget.negativeText),
          onPressed: () => Navigator.pop(context),
        ),
      if (Platform.isIOS)
        CupertinoDialogAction(
          child: Text(widget.affirmativeText),
          onPressed: () {
            _textEditingController.text = pastedText;
            Navigator.pop(context);
          },
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        AbsorbPointer(
          absorbing: true,
          child: TextField(
            controller: _textEditingController,
            focusNode: _focusNode,
            enabled: widget.enabled,
            autofocus: widget.autoFocus,
            autocorrect: false,
            keyboardType: widget.textInputType,
            inputFormatters: [
              ...widget.inputFormatters,
              LengthLimitingTextInputFormatter(widget.length),
            ],
            showCursor: false,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
            ),
            style: TextStyle(
              color: Colors.transparent,
              height: 0,
              fontSize: 0.01,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_focusNode),
          child: Container(
            color: widget.backgroundColor,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: widget.mainAxisAlignment,
              children: List.generate(widget.length, (i) {
                return Container(
                  width: widget.fieldWidth,
                  height: widget.fieldHeight,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: _getColorFromIndex(i),
                        width: widget.borderWidth,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      widget.obsecureText && _inputList[i].isNotEmpty
                          ? "●"
                          : _inputList[i],
                      style: widget.textStyle,
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}

enum AnimationType { scale, slide, fade, none }
enum PinCodeFieldShape { box, underline, circle }
