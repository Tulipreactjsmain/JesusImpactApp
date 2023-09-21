import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jimpact/features/home/widgets/search_bar.dart';
import 'package:jimpact/theme/palette.dart';
import 'package:jimpact/utils/app_constants.dart';
import 'package:jimpact/utils/app_extensions.dart';
import 'package:jimpact/utils/widgets/appbar.dart';
import 'package:jimpact/utils/widgets/button.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class OpenGroupsView extends ConsumerWidget {
  const OpenGroupsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: customAppBar('', context: context),
      body: SizedBox(
        height: height(context),
        width: width(context),
        child: Padding(
          padding: 34.padH,
          child: Column(
            children: [
              15.sbH,

              //! title
              'Open Groups'
                  .txt(
                    size: 32.sp,
                    colorType: TxtClrType.g41,
                    fontWeight: FontWeight.w300,
                  )
                  .alignCenterLeft(),
              14.sbH,

              //! connect with
              'Connect with other with similar interest by joining any of the open or closed connect groups'
                  .txt16(
                    colorType: TxtClrType.g78,
                    fontWeight: FontWeight.w300,
                  )
                  .alignCenterLeft(),
              48.sbH,
              const SearchBarr(),

              42.sbH,
              SizedBox(
                height: 500.h,
                child: GridView.builder(
                  itemCount: 8,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: (170 / 260).h,
                    mainAxisSpacing: 24.h,
                    crossAxisSpacing: 14.w,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
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
                            height: 300.h,
                            width: 200.w,
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
                                    'For Her'.txt16(
                                      fontWeightType: TxtFntWt.med,
                                      color: Pallete.whiteColor,
                                    ),
                                    3.sbH,
                                    Row(
                                      children: [
                                        Icon(PhosphorIcons.userFill,
                                            size: 14.sp,
                                            color: Pallete.whiteColor),
                                        6.6.sbW,
                                        '12 Members'.txt(
                                            size: 14.sp,
                                            fontWeight: FontWeight.w300,
                                            color: Pallete.whiteColor),
                                        5.sbW,
                                      ],
                                    ),
                                    8.sbH,
                                    BButton(
                                      onTap: () {},
                                      height: 26.h,
                                      width: 50.w,
                                      radius: 5.r,
                                      isText: false,
                                      item: 'Join'.txt(
                                          size: 15.sp,
                                          color: Pallete.whiteColor),
                                    ),
                                    22.sbH,
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ).alignCenterLeft(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
