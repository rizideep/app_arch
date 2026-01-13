import 'package:ecom/base/app_bloc.dart';
import 'package:ecom/base/app_callbacks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../base/app_events.dart';
import '../base/app_states.dart';
import '../custom_widget/custom_loading.dart';
import '../custom_widget/error_screen.dart';
import '../custom_widget/no_internet_screen.dart';
import '../src/app_colors.dart';
import '../src/app_font_size.dart';
import '../utils/util.dart';
import '../utils/validation.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    implements AppNetworkCallback, AppErrorCallback {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool hidePassword = true;
  late AppBloc appBloc;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    appBloc = AppBloc();
    super.initState();
  }

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      appBloc.add(
        RegisterEvent(
          nameController.text.toString().trim(),
          emailController.text.toString().trim(),
          phoneController.text.toString().trim(),
          passwordController.text.toString().trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up"), centerTitle: true,automaticallyImplyLeading:
      false,),
      body: BlocConsumer<AppBloc, AppStates>(
        bloc: appBloc,
        listener: (context, state) async {
          if (state is SuccessState && state.appEvent is LoginEvent) {
            MyUtil.showSnackBar(context,state.serverResponse.message!);

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
          padding: const EdgeInsets.fromLTRB(appPaddingHorizontal, 20, 20, 20),
          child: Form(
            key: _formKey,
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,

                      decoration: const InputDecoration(
                        labelText: "Name",
                        prefixIcon: Icon(Icons.phone),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter name";
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,

                      decoration: const InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.phone),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter email";
                        }
                        if (!Validator.validateEmail(value)) {
                          return "Enter valid email";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      decoration: const InputDecoration(
                        labelText: "Phone Number",
                        prefixIcon: Icon(Icons.phone),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter phone number";
                        }
                        if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                          return "Enter valid 10 digit number";
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
                        onPressed: _signUp,
                        child: const Text(
                          "SIGN UP",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox()),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Login"),
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

  @override
  onRetry() {
    _signUp();
  }

  @override
  onErrorCall() {
    _signUp();
  }
}
