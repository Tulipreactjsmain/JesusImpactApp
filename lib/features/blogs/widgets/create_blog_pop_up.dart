import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jimpact/features/blogs/providers/blog_providers.dart';
import 'package:jimpact/theme/palette.dart';
import 'package:jimpact/utils/app_constants.dart';
import 'package:jimpact/utils/app_extensions.dart';
import 'package:jimpact/utils/nav.dart';
import 'package:jimpact/utils/snack_bar.dart';
import 'package:jimpact/utils/type_defs.dart';
import 'package:jimpact/utils/widgets/button.dart';
import 'package:jimpact/utils/widgets/text_input.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CreateBlogPopup extends ConsumerStatefulWidget {
  final Animation<double> a1;
  final Animation<double> a2;
  final void Function()? cancelEffect;
  const CreateBlogPopup({
    super.key,
    required this.a1,
    required this.a2,
    this.cancelEffect,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateBlogPopupState();
}

class _CreateBlogPopupState extends ConsumerState<CreateBlogPopup> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(blogControllerProvider);
    return Dialog(
      elevation: 65,
      child: Container(
        //! USE ANIMATION DOUBLE VALUES TO ANIMATE DIALOGUE
        height: 600.h * widget.a1.value,
        // width: width(context),
        padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(top: 20.h),
        decoration: BoxDecoration(
          color: Palette.whiteColor,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: SingleChildScrollView(
          child: [_titleController, _contentController].multiSync(
            builder: (context, child) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 7.h),
                  child: const Icon(PhosphorIcons.arrowLeft).alignCenterLeft(),
                ).tap(
                  onTap: () {
                    // widget.cancelEffect!.call();
                    goBack(context);
                  },
                ),
                10.sbH,
                'Title'.txt16().alignCenterLeft(),
                3.sbH,
                TextInputWidget(
                  hintText: '',
                  // inputTitle: 'Title',
                  controller: _titleController,
                ),
                10.sbH,
                'Content'.txt16().alignCenterLeft(),
                SizedBox(
                  width: width(context),
                  child: TextField(
                    onChanged: (value) {
                      // String typed = value;
                      // if (typed.isNotEmpty) {
                      //   isButtonActive.value = true;
                      // } else {
                      //   isButtonActive.value = false;
                      // }
                    },
                    autofocus: true,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(
                      fontSize: 18.sp,
                    ),
                    cursorColor: Palette.blackColor,
                    controller: _contentController,
                    maxLength: 350,
                    decoration: InputDecoration(
                      hintText: 'What\'s on your mind ?',
                      hintStyle: TextStyle(
                          fontSize: 18.sp,
                          color: Palette.blackColor.withOpacity(0.6)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                30.sbH,
                isLoading
                    ? SizedBox(
                        height: 50.h,
                        child: const Center(
                            child: CircularProgressIndicator(
                          color: Palette.redColor,
                        )),
                      )
                    : BButton(
                        onTap: () {
                          if (_titleController.text.isNotEmpty &&
                              _contentController.text.isNotEmpty) {
                            ref
                                .read(blogControllerProvider.notifier)
                                .createBlog(
                                    title: _titleController.text,
                                    content: _contentController.text,
                                    context: context,
                                    sideEffect: () {
                                      
                                      Timer(100.ms, () {
                                        showBanner(
                                          context: context,
                                          theMessage: 'Post created!',
                                          theType: NotificationType.success,
                                        );
                                      });
                                    });
                          }
                        },
                        text: 'Post',
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
