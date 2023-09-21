import 'package:jimpact/features/auth/controllers/auth_controller.dart';
import 'package:jimpact/features/auth/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//! the auth repo provider
final Provider<AuthRepository> authRepositoryProvider =
    Provider((ref) => const AuthRepository());

//! the auth controller provider
final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    return AuthController(
      authRepository: authRepository,
      ref: ref,
    );
  },
);

//! the get token provider
final getTokenProvider = FutureProvider<bool>((ref) async {
  final authController = ref.watch(authControllerProvider.notifier);
  // await authController.initialize();
  return authController.getToken();
});
