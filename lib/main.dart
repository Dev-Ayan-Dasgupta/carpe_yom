import 'dart:async';
import 'package:carpeyom/config/routes/app_router.dart';
import 'package:carpeyom/config/routes/routes.dart';
import 'package:carpeyom/core/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

FutureOr<void> main() async {
  runApp(
    MyApp(appRouter: AppRouter()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
    required this.appRouter,
  });

  final AppRouter appRouter;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: BlocProviders.blocProviders,
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            behavior: HitTestBehavior.opaque,
            child: MaterialApp(
              initialRoute: Routes.splash,
              onGenerateRoute: widget.appRouter.onGenerateRoute,
              debugShowCheckedModeBanner: false,
              title: 'carpe Yom',
              theme: ThemeData(
                // for others Android
                colorSchemeSeed: AppColors.green100,
              ),
            ),
          ),
        );
      },
    );
  }
}
