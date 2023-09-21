// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/num_duration_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:jimpact/theme/palette.dart';
import 'package:jimpact/utils/app_constants.dart';
import 'package:jimpact/utils/app_extensions.dart';
import 'package:jimpact/utils/widgets/button.dart';

final toggleOverlayControllerProvider =
    StateNotifierProvider<ToggleOverlayController, PopUpOverlay?>((ref) {
  return ToggleOverlayController();
});

//! the state notitfier class for toggling the overlay
class ToggleOverlayController extends StateNotifier<PopUpOverlay?> {
  ToggleOverlayController() : super(null);

  //! show
  void showPopUpOverLay({required PopUpOverlay overlay}) {
    state = overlay;
  }

  //! remove
  void removePopUpOverLay() {
    state = null;
  }
}

//! () => toggleOverlay
void showPopUpOverLay({
  required BuildContext context,
  required WidgetRef ref,
  required PopUpOverlay overlay,
}) {
  ref
      .read(toggleOverlayControllerProvider.notifier)
      .showPopUpOverLay(overlay: overlay);
}

void removePopUpOverLay({
  required BuildContext context,
  required WidgetRef ref,
}) {
  ref.read(toggleOverlayControllerProvider.notifier).removePopUpOverLay();
}

class PopUpOverlay {
  final String? image;
  final String? title;
  final String? description;
  final String? buttonText;

  const PopUpOverlay({
    required this.image,
    required this.title,
    required this.description,
    this.buttonText,
  });
}

class PopUpOverLayWidget extends ConsumerWidget {
  final PopUpOverlay? overlay;
  final void Function()? onButtonTap;
  const PopUpOverLayWidget({
    super.key,
    required this.overlay,
    this.onButtonTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      elevation: 0,
      color: Colors.transparent,
      child: SizedBox(
        height: height(context),
        width: width(context),
        child: Center(
          child: Container(
            width: width(context) * 0.8,
            padding: EdgeInsets.symmetric(
              horizontal: 42.w,
              vertical: 50.h,
            ),
            decoration: BoxDecoration(
              color: Pallete.whiteColor,
              borderRadius: BorderRadius.circular(25.r),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(1, 1),
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (overlay!.image!.isNotEmpty)
                  Column(
                    children: [
                      overlay!.image!.png.myImage(),
                      55.sbH,
                    ],
                  ),
                overlay!.title!.txt(
                  size: 22.sp,
                  fontWeightType: TxtFntWt.sBold,
                  colorType: TxtClrType.g54,
                ),
                20.sbH,
                overlay!.description!.txt16(
                    fontWeight: FontWeight.w300,
                    colorType: TxtClrType.g78,
                    textAlign: TextAlign.center),
                54.sbH,
                ArrowButton(
                  width: 150,
                  onTap: () {
                    removePopUpOverLay(context: context, ref: ref);
                    if (onButtonTap != null) {
                      onButtonTap!.call();
                    }
                  },
                  text: overlay!.buttonText ?? 'Proceed',
                ),
              ],
            ),
          ).fadeInFromBottom(
            delay: 100.ms,
            animatiomDuration: 100.ms,
          ),
        ),
      ).fadeIn(delay: 0.ms, animatiomDuration: 100.ms),
    );
  }
}
