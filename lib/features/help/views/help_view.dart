import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jimpact/features/help/views/faqs_view.dart';
import 'package:jimpact/features/help/views/privacy_policy_view.dart';
import 'package:jimpact/features/settings/widgets/settings_tile.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:jimpact/theme/palette.dart';
import 'package:jimpact/utils/app_extensions.dart';
import 'package:jimpact/utils/nav.dart';
import 'package:jimpact/utils/widgets/appbar.dart';

class HelpView extends StatelessWidget {
  const HelpView({super.key});

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
            'Help'
                .txt(
                  size: 32.sp,
                  colorType: TxtClrType.g41,
                  fontWeight: FontWeight.w300,
                )
                .alignCenterLeft(),
            70.sbH,

            //! faqs
            SettingsTile(
              icon: PhosphorIcons.question,
              title: 'FAQs',
              onTap: () {
                goTo(context: context, view: const FAQsView());
              },
            ),
            28.sbH,

            //! privacy Policy
            SettingsTile(
              icon: PhosphorIcons.lock,
              title: 'Privacy Policy',
              onTap: () {
                goTo(context: context, view: const PrivacyPolicyView());
              },
            ),
          ],
        ),
      ),
    );
  }
}
