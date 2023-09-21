import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jimpact/theme/palette.dart';
import 'package:jimpact/utils/app_extensions.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final void Function()? onTap;
  const SettingsTile({
    Key? key,
    required this.icon,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              child: Icon(icon, size: 24.sp),
            ),
          ),
          20.sbW,
          title.txt16(
            colorType: TxtClrType.g54,
          ),
          const Spacer(),
          const Icon(
            Icons.keyboard_arrow_right,
            color: Pallete.redColor,
          ),
        ],
      ),
    ).tap(onTap: onTap);
  }
}