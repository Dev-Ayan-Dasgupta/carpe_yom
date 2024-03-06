import 'package:carpeyom/core/constants/index.dart';
import 'package:carpeyom/core/widgets/index.dart';
import 'package:carpeyom/features/securityQuestions/presentation/bloc/securityquestionbloc/security_questions_bloc.dart';
import 'package:carpeyom/features/securityQuestions/presentation/bloc/securityquestionbloc/security_questions_event.dart';
import 'package:carpeyom/features/securityQuestions/presentation/bloc/securityquestionbloc/security_questions_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SecurityQuestionPage extends StatefulWidget {
  const SecurityQuestionPage({super.key});

  @override
  State<SecurityQuestionPage> createState() => _SecurityQuestionPageState();
}

class _SecurityQuestionPageState extends State<SecurityQuestionPage>
    with TextStyleMixin {
  final TextEditingController _qus1Controller = TextEditingController();
  final TextEditingController _qus2Controller = TextEditingController();

  bool isQus1 = false;
  bool isQus2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 20,
        toolbarHeight: 70,
        title: Text(
          "Security Questions",
          style: appBarStyle(),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        child: BlocBuilder<SecurityQuestionBloc, SecurityQuestionState>(
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(height: 30),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Take a note",
                        style: headingStyle(),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "The information provided will be used for verification purposes only",
                        style: bodyStyle(
                            fontSize: 14.w,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black20),
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Mother's Name",
                              style: hintStyle(
                                  fontSize: 12.w,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black100),
                            ),
                            const Asterisk(),
                          ],
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            ImageConstants.securityQuPerson,
                            width: 20,
                            height: 20,
                            fit: BoxFit.fill,
                          ),
                        ),
                        hintText: "Enter Your Mother's Name",
                        controller: _qus1Controller,
                        onChanged: (p0) {
                          context.read<SecurityQuestionBloc>().add(
                              SecurityQuestionEnableButton(
                                  (_qus1Controller.text.isNotEmpty &&
                                      _qus2Controller.text.isNotEmpty)));
                        },
                      ),
                      SizedBox(height: 20.h),
                      CustomTextField(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Favourite City",
                              style: hintStyle(
                                  fontSize: 12.w,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black100),
                            ),
                            const Asterisk(),
                          ],
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            ImageConstants.securityQuCity,
                            width: 20,
                            height: 20,
                            fit: BoxFit.fill,
                          ),
                        ),
                        hintText: "Enter Your Favourite City",
                        controller: _qus2Controller,
                        onChanged: (p0) {
                          context.read<SecurityQuestionBloc>().add(
                              SecurityQuestionEnableButton(
                                  (_qus1Controller.text.isNotEmpty &&
                                      _qus2Controller.text.isNotEmpty)));
                        },
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    state is SecurityQuestionSuccessState
                        ? GradientButton(
                            onTap: () {
                              SecurityQuestionBloc().showAlertSuccess(context);
                            },
                            text: "Proceed",
                            // auxWidget: state is LoginLoading
                            //     ? const LoaderRow()
                            //     : const SizedBox(),
                          )
                        : SolidButton(onTap: () {}, text: "Proceed")
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
