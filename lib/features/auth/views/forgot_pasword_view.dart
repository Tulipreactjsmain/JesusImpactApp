import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jimpact/theme/palette.dart';
import 'package:jimpact/utils/app_constants.dart';
import 'package:jimpact/utils/app_extensions.dart';
import 'package:jimpact/utils/nav.dart';
import 'package:jimpact/utils/pop_overlay.dart';
import 'package:jimpact/utils/widgets/button.dart';
import 'package:jimpact/utils/widgets/text_input.dart';

class ForgotPasswordView extends ConsumerStatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends ConsumerState<ForgotPasswordView> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PopUpOverlay? overlay = ref.watch(toggleOverlayControllerProvider);
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            foregroundColor: Pallete.textBlack54,
          ),
          body: SizedBox(
            height: height(context),
            width: width(context),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: Padding(
                padding: 32.padH,
                child: Column(
                  children: [
                    40.sbH,
                    'Forgot Password ?'
                        .txt(
                          size: 32.sp,
                          fontWeight: FontWeight.w300,
                          colorType: TxtClrType.g54,
                        )
                        .alignCenterLeft(),
                    12.sbH,

                    //! description
                    'Enter your registered email below to receive password reset intructions'
                        .txt16(
                          fontWeight: FontWeight.w300,
                          colorType: TxtClrType.g78,
                        )
                        .alignCenterLeft(),

                    88.sbH,

                    //! email
                    TextInputWidget(
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Email Address',
                      controller: _emailController,
                    ),
                    48.sbH,

                    BButton(
                      width: 196.w,
                      onTap: () {
                        showPopUpOverLay(
                          context: context,
                          ref: ref,
                          overlay: const PopUpOverlay(
                              image: '',
                              description:
                                  'Please check your inbox and click on the received link to reset your password',
                              title: 'Email has been sent',
                              buttonText: 'Login'),
                        );
                      },
                      text: 'Reset Password',
                    ).alignCenterLeft(),
                    60.sbH,
                  ],
                ),
              ),
            ),
          ),
        ),
        if (overlay != null)
          PopUpOverLayWidget(
            overlay: overlay,
            onButtonTap: () {
              goBack(context);
            },
          ),
      ],
    );
  }
}
