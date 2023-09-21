// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:jimpact/theme/palette.dart';
import 'package:jimpact/utils/app_extensions.dart';
import 'package:jimpact/utils/widgets/myicon.dart';

class InterestSelectionTile extends StatelessWidget {
  final ValueNotifier<List<String>> selectedInterests;
  final String interest;

  const InterestSelectionTile({
    Key? key,
    required this.selectedInterests,
    required this.interest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: switch (selectedInterests.value.contains(interest)) {
          true => Pallete.redColor,
          false => Pallete.boxGrey,
        },
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyIcon(
            icon: interest,
            height: 16.6.h,
            color: switch (selectedInterests.value.contains(interest)) {
              true => Pallete.whiteColor,
              false => null,
            },
          ),
          11.5.sbW,
          interest.toCapitalized().txt16(
                color: switch (selectedInterests.value.contains(interest)) {
                  true => Pallete.whiteColor,
                  false => Pallete.textBlack54,
                },
              )
        ],
      ),
    ).tap(
      onTap: () {
        if (selectedInterests.value.contains(interest)) {
          selectedInterests.value = [
            ...selectedInterests.value
                .where((interestt) => interestt != interest),
          ];
        } else {
          selectedInterests.value = [interest, ...selectedInterests.value];
        }
      },
    );
  }
}
