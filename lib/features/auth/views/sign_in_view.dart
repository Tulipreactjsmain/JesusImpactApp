import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/num_duration_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jimpact/features/auth/providers/auth_providers.dart';
import 'package:jimpact/features/auth/views/create_account_view.dart';
import 'package:jimpact/features/auth/views/forgot_pasword_view.dart';
import 'package:jimpact/features/base_nav/wrapper/base_nav_wrapper.dart';
import 'package:jimpact/shared/app_texts.dart';
import 'package:jimpact/theme/palette.dart';
import 'package:jimpact/utils/app_constants.dart';
import 'package:jimpact/utils/app_extensions.dart';
import 'package:jimpact/utils/nav.dart';
import 'package:jimpact/utils/widgets/button.dart';
import 'package:jimpact/utils/widgets/myicon.dart';
import 'package:jimpact/utils/widgets/text_input.dart';
import 'package:simple_notifier/simple_notifier.dart';

class SignInView extends ConsumerStatefulWidget {
  const SignInView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInViewState();
}

class _SignInViewState extends ConsumerState<SignInView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> isPasswordInvisible = ValueNotifier(true);

  void passwordVisibility() =>
      isPasswordInvisible.value = !isPasswordInvisible.value;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();

    isPasswordInvisible.dispose();

    super.dispose();
  }

  ValueNotifier<bool> isLoading = false.notifier;

  void load() {
    // int count = 0;
    isLoading.value = true;
    Future.delayed(6.seconds).whenComplete(
      () {
        isLoading.value = false;
        goTo(context: context, view: const BaseNavWrapper());

        // Navigator.of(context).popUntil((_) => count++ >= 2);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isAuthLoading = ref.watch(authControllerProvider);
    return Scaffold(
      extendBodyBehindAppBar: true,
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
                140.sbH,
                'Sign in'
                    .txt(
                      size: 32.sp,
                      fontWeight: FontWeight.w300,
                      colorType: TxtClrType.g54,
                    )
                    .alignCenterLeft(),
                89.sbH,

                //! email
                TextInputWidget(
                  // keyboardType: TextInputType.emailAddress,
                  hintText: 'Username',
                  controller: _usernameController,
                ),
                34.sbH,

                //! password
                isPasswordInvisible.listen(
                  builder: (context, value, child) => TextInputWidget(
                    hintText: AppTexts.password,
                    controller: _passwordController,
                    obscuretext: isPasswordInvisible.value,
                    suffixIcon: Padding(
                      padding: 15.padH,
                      child: MyIcon(
                        icon: 'showpassword',
                        height: 15.h,
                        color: isPasswordInvisible.value == false
                            ? Pallete.redColor
                            : null,
                      ),
                    ).tap(onTap: passwordVisibility),
                  ),
                ),
                18.sbH,
                RichText(
                  text: TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        goTo(
                            context: context, view: const ForgotPasswordView());
                      },
                    text: 'Forgot Password?',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 16.sp,
                        color: Pallete.textGrey70,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ).alignCenterRight(),
                51.sbH,
                isLoading.value
                    ? SizedBox(
                        height: 50.h,
                        child: const Center(
                            child: CircularProgressIndicator(
                          color: Pallete.redColor,
                        )),
                      )
                    : ArrowButton(
                        width: 154.w,
                        onTap: () {
                          setState(() {
                            load();
                          });
                          // ref.read(authControllerProvider.notifier).loginUser(
                          //       context: context,
                          //       email: _usernameController.text,
                          //       password: _passwordController.text,
                          //     );
                        },
                        text: 'Sign in',
                      ).alignCenterLeft(),
                144.sbH,

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
                ).alignCenterLeft(),

                30.sbH,
                RichText(
                  text: TextSpan(
                    text: 'Don\'t have an account yet ? ',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 16.sp,
                        color: Pallete.textGrey70,
                      ),
                    ),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            goTo(
                                context: context,
                                view: const CreateAccountView());
                          },
                        text: 'Sign up',
                        style: TextStyle(
                          color: Pallete.redColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ).alignCenterLeft(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
