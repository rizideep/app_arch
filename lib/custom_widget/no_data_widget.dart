import 'package:ecom/src/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class NoDataWidget extends StatelessWidget {
  final String imagePath, headerText, subString;

  const NoDataWidget(this.imagePath, this.headerText, this.subString,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          SvgPicture.asset(
            imagePath,
            width: 65,
            height: 65,
          ),
          const SizedBox(
            height: 18,
          ),
          Text(
            headerText,
            textAlign: TextAlign.center,
            style: MyTxtStyle.font16w600Gen100,
          ),
          Text(
            subString,
            textAlign: TextAlign.center,
            style: MyTxtStyle.font13w400Gen70,
          ),
        ],
      ),
    );
  }
}
