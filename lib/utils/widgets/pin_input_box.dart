import 'package:jimpact/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class PinInputBox extends StatelessWidget {
  final void Function(String)? onCompleted;
  final TextEditingController? controller;
  const PinInputBox({
    Key? key,
    this.onCompleted,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 6,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // obscuringCharacter: '*',
      obscureText: false,
      useNativeKeyboard: true,
      autofocus: true,
      defaultPinTheme: PinTheme(
        width: 42.h,
        height: 49.h,
        textStyle: TextStyle(
          fontSize: 16.sp,
          color: Pallete.blackColor,
          fontWeight: FontWeight.w700,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
          color: Pallete.pinGrey,
          borderRadius: BorderRadius.circular(4.r),
        ),
      ),
      focusedPinTheme: PinTheme(
        width: 42.h,
        height: 49.h,
        textStyle: TextStyle(
          fontSize: 16.sp,
          color: Pallete.blackColor,
          fontWeight: FontWeight.w700,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Pallete.greyColor),
          color: Pallete.whiteColor,
          borderRadius: BorderRadius.circular(4.r),
        ),
      ),
      submittedPinTheme: PinTheme(
        width: 42.h,
        height: 49.h,
        textStyle: TextStyle(
          fontSize: 16.sp,
          color: Pallete.blackColor,
          fontWeight: FontWeight.w700,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
          color: Pallete.pinGrey,
          borderRadius: BorderRadius.circular(4.r),
        ),
      ),
      controller: controller,
      onCompleted: onCompleted,
    );
  }
}
