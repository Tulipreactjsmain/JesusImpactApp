import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jimpact/theme/palette.dart';
import 'package:jimpact/utils/app_extensions.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class TopBlogCard extends StatelessWidget {
  const TopBlogCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 370.h,
      width: 400.w,
      decoration: BoxDecoration(
        color: Pallete.blackColor,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Placeholder(
              color: Pallete.textInputFillGreyEE,
            ),
          ),
          Container(
            height: 370.h,
            width: 400.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.5),
                  Colors.black
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //! title
              Padding(
                padding: 16.padH,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    'Christain teenagers and the Sex conversation'.txt(
                      size: 22.sp,
                      fontWeightType: TxtFntWt.med,
                      color: Colors.white,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    8.sbH,
                    'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed'
                        .txt14(
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    16.sbH,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        'Jesus Impact'.txt(
                            size: 10.sp,
                            fontWeightType: TxtFntWt.med,
                            color: Pallete.redColor),
                        Row(
                          children: [
                            '12'.txt(
                              size: 12.sp,
                              fontWeightType: TxtFntWt.med,
                              color: Pallete.redColor,
                            ),
                            5.sbW,
                            Icon(PhosphorIcons.userFill,
                                size: 14.sp, color: Pallete.redColor),
                          ],
                        ),
                      ],
                    ),
                    21.sbH,
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
