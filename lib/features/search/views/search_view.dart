import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jimpact/features/home/widgets/search_bar.dart';
import 'package:jimpact/utils/app_constants.dart';
import 'package:jimpact/utils/app_extensions.dart';
import 'package:jimpact/utils/widgets/button.dart';

class SearchView extends ConsumerWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: height(context),
      width: width(context),
      child: Padding(
        padding: 34.padH,
        child: Column(
          children: [
            90.sbH,
            const SearchBarr(),
            36.sbH,
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 20,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 33.h),
                    child: SizedBox(
                      height: 50.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
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
                                  'Name Surname'.txt16(
                                    fontWeightType: TxtFntWt.med,
                                    colorType: TxtClrType.g54,
                                  ),
                                  2.sbH,

                                  //! username
                                  '@username'.txt(
                                    size: 13.sp,
                                    colorType: TxtClrType.g54,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          //! follow button
                          BButton(
                            onTap: () {},
                            height: 34.h,
                            width: 85.w,
                            radius: 5.r,
                            text: 'Follow',
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
