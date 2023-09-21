import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jimpact/theme/palette.dart';
import 'package:jimpact/utils/app_constants.dart';
import 'package:jimpact/utils/app_extensions.dart';

class ComingSoonBottomSheet extends StatelessWidget {
  const ComingSoonBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      width: width(context),
      decoration: BoxDecoration(
        color: Pallete.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        children: [
          13.sbH,
          //! grey bar
          Container(
            width: 60.w,
            height: 4.h,
            decoration: ShapeDecoration(
              color: Pallete.descriptionGrey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
            ),
          ),
          20.sbH,
          //! header
          'Coming soon...'.txtHeading(fontWeight: FontWeight.w600, size: 16.sp),

          27.sbH,
          'bengz'.png.myImage(height: 100.w, color: Pallete.redColor),
        ],
      ),
    );
  }
}
