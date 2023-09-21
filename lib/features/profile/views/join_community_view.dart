import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jimpact/features/base_nav/wrapper/base_nav_wrapper.dart';
import 'package:jimpact/theme/palette.dart';
import 'package:jimpact/utils/app_extensions.dart';
import 'package:jimpact/utils/nav.dart';
import 'package:jimpact/utils/pop_overlay.dart';
import 'package:jimpact/utils/widgets/appbar.dart';
import 'package:jimpact/utils/widgets/button.dart';
import 'package:simple_notifier/simple_notifier.dart';

class JoinCommunityView extends ConsumerStatefulWidget {
  const JoinCommunityView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _JoinCommunityViewState();
}

class _JoinCommunityViewState extends ConsumerState<JoinCommunityView> {
  ValueNotifier<List<String>> selectedComms = [''].notifier;

  @override
  Widget build(BuildContext context) {
    PopUpOverlay? overlay = ref.watch(toggleOverlayControllerProvider);
    return Stack(
      children: [
        Scaffold(
          appBar: customAppBar('My community', context: context),
          body: SizedBox.expand(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              child: Padding(
                padding: 32.padH,
                child: Column(
                  children: [
                    30.sbH,

                    //! what
                    'What groups would you like to join?'
                        .txt(
                          size: 32.sp,
                          colorType: TxtClrType.g41,
                          fontWeight: FontWeight.w300,
                        )
                        .alignCenterLeft(),
                    14.sbH,

                    //! join
                    'Join 3 or more groups you are interested in'
                        .txt18(
                          colorType: TxtClrType.g78,
                          fontWeight: FontWeight.w300,
                        )
                        .alignCenterLeft(),

                    60.sbH,
                    selectedComms.listen(
                      builder: (context, value, child) => SizedBox(
                        height: 400,
                        child: GridView(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: (170 / 110).h,
                            mainAxisSpacing: 26.h,
                            crossAxisSpacing: 24.w,
                          ),
                          children: List.generate(
                            communities.length,
                            (index) => Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 27.w, vertical: 12.h),
                              decoration: BoxDecoration(
                                color: switch (selectedComms.value
                                    .contains(communities[index])) {
                                  true => Pallete.redColor,
                                  false => Pallete.boxGrey,
                                },
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // MyIcon(
                                  //   icon: communities[index],
                                  //   height: 16.6.h,
                                  //   color: switch (selectedComms.value
                                  //       .contains(communities[index])) {
                                  //     true => Pallete.whiteColor,
                                  //     false => null,
                                  //   },
                                  // ),
                                  // 11.5.sbW,
                                  communities[index].toCapitalized().txt16(
                                        color: switch (selectedComms.value
                                            .contains(communities[index])) {
                                          true => Pallete.whiteColor,
                                          false => Pallete.textBlack54,
                                        },
                                      )
                                ],
                              ),
                            ).tap(onTap: () {
                              if (selectedComms.value
                                  .contains(communities[index])) {
                                selectedComms.value = [
                                  ...selectedComms.value.where(
                                      (comm) => comm != communities[index]),
                                ];
                              } else {
                                selectedComms.value = [
                                  communities[index],
                                  ...selectedComms.value
                                ];
                              }
                            }),
                          ),
                        ).alignCenterLeft(),
                      ),
                    ),

                    110.sbH,
                    ArrowButton(
                      onTap: () {
                        goTo(context: context, view: const BaseNavWrapper());
                      },
                      width: 160.w,
                      text: 'Next',
                    ).alignCenterLeft(),
                    60.sbH,
                  ],
                ),
              ),
            ),
          ),
        ),
        if (overlay != null)
          PopUpOverLayWidget(
            overlay: overlay,
            onButtonTap: () {},
          ),
      ],
    );
  }
}

List<String> communities = [
  'Resurrection',
  'Love',
  'Music',
  'Justice',
  'Politics',
  'Peace',
];
