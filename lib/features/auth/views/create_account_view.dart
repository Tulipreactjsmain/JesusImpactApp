import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jimpact/features/auth/providers/auth_providers.dart';
import 'package:jimpact/features/auth/views/sign_in_view.dart';
import 'package:jimpact/features/profile/views/interests_selection_view.dart';
import 'package:jimpact/shared/app_texts.dart';
import 'package:jimpact/theme/palette.dart';
import 'package:jimpact/utils/app_constants.dart';
import 'package:jimpact/utils/app_extensions.dart';
import 'package:jimpact/utils/nav.dart';
import 'package:jimpact/utils/pop_overlay.dart';
import 'package:jimpact/utils/widgets/button.dart';
import 'package:jimpact/utils/widgets/myicon.dart';
import 'package:jimpact/utils/widgets/text_input.dart';
import 'package:simple_notifier/simple_notifier.dart';

class CreateAccountView extends ConsumerStatefulWidget {
  const CreateAccountView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateAccountViewState();
}

class _CreateAccountViewState extends ConsumerState<CreateAccountView> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _reenterPasswordController =
      TextEditingController();
  final ValueNotifier<bool> isPasswordInvisible = ValueNotifier(true);
  final ValueNotifier<bool> isReenterPasswordInvisible = ValueNotifier(true);

  void passwordVisibility() =>
      isPasswordInvisible.value = !isPasswordInvisible.value;

  void repasswordVisibility() =>
      isReenterPasswordInvisible.value = !isReenterPasswordInvisible.value;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _reenterPasswordController.dispose();
    isPasswordInvisible.dispose();
    isReenterPasswordInvisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PopUpOverlay? overlay = ref.watch(toggleOverlayControllerProvider);
    bool isAuthLoading = ref.watch(authControllerProvider);
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
                    20.sbH,
                    'Create a new account'
                        .txt(
                          size: 25.sp,
                          fontWeightType: TxtFntWt.sBold,
                          colorType: TxtClrType.g54,
                        )
                        .alignCenterLeft(),
                    12.sbH,

                    //! description
                    'Lorem ipsum dolor sit amet, consetetur\nsadipscing elitr, sed diam nonumy eirmod'
                        .txt16(
                          fontWeight: FontWeight.w300,
                          colorType: TxtClrType.g78,
                        )
                        .alignCenterLeft(),

                    30.sbH,
                    RichText(
                      text: TextSpan(
                        text: 'Already have n account ? ',
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
                                    context: context, view: const SignInView());
                              },
                            text: 'Sign in',
                            style: TextStyle(
                              color: Pallete.redColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ).alignCenterLeft(),
                    40.sbH,

                    //! first name
                    TextInputWidget(
                      hintText: AppTexts.firstName,
                      controller: _firstNameController,
                    ),
                    34.sbH,

                    //! last name
                    TextInputWidget(
                      hintText: AppTexts.lastName,
                      controller: _lastNameController,
                    ),
                    34.sbH,

                    //! user name
                    TextInputWidget(
                      hintText: 'Username',
                      controller: _usernameController,
                    ),
                    34.sbH,

                    //! email
                    TextInputWidget(
                      keyboardType: TextInputType.emailAddress,
                      hintText: AppTexts.email,
                      controller: _emailController,
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
                    34.sbH,

                    isReenterPasswordInvisible.listen(
                      builder: (context, value, child) => TextInputWidget(
                        hintText: 'Confirm Password',
                        controller: _reenterPasswordController,
                        obscuretext: isReenterPasswordInvisible.value,
                        suffixIcon: Padding(
                          padding: 15.padH,
                          child: MyIcon(
                            icon: 'showpassword',
                            height: 15.h,
                            color: isReenterPasswordInvisible.value == false
                                ? Colors.black
                                : null,
                          ),
                        ).tap(onTap: repasswordVisibility),
                      ),
                    ),

                    100.sbH,
                    Wrap(
                      children: [
                        Container(
                          height: 20.h,
                          width: 20.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.r),
                            color: Pallete.textInputFillGreyEE,
                          ),
                        ),
                        12.sbW,
                        RichText(
                          text: TextSpan(
                            text: 'I agree to the ',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 16.sp,
                                color: Pallete.textGrey70,
                              ),
                            ),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                                text: 'Terms of Service',
                                style: TextStyle(
                                  color: Pallete.redColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: ' & ',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 16.sp,
                                    color: Pallete.textGrey70,
                                  ),
                                ),
                              ),
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  color: Pallete.redColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ).alignCenterLeft(),
                    49.sbH,

                    isAuthLoading
                        ? SizedBox(
                            height: 50.h,
                            child: const Center(
                                child: CircularProgressIndicator(
                              color: Pallete.redColor,
                            )),
                          )
                        : ArrowButton(
                            width: 200.w,
                            onTap: () {
                              ref
                                  .read(authControllerProvider.notifier)
                                  .signUpUser(
                                    context: context,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    firstName: _firstNameController.text,
                                    lastName: _lastNameController.text,
                                    username: _usernameController.text,
                                    onTap: () {
                                      showPopUpOverLay(
                                        context: context,
                                        ref: ref,
                                        overlay: const PopUpOverlay(
                                          image: 'successreg',
                                          title: 'Successful Registration',
                                          description: 'Login to your account',
                                        ),
                                      );
                                    },
                                  );
                            },
                            text: 'Get Started',
                          ).alignCenterLeft(),
                    60.sbH,
                  ],
                ),
              ),
            ),
          ),
        ),

        //! overlay
        if (overlay != null)
          PopUpOverLayWidget(
            overlay: overlay,
            onButtonTap: () {
              goTo(context: context, view: const InterestsSelectionView());
            },
          ),
      ],
    );
  }
}
