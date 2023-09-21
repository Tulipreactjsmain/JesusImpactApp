import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jimpact/features/auth/views/choose_auth_route_view.dart';
import 'package:jimpact/theme/palette.dart';
import 'package:jimpact/utils/register_model_adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RegisterAdapters.initializeBDAndRegisterAdapters();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(485, 910),
        minTextAdapt: true,
        splitScreenMode: false,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Jesus Impact',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Pallete.redColor),
              useMaterial3: true,
            ),
            home: const ChooseAuthRouteView(),
          );
        });
  }
}
