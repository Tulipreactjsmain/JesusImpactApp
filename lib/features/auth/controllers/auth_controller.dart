// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_field
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimpact/cache/token_cache.dart';
import 'package:jimpact/features/auth/repositories/auth_repository.dart';
import 'package:jimpact/features/base_nav/wrapper/base_nav_wrapper.dart';
import 'package:jimpact/models/tokens/token_model.dart';
import 'package:jimpact/models/user/user_model.dart';
import 'package:jimpact/utils/app_extensions.dart';
import 'package:jimpact/utils/failure.dart';
import 'package:jimpact/utils/nav.dart';
import 'package:jimpact/utils/type_defs.dart';

import '../../../utils/snack_bar.dart';

//!

//! the user state provider
final userProvider = StateProvider<UserModel?>((ref) => null);

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);

  Future<void> initialize() async {
    'authstate initialized'.log();
  }

  Future<bool> getToken() async {
    bool isToken = false;
    //! FETCH USER TOKEN
    final Iterable<UserToken?> userToken = await TokenCache.getUserTokens();

    userToken.first!.accessToken!.log();

    if (userToken.first!.accessToken != null) {
      isToken = true;
    }

    return isToken;
  }

  //! sign up user
  Future<void> signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String username,
    required void Function()? onTap,
  }) async {
    state = true;

    final response = await _authRepository.signUpUser(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      username: username,
    );

    state = false;
    response.fold(
      (Failure l) => showBanner(
        context: context,
        theMessage: l.message,
        theType: NotificationType.failure,
      ),
      (bool result) {
        onTap!.call();
      },
    );
  }

  // //! login user
  Future<void> loginUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    state = true;
    final response = await _authRepository.loginUser(
      email: email,
      password: password,
    );

    state = false;
    response.fold(
      (Failure l) => showBanner(
        context: context,
        theMessage: l.message,
        theType: NotificationType.failure,
      ),
      (String result) {
        result.log();
        goTo(
          view: const BaseNavWrapper(),
          context: context,
        );
      },
    );
  }

  // //! get user data
  // Future<void> getUserData({required BuildContext context}) async {
  //   state = true;
  //   final response = await _authRepository.getUserData();

  //   state = false;
  //   response.fold(
  //     (Failure l) => showBanner(
  //       context: context,
  //       theMessage: l.message,
  //       theType: NotificationType.failure,
  //     ),
  //     (UserModel user) {
  //       'user updated successfully'.log();
  //       _ref.read(userProvider.notifier).update((state) => user);
  //     },
  //   );
  // }
}
