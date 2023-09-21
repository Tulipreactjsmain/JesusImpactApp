// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jimpact/features/profile/widgets/interest_selection_tile.dart';
import 'package:simple_notifier/simple_notifier.dart';

import 'package:jimpact/features/profile/views/join_community_view.dart';
import 'package:jimpact/theme/palette.dart';
import 'package:jimpact/utils/app_extensions.dart';
import 'package:jimpact/utils/nav.dart';
import 'package:jimpact/utils/widgets/appbar.dart';
import 'package:jimpact/utils/widgets/button.dart';

class InterestsSelectionView extends ConsumerStatefulWidget {
  const InterestsSelectionView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InterestsSelectionViewState();
}

class _InterestsSelectionViewState
    extends ConsumerState<InterestsSelectionView> {
  ValueNotifier<List<String>> selectedInterests = [''].notifier;
  List<String> selectedInterestss = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Your interests', context: context),
      body: SizedBox.expand(
        child: Padding(
          padding: 32.padH,
          child: Column(
            children: [
              30.sbH,
              'Welcome Broski'
                  .txt18(
                    color: Pallete.redColor,
                    fontWeightType: TxtFntWt.med,
                  )
                  .alignCenterLeft(),
              27.sbH,

              //! what
              'What are you interested in?'
                  .txt(
                    size: 32.sp,
                    colorType: TxtClrType.g41,
                    fontWeight: FontWeight.w300,
                  )
                  .alignCenterLeft(),
              14.sbH,

              //! select 5 more
              'Select one or more categories you are interested in'
                  .txt18(
                    colorType: TxtClrType.g78,
                    fontWeight: FontWeight.w300,
                  )
                  .alignCenterLeft(),

              48.sbH,
              // Align(
              //   alignment: Alignment.centerLeft,
              //   child: Wrap(
              //     spacing: 16.w,
              //     runSpacing: 16.h,
              //     children: [
              //       //! 1
              //       InkWell(
              //         splashColor: Colors.transparent,
              //         highlightColor: Colors.transparent,
              //         onTap: () {
              //           if (selectedInterestss.contains(interests[0])) {
              //             setState(() {
              //               selectedInterestss = [
              //                 ...selectedInterestss.where(
              //                     (interestt) => interestt != interests[0]),
              //               ];
              //             });
              //           } else {
              //             setState(() {
              //               selectedInterestss = [
              //                 interests[0],
              //                 ...selectedInterestss
              //               ];
              //             });
              //           }
              //         },
              //         child: Container(
              //           padding: EdgeInsets.symmetric(
              //               horizontal: 27.w, vertical: 12.h),
              //           decoration: BoxDecoration(
              //             color: selectedInterestss.contains(interests[0])
              //                 ? const Color(0xFFD03D2D)
              //                 : const Color(0xFFEDEDED),
              //             borderRadius: BorderRadius.circular(12.r),
              //           ),
              //           child: Row(
              //             mainAxisSize: MainAxisSize.min,
              //             children: [
              //               MyIcon(
              //                 icon: interests[0],
              //                 height: 16.6.h,
              //                 color: selectedInterestss.contains(interests[0])
              //                     ? Colors.white
              //                     : null,
              //               ),
              //               SizedBox(
              //                 width: 11.5.w,
              //               ),
              //               interests[0].toCapitalized().txt16(
              //                     color:
              //                         selectedInterestss.contains(interests[0])
              //                             ? Colors.white
              //                             : const Color(0xff545454),
              //                   )
              //             ],
              //           ),
              //         ),
              //       ),

              //       //! 2
              //       InkWell(
              //         splashColor: Colors.transparent,
              //         highlightColor: Colors.transparent,
              //         onTap: () {
              //           if (selectedInterestss.contains(interests[1])) {
              //             setState(() {
              //               selectedInterestss = [
              //                 ...selectedInterestss.where(
              //                     (interestt) => interestt != interests[1]),
              //               ];
              //             });
              //           } else {
              //             setState(() {
              //               selectedInterestss = [
              //                 interests[1],
              //                 ...selectedInterestss
              //               ];
              //             });
              //           }
              //         },
              //         child: Container(
              //           padding: EdgeInsets.symmetric(
              //               horizontal: 27.w, vertical: 12.h),
              //           decoration: BoxDecoration(
              //             color: selectedInterestss.contains(interests[1])
              //                 ? const Color(0xFFD03D2D)
              //                 : const Color(0xFFEDEDED),
              //             borderRadius: BorderRadius.circular(12.r),
              //           ),
              //           child: Row(
              //             mainAxisSize: MainAxisSize.min,
              //             children: [
              //               MyIcon(
              //                 icon: interests[1],
              //                 height: 16.6.h,
              //                 color: selectedInterestss.contains(interests[1])
              //                     ? Colors.white
              //                     : null,
              //               ),
              //               SizedBox(
              //                 width: 11.5.w,
              //               ),
              //               interests[1].toCapitalized().txt16(
              //                     color:
              //                         selectedInterestss.contains(interests[1])
              //                             ? Colors.white
              //                             : const Color(0xff545454),
              //                   )
              //             ],
              //           ),
              //         ),
              //       ),

              //       //! 3
              //       InkWell(
              //         splashColor: Colors.transparent,
              //         highlightColor: Colors.transparent,
              //         onTap: () {
              //           if (selectedInterestss.contains(interests[2])) {
              //             setState(() {
              //               selectedInterestss = [
              //                 ...selectedInterestss.where(
              //                     (interestt) => interestt != interests[2]),
              //               ];
              //             });
              //           } else {
              //             setState(() {
              //               selectedInterestss = [
              //                 interests[2],
              //                 ...selectedInterestss
              //               ];
              //             });
              //           }
              //         },
              //         child: Container(
              //           padding: EdgeInsets.symmetric(
              //               horizontal: 27.w, vertical: 12.h),
              //           decoration: BoxDecoration(
              //             color: selectedInterestss.contains(interests[2])
              //                 ? const Color(0xFFD03D2D)
              //                 : const Color(0xFFEDEDED),
              //             borderRadius: BorderRadius.circular(12.r),
              //           ),
              //           child: Row(
              //             mainAxisSize: MainAxisSize.min,
              //             children: [
              //               MyIcon(
              //                 icon: interests[2],
              //                 height: 16.6.h,
              //                 color: selectedInterestss.contains(interests[2])
              //                     ? Colors.white
              //                     : null,
              //               ),
              //               SizedBox(
              //                 width: 11.5.w,
              //               ),
              //               interests[2].toCapitalized().txt16(
              //                     color:
              //                         selectedInterestss.contains(interests[2])
              //                             ? Colors.white
              //                             : const Color(0xff545454),
              //                   )
              //             ],
              //           ),
              //         ),
              //       ),

              //       //! 4
              //       InkWell(
              //         splashColor: Colors.transparent,
              //         highlightColor: Colors.transparent,
              //         onTap: () {
              //           if (selectedInterestss.contains(interests[3])) {
              //             setState(() {
              //               selectedInterestss = [
              //                 ...selectedInterestss.where(
              //                     (interestt) => interestt != interests[3]),
              //               ];
              //             });
              //           } else {
              //             setState(() {
              //               selectedInterestss = [
              //                 interests[3],
              //                 ...selectedInterestss
              //               ];
              //             });
              //           }
              //         },
              //         child: Container(
              //           padding: EdgeInsets.symmetric(
              //               horizontal: 27.w, vertical: 12.h),
              //           decoration: BoxDecoration(
              //             color: selectedInterestss.contains(interests[3])
              //                 ? const Color(0xFFD03D2D)
              //                 : const Color(0xFFEDEDED),
              //             borderRadius: BorderRadius.circular(12.r),
              //           ),
              //           child: Row(
              //             mainAxisSize: MainAxisSize.min,
              //             children: [
              //               MyIcon(
              //                 icon: interests[3],
              //                 height: 16.6.h,
              //                 color: selectedInterestss.contains(interests[3])
              //                     ? Colors.white
              //                     : null,
              //               ),
              //               SizedBox(
              //                 width: 11.5.w,
              //               ),
              //               interests[3].toCapitalized().txt16(
              //                     color:
              //                         selectedInterestss.contains(interests[3])
              //                             ? Colors.white
              //                             : const Color(0xff545454),
              //                   )
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              selectedInterests.listen(
                builder: (context, value, child) => Wrap(
                  spacing: 16.w,
                  runSpacing: 16.h,
                  children: List.generate(
                    interests.length,
                    (index) => InterestSelectionTile(
                        interest: interests[index],
                        selectedInterests: selectedInterests),
                  ),
                ).alignCenterLeft(),
              ),

              200.sbH,
              ArrowButton(
                onTap: () {
                  goTo(context: context, view: const JoinCommunityView());
                },
                width: 160.w,
                text: 'Next',
              ).alignCenterLeft(),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> interests = [
  'faith',
  'love',
  'prayer',
  'resurrection',
];
