import 'dart:async';

import 'package:childcaresoftware/blocs/student/student_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:childcaresoftware/widgets/top_bar.dart';
import 'package:childcaresoftware/constants/color.dart';

class SendMessageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        label: 'Gửi Tin Nhắn',
      ),
      body: const _SendMessageScreen(),
    );
  }
}

class _SendMessageScreen extends StatefulWidget {
  const _SendMessageScreen({Key? key}) : super(key: key);

  @override
  _SendMessageScreenState createState() => _SendMessageScreenState();
}

class _SendMessageScreenState extends State<_SendMessageScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StudentBloc>(
      create: (context) => StudentBloc()..add(GetBrandMyList()),
      child: BlocConsumer<StudentBloc, StudentState>(
        listener: (context, state) {
          // Xử lý thay đổi trạng thái ở đây nếu cần
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Chọn trẻ mà tin nhắn này liên quan",
                    style: TextStyle(
                      color: AppColors.DEEP_GREY,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.GREEN_BUTTON,
                    boxShadow: [
                      BoxShadow(color: AppColors.PRIMARY_SECOND, spreadRadius: 1),
                    ],
                  ),
                  child: Text(
                    'Faiz, Ali',
                    maxLines: 1,
                    style: TextStyle(
                      color: AppColors.WHITE,
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "Tin Nhắn",
                    style: TextStyle(
                      color: AppColors.DEEP_GREY,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  child: TextFormField(
                    minLines: 10,
                    maxLines: 10,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      filled: true,
                      fillColor: AppColors.WHITE,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: AppColors.GREY_BORDER),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(width: 1, color: AppColors.GREY_BORDER),
                      ),
                    ),
                    onChanged: (value) {
                      // Xử lý thay đổi tin nhắn ở đây
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.GREEN_BUTTON,
                    boxShadow: [
                      BoxShadow(color: AppColors.PRIMARY_SECOND, spreadRadius: 1),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.image, color: AppColors.WHITE, size: 20),
                        const SizedBox(width: 5),
                        Text(
                          'Đính kèm Hình Ảnh',
                          maxLines: 1,
                          style: TextStyle(
                            color: AppColors.WHITE,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.GREEN_BUTTON, // Sử dụng backgroundColor thay vì primary
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      // Xử lý gửi tin nhắn ở đây
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.send, color: AppColors.WHITE, size: 20),
                        const SizedBox(width: 5),
                        const Text("GỬI", style: TextStyle(color: AppColors.WHITE)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
