import 'package:ecom/auth/signup_screen.dart';
import 'package:ecom/base/app_callbacks.dart';
import 'package:ecom/base/app_events.dart';
import 'package:ecom/src/app_font_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../base/app_bloc.dart';
import '../base/app_states.dart';
import '../custom_widget/custom_loading.dart';
import '../custom_widget/error_screen.dart';
import '../custom_widget/no_internet_screen.dart';
import '../utils/util.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    implements AppNetworkCallback, AppErrorCallback {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool hidePassword = true;
  late AppBloc appBloc;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    appBloc = AppBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login"), centerTitle: true),
      body: BlocConsumer<AppBloc, AppStates>(
        bloc: appBloc,
        listener: (context, state) async {
          if (state is SuccessState && state.appEvent is LoginEvent) {
            MyUtil.showSnackBar(context, state.serverResponse.message!);
          }
          if (state is ErrorState) {
            MyUtil.showToast(state.appError.errorMessage);
          }
        },
        builder: (BuildContext context, AppStates state) {
          return getPageState(state);
        },
      ),
    );
  }

  getPageState(AppStates appStates) {
    if (appStates is NeutralState) {
      return getMainView();
    } else if (appStates is NetworkErrorState) {
      return NoInternetScreen(this);
    } else if (appStates is ErrorState) {
      return ErrorScreen(
        this,
        appStates.appError.errorMessage,
        appStates.appError.statusCode,
      );
    } else if (appStates is LoadingState) {
      return Stack(children: [getMainView(), const CustomLoading()]);
    }
  }

  getMainView() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(appPaddingHorizontal, 20, 20, 100),
          child: Form(
            key: _formKey,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    const SizedBox(height: 40),

                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,

                      decoration: const InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter  email";
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    TextFormField(
                      controller: passwordController,
                      obscureText: hidePassword,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter password";
                        }
                        if (value.length < 6) {
                          return "Minimum 6 characters required";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _login,
                        child: const Text(
                          "LOGIN",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox()),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SignUpScreen(),
                              ),
                            );
                          },
                          child: const Text("Sign Up"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      appBloc.add(
        LoginEvent(
          emailController.text.toString().trim(),
          passwordController.text.toString().trim(),
        ),
      );
    }
  }

  @override
  onRetry() {
    _login();
  }

  @override
  onErrorCall() {
    _login();
  }
}
