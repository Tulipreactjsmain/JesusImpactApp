import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jimpact/shared/app_texts.dart';
import 'package:jimpact/theme/palette.dart';
import 'package:jimpact/utils/app_constants.dart';
import 'package:jimpact/utils/app_extensions.dart';
import 'package:jimpact/utils/widgets/appbar.dart';
import 'package:jimpact/utils/widgets/button.dart';
import 'package:jimpact/utils/widgets/myicon.dart';
import 'package:jimpact/utils/widgets/text_input.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:simple_notifier/simple_notifier.dart';

class EditProfileView extends ConsumerStatefulWidget {
  const EditProfileView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfileViewState();
}

class _EditProfileViewState extends ConsumerState<EditProfileView> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _reenterPasswordController =
      TextEditingController();
  ValueNotifier<File?> image = ValueNotifier(File(""));
  final ValueNotifier<bool> isPasswordInvisible = ValueNotifier(true);
  void passwordVisibility() =>
      isPasswordInvisible.value = !isPasswordInvisible.value;

  void takePhoto(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) return;

      final imageTemp = File(image.path);

      this.image.value = imageTemp;

      //  setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      'Failed to pick images: $e'.log();
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _reenterPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar('Edit Profile', context: context),
      body: SizedBox(
        height: height(context),
        width: width(context),
        child: SingleChildScrollView(
          child: Padding(
            padding: 32.padH,
            child: Column(
              children: [
                35.sbH,
                image.listen(
                  builder: (context, value, child) => Container(
                    height: 117.h,
                    width: 117.h,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      image: image.value == null
                          ? null
                          : DecorationImage(
                              image: FileImage(image.value!),
                              fit: BoxFit.cover,
                            ),
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: Center(
                      child: Icon(
                        PhosphorIcons.imageFill,
                        color: Colors.white,
                        size: 40.sp,
                      ),
                    ),
                  ).tap(onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (_) => bottomSheet(),
                    );
                  }),
                ),
                62.sbH,
                //! first name
                TextInputWidget(
                  hintText: AppTexts.firstName,
                  controller: _firstNameController,
                ),
                34.sbH,

                //! last name
                TextInputWidget(
                  hintText: AppTexts.lastName,
                  controller: _lastNameController,
                ),
                34.sbH,

                //! user name
                TextInputWidget(
                  hintText: 'Username',
                  controller: _usernameController,
                ),
                34.sbH,

                //! email
                TextInputWidget(
                  keyboardType: TextInputType.emailAddress,
                  hintText: AppTexts.email,
                  controller: _emailController,
                ),
                34.sbH,

                //! password
                isPasswordInvisible.listen(
                  builder: (context, value, child) => TextInputWidget(
                    hintText: AppTexts.password,
                    controller: _passwordController,
                    obscuretext: isPasswordInvisible.value,
                    suffixIcon: Padding(
                      padding: 15.padH,
                      child: MyIcon(
                        icon: 'showpassword',
                        height: 15.h,
                        color: isPasswordInvisible.value == false
                            ? Pallete.redColor
                            : null,
                      ),
                    ).tap(onTap: passwordVisibility),
                  ),
                ),
                34.sbH,
                BButton(
                  onTap: () {},
                  isText: false,
                  item: Padding(
                    padding: 20.padH,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        'Save'.txt(
                          size: 20.sp,
                          color: Colors.white,
                          fontWeightType: TxtFntWt.med,
                        ),
                        const Icon(
                          PhosphorIcons.floppyDiskFill,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
        decoration: BoxDecoration(
            color: Pallete.whiteColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.r))),
        height: 150.h,
        width: double.infinity,
        child: Column(children: [
          //! SPACER
          20.sbH,

          //! NOTICE
          Text('Choose profile photo',
              style: TextStyle(
                  color: Pallete.blackColor,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700)),

          //! SPACER
          20.sbH,

          //! OPTIONS
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            //! CAMERA
            IconButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  takePhoto(ImageSource.camera);
                },
                icon: Icon(
                  Icons.camera_alt,
                  color: Pallete.redColor,
                  size: 40.sp,
                )),

            //! GALLERY
            IconButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  takePhoto(ImageSource.gallery);
                },
                icon: Icon(
                  Icons.photo,
                  color: Pallete.redColor,
                  size: 40.sp,
                ))
          ])
        ]));
  }
}
