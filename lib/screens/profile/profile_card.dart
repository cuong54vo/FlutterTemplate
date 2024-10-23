import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:childcaresoftware/commons/dialogs.dart';
import 'package:childcaresoftware/constants/color.dart';
import 'package:childcaresoftware/constants/form_status.dart';
import 'package:expandable/expandable.dart';
import '../../blocs/blocs.dart';
import '../../widgets/dropdown_label.dart';
import '../../widgets/widgets.dart';

class ProfileCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const ProfileCard({
    Key? key,
    String? title,
    IconData? icon,
  })  : title = title ?? 'Default Title', // Giá trị mặc định
        icon = icon ?? Icons.person, // Giá trị mặc định
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _ProfileCard(title: title, icon: icon),
    );
  }
}

class _ProfileCard extends StatefulWidget {
  final String title;
  final IconData icon;

  const _ProfileCard({Key? key, required this.title, required this.icon}) : super(key: key);

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<_ProfileCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Color.fromRGBO(235, 238, 241, 1), spreadRadius: 1),
        ],
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width * 0.1,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color.fromRGBO(222, 243, 242, 1),
              boxShadow: [
                BoxShadow(color: AppColors.WHITE, spreadRadius: 1),
              ],
            ),
            child: Icon(widget.icon, size: 25, color: AppColors.PRIMARY_TRANSPARENT),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              widget.title,
              style: TextStyle(
                  color: AppColors.DEEP_GREY,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileCardHeader extends StatelessWidget {
  final String title;

  const ProfileCardHeader({
    Key? key,
    String? title,
  }) : title = title ?? 'Header', // Giá trị mặc định
       super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _ProfileCardHeader(title: title),
    );
  }
}

class _ProfileCardHeader extends StatefulWidget {
  final String title;

  const _ProfileCardHeader({Key? key, required this.title}) : super(key: key);

  @override
  _ProfileCardHeaderState createState() => _ProfileCardHeaderState();
}

class _ProfileCardHeaderState extends State<_ProfileCardHeader> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.GREEN_LIGHT,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              widget.title,
              style: TextStyle(
                  color: AppColors.BLACK,
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileCardWithDropdown extends StatelessWidget {
  final String title;
  final IconData icon;

  const ProfileCardWithDropdown({
    Key? key,
    String? title,
    IconData? icon,
  })  : title = title ?? 'Dropdown Title', // Giá trị mặc định
        icon = icon ?? Icons.arrow_drop_down, // Giá trị mặc định
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _ProfileCardWithDropdown(title: title, icon: icon),
    );
  }
}

class _ProfileCardWithDropdown extends StatefulWidget {
  final String title;
  final IconData icon;

  const _ProfileCardWithDropdown({Key? key, required this.title, required this.icon}) : super(key: key);

  @override
  _ProfileCardWithDropdownState createState() => _ProfileCardWithDropdownState();
}

class _ProfileCardWithDropdownState extends State<_ProfileCardWithDropdown> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10),
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Color.fromRGBO(235, 238, 241, 1), spreadRadius: 1),
        ],
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width * 0.1,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color.fromRGBO(222, 243, 242, 1),
              boxShadow: [
                BoxShadow(color: AppColors.WHITE, spreadRadius: 1),
              ],
            ),
            child: Icon(widget.icon, size: 25, color: AppColors.PRIMARY_TRANSPARENT),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
              widget.title,
              style: TextStyle(
                  color: AppColors.DEEP_GREY,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
          Spacer(),
          Container(
            width: 100,
            child: DropdownLabel(
              label: "",
              rate: [0, 10],
              value: "ENG",
              valueList: ["ENG", "VN"],
              backgroundColor: AppColors.GREEN_LIGHT,
              borderColor: AppColors.GREEN_LIGHT,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileCardWithCheckBox extends StatelessWidget {
  final String title;
  final IconData icon;

  const ProfileCardWithCheckBox({
    Key? key,
    String? title,
    IconData? icon,
  })  : title = title ?? 'Checkbox Title', // Giá trị mặc định
        icon = icon ?? Icons.check_box, // Giá trị mặc định
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _ProfileCardWithCheckBox(title: title, icon: icon),
    );
  }
}

class _ProfileCardWithCheckBox extends StatefulWidget {
  final String title;
  final IconData icon;

  const _ProfileCardWithCheckBox({Key? key, required this.title, required this.icon}) : super(key: key);

  @override
  _ProfileCardWithCheckBoxState createState() => _ProfileCardWithCheckBoxState();
}

class _ProfileCardWithCheckBoxState extends State<_ProfileCardWithCheckBox> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Color.fromRGBO(235, 238, 241, 1), spreadRadius: 1),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
              widget.title,
              style: TextStyle(
                  color: AppColors.DEEP_GREY,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
          Spacer(),
          Container(
            width: MediaQuery.of(context).size.width * 0.1 - 5,
            child: CheckBoxInput(
              label: "",
              action: () => {},
              checked: true,
              lableStyle: TextStyle(),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileCardWithDescription extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const ProfileCardWithDescription({
    Key? key,
    String? title,
    String? description,
    IconData? icon,
  })  : title = title ?? 'Description Title', // Giá trị mặc định
        description = description ?? 'Default Description', // Giá trị mặc định
        icon = icon ?? Icons.description, // Giá trị mặc định
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _ProfileCardWithDescription(
          title: title, icon: icon, description: description),
    );
  }
}

class _ProfileCardWithDescription extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;

  const _ProfileCardWithDescription({
    Key? key,
    required this.title,
    required this.icon,
    required this.description,
  }) : super(key: key);

  @override
  _ProfileCardWithDescriptionState createState() =>
      _ProfileCardWithDescriptionState();
}

class _ProfileCardWithDescriptionState
    extends State<_ProfileCardWithDescription> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Color.fromRGBO(235, 238, 241, 1), spreadRadius: 1),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.1 - 10,
              child: CheckBoxInput(
                label: "",
                action: () => {},
                checked: true,
                lableStyle: TextStyle(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      color: AppColors.DEEP_GREY,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 120,
                  child: Text(
                    widget.description,
                    style: TextStyle(
                        color: AppColors.DEEP_GREY,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
