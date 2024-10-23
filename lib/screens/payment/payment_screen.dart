import 'package:childcaresoftware/screens/payment/account_tab.dart';
import 'package:childcaresoftware/screens/payment/payment_setting_tab.dart';
import 'package:flutter/material.dart';
import 'package:childcaresoftware/widgets/top_bar.dart';
import 'package:childcaresoftware/constants/color.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        label: 'Payment',
      ),
      body: const Padding(
        padding: EdgeInsets.all(0),
        child: _PaymentScreen(),
      ),
    );
  }
}

class _PaymentScreen extends StatefulWidget {
  const _PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<_PaymentScreen> {
  final List<Tab> paymentTabs = const <Tab>[
    Tab(text: 'Accounts'),
    Tab(text: 'Payment Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: paymentTabs.length,
      initialIndex: 0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: 60,
                color: AppColors.PRIMARY,
                child: TabBar(
                  labelPadding: EdgeInsets.zero,
                  tabs: paymentTabs,
                  unselectedLabelColor: AppColors.WHITE,
                  labelColor: AppColors.PRIMARY_TRANSPARENT,
                  unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  indicatorColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: AppColors.TAB_SELECTED,
                  ),
                ),
              ),
              Container(
                height: 2,
                color: AppColors.GREY,
              ),
              Expanded(
                child: Container(
                  color: AppColors.BACKGROUND_COLOR,
                  child: TabBarView(
                    children: <Widget>[
                      AccountTab(),
                      PaymentSettingTab(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
