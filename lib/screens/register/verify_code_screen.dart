import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:childcaresoftware/blocs/blocs.dart';
import 'package:childcaresoftware/commons/dialogs.dart';
import 'package:childcaresoftware/constants/color.dart';
import 'package:childcaresoftware/constants/form_status.dart';
import 'package:childcaresoftware/router.dart';
import 'package:childcaresoftware/widgets/widgets.dart';

class ActivateVerifyCodeScreen extends StatelessWidget {
  const ActivateVerifyCodeScreen({required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // brightness: Brightness.light,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(color: AppColors.PRIMARY),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) => VerifyCodeRegisterBloc(email: email),
          child: BlocListener<VerifyCodeRegisterBloc, VerifyCodeRegisterState>(
            listener: (context, state) {
              switch (state.status) {
                case FormStatus.submissionInProgress:
                  Dialogs.showLoadingDialog(context);
                  break;
                case FormStatus.submissionSuccess:
                  Dialogs.hideDialog(context);
                  Navigator.pushNamed(context, AppRouter.LOGIN);
                  break;
                case FormStatus.submissionFailure:
                  Dialogs.hideDialog(context);
                  Dialogs.showErrorDialog(context, state.messageStatus);
                  break;
                default:
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Nhập mã kích hoạt 6 chữ số',
                  style: TextStyle(
                    color: AppColors.PRIMARY,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Vui lòng kiểm tra hộp thư email của bạn. Chúng tôi đã gửi cho bạn mã kích hoạt 6 chữ số.',
                  style: TextStyle(color: AppColors.PRIMARY, fontSize: 15),
                ),
                const SizedBox(height: 30),
                const _OTPCodeField(),
                const SizedBox(height: 30),
                const _ActivateButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OTPCodeField extends StatefulWidget {
  const _OTPCodeField({Key? key}) : super(key: key);

  @override
  __OTPCodeFieldState createState() => __OTPCodeFieldState();
}

class __OTPCodeFieldState extends State<_OTPCodeField> with WidgetsBindingObserver {
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    focusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (focusNode.hasFocus) {
          focusNode.unfocus();
          Future.delayed(const Duration(milliseconds: 1),
              () => FocusScope.of(context).requestFocus(focusNode));
        } else {
          FocusScope.of(context).requestFocus(focusNode);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      textInputType: TextInputType.number,
      focusNode: focusNode,
      length: 6,
      // obscureText: false,
      animationType: AnimationType.scale,
      shape: PinCodeFieldShape.box,
      animationDuration: const Duration(milliseconds: 300),
      borderRadius: BorderRadius.circular(5),
      fieldHeight: 50,
      fieldWidth: 40,
      onChanged: (value) {
        context.read<VerifyCodeRegisterBloc>().add(VerifyCodeRegisterOTPChanged(otp: value));
      },
    );
  }
}

class _ActivateButton extends StatelessWidget {
  const _ActivateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifyCodeRegisterBloc, VerifyCodeRegisterState>(
      builder: (context, state) {
        return Button(
          label: 'Kích hoạt',
          flex: 1,
          onPress: () {
            context.read<VerifyCodeRegisterBloc>().add(VerifyCodeRegisterSubmitted());
          },
        );
      },
    );
  }
}
