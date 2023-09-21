// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jimpact/features/auth/views/choose_auth_route_view.dart';
import 'package:jimpact/features/base_nav/wrapper/base_nav_controller.dart';
import 'package:jimpact/features/blogs/views/blogs_view.dart';
import 'package:jimpact/features/help/views/contact_us_view.dart';
import 'package:jimpact/features/help/views/help_view.dart';
import 'package:jimpact/features/profile/views/edit_profile_view.dart';
import 'package:jimpact/features/settings/views/settings_view.dart';

import 'package:jimpact/theme/palette.dart';
import 'package:jimpact/utils/app_extensions.dart';
import 'package:jimpact/utils/nav.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class NavDrawer extends ConsumerWidget {
  const NavDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      backgroundColor: Pallete.whiteColor,
      width: 350.w,
      child: Column(
        children: [
          93.sbH,
          Padding(
            padding: EdgeInsets.only(left: 34.w),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 33.h,
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
              ],
            ),
          ),
          50.sbH,

          //! first set
          Padding(
            padding: EdgeInsets.only(left: 26.w),
            child: Column(
              children: List.generate(
                sideNavItems1.length,
                (index) => ListTile(
                  onTap: () {
                    switch (index) {
                      case 0:
                        goTo(context: context, view: const EditProfileView());
                        break;
                      case 1:
                        goTo(context: context, view: const BlogsView());
                        break;
                      case 2:
                        moveToPage(context: context, ref: ref, index: 2);
                        goBack(context);
                        break;
                      case 3:
                        goTo(context: context, view: const SettingsView());
                        break;
                      default:
                    }
                  },
                  leading: Icon(
                    sideNavItems1[index].icon,
                    size: 23.sp,
                    color: Pallete.greyA7,
                  ),
                  title: sideNavItems1[index].title.txt(
                        size: 16.sp,
                        colorType: TxtClrType.g54,
                      ),
                ),
              ),
            ),
          ),

          Padding(
            padding: 10.padV,
            child: const Divider(
              thickness: 0.5,
            ),
          ),

          //! second set
          Padding(
            padding: EdgeInsets.only(left: 26.w),
            child: Column(
              children: List.generate(
                sideNavItems2.length,
                (index) => ListTile(
                  onTap: () {
                    switch (index) {
                      case 0:
                        goTo(context: context, view: const HelpView());
                        break;
                      case 2:
                        goTo(context: context, view: const ContactUsView());
                        break;
                      case 3:
                        goTo(context: context, view: const ChooseAuthRouteView());
                        break;
                      default:
                    }
                  },
                  leading: Icon(
                    sideNavItems2[index].icon,
                    size: 23.sp,
                    color: sideNavItems2[index].title == 'Log out'
                        ? Pallete.redColor
                        : Pallete.greyA7,
                  ),
                  title: sideNavItems2[index].title.txt(
                        size: 16.sp,
                        color: sideNavItems2[index].title == 'Log out'
                            ? Pallete.redColor
                            : Pallete.textBlack54,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SideNavItem {
  final IconData icon;
  final String title;
  const SideNavItem({
    required this.icon,
    required this.title,
  });
}

List<SideNavItem> sideNavItems1 = const [
  SideNavItem(icon: PhosphorIcons.penFill, title: 'Edit Profile'),
  SideNavItem(icon: PhosphorIcons.bookFill, title: 'Blogs'),
  SideNavItem(icon: PhosphorIcons.usersFill, title: 'Connect Groups'),
  SideNavItem(icon: PhosphorIcons.gearFill, title: 'Settings'),
];

List<SideNavItem> sideNavItems2 = const [
  SideNavItem(icon: PhosphorIcons.questionFill, title: 'Help'),
  SideNavItem(icon: PhosphorIcons.moneyFill, title: 'Donate'),
  SideNavItem(icon: PhosphorIcons.phoneFill, title: 'Contact us'),
  SideNavItem(icon: PhosphorIcons.power, title: 'Log out'),
];
