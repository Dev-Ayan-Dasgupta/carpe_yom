import 'package:carpeyom/config/routes/routes.dart';
import 'package:carpeyom/core/constants/index.dart';
import 'package:carpeyom/core/widgets/index.dart';
import 'package:carpeyom/features/emailVerification/domain/entities/registration_argument.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginBottomSheet extends StatelessWidget with TextStyleMixin {
  LoginBottomSheet({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 10.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.w),
          topRight: Radius.circular(20.w),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40.h),
          Text(
            title,
            textAlign: TextAlign.center,
            style: headingStyle(fontSize: 22.w, color: AppColors.black30),
          ),
          SizedBox(height: 15.h),
          Padding(
            padding: EdgeInsets.only(left: 40.w, right: 40.w),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: bodyStyle(fontSize: 14.w, color: AppColors.black100),
            ),
          ),
          SizedBox(height: 30.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SolidButton(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    Routes.login,
                  );
                },
                text: "Login",
                width: 195.w,
                height: 55.h,
              ),
              GradientButton(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    Routes.registration,
                    arguments: RegistrationArgumentEntity(
                      isInitial: true,
                      isUpdateCorpEmail: false,
                    ).toMap(),
                  );
                },
                text: "Register",
                width: 195.w,
                height: 55.h,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
