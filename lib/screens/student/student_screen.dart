import 'package:flutter/material.dart';
import 'package:childcaresoftware/screens/student/student_tab.dart';
import 'package:childcaresoftware/widgets/top_bar.dart';
import 'package:childcaresoftware/constants/color.dart';

class StudentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        label: 'Student',
        isShowBackButton: false,
      ),
      body: const Padding(
        padding: EdgeInsets.all(0),
        child: _StudentScreen(),
      ),
    );
  }
}

class _StudentScreen extends StatefulWidget {
  const _StudentScreen({Key? key}) : super(key: key);

  @override
  _StudentScreenState createState() => _StudentScreenState();
}

class _StudentScreenState extends State<_StudentScreen> {
  final List<Tab> productSearchTab = const [
    Tab(text: 'Students'),
    Tab(text: 'Attendance'),
    Tab(text: 'Message'),
    Tab(text: 'Learn'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: productSearchTab.length,
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
                  tabs: productSearchTab.map((tab) {
                    return Container(
                      alignment: Alignment.center,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        border: Border(
                          right: BorderSide(color: Colors.grey, width: 0.5),
                        ),
                      ),
                      child: Text(tab.text ?? ''),
                    );
                  }).toList(),
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
              const Divider(color: AppColors.GREY),
              Expanded(
                child: Container(
                  color: AppColors.BACKGROUND_COLOR,
                  child: TabBarView(
                    children: <Widget>[
                      StudentTab(),
                      StudentTab(),
                      StudentTab(),
                      StudentTab(),
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
