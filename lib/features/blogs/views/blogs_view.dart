import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jimpact/features/blogs/widgets/blog_card.dart';
import 'package:jimpact/features/blogs/widgets/top_blog_card.dart';
import 'package:jimpact/theme/palette.dart';
import 'package:jimpact/utils/app_extensions.dart';
import 'package:jimpact/utils/widgets/appbar.dart';

class BlogsView extends ConsumerWidget {
  const BlogsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: Pallete.bgGreyFB,
        appBar: customAppBar('Blogs', context: context),
        body: Column(
          children: [
            20.sbH,
            SizedBox(
              height: 35.h,
              child: TabBar(
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                indicator: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                    width: 3,
                    color: Pallete.redColor,
                  )),
                ),
                labelColor: Pallete.blackColor,
                unselectedLabelColor: Pallete.blackColor,
                labelStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: const Color(0xFF545454),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                unselectedLabelStyle: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: const Color(0xFF545454),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                tabs: const [
                  Tab(
                    text: 'Faith',
                  ),
                  Tab(
                    text: 'Love',
                  ),
                  Tab(
                    text: 'Prayer',
                  ),
                  Tab(
                    text: 'Hope',
                  ),
                  Tab(
                    text: 'Resurrection',
                  ),
                  Tab(
                    text: 'Lifestyle',
                  ),
                ],
              ),
            ),

            //! body
            Expanded(
              child: TabBarView(
                children: [
                  //! FAITH
                  SingleChildScrollView(
                      padding: EdgeInsets.only(top: 30.h),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 38.w,
                        runSpacing: 38.h,
                        children: List.generate(
                            10,
                            (index) => index == 0
                                ? const TopBlogCard()
                                : const BlogCard()),
                      )),

                  //! LOVE
                  SingleChildScrollView(
                      padding: EdgeInsets.only(top: 30.h),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 38.w,
                        runSpacing: 38.h,
                        children: List.generate(
                            10,
                            (index) => index == 0
                                ? const TopBlogCard()
                                : const BlogCard()),
                      )),

                  //! PRAYER
                  SingleChildScrollView(
                      padding: EdgeInsets.only(top: 30.h),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 38.w,
                        runSpacing: 38.h,
                        children: List.generate(
                            10,
                            (index) => index == 0
                                ? const TopBlogCard()
                                : const BlogCard()),
                      )),

                  //! HOPE
                  SingleChildScrollView(
                      padding: EdgeInsets.only(top: 30.h),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 38.w,
                        runSpacing: 38.h,
                        children: List.generate(
                            10,
                            (index) => index == 0
                                ? const TopBlogCard()
                                : const BlogCard()),
                      )),

                  //! RESURRECTION
                  SingleChildScrollView(
                      padding: EdgeInsets.only(top: 30.h),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 38.w,
                        runSpacing: 38.h,
                        children: List.generate(
                            10,
                            (index) => index == 0
                                ? const TopBlogCard()
                                : const BlogCard()),
                      )),

                  //! LIFESTYLE
                  SingleChildScrollView(
                      padding: EdgeInsets.only(top: 30.h),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 38.w,
                        runSpacing: 38.h,
                        children: List.generate(
                            10,
                            (index) => index == 0
                                ? const TopBlogCard()
                                : const BlogCard()),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
