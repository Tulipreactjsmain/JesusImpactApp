import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimpact/features/blogs/controllers/blog_controller.dart';
import 'package:jimpact/features/blogs/repositories/blog_repository.dart';
import 'package:jimpact/models/blogs/blog_model.dart';

//! the blog repo provider
final Provider<BlogRepository> blogRepositoryProvider =
    Provider((ref) => const BlogRepository());

//! the provider for the blog controller
StateNotifierProvider<BlogController, bool> blogControllerProvider =
    StateNotifierProvider((ref) {
  BlogRepository blogRepository = ref.watch(blogRepositoryProvider);
  return BlogController(blogRepository: blogRepository, ref: ref);
});

//! provider for getting blogs list
final getAllBlogsProvider = FutureProvider<List<BlogModel>>((ref) {
  final blogController = ref.watch(blogControllerProvider.notifier);
  return blogController.getAllBlogs();
});
