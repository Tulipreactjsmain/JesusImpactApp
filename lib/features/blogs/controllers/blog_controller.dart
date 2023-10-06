// ignore_for_file: unused_field
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimpact/features/auth/controllers/auth_controller.dart';
import 'package:jimpact/features/blogs/repositories/blog_repository.dart';
import 'package:jimpact/models/blogs/blog_model.dart';
import 'package:jimpact/models/user/user_model.dart';
import 'package:jimpact/utils/app_extensions.dart';
import 'package:jimpact/utils/snack_bar.dart';
import 'package:jimpact/utils/type_defs.dart';

class BlogController extends StateNotifier<bool> {
  final BlogRepository _blogRepository;
  final Ref _ref;
  BlogController({
    required BlogRepository blogRepository,
    required Ref ref,
  })  : _blogRepository = blogRepository,
        _ref = ref,
        super(false);

  //! get blogs
  Future<List<BlogModel>> getAllBlogs() async {
    return _blogRepository.getAllBlogs();
  }

  //! create blogs
  void createBlog({
    required String title,
    required String content,
    required BuildContext context,
    required void Function()? sideEffect,
  }) async {
    UserModel user = _ref.watch(userProvider)!;
    state = true;

    final res = await _blogRepository.createBlog(
      user: user.id!,
      title: title,
      content: content,
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
        // goBack(context);
        sideEffect!.call();
      },
    );
  }
}
