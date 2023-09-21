import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jimpact/theme/palette.dart';
import 'package:jimpact/utils/widgets/text_input.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SearchBarr extends ConsumerStatefulWidget {
  const SearchBarr({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchBarrState();
}

class _SearchBarrState extends ConsumerState<SearchBarr> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextInputWidget(
      hintText: 'Search groups',
      controller: _searchController,
      suffixIcon: Padding(
        padding: EdgeInsets.only(right: 18.w),
        child: Icon(
          PhosphorIcons.magnifyingGlassBold,
          color: Pallete.greyA7,
          size: 24.sp,
        ),
      ),
    );
  }
}
