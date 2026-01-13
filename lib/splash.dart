import 'dart:io';

import 'package:ecom/auth/login_screen.dart';
import 'package:ecom/auth/signup_screen.dart';
import 'package:ecom/utils/getx_storage.dart';
import 'package:ecom/utils/preferences_constant.dart';
import 'package:ecom/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'utils/image.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;
  final box = GetStorageUtil();
  int? userId;

  @override
  void initState() {
    super.initState();
    userId = box.read((PreferencesConstant.userId));
    MyUtil.printW("user id $userId");

    animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    animation = CurvedAnimation(parent: animationController, curve: Curves.bounceIn);
    Future.delayed(const Duration(seconds: 4));

    startSplashAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getSplashFrontWidget(),
    );
  }

  getSplashFrontWidget() {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
          child: Stack(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Center(
                  child: ScaleTransition(
                scale: animation,
                child: Image.asset(
                  AppImages.agreement,
                  fit: BoxFit.cover,
                  width: 200,
                ),
              )),
            ),
          ),
        ],
      )),
    );
  }

  startSplashAnimation() {
    animationController.forward(from: 0.0);
    Future.delayed(const Duration(seconds: 5), () {
      _decideMainPage();
    });
  }

  _decideMainPage() {
    if (userId != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  // Future<void> checkForUpdate(BuildContext context) async {
  //   InAppUpdate.checkForUpdate().then((updateInfo) {
  //     if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
  //       if (updateInfo.immediateUpdateAllowed) {
  //         InAppUpdate.performImmediateUpdate();
  //       } else if (updateInfo.flexibleUpdateAllowed) {
  //         InAppUpdate.startFlexibleUpdate().then((appUpdateResult) {
  //           if (appUpdateResult == AppUpdateResult.success) {
  //             InAppUpdate.completeFlexibleUpdate().then((value){
  //               MyUtil.showToast('App Updated Successfully');
  //             });
  //           }
  //         });
  //       }
  //     }
  //   });
  // }

  @override
  onTapButton() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }
}
