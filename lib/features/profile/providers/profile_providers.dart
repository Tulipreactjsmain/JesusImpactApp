import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimpact/features/profile/controllers/profile_controller.dart';
import 'package:jimpact/features/profile/repositories/profile_repository.dart';

//! the profile repository provider
Provider<ProfileRepository> profileRepositoryProvider = Provider((ref) {
  return const ProfileRepository();
});

//! the provider for the profile controller
StateNotifierProvider<ProfileController, bool> profileControllerProvider =
    StateNotifierProvider((ref) {
  ProfileRepository profileRepository = ref.watch(profileRepositoryProvider);
  return ProfileController(
    profileRepository: profileRepository,
    ref: ref,
  );
});
