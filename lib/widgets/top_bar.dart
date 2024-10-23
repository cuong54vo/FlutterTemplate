import 'package:flutter/material.dart';
import 'package:childcaresoftware/screens/screens.dart';
import 'package:childcaresoftware/constants/color.dart';
import '../commons/variables.dart';
import '../screens/payment/payment_router.dart';
import '../screens/settings/settings_router.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({
    Key? key,
    required this.label,
    this.onPress = _defaultOnPress,
    this.isBadge = false,
    this.badge,
    this.action,
    this.isShowSetting = true,
    this.isShowBackButton = true,
    this.icon = Icons.tune_outlined,
  }) : super(key: key);

  final String label;
  final VoidCallback onPress;
  final bool isBadge;
  final int? badge;
  final Function? action;
  final bool isShowSetting;
  final bool isShowBackButton;
  final IconData icon;

  static void _defaultOnPress() {
    // Default action does nothing
  }

  void _goBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: isShowBackButton
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.WHITE,
              ),
              onPressed: () => _goBack(context),
            )
          : const SizedBox(width: 50),
      iconTheme: const IconThemeData(
        color: AppColors.WHITE,
      ),
      backgroundColor: AppColors.PRIMARY,
      title: Center(
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.WHITE,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      elevation: 0.0,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.settings, color: AppColors.WHITE, size: 20),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsScreen()),
            );
          },
        ),
        Variables.isTeacher
            ? IconButton(
                icon: const Icon(Icons.tune_outlined, color: AppColors.WHITE, size: 20),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()),
                  );
                },
              )
            : IconButton(
                icon: const Icon(Icons.payment_outlined, color: AppColors.WHITE, size: 20),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentScreen()),
                  );
                },
              ),
      ],
    );
  }
}

class TopBarWithAction extends StatelessWidget implements PreferredSizeWidget {
  const TopBarWithAction({
    Key? key,
    required this.label,
    this.onPress = _defaultOnPress,
    this.isBadge = false,
    this.badge,
    this.action,
    this.isRedirect = true,
  }) : super(key: key);

  final String label;
  final VoidCallback onPress;
  final bool isBadge;
  final int? badge;
  final Function? action;
  final bool isRedirect;

  static void _defaultOnPress() {
    // Default action does nothing
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      iconTheme: const IconThemeData(
        color: AppColors.WHITE,
      ),
      backgroundColor: AppColors.PRIMARY,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.WHITE,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
      elevation: 0.0,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.check, color: AppColors.WHITE, size: 30),
          onPressed: () {
            action?.call();
          },
        ),
      ],
    );
  }
}
