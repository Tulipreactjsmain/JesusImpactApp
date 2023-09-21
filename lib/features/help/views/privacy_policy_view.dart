import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jimpact/theme/palette.dart';
import 'package:jimpact/utils/app_extensions.dart';
import 'package:jimpact/utils/widgets/appbar.dart';

class PrivacyPolicyView extends ConsumerWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              'Privacy Policy'
                  .txt(
                    size: 32.sp,
                    colorType: TxtClrType.g41,
                    fontWeight: FontWeight.w300,
                  )
                  .alignCenterLeft(),
              36.sbH,

              dummyPolicy.txt16(
                colorType: TxtClrType.g54,
                fontWeight: FontWeight.w300,
              ),

              60.sbH,
            ],
          ),
        ),
      ),
    );
  }
}

const String dummyPolicy =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod lorem id mauris dapibus, ut feugiat mauris convallis. Phasellus vitae cursus enim. Cras mauris dui, porta non accumsan vel, rutrum eu magna. Cras blandit justo ac augue laoreet molestie. Nulla id hendrerit erat. Donec porta bibendum turpis eget pharetra. Proin sodales lobortis leo, sed dictum ex pretium vel. Curabitur nec molestie risus. Aliquam iaculis, libero at laoreet imperdiet, elit sapien euismod quam, nec lobortis erat neque sit amet turpis. Sed ultricies ultricies enim, ac sollicitudin ligula efficitur nec. In hac habitasse platea dictumst. Morbi lobortis sollicitudin diam vitae bibendum. Curabitur porttitor orci sit amet vehicula placerat. Sed posuere, felis ac cursus pulvinar, mi sapien dictum massa, id ornare justo erat sit amet enim. Sed nunc risus, sollicitudin et odio ut, lacinia sollicitudin mauris. Cras felis lacus, consequat non consequat id, vestibulum sit amet magna. Pellentesque commodo est a quam tempor molestie. Nam auctor sed diam ut dignissim. Donec pulvinar fermentum commodo. Praesent porttitor eu leo eget vestibulum. Mauris fermentum mattis interdum. Nullam et tortor dictum, laoreet lacus in, convallis mauris. Sed condimentum, nibh ac semper fringilla, eros erat tincidunt lectus, at tempor elit turpis non arcu. Morbi dignissim blandit consectetur. Nunc porta molestie posuere. Aenean ut odio pellentesque est interdum fringilla. Donec convallis, erat et suscipit bibendum, lectus ex egestas felis, a egestas orci massa quis risus. Ut sit amet volutpat ante. Duis ac purus nisl. Sed vel quam eleifend, sodales tellus quis, egestas ligula. Mauris vel euismod est, eget posuere dui.';
