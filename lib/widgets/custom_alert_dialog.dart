import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

customAlertDialog(BuildContext context, Function() onPressed) {
  return showCupertinoDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) {
      return CupertinoAlertDialog(
        title: Text("Wait!"),
        content: Text("Are you sure to logout?"),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Get.back();
            },
            child: Text("No"),
          ),
          CupertinoActionSheetAction(onPressed: onPressed, child: Text("Yes")),
        ],
      );
    },
  );
}
