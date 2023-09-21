// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimpact/features/base_nav/wrapper/base_nav_controller.dart';
import 'package:jimpact/theme/palette.dart';
import 'package:jimpact/utils/app_extensions.dart';

class NavBarWidget extends ConsumerWidget {
  final Nav nav;
  const NavBarWidget({
    Key? key,
    required this.nav,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int indexFromController = ref.watch(baseNavControllerProvider);
    // if (nav.index > 2) {
    //   indexFromController = indexFromController + 1;
    // }
    return SizedBox(
      width: 50,
      child: Column(
        children: [
          //! ICON
          Icon(
            switch (indexFromController == nav.index) {
              true => nav.selectedIcon,
              false => nav.icon,
            },
            color: nav.index == 2
                ? Colors.transparent
                : switch (indexFromController == nav.index) {
                    true => Pallete.redColor,
                    false => Pallete.greyA7,
                  },
          ),

          // //! SPACER
          // 8.4.sbH,
        ],
      ),
    ).tap(
      onTap: () {
        if (nav.index == 2) {}

        moveToPage(
          context: context,
          ref: ref,
          index: nav.index,
        );
      },
    );
  }
}
