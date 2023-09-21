import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jimpact/features/auth/views/create_account_view.dart';
import 'package:jimpact/features/auth/views/sign_in_view.dart';
import 'package:jimpact/shared/app_texts.dart';
import 'package:jimpact/theme/palette.dart';
import 'package:jimpact/utils/app_extensions.dart';
import 'package:jimpact/utils/nav.dart';
import 'package:jimpact/utils/utils.dart';
import 'package:jimpact/utils/widgets/button.dart';
import 'package:jimpact/utils/widgets/myicon.dart';

class ChooseAuthRouteView extends ConsumerWidget {
  const ChooseAuthRouteView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: stopWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox.expand(
          child: Padding(
            padding: 48.padH,
            child: Column(
              children: [
                171.sbH,
                //! lets grow
                AppTexts.letsGrow.txt18(
                  colorType: TxtClrType.g78,
                  textAlign: TextAlign.center,
                ),
                95.sbH,
    
                //! buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ArrowButton(
                      onTap: () {
                        goTo(context: context, view: const CreateAccountView());
                      },
                      text: AppTexts.getStarted,
                      width: 176.w,
                    ),
                    TransparentButton(
                      onTap: () {
                        goTo(context: context, view: const SignInView());
                      },
                      width: 176.w,
                      isText: false,
                      item: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppTexts.signIn.txt18(
                            color: Pallete.redColor,
                            fontWeight: FontWeight.w500,
                          ),
                          20.sbW,
                          MyIcon(
                            icon: 'padlock',
                            height: 14.6.h,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                367.sbH,
    
                //! sign up with
                AppTexts.orSignUp.txt18(
                  colorType: TxtClrType.g54,
                  textAlign: TextAlign.center,
                ),
    
                27.sbH,
                SizedBox(
                  width: 197.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      3,
                      (index) => CircleAvatar(
                        backgroundColor: Pallete.textInputFillGreyEE,
                        child: Container(
                            padding: const EdgeInsets.all(9),
                            child: switch (index) {
                              0 => Image.network(
                                  "https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png"),
                              1 => Image.network(
                                  "https://cdn.icon-icons.com/icons2/1826/PNG/512/4202107facebookfblogosocialsocialmedia-115710_115591.png"),
                              2 => Image.network(
                                  "https://img.freepik.com/free-icon/twitter_318-674515.jpg"),
                              _ => null
                            }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
