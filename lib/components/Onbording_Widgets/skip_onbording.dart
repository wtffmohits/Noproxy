import 'package:flutter/material.dart';
import 'package:noproxy/Authantication/onbording_auth/onbording_auth.dart';
import 'package:noproxy/widgets/Themes/color.dart';
import 'package:noproxy/widgets/Themes/device_utls.dart';
import 'package:noproxy/widgets/Themes/size.dart';

class skiponbording extends StatelessWidget {
  const skiponbording({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: TDeviceUtils.getAppBarHeight(),
        right: Tsize.defaultSize,
        child: TextButton(
          onPressed: () => OnBordingController.instance.skipPage(),
          child: const Text("Skip",
              style: TextStyle(fontSize: 22, color: TColors.boomColor)),
        ));
  }
}
