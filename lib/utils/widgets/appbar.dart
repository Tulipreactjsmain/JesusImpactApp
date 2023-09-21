import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jimpact/theme/palette.dart';
import 'package:jimpact/utils/nav.dart';

AppBar customAppBar(String title,
    {bool isLeftAligned = false,
    List<Widget>? actions,
    TabBar? bottom,
    bool showBackButton = true,
    Color? color,
    Color? iconColor,
    bool overrideBackButtonAction = false,
    bool showXIcon = false,
    Color? foregroundColor,
    Function? backFunction,
    required BuildContext context}) {
  return AppBar(
      surfaceTintColor: Colors.transparent,
      foregroundColor: foregroundColor ?? Pallete.textBlack54,
      backgroundColor: color ?? Pallete.whiteColor,
      leading: isLeftAligned
          ? null
          : showBackButton
              ? overrideBackButtonAction
                  ? showXIcon
                      ? IconButton(
                          onPressed: () => goBack(context),
                          icon: Icon(
                            Icons.close,
                            color: iconColor ?? Pallete.textBlack54,
                          ))
                      : BackButton(
                          color: iconColor ?? Pallete.textBlack54,
                          onPressed: () => backFunction!(),
                        )
                  : showXIcon
                      ? IconButton(
                          onPressed: () => goBack(context),
                          icon: Icon(
                            Icons.close,
                            color: iconColor ?? Pallete.textBlack54,
                          ))
                      : BackButton(color: iconColor ?? Pallete.textBlack54)
              : null,
      elevation: 0,
      centerTitle: !isLeftAligned,
      leadingWidth: isLeftAligned ? 10 : null,
      title: Text(
        title,
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: 22.sp,
            color: Pallete.textGrey41,
          ),
        ),
      ),
      actions: actions ?? const [SizedBox.shrink()],
      bottom: bottom);
}
