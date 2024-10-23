import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:childcaresoftware/blocs/blocs.dart';
import 'package:childcaresoftware/commons/dialogs.dart';
import 'package:childcaresoftware/commons/validator.dart';
import 'package:childcaresoftware/constants/color.dart';
import 'package:childcaresoftware/constants/form_status.dart';
import 'package:childcaresoftware/router.dart';
import 'package:childcaresoftware/screens/screens.dart';
import 'package:childcaresoftware/widgets/widgets.dart';

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // brightness: Brightness.light,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: AppColors.PRIMARY),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Child Care Software',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: AppColors.BLACK,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ],
        ),
        elevation: 0.0,
      ),
      body: BlocProvider(
        create: (context) {
          return ForgotPasswordBloc();
        },
        child: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            switch (state.status) {
              case FormStatus.submissionInProgress:
                Dialogs.showLoadingDialog(context);
                break;
              case FormStatus.submissionSuccess:
                Dialogs.hideDialog(context);
                Dialogs.showAlertDialog(
                  context,
                  'Chúng tôi đã gửi liên kết khôi phục mật khẩu đến email của bạn',
                  () {
                    Navigator.pushNamed(
                      context, AppRouter.LOGIN,
                    );
                  },
                );
                break;
              case FormStatus.submissionFailure:
                Dialogs.hideDialog(context);
                Dialogs.showErrorDialog(context, state.messageStatus);
                break;
              default:
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Đặt lại mật khẩu',
                      style: TextStyle(
                        color: AppColors.PRIMARY,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Text(
                      'Để khôi phục mật khẩu của bạn, hãy nhập địa chỉ email đã đăng ký. Chúng tôi sẽ gửi mã khôi phục đến email của bạn.',
                      style: TextStyle(color: AppColors.PRIMARY, fontSize: 15),
                    ),
                  ),
                  SizedBox(height: 30),
                  _EmailInput(),
                  SizedBox(height: 30),
                  _NextButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      builder: (context, state) {
        return TextFormField(
          decoration: InputDecoration(
              labelText: 'Địa chỉ E-Mail',
              prefixIcon: Icon(
                Icons.email,
                color: AppColors.PRIMARY,
              )),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (!Validators.isValidEmail(value!)) {
              return 'Email không hợp lệ';
            }
            return null;
          },
          onChanged: (value) => context
              .read<ForgotPasswordBloc>()
              .add(ForgotPasswordEmailChanged(email: value)),
        );
      },
    );
  }
}

class _NextButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      builder: (context, state) {
        return Button(
            label: 'Gửi liên kết khôi phục mật khẩu',
            flex: 1,
            onPress: () {
              if (Form.of(context).validate()) {
                context
                    .read<ForgotPasswordBloc>()
                    .add(ForgotPasswordSubmitted());
              }
            });
      },
    );
  }
}
