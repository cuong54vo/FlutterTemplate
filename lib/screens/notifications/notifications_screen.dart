import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:childcaresoftware/blocs/notifications/notifications_bloc.dart';
import 'package:childcaresoftware/constants/color.dart';
import 'package:childcaresoftware/constants/form_status.dart';
import 'package:childcaresoftware/models/models.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:childcaresoftware/screens/notifications/notifications_router.dart';

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.zero,
        child: const _NotificationList(),
      ),
    );
  }
}

class _NotificationList extends StatefulWidget {
  const _NotificationList({Key? key}) : super(key: key);

  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<_NotificationList> {
  late Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationsBloc, NotificationsState>(
      listener: (context, state) {
        if (state.status == FormStatus.submissionSuccess) {
          _refreshCompleter.complete();
          _refreshCompleter = Completer();
        }
      },
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () {
            context.read<NotificationsBloc>().add(NotificationsStarted());
            return _refreshCompleter.future;
          },
          child: state.notificationList.isNotEmpty
              ? ListView.builder(
                  itemCount: state.notificationList.length,
                  itemBuilder: (context, index) {
                    final item = state.notificationList[index];
                    return _NotificationCard(
                      item: item,
                      color: item.read == 1 ? AppColors.WHITE : AppColors.GREY,
                      action: (id, value) {
                        context.read<NotificationsBloc>().add(NotificationsMarkAsRead(id: id));
                        if (value['action'] == 'JOB_DETAIL') {
                          Navigator.pushNamed(context, NotificationRouter.JOBS_DETAIL);
                        }
                      },
                    );
                  },
                )
              : Center(
                  child: Text(
                    'NO NOTIFICATION',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.PRIMARY,
                    ),
                  ),
                ),
        );
      },
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final NotificationItem item;
  final Color color;
  final Function? action;

  const _NotificationCard({
    Key? key,
    required this.item,
    required this.color,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.read == 0 && action != null) {
          action!(item.id!, item.actionMobile ?? {});
        }
      },
      child: Container(
        color: color,
        height: 80,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: _PrefixImage(type: item.event ?? 'default_type'),
              ),
            ),
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 10, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.timeAgo ?? 'Chưa xác định',
                      style: TextStyle(fontSize: 12, color: AppColors.PRIMARY),
                    ),
                    Html(
                      data: item.message,
                      style: {
                        "html": Style(fontSize: FontSize(13)),
                        "b": Style(color: AppColors.BLACK),
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrefixImage extends StatelessWidget {
  final String type;

  const _PrefixImage({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = _getColorForType(type);
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Icon(
        _getIconForType(type),
        size: 40,
        color: AppColors.WHITE,
      ),
    );
  }

  Color _getColorForType(String type) {
    switch (type) {
      case 'project_create':
        return AppColors.LIGHT_BLUE;
      case 'manager_project_approve':
        return AppColors.GREEN;
      case 'client_invite':
        return AppColors.RED;
      case 'seeker_cancel':
        return AppColors.DEEP_BLUE;
      case 'seeker_accept':
      case 'agency_register':
      case 'approve_branch':
      default:
        return AppColors.PURPLE;
    }
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'project_create':
        return Icons.business_center;
      case 'manager_project_approve':
        return Icons.check;
      case 'client_invite':
        return Icons.close;
      case 'seeker_cancel':
        return Icons.send;
      case 'seeker_accept':
      case 'agency_register':
      case 'approve_branch':
      default:
        return Icons.receipt;
    }
  }
}
