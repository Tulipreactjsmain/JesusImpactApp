import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jimpact/shared/app_texts.dart';
import 'package:jimpact/theme/palette.dart';
import 'package:jimpact/utils/app_extensions.dart';
import 'package:jimpact/utils/widgets/appbar.dart';
import 'package:jimpact/utils/widgets/button.dart';
import 'package:jimpact/utils/widgets/myicon.dart';
import 'package:jimpact/utils/widgets/text_input.dart';
import 'package:simple_notifier/simple_notifier.dart';

class ChangePasswordView extends ConsumerStatefulWidget {
  const ChangePasswordView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChangePasswordViewState();
}

class _ChangePasswordViewState extends ConsumerState<ChangePasswordView> {
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
    _passwordController.dispose();
    _reenterPasswordController.dispose();
    isPasswordInvisible.dispose();
    isReenterPasswordInvisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.bgGreyFB,
      appBar: customAppBar('', context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: 32.padH,
          child: Column(
            children: [
              30.sbH,

              //! what
              'Change Password'
                  .txt(
                    size: 32.sp,
                    colorType: TxtClrType.g41,
                    fontWeight: FontWeight.w300,
                  )
                  .alignCenterLeft(),
              47.sbH,

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

              400.sbH,
              BButton(
                onTap: () {},
                text: 'Change Password',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
