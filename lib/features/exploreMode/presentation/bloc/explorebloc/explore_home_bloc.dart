import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carpeyom/config/routes/routes.dart';
import 'package:carpeyom/core/constants/index.dart';
import 'package:carpeyom/core/widgets/index.dart';
import 'package:carpeyom/features/emailVerification/domain/entities/registration_argument.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
part 'explore_home_event.dart';

part 'explore_home_state.dart';

class ExploreHomeBloc extends Bloc<ExploreHomeEvent, ExploreHomeState>
    with TextStyleMixin {
  ExploreHomeBloc() : super(const ExploreHomeInitial()) {
    on<ExploreHomeConfigurableEvent>((event, emit) {
      emit(ExploreHomeTimedOutState());
    });
  }

  // ! buttomSheet Pop-up dialog to show after complete
  //timer with 120 second duration
  void showButtomSheet(BuildContext context) {
    showModalBottomSheet(
      barrierColor: const Color.fromARGB(80, 0, 0, 0),
      isDismissible: false,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return LoginBottomSheet(
          title: "That was just a glimpse!",
          description:
              "Please take a moment to Log in or Register to unlock the full experience and exclusive features of our platform.",
        );
      },
    );
  }

  // ! Pop-up dialog to show to explore mode
  void onRegisterPrompt(BuildContext context) {
    showAdaptiveDialog(
      barrierColor: Colors.black,
      context: context,
      builder: (context) {
        return CustomDialog(
          svgAssetPath: ImageConstants.alert,
          title: "Hey!",
          message: "Ready to unlock the door of opportunities?",
          widget: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SolidButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    height: 55.h,
                    width: 135.w,
                    text: "Close",
                    fontColor: AppColors.green20,
                    fontSize: 15.w,
                    borderColor: const Color.fromRGBO(0, 0, 0, 0.2),
                    borderRadius: 10.w,
                    color: Colors.white,
                  ),
                  GradientButton(
                    onTap: () {
                      Navigator.pop(context);
                      showRegistration(context);
                    },
                    height: 55.h,
                    width: 135.w,
                    text: "Register",
                    fontSize: 15.w,
                    borderRadius: 10.w,
                  ),
                ],
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: Text("Already have an account?",
                        textAlign: TextAlign.center,
                        style: hintStyle(
                            color: const Color.fromRGBO(0, 0, 0, 0.5))),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        Routes.login,
                      );
                    },
                    child: Text(
                      "Log in",
                      textAlign: TextAlign.center,
                      style: bodyStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.green20,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  // ! Screen to show Lets Start(Registration)
  void showRegistration(BuildContext context) {
    Navigator.pushReplacementNamed(
      context,
      Routes.registration,
      arguments: RegistrationArgumentEntity(
        isInitial: true,
        isUpdateCorpEmail: false,
      ).toMap(),
    );
  }
}
