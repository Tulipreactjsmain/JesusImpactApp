import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jimpact/theme/palette.dart';
import 'package:jimpact/utils/app_constants.dart';
import 'package:jimpact/utils/app_extensions.dart';

class NotificationsView extends ConsumerWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: height(context),
      width: width(context),
      child: Stack(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: 20,
            padding:
                EdgeInsets.symmetric(horizontal: 34.w).copyWith(top: 160.h),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 33.h),
                child: SizedBox(
                  height: 50.h,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25.h,
                      ),
                      17.sbW,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //! name
                          Row(
                            children: [
                              'Tony Stark'.txt16(
                                  fontWeightType: TxtFntWt.bold,
                                  color: Pallete.redColor),
                              ' followed you'.txt16(
                                fontWeightType: TxtFntWt.sBold,
                                colorType: TxtClrType.g54,
                              ),
                            ],
                          ),
                          2.sbH,

                          //! username
                          '5m'.txt14(
                            colorType: TxtClrType.g54,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          //! header
          Container(
            height: 125.h,
            width: width(context),
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: 34.w)
                .copyWith(bottom: 7.h, top: 66.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                'Notifications'.txt(
                  size: 22.sp,
                  fontWeightType: TxtFntWt.med,
                  colorType: TxtClrType.g41,
                ),
                'Clear'.txt(
                  size: 17.sp,
                  fontWeightType: TxtFntWt.med,
                  color: Pallete.greyA7,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
