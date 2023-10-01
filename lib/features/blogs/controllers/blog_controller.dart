// ignore_for_file: unused_field
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jimpact/features/blogs/repositories/blog_repository.dart';
import 'package:jimpact/models/blogs/blog_model.dart';

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
}
