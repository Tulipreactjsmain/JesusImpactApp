import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimpact/features/auth/controllers/auth_controller.dart';
import 'package:jimpact/features/profile/repositories/profile_repository.dart';
import 'package:jimpact/utils/app_extensions.dart';
import 'package:jimpact/utils/snack_bar.dart';
import 'package:jimpact/utils/type_defs.dart';

class ProfileController extends StateNotifier<bool> {
  final ProfileRepository _profileRepository;
  final Ref _ref;
  ProfileController({
    required ProfileRepository profileRepository,
    required Ref ref,
  })  : _profileRepository = profileRepository,
        _ref = ref,
        super(false);

  //! update username
  void updateUsername({
    required String username,
    void Function()? leftSideEffect,
    void Function()? rightSideEffect,
    required BuildContext context,
    required bool isPassword,
  }) async {
    state = true;
    final res = await _profileRepository.updateUserName(
      username: username,
      isPassword: isPassword,
    );

    state = false;

    res.fold(
      (l) {
        l.message.log();
        showBanner(
          context: context,
          theMessage: l.message,
          theType: NotificationType.failure,
        );
      },
      (r) {
        r.userName!.log();
        rightSideEffect!.call();
        showBanner(
          context: context,
          theMessage: isPassword
              ? 'Password updated successfully'
              : 'Username updated successfully',
          theType: NotificationType.success,
        );
        _ref.read(userProvider.notifier).update((state) => r);
      },
    );
  }
}
