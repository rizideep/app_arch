import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../base/app_callbacks.dart';
import '../splash.dart';
import '../src/app_colors.dart';
import '../src/app_font_size.dart';
import '../utils/app_constant.dart';
import '../utils/getx_storage.dart';
import '../utils/image.dart';
import '../utils/preferences_constant.dart';
import 'custom_loading.dart';

class ErrorScreen extends StatefulWidget {
  final String? errorMessage;
  final int? statusCode;
  final AppErrorCallback appErrorCallback;

  const ErrorScreen(this.appErrorCallback, this.errorMessage, this.statusCode,
      {Key? key})
      : super(key: key);

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  _ErrorScreenState();

  late String image;
  late String buttonText;
  late int? userType;
  bool isLoading = false;
  var box = GetStorageUtil();

  @override
  void initState() {
    super.initState();
    userType = box.read(PreferencesConstant.userTYPE);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.errorMessage!.compareTo(AppConstant.slowInternet) == 0) {
      image = AppImages.agreement;
      buttonText = AppConstant.okay;
    } else {
      image = AppImages.agreement;
      buttonText = AppConstant.startOver;
    }
    if (widget.statusCode! == 401 || widget.statusCode! == 402) {
      buttonText = AppConstant.logInAgain;
    }
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            getMainView(),
            getLogoutButton(),
            const SizedBox(height: 16,),
            if(!isLoading)
            getBackButton()
          ],
        ),
      ),
    );
  }

  Widget getMainView( ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(image),
            const SizedBox(
              height: 10,
            ),
            const Text(
              AppConstant.ooops,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: textColorBlack,
                  fontFamily: AppConstant.appFontInter),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.errorMessage != null
                  ? widget.errorMessage!.isNotEmpty
                  ? widget.errorMessage!
                  : AppConstant.someThingWentWrong
                  : AppConstant.someThingWentWrong,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: colorsGeneral70,
                  fontFamily: AppConstant.appFontInter),
              textAlign: TextAlign.center,
            ),

          ],
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget getLogoutButton( ) {
    if(isLoading){
      return const Center(
        child: Padding(
          padding: EdgeInsets.only(right: 30,left: 20),
          child: CustomLoading(),
        ),
      );
    }else{
      return  ElevatedButton(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(greyDrkLight),
            backgroundColor:
            WidgetStateProperty.all<Color>(colorOrange),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(appScreenPaddingSecondBottom)),
                )),
          ),
          onPressed: () => {
            setState(() {
              isLoading = true;
            }),
            if (widget.statusCode! == 401 || widget.statusCode! == 402)
              {logOutAction()}
            else
              {
                widget.appErrorCallback.onErrorCall(),
              },

          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 8),
            child: Text(
              buttonText,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: colorsGeneral10,
                  fontFamily: AppConstant.appFontInter),
            ),
          ));
    }
  }

  Widget getBackButton( ) {
    return  ElevatedButton(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all<Color>(greyDrkLight),
          backgroundColor:
          WidgetStateProperty.all<Color>(colorOrange),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                    Radius.circular(appScreenPaddingSecondBottom)),
              )),
        ),
        onPressed: () => {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) =>   const Splash()))
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 8),
          child: Text(
            "Re-open",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: colorsGeneral10,
                fontFamily: AppConstant.appFontInter),
          ),
        ));
  }


  logOutAction() async {
    if (userType!=null&&userType == PreferencesConstant.userTypeCustomer) {


    }

    box.eraseAll();
    moveToLoginPage();
    setState(() {
      isLoading = false;
    });
  }

  moveToLoginPage() {
    Navigator.pushNamedAndRemoveUntil(context, "login", (r) => false);
  }
}
