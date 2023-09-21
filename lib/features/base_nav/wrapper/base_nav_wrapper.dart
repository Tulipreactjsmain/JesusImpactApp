import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jimpact/features/base_nav/widgets/nav_bar_widget.dart';
import 'package:jimpact/features/base_nav/wrapper/base_nav_controller.dart';
import 'package:jimpact/features/base_nav/wrapper/side_nav_drawer.dart';
import 'package:jimpact/theme/palette.dart';
import 'package:jimpact/utils/app_constants.dart';
import 'package:jimpact/utils/app_extensions.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BaseNavWrapper extends ConsumerWidget {
  const BaseNavWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int indexFromController = ref.watch(baseNavControllerProvider);
    return Scaffold(
      backgroundColor: Pallete.bgGreyFB,
      drawer: const NavDrawer(),
      // pages
      body: Stack(
        children: [
          pages[indexFromController],
          switch (indexFromController == 0 || indexFromController == 4) {
            true => Positioned(
                right: 34.w,
                top: 75.h,
                child: Builder(builder: (context) {
                  return SizedBox(
                    height: 32.h,
                    width: 32.h,
                  ).tap(onTap: () {
                    Scaffold.of(context).openDrawer();
                  });
                }),
              ),
            false => const SizedBox.shrink(),
          }
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          20.sbH,
          CircleAvatar(
            radius: 30.h,
            backgroundColor: Pallete.redColor,
            child: const Icon(
              PhosphorIcons.usersFill,
              color: Pallete.whiteColor,
            ),
          ).tap(
            onTap: () => moveToPage(
              context: context,
              ref: ref,
              index: 2,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // nav bar
      bottomNavigationBar: Material(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(top: 26.h, left: 32.w, right: 32.w),
          decoration: BoxDecoration(
            color: Pallete.greyPinkF2,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(45.r),
              topRight: Radius.circular(45.r),
            ),
          ),
          height: 80,
          width: width(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              nav.length,
              (index) => NavBarWidget(nav: nav[index]),
            ),
          ),
        ),
      ),
    );
  }
}


