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
      foregroundColor: foregroundColor ?? Palette.textBlack54,
      backgroundColor: color ?? Palette.whiteColor,
      leading: isLeftAligned
          ? null
          : showBackButton
              ? overrideBackButtonAction
                  ? showXIcon
                      ? IconButton(
                          onPressed: () => goBack(context),
                          icon: Icon(
                            Icons.close,
                            color: iconColor ?? Palette.textBlack54,
                          ))
                      : BackButton(
                          color: iconColor ?? Palette.textBlack54,
                          onPressed: () => backFunction!(),
                        )
                  : showXIcon
                      ? IconButton(
                          onPressed: () => goBack(context),
                          icon: Icon(
                            Icons.close,
                            color: iconColor ?? Palette.textBlack54,
                          ))
                      : BackButton(color: iconColor ?? Palette.textBlack54)
              : null,
      elevation: 0,
      centerTitle: !isLeftAligned,
      leadingWidth: isLeftAligned ? 10 : null,
      title: Text(
        title,
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontSize: 22.sp,
            color: Palette.textGrey41,
          ),
        ),
      ),
      actions: actions ?? const [SizedBox.shrink()],
      bottom: bottom);
}
