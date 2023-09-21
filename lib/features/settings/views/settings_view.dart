// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jimpact/features/settings/widgets/settings_tile.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:simple_notifier/simple_notifier.dart';

import 'package:jimpact/features/auth/views/change_password_view.dart';
import 'package:jimpact/theme/palette.dart';
import 'package:jimpact/utils/app_extensions.dart';
import 'package:jimpact/utils/nav.dart';
import 'package:jimpact/utils/widgets/appbar.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  ValueNotifier<bool> notif = false.notifier;
  ValueNotifier<bool> appNotif = false.notifier;

  @override
  void dispose() {
    notif.dispose();
    appNotif.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.bgGreyFB,
      appBar: customAppBar('', context: context),
      body: Padding(
        padding: 32.padH,
        child: Column(
          children: [
            30.sbH,

            //! what
            'Settings'
                .txt(
                  size: 32.sp,
                  colorType: TxtClrType.g41,
                  fontWeight: FontWeight.w300,
                )
                .alignCenterLeft(),
            70.sbH,

            //! notifications
            SizedBox(
              height: 50.h,
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    height: 50.h,
                    width: 50.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: const Color(0xFFD5D5D5),
                    ),
                    child: Center(
                      child: Icon(PhosphorIcons.bell, size: 24.sp),
                    ),
                  ),
                  20.sbW,
                  'Turn on Notifications'.txt16(
                    colorType: TxtClrType.g54,
                  ),
                  const Spacer(),
                  notif.listen(
                    builder: (context, value, child) => Switch.adaptive(
                      value: notif.value,
                      activeColor: Pallete.redColor,
                      onChanged: (value) {
                        notif.value = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
            28.sbH,

            //! app notifications
            SizedBox(
              height: 50.h,
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    height: 50.h,
                    width: 50.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      color: const Color(0xFFD5D5D5),
                    ),
                    child: Center(
                      child: Icon(PhosphorIcons.bell, size: 24.sp),
                    ),
                  ),
                  20.sbW,
                  'Turn on App Notifications'.txt16(
                    colorType: TxtClrType.g54,
                  ),
                  const Spacer(),
                  appNotif.listen(
                    builder: (context, value, child) => Switch.adaptive(
                      value: appNotif.value,
                      activeColor: Pallete.redColor,
                      onChanged: (value) {
                        appNotif.value = value;
                      },
                    ),
                  ),
                ],
              ),
            ),
            28.sbH,

            //! change password
            SettingsTile(
              icon: PhosphorIcons.pen,
              title: 'Password',
              onTap: () {
                goTo(context: context, view: const ChangePasswordView());
              },
            )
          ],
        ),
      ),
    );
  }
}
