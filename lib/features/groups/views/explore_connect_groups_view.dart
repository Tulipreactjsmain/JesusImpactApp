import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jimpact/features/groups/views/open_group_view.dart';
import 'package:jimpact/features/home/widgets/search_bar.dart';
import 'package:jimpact/utils/nav.dart';
import 'package:jimpact/utils/widgets/button.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:jimpact/theme/palette.dart';
import 'package:jimpact/utils/app_constants.dart';
import 'package:jimpact/utils/app_extensions.dart';

class ExploreConnectedGroupsView extends ConsumerWidget {
  const ExploreConnectedGroupsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: height(context),
      width: width(context),
      child: Stack(
        children: [
          //! body
          SizedBox(
            height: height(context),
            width: width(context),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: Column(
                children: [
                  170.sbH,
                  Padding(
                    padding: 34.padH,
                    child: 'Explore Connect Groups'
                        .txt(
                          size: 30.sp,
                          fontWeight: FontWeight.w300,
                          colorType: TxtClrType.g41,
                        )
                        .alignCenterLeft(),
                  ),
                  16.sbH,
                  Padding(
                    padding: 34.padH,
                    child:
                        'Connect with other with similar interest by joining any of the open or closed connect groups'
                            .txt16(
                                fontWeight: FontWeight.w300,
                                colorType: TxtClrType.g78),
                  ),
                  48.sbH,

                  //! search
                  Padding(padding: 34.padH, child: const SearchBarr()),
                  42.sbH,

                  //! open group
                  Padding(
                    padding: 34.padH,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        'Open Groups'.txt(
                          size: 17.sp,
                          fontWeightType: TxtFntWt.med,
                          color: Pallete.greyA7,
                        ),
                        'View All'
                            .txt(
                          size: 17.sp,
                          fontWeightType: TxtFntWt.med,
                          color: Pallete.redColor,
                        )
                            .tap(onTap: () {
                          goTo(context: context, view: const OpenGroupsView());
                        }),
                      ],
                    ),
                  ),
                  17.sbH,

                  //! open groups list view
                  SizedBox(
                    height: 260.h,
                    width: double.infinity,
                    child: ListView.builder(
                      padding: EdgeInsets.only(left: 34.w, right: 17.w),
                      scrollDirection: Axis.horizontal,
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 260.h,
                          width: 170.w,
                          margin: EdgeInsets.only(right: 16.w),
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
                                height: 260.h,
                                width: 170.w,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                    ),
                  ),

                  46.sbH,

                  //! closed group
                  Padding(
                    padding: 34.padH,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        'Closed Groups'.txt(
                          size: 17.sp,
                          fontWeightType: TxtFntWt.med,
                          color: Pallete.greyA7,
                        ),
                        'View All'
                            .txt(
                          size: 17.sp,
                          fontWeightType: TxtFntWt.med,
                          color: Pallete.redColor,
                        )
                            .tap(onTap: () {
                          goTo(context: context, view: const OpenGroupsView());
                        }),
                      ],
                    ),
                  ),
                  17.sbH,

                  //! closed groups list view
                  SizedBox(
                    height: 260.h,
                    width: double.infinity,
                    child: ListView.builder(
                      padding: EdgeInsets.only(left: 34.w, right: 17.w),
                      scrollDirection: Axis.horizontal,
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 260.h,
                          width: 170.w,
                          margin: EdgeInsets.only(right: 16.w),
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
                                height: 260.h,
                                width: 170.w,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                    ),
                  ),
                  60.sbH,
                ],
              ),
            ),
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
                Container(
                  height: 31.h,
                  width: 31.h,
                  decoration: BoxDecoration(
                      color: Pallete.redColor,
                      borderRadius: BorderRadius.circular(7.r)),
                ),

                //!
                Row(
                  children: [
                    CircleAvatar(
                      radius: 13.h,
                      backgroundColor: Pallete.redColor,
                      child: Icon(
                        PhosphorIcons.plusBold,
                        size: 20.sp,
                        color: Pallete.whiteColor,
                      ),
                    ),
                    42.sbW,
                    const Icon(
                      PhosphorIcons.listBold,
                      color: Pallete.textBlack54,
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
