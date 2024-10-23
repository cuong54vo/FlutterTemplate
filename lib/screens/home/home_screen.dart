import 'package:childcaresoftware/screens/activity/activity_router.dart';
import 'package:childcaresoftware/screens/checkin/checkin_router.dart';
import 'package:childcaresoftware/screens/dashboard_teacher/dashboard_teacher_router.dart';
import 'package:childcaresoftware/screens/learning/learning_router.dart';
import 'package:childcaresoftware/screens/message/message_router.dart';
import 'package:childcaresoftware/screens/payment/payment_router.dart';
import 'package:childcaresoftware/screens/profile/profile_router.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:childcaresoftware/blocs/blocs.dart';
import 'package:childcaresoftware/commons/dialogs.dart';
import 'package:childcaresoftware/constants/color.dart';
import 'package:childcaresoftware/screens/screens.dart';
import 'package:childcaresoftware/screens/settings/settings_router.dart';
import 'package:childcaresoftware/screens/student/student_router.dart';
import 'package:childcaresoftware/service_locator.dart';
import 'package:childcaresoftware/widgets/widgets.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:childcaresoftware/repositories/repositories.dart';
import '../../commons/variables.dart';
import '../add_payment_method/add_payment_method_router.dart';
import '../calendar/calendar_router.dart';
import '../checkout/checkout_router.dart';
import '../teacher/teacher_router.dart';
import '../tuition/tuition_router.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static final List<Widget> teacher = [
    ActivityRouter(),
    StudentRouter(),
    DashboardTeacherRouter(),
    TeacherRouter(),
    TuitionRouter(),
  ];
  
  static final List<Widget> parent = [
    ActivityRouter(),
    CalendarRouter(),
    CheckInRouter(),
    MessageRouter(),
    LearningRouter(),
  ];

  late final List<Widget> _originalList = Variables.isTeacher ? teacher : parent;
  late Map<int, bool> _originalDic;
  late List<Widget> _listScreens;
  late List<int> _listScreensIndex = [0];
  
  int tabIndex = 0;
  DateTime? currentBackPressTime;
  
  static final List<_BottomAppBarItem> menuTeacher = [
    _BottomAppBarItem(iconData: Icons.local_activity_outlined, text: 'Activity'),
    _BottomAppBarItem(iconData: Icons.assignment_ind_outlined, text: 'Student'),
    _BottomAppBarItem(iconData: Icons.home_outlined, text: 'Dashboard'),
    _BottomAppBarItem(iconData: Icons.supervised_user_circle_outlined, text: 'Teacher'),
    _BottomAppBarItem(iconData: Icons.description_outlined, text: 'Tuition'),
  ];

  static final List<_BottomAppBarItem> menuParent = [
    _BottomAppBarItem(iconData: Icons.local_activity_outlined, text: 'Activity'),
    _BottomAppBarItem(iconData: Icons.calendar_month_outlined, text: 'Calendar'),
    _BottomAppBarItem(iconData: Icons.home_outlined, text: 'Home'),
    _BottomAppBarItem(iconData: Icons.message_outlined, text: 'Message'),
    _BottomAppBarItem(iconData: Icons.book_outlined, text: 'Learning'),
  ];

  late final List<_BottomAppBarItem> listItems = Variables.isTeacher ? menuTeacher : menuParent;

  @override
  void initState() {
    super.initState();
    getStartScreen().then((startScreen) {
      _originalDic = {
        0: false,
        1: false,
        2: false,
        3: false,
        4: false,
      };
      if (startScreen != null) {
        tabIndex = int.parse(startScreen);
        _originalDic[tabIndex] = true;
        _listScreens = [_originalList.elementAt(tabIndex)];
        _listScreensIndex = [tabIndex];
      } else {
        _originalDic[0] = true;
        _listScreens = [_originalList.first];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>(create: (context) {
          return ProfileBloc()..add(GetProfile());
        }),
        BlocProvider<SettingsBloc>(create: (context) {
          return SettingsBloc()..add(SettingsLoaded());
        }),
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
        final unread = null;

        return WillPopScope(
          onWillPop: () async {
            if (tabIndex == 1) {
              DateTime now = DateTime.now();
              if (currentBackPressTime == null || now.difference(currentBackPressTime!) > Duration(seconds: 3)) {
                currentBackPressTime = now;
                Fluttertoast.showToast(
                  msg: "Press again to exit app",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: AppColors.GREY_COLOR,
                  textColor: AppColors.WHITE,
                  fontSize: 14.0,
                );
                return Future.value(false);
              }
              return Future.value(true);
            }

            DateTime now = DateTime.now();
            if (currentBackPressTime == null || now.difference(currentBackPressTime!) > Duration(seconds: 3)) {
              currentBackPressTime = now;
              Fluttertoast.showToast(
                msg: "Press again to exit app",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: AppColors.GREY_COLOR,
                textColor: AppColors.WHITE,
                fontSize: 14.0,
              );
              return Future.value(false);
            }
            return Future.value(true);
          },
          child: Scaffold(
            body: IndexedStack(
              index: _listScreensIndex.indexOf(tabIndex),
              children: _listScreens.isNotEmpty ? _listScreens : [],
            ),
            bottomNavigationBar: _buildTabBar(unread),
            floatingActionButton: Container(
              height: 75.0,
              width: 75.0,
              child: FloatingActionButton(
                onPressed: () => _selectedTab(2, context),
                backgroundColor: AppColors.BACKGROUND_BODY,
                child: Container(
                  height: 55.0,
                  width: 55.0,
                  decoration: BoxDecoration(
                    color: AppColors.WHITE,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.home_outlined, color: AppColors.PRIMARY_TRANSPARENT, size: 30),
                ),
                elevation: 0,
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          ),
        );
      }),
    );
  }

  Future<String?> getStartScreen() async {
    final startScreen = await locator<SettingsRepository>().getStartScreen();
    return startScreen;
  }

  void _selectedTab(int index, BuildContext context) {
    if (_originalDic[index] == false) {
      _listScreensIndex.add(index);
      _originalDic[index] = true;
      _listScreensIndex.sort();
      _listScreens = _listScreensIndex.map((index) => _originalList[index]).toList();
    }
    _sendCurrentTabToAnalytics(index);
    setState(() {
      tabIndex = index;
    });
  }

  Widget _buildTabBar(unread) {
    final items = List.generate(listItems.length, (int index) {
      return _buildTabItem(
        item: listItems[index],
        index: index,
        onPressed: _selectedTab,
        unread: unread,
      );
    });

    return BottomAppBar(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      color: AppColors.PRIMARY,
    );
  }

  Widget _buildTabItem({
    required _BottomAppBarItem item,
    required int index,
    required Function(int, BuildContext) onPressed,
    int? unread,
  }) {
    final color = tabIndex == index ? AppColors.PRIMARY_TRANSPARENT : AppColors.WHITE;
    return Expanded(
      child: SizedBox(
        height: 60,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index, context),
            child: Container(
              padding: EdgeInsets.only(top: 8),
              color: tabIndex == index ? AppColors.PRIMARY : AppColors.PRIMARY,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  item.text == 'Alerts' && (unread ?? 0) > 0
                      ? badges.Badge(
                          position: badges.BadgePosition.bottomEnd(bottom: 8, end: -10),
                          badgeContent: Text(
                            unread.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                          child: Icon(item.iconData, color: color, size: 30),
                        )
                      : item.text.toLowerCase() == 'dashboard'
                          ? Icon(null)
                          : Icon(item.iconData, color: color, size: 30),
                  Padding(
                    padding: item.text.toLowerCase() == 'dashboard' ? const EdgeInsets.only(top: 14) : const EdgeInsets.only(top: 8),
                    child: Text(
                      item.text,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: color, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _sendCurrentTabToAnalytics(int tabIndex) {
    // MyApp.observer.analytics.setCurrentScreen(
    //   screenName: '${_originalList[tabIndex].toString()}',
    // );
  }
}

class _BottomAppBarItem {
  final IconData iconData;
  final String text;

  _BottomAppBarItem({required this.iconData, required this.text});
}
