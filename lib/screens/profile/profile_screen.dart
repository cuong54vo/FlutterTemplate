import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:childcaresoftware/blocs/student/student_bloc.dart';
import 'package:childcaresoftware/constants/color.dart';
import 'package:childcaresoftware/screens/profile/profile_card.dart';
import 'package:childcaresoftware/widgets/top_bar.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        label: 'Profile',
      ),
      body: Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: const _ProfileContent(),
      ),
    );
  }
}

class _ProfileContent extends StatefulWidget {
  const _ProfileContent({Key? key}) : super(key: key);

  @override
  _ProfileContentState createState() => _ProfileContentState();
}

class _ProfileContentState extends State<_ProfileContent> with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  late final Completer<void> _refreshCompleter = Completer<void>();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    return BlocProvider<StudentBloc>(
      create: (context) => StudentBloc()..add(GetBrandMyList()),
      child: BlocConsumer<StudentBloc, StudentState>(
        listener: (context, state) {
          // Handle state changes if necessary
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileSection([
                  ProfileCard(title: "Update Email", icon: Icons.edit_note_outlined),
                  ProfileCard(title: "Update Name", icon: Icons.edit_note_outlined),
                  ProfileCard(title: "Update Password", icon: Icons.edit_note_outlined),
                ]),
                _buildProfileInfoSection(),
                _buildNotificationSection(),
                _buildMessageSection(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileSection(List<ProfileCard> cards) {
    return _buildContainerWithShadow(
      Column(children: cards),
    );
  }

  Widget _buildProfileInfoSection() {
    return _buildContainerWithShadow(
      Column(
        children: [
          ProfileCardHeader(title: "Profile Info"),
          ProfileCard(title: "AJ Ali", icon: Icons.people_alt_outlined),
          ProfileCard(title: "asifn77@hotmail.com", icon: Icons.email_outlined),
          ProfileCardWithDropdown(title: "Language", icon: Icons.language_outlined),
        ],
      ),
    );
  }

  Widget _buildNotificationSection() {
    return _buildContainerWithShadow(
      Column(
        children: [
          ProfileCardHeader(title: "Push Notifications"),
          ..._buildNotificationItems(),
        ],
      ),
    );
  }

  List<Widget> _buildNotificationItems() {
    const titles = [
      "Messages",
      "School Events",
      "Images",
      "Videos",
      "Meals",
      "Naps",
      "Reminders",
      "Potty",
      "Medicine",
      "Incidents",
      "Curriculum",
      "Attendance",
      "Other",
    ];
    return titles.map((title) => ProfileCardWithCheckBox(title: title)).toList();
  }

  Widget _buildMessageSection() {
    return _buildContainerWithShadow(
      Column(
        children: [
          ProfileCardHeader(title: "Messages"),
          ProfileCardWithDescription(
            title: "Email/Text",
            description: "Receive messages from demo school via email and/or text.",
          ),
        ],
      ),
    );
  }

  Widget _buildContainerWithShadow(Widget child) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(5),
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
      child: child,
    );
  }

  void _onScroll() {
    // Add any scroll-related logic if needed
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

// Định nghĩa ProfileCardWithDropdown
class ProfileCardWithDropdown extends StatelessWidget {
  final String title;
  final IconData icon;

  const ProfileCardWithDropdown({Key? key, required this.title, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: DropdownButton<String>(
        items: <String>['English', 'Vietnamese', 'Spanish'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          // Xử lý sự thay đổi ngôn ngữ
        },
        hint: const Text('Select Language'),
      ),
    );
  }
}
