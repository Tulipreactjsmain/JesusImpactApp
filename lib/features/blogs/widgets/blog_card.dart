import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jimpact/theme/palette.dart';
import 'package:jimpact/utils/app_extensions.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      child: Container(
        height: 290.h,
        width: 180.w,
        decoration: BoxDecoration(
          color: Pallete.whiteColor,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Placeholder(
                fallbackHeight: 124.h,
                color: Pallete.textInputFillGreyEE,
              ),
            ),
            16.sbH,

            //! title
            Padding(
              padding: 16.padH,
              child: Column(
                children: [
                  'The Reason for the Season'.txt(
                    size: 13.sp,
                    fontWeightType: TxtFntWt.med,
                    colorType: TxtClrType.g54,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  8.sbH,
                  'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed'
                      .txt(
                    size: 11.sp,
                    fontWeightType: TxtFntWt.reg,
                    colorType: TxtClrType.g78,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  16.sbH,
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                    children: [
                      'Jesus Impact'.txt(
                        size: 10.sp,
                        fontWeightType:
                            TxtFntWt.med,
                        colorType: TxtClrType.g54,
                      ),
                      Row(
                        children: [
                          '12'.txt(
                              size: 12.sp,
                              fontWeightType:
                                  TxtFntWt.med,
                              color:
                                  Pallete.redColor),
                          5.sbW,
                          Icon(
                              PhosphorIcons
                                  .userFill,
                              size: 14.sp,
                              color:
                                  Pallete.redColor),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
