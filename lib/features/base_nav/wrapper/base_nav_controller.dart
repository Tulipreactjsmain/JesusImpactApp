import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimpact/features/groups/views/explore_connect_groups_view.dart';
import 'package:jimpact/features/home/views/home_feed_view.dart';
import 'package:jimpact/features/notifications/views/notifications_view.dart';
import 'package:jimpact/features/profile/views/profile_view.dart';
import 'package:jimpact/features/search/views/search_view.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

///! the state notifier provider for controlling the state of the base nav wrapper
final baseNavControllerProvider =
    StateNotifierProvider<BaseNavController, int>((ref) {
  return BaseNavController();
});

//! the state notifier class for controlling the state of the base nav wrapper
class BaseNavController extends StateNotifier<int> {
  BaseNavController() : super(0);

  //! move to page
  void moveToPage({required int index}) {
    state = index;
  }
}

//! () => move to page
void moveToPage({
  required BuildContext context,
  required WidgetRef ref,
  required int index,
}) {
  ref.read(baseNavControllerProvider.notifier).moveToPage(index: index);
}

//! List of pages
List<Widget> pages = [
  const HomeFeedView(),
  const SearchView(),
  const ExploreConnectedGroupsView(),
  const NotificationsView(),
  const ProfileView(),
];

//! nav widget enums
enum Nav {
  home(PhosphorIcons.houseSimpleBold, PhosphorIcons.houseSimpleFill),
  search(PhosphorIcons.magnifyingGlassBold, PhosphorIcons.magnifyingGlassBold),
  connect(PhosphorIcons.pen, PhosphorIcons.pen),
  notification(PhosphorIcons.notificationBold, PhosphorIcons.notificationFill),
  profile(PhosphorIcons.userBold, PhosphorIcons.userFill);

  const Nav(
    this.icon,
    this.selectedIcon,
  );
  final IconData icon;
  final IconData selectedIcon;
}

List<Nav> nav = [
  Nav.home,
  Nav.search,
  Nav.connect,
  Nav.notification,
  Nav.profile,
];
