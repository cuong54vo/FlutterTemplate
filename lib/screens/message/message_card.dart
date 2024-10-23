import 'dart:async';
import 'package:childcaresoftware/commons/dialogs.dart';
import 'package:childcaresoftware/constants/color.dart';
import 'package:flutter/material.dart';

import '../../blocs/blocs.dart';
import 'message_router.dart';

class MessageCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback action;

  const MessageCard({
    Key? key,
    required this.title,
    required this.icon,
    this.action = _emptyAction, // Hàm rỗng mặc định
  }) : super(key: key);

  static void _emptyAction() {} // Hàm rỗng

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _MessageCard(title: title, icon: icon, action: action),
    );
  }
}

class _MessageCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback action;

  const _MessageCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.action,
  }) : super(key: key);

  @override
  _MessageCardState createState() => _MessageCardState();
}

class _MessageCardState extends State<_MessageCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              widget.action(); // Gọi action khi nhấn
            },
            child: Container(
              margin: const EdgeInsets.only(left: 50, top: 10),
              height: 50,
              width: MediaQuery.of(context).size.width - 66,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.WHITE,
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromRGBO(235, 238, 241, 1),
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 70,
            height: 70,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: AppColors.WHITE,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromRGBO(235, 238, 241, 1),
                  spreadRadius: 1,
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 35,
              backgroundColor: const Color.fromRGBO(222, 243, 242, 1),
              child: ClipOval(
                child: Icon(
                  widget.icon,
                  size: 25,
                  color: AppColors.PRIMARY_TRANSPARENT,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
