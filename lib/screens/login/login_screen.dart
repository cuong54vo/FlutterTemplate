import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:childcaresoftware/blocs/blocs.dart';
import 'package:childcaresoftware/commons/dialogs.dart';
import 'package:childcaresoftware/commons/validator.dart';
import 'package:childcaresoftware/constants/color.dart';
import 'package:childcaresoftware/constants/form_status.dart';
import 'package:childcaresoftware/router.dart';
import 'package:childcaresoftware/widgets/widgets.dart';
import 'package:childcaresoftware/main.dart';
import '../screens.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(),
        child: BlocListener<LoginBloc, LoginState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            switch (state.status) {
              case FormStatus.submissionInProgress:
                Dialogs.showLoadingDialog(context);
                break;
              case FormStatus.submissionSuccess:
                Dialogs.hideDialog(context);
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
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
              child: ListView(
                physics: const ClampingScrollPhysics(),
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 10),
                  Image.asset('assets/icon/logo-v4.png', height: 150),
                  const SizedBox(height: 12),
                  const SizedBox(height: 30),
                  const _EmailInput(),
                  const SizedBox(height: 12),
                  const _PasswordInput(),
                  const SizedBox(height: 12),
                  const _ForgotPasswordButton(),
                  const _RoleCheckBox(title: "is Teacher"),
                  const SizedBox(height: 40),
                  const _LoginButton(),
                  const SizedBox(height: 30),
                  const _SignUpButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ForgotPasswordButton extends StatelessWidget {
  const _ForgotPasswordButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Spacer(),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
            );
          },
          child: Text(
            'Forgot Password?',
            style: TextStyle(color: AppColors.PRIMARY),
          ),
        ),
      ],
    );
  }
}

class _EmailInput extends StatefulWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  _EmailInputState createState() => _EmailInputState();
}

class _EmailInputState extends State<_EmailInput> {
  final FocusNode focusNode = FocusNode();
  bool autoValidate = false;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {
        autoValidate = !focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      decoration: InputDecoration(
        labelText: 'Email address',
        prefixIcon: Icon(Icons.email, color: AppColors.PRIMARY),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (!Validators.isValidEmail(value!)) {
          return 'Invalid Email';
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      onChanged: (value) {
        context.read<LoginBloc>().add(EmailChanged(email: value));
      },
    );
  }
}

class _PasswordInput extends StatefulWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.isPasswordVisible != current.isPasswordVisible,
      builder: (context, state) {
        return TextFormField(
          focusNode: focusNode,
          obscureText: !state.isPasswordVisible,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: Icon(Icons.lock, color: AppColors.PRIMARY),
            suffixIcon: IconButton(
              icon: Icon(
                state.isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: AppColors.PRIMARY,
              ),
              onPressed: () {
                context.read<LoginBloc>().add(
                    PasswordVisibleChanged(isVisible: !state.isPasswordVisible));
              },
            ),
          ),
          onChanged: (value) {
            context.read<LoginBloc>().add(PasswordChanged(password: value));
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (!Validators.isRequiredField(value!)) {
              return 'Invalid Password';
            }
            return null;
          },
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Button(
          label: 'Login to Child Care Software',
          flex: 1,
          onPress: () {
            if (Form.of(context)?.validate() ?? false) {
              sendInfoToAnalytics(state.email);
              context.read<LoginBloc>().add(LoginSubmitted());
            }
          },
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        const Text(
          'Don\'t have an account?',
          style: TextStyle(color: AppColors.BLACK),
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterScreen()),
            );
          },
          child: Text(
            'Sign up',
            style: TextStyle(
              color: AppColors.PRIMARY,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _RoleCheckBox extends StatefulWidget {
  final String title;
  const _RoleCheckBox({Key? key, required this.title}) : super(key: key);

  @override
  _RoleCheckBoxState createState() => _RoleCheckBoxState();
}

class _RoleCheckBoxState extends State<_RoleCheckBox> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.isTeacher != current.isTeacher,
      builder: (context, state) {
        return Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.1 - 5,
              child: CheckBoxInput(
                label: "",
                action: (value) {
                  context.read<LoginBloc>().add(IsTeacherChanged(isTeacher: value));
                },
                checked: state.isTeacher,
              ),
            ),
            Text(
              widget.title,
              style: const TextStyle(
                color: AppColors.DEEP_GREY,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }
}

void sendInfoToAnalytics(String email) {
  // MyApp.observer.analytics.logEvent(
  //   name: 'Login Screen',
  //   parameters: <String, dynamic>{
  //     'email': email,
  //   },
  // );
}
