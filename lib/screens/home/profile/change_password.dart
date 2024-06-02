import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/buttons.dart';
import '../../../widgets/text_inputs.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        title: Text(
          "Change Password",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        child: Column(
          children: [
            CustomTextField(
              hintTitle: "Old Password",
              iconData: Icons.password,
              color: Theme.of(context).colorScheme.secondary,
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomTextField(
              hintTitle: "New Password",
              iconData: Icons.password,
              color: Theme.of(context).colorScheme.secondary,
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomTextField(
              hintTitle: "Confirm New Password",
              iconData: Icons.password,
              color: Theme.of(context).colorScheme.secondary,
            ),
            SizedBox(
              height: 40.h,
            ),
            PrimaryButton(
              onTap: () {
                Navigator.pop(context);
              },
              buttonTitle: "Change Password",
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
