import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jimpact/theme/palette.dart';
import 'package:jimpact/utils/app_extensions.dart';
import 'package:jimpact/utils/widgets/appbar.dart';
import 'package:jimpact/utils/widgets/button.dart';
import 'package:jimpact/utils/widgets/text_input.dart';

class ContactUsView extends ConsumerStatefulWidget {
  const ContactUsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContactUsViewState();
}

class _ContactUsViewState extends ConsumerState<ContactUsView> {
  final TextEditingController _contentController = TextEditingController();

  @override
  void dispose() {
    _contentController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.bgGreyFB,
      appBar: customAppBar('', context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: 32.padH,
          child: Column(
            children: [
              30.sbH,

              //! what
              'Contact Us'
                  .txt(
                    size: 32.sp,
                    colorType: TxtClrType.g41,
                    fontWeight: FontWeight.w300,
                  )
                  .alignCenterLeft(),
              47.sbH,

              //! select topic
              BButton(
                onTap: () {},
                color: Pallete.textInputFillGreyEE,
                isText: false,
                item: Padding(
                  padding: 20.padH,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      'Select a Topic'
                          .txt(size: 20.sp, colorType: TxtClrType.g54),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Pallete.textBlack54,
                        size: 32.sp,
                      )
                    ],
                  ),
                ),
              ),
              31.sbH,

              //! text
              TextInputWidget(
                maxLines: 20,
                height: 200.h,
                hintText: 'Enter text',
                controller: _contentController,
              ),

              170.sbH,
              BButton(
                onTap: () {},
                text: 'Submit',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
