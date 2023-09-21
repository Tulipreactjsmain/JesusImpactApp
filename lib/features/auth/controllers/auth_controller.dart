// ignore_for_file: public_member_api_docs, sort_constructors_first
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
      (bool user) {
        // _ref.read(userProvider.notifier).update((state) => user);
        onTap!.call();
        // goTo(context, const LegalTermsView());
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
      (UserModel user) {
        _ref.read(userProvider.notifier).update((state) => user);
        //! update time for auth rotation
        // _ref.read(authRotationControllerProvider.notifier).countTime();

        // user.firstName!.log();
        goTo(
          view: const BaseNavWrapper(),
          context: context,
        );
      },
    );
  }

  // //! send sms otp
  // Future<void> sendSMSOTP({
  //   required BuildContext context,
  //   required String phoneNumber,
  // }) async {
  //   state = true;
  //   final response = await _authRepository.sendSMSOTP(
  //     phoneNumber: phoneNumber,
  //   );

  //   state = false;
  //   response.fold(
  //     (Failure l) => showBanner(
  //       context: context,
  //       theMessage: l.message,
  //       theType: NotificationType.failure,
  //     ),
  //     (String successMessage) {
  //       goTo(
  //         context,
  //         VerificationView(
  //           phoneNUmber: phoneNumber,
  //         ),
  //       );
  //     },
  //   );
  // }

  // //! verify sms otp
  // Future<void> verifySMSOTP({
  //   required BuildContext context,
  //   required String phoneNumber,
  //   required String oTP,
  //   required void Function()? onTap,
  // }) async {
  //   state = true;
  //   final response = await _authRepository.verifySMSOTP(
  //     phoneNumber: phoneNumber,
  //     oTP: oTP,
  //   );

  //   state = false;
  //   response.fold(
  //     (Failure l) => showBanner(
  //       context: context,
  //       theMessage: l.message,
  //       theType: NotificationType.failure,
  //     ),
  //     (String successMessage) async {
  //       UserModel? user = _ref.read(userProvider);
  //       user!.firstName!.toString().log();
  //       user = user.copyWith(
  //         phoneNumber: phoneNumber,
  //         verifiedPhone: true,
  //       );
  //       // ErrorModel? errorModel;

  //       // print(user.lastName!.toString());

  //       // errorModel = await _ref.read(authRepositoryProvider).getUserData();

  //       // _ref.read(userProvider.notifier).update((state) => errorModel!.data);

  //       await _ref.read(profileControllerProvider.notifier).updateUserInfo(
  //             context: context,
  //             user: user,
  //           );

  //       'otp success'.log();

  //       // showBanner(
  //       //   context: context,
  //       //   theMessage: successMessage,
  //       //   theType: NotificationType.success,
  //       // );
  //       onTap!.call();
  //     },
  //   );
  // }

  // //! send email otp
  // Future<void> sendEmailOTP({
  //   required BuildContext context,
  //   required String email,
  // }) async {
  //   state = true;
  //   final response = await _authRepository.sendEmailOTP(
  //     email: email,
  //   );

  //   state = false;
  //   response.fold(
  //     (Failure l) => showBanner(
  //       context: context,
  //       theMessage: l.message,
  //       theType: NotificationType.failure,
  //     ),
  //     (String successMessage) {
  //       goTo(
  //         context,
  //         EmailOTPView(email: email),
  //       );
  //       showBanner(
  //         context: context,
  //         theMessage: successMessage.toTitleCase(),
  //         theType: NotificationType.info,
  //       );
  //     },
  //   );
  // }

  // //! verify email otp
  // Future<void> verifyEmailOTP({
  //   required BuildContext context,
  //   required String email,
  //   required String oTP,
  // }) async {
  //   state = true;
  //   final response = await _authRepository.verifyEmailOTP(
  //     email: email,
  //     oTP: oTP,
  //   );

  //   state = false;
  //   response.fold(
  //     (Failure l) => showBanner(
  //       context: context,
  //       theMessage: l.message,
  //       theType: NotificationType.failure,
  //     ),
  //     (String token) async {
  //       goTo(
  //         context,
  //         PasswordSettingsView(token: token),
  //       );
  //     },
  //   );
  // }

  // //! chnage password
  // Future<void> changePassword({
  //   required BuildContext context,
  //   required String password,
  //   required String token,
  // }) async {
  //   state = true;
  //   final response = await _authRepository.changePassword(
  //     password: password,
  //     token: token,
  //   );

  //   state = false;
  //   response.fold(
  //     (Failure l) {
  //       goTo(
  //         context,
  //         PasswordFailureView(messsage: l.message),
  //       );
  //     },
  //     (String token) {
  //       goTo(
  //         context,
  //         const PasswordUpdateSuccessView(),
  //       );
  //     },
  //   );
  // }

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
