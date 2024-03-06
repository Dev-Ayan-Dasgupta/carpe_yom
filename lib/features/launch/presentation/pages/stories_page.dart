import 'dart:developer';

import 'package:carpeyom/config/routes/routes.dart';
import 'package:carpeyom/core/constants/index.dart';
import 'package:carpeyom/core/widgets/index.dart';
import 'package:carpeyom/features/emailVerification/domain/entities/registration_argument.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stories/flutter_stories.dart';
import 'package:pausable_timer/pausable_timer.dart';

class StoriesPage extends StatefulWidget {
  const StoriesPage({super.key});

  @override
  State<StoriesPage> createState() => _StoriesPageState();
}

class _StoriesPageState extends State<StoriesPage> with TextStyleMixin {
  List images = [
    Image.asset(ImageConstants.onboarding1, fit: BoxFit.fill),
    Image.asset(ImageConstants.onboarding2, fit: BoxFit.fill),
    Image.asset(ImageConstants.onboarding3, fit: BoxFit.fill),
  ];
  bool isLoading = false;

  int seconds = 0;
  late final PausableTimer _timer;

  @override
  void initState() {
    super.initState();
    initTimer();
  }

  initTimer() async {
    _timer = PausableTimer.periodic(
      const Duration(seconds: 1),
      () {
        if (!mounted) {
          return;
        }
        setState(() {
          seconds++;
          log("seconds -> $seconds");
          pauseTimer();
        });
      },
    );
    _timer.start();
  }

  pauseTimer() {
    if (seconds >= 2) {
      _timer.pause();
    }
  }

  void onGetStarted() {
    Navigator.pushNamed(
      context,
      Routes.registration,
      arguments: RegistrationArgumentEntity(
        isInitial: true,
        isUpdateCorpEmail: false,
      ).toMap(),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    return PopScope(
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
      },
      child: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          systemStatusBarContrastEnforced: true,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            toolbarHeight: 10,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Stack(
            children: [
              CupertinoPageScaffold(
                child: Story(
                  momentCount: 3,
                  momentDurationGetter: (index) => const Duration(seconds: 5),
                  momentBuilder: (context, index) => images[index],
                ),
              ),
              AnimatedPositioned(
                top: seconds * 90.h - 110.h,
                duration: const Duration(seconds: 1),
                child: SizedBox(
                  width: 428.w,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.login,
                                );
                              },
                              child: Text(
                                "Log in", // make this login from backend when the backend will be ready
                                style: bodyStyle(
                                    fontSize: 16.w,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                            // const SizedBox(width: 10),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              AnimatedPositioned(
                bottom: seconds * 85.h - 160.h,
                duration: const Duration(seconds: 1),
                child: SizedBox(
                  width: 428.w,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        GradientButton(
                          height: 60.h,
                          onTap: onGetStarted,
                          text: "Let's Start",
                          auxWidget: isLoading
                              ? const ButtonLoader()
                              : const SizedBox(),
                        ),
                        const SizedBox(height: 16),
                        SolidButton(
                          onTap: () async {
                            Navigator.pushNamed(
                                context, Routes.exploreDashboard);
                          },
                          text: "Explore",
                          color: const Color.fromARGB(30, 0, 0, 0),
                          fontColor: Colors.white,
                        ),

                        SizedBox(
                          height: MediaQuery.paddingOf(context).bottom + 24,
                        ), //Make relavant change form backend with text
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
