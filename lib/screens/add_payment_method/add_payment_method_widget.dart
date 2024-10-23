import 'package:childcaresoftware/constants/color.dart';
import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';

class InputWithLabelOnTop extends StatelessWidget {
  final String title;
  final bool isRequired;

  const InputWithLabelOnTop({
    Key? key,
    required this.title,
    this.isRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _InputWithLabelOnTop(title: title, isRequired: isRequired),
    );
  }
}

class _InputWithLabelOnTop extends StatefulWidget {
  final String title;
  final bool isRequired;

  const _InputWithLabelOnTop({
    Key? key,
    required this.title,
    this.isRequired = false,
  }) : super(key: key);

  @override
  _InputWithLabelOnTopState createState() => _InputWithLabelOnTopState();
}

class _InputWithLabelOnTopState extends State<_InputWithLabelOnTop> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  color: AppColors.DEEP_GREY,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (widget.isRequired)
                Text(
                  "*",
                  style: TextStyle(
                    color: AppColors.RED,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
          Container(
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                filled: true,
                fillColor: AppColors.WHITE,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  borderSide: BorderSide(color: AppColors.PRIMARY),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  borderSide: BorderSide(width: 1, color: AppColors.BLACK),
                ),
              ),
              onChanged: (value) {
                // Handle value change
              },
            ),
          ),
        ],
      ),
    );
  }
}
