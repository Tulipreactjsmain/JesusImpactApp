import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jimpact/theme/palette.dart';
import 'package:jimpact/utils/app_extensions.dart';
import 'package:jimpact/utils/widgets/appbar.dart';
import 'package:simple_notifier/simple_notifier.dart';

class FAQsView extends ConsumerStatefulWidget {
  const FAQsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FAQsViewState();
}

class _FAQsViewState extends ConsumerState<FAQsView> {
  ValueNotifier<int> openIndex = 0.notifier;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.bgGreyFB,
      appBar: customAppBar('', context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: 32.padH,
          child: Column(
            children: [
              30.sbH,

              //! what
              'FAQs'
                  .txt(
                    size: 32.sp,
                    colorType: TxtClrType.g41,
                    fontWeight: FontWeight.w300,
                  )
                  .alignCenterLeft(),
              36.sbH,

              openIndex.listen(
                builder: (context, value, child) => Column(
                  children: List.generate(
                    5,
                    (index) => AnimatedContainer(
                      duration: 300.ms,
                      width: double.infinity,
                      height: openIndex.value == index ? 318.h : 56.h,
                      padding: EdgeInsets.all(20.w),
                      margin: EdgeInsets.only(bottom: 37.h),
                      decoration: BoxDecoration(
                        color: Pallete.textInputFillGreyEE,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                'How do I join a Group?'.txt(
                                  size: 20.sp,
                                  color: openIndex.value == index
                                      ? Pallete.redColor
                                      : Pallete.textBlack54,
                                ),
                                Icon(openIndex.value == index
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down),
                              ],
                            ),
                            29.sbH,
                            'Lorem ipsum dolor sit amet, @consetetur sadipscing elitr, orem ipsum dolor sit amet, @consetetur sadipscing elitr, sed diam nonumy elitr eirmod dolor sit amet. sadipscing elitr, sed diam nonumy elitr eirmod dolor sit amet.sesed diam nonumy elitr eirmod dolor sit amet. sadipscing elitr, sed diam nonumy elitr eirmod dolor sit amet.setetur sadipscing elitr, sed diam nonumy elitr eirmod '
                                .txt16(
                              colorType: TxtClrType.g54,
                              fontWeight: FontWeight.w300,
                            ),
                          ],
                        ),
                      ),
                    ).tap(onTap: () {
                      openIndex.value = index;
                    }),
                  ),
                ),
              ),
              40.sbH,
            ],
          ),
        ),
      ),
    );
  }
}
