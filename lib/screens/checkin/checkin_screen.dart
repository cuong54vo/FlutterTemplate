import 'package:childcaresoftware/screens/checkin/checkin_router.dart';
import 'package:childcaresoftware/widgets/dropdown_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:childcaresoftware/widgets/top_bar.dart';
import 'package:package_info/package_info.dart';
import 'package:childcaresoftware/blocs/blocs.dart';
import 'package:childcaresoftware/commons/dialogs.dart';
import 'package:childcaresoftware/constants/color.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import '../checkout/checkout_router.dart';
import '../payment/payment_router.dart';

const List<String> _assetNames = <String>[
  'assets/icon/icon1.svg',
  'assets/icon/icon2.svg',
  'assets/icon/icon3.svg',
];

class CheckInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        label: 'Home',
        isShowBackButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: const _CheckInScreen(),
      ),
    );
  }
}

class _CheckInScreen extends StatefulWidget {
  const _CheckInScreen({Key? key}) : super(key: key);

  @override
  _CheckInScreenState createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<_CheckInScreen> {
  final List<Widget> _painters = [];

  @override
  void initState() {
    super.initState();
    for (String assetName in _assetNames) {
      _painters.add(SvgPicture.asset(assetName));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAvatar(),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: _buildCheckInButton(context),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          child: _buildDropdown(),
        ),
        _buildNoActivityMessage(),
      ],
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      height: MediaQuery.of(context).size.width / 4,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColors.WHITE,
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(235, 238, 241, 1),
            spreadRadius: 1,
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 0,
        backgroundColor: Colors.red,
        child: ClipOval(child: Image.asset('assets/images/avt1.jpeg')),
      ),
    );
  }

  Widget _buildCheckInButton(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        ),
        backgroundColor: MaterialStateProperty.all(AppColors.GREEN_BUTTON),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(context, CheckInRouter.checkOutScreen);
      },
      child: Row(
        children: <Widget>[
          const Icon(
            Icons.login_outlined,
            color: AppColors.WHITE,
          ),
          const SizedBox(width: 10),
          const Text(
            "CHECK IN",
            style: TextStyle(color: AppColors.WHITE),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown() {
    return DropdownLabel(
      label: "",
      rate: [0, 10],
      value: "All Activities",
      valueList: ["All Activities"],
    );
  }

  Widget _buildNoActivityMessage() {
    return const Text(
      "Oh no! Looks like there is no activity yet.",
      style: TextStyle(color: AppColors.GREY_COLOR, fontSize: 15),
    );
  }

  Future<PackageInfo> getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo; // Return the PackageInfo
  }

  void sendInfoToAnalytics(String email) {
    // Your analytics code here
  }
}
