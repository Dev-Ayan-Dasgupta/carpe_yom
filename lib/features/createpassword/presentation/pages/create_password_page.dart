import 'package:carpeyom/config/routes/routes.dart';
import 'package:carpeyom/core/widgets/index.dart';
import 'package:carpeyom/features/createpassword/domain/entities/create_account.dart';
import 'package:carpeyom/features/mobileNumberVerification/domain/entities/mobile_number_verification_argument.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/bloc/checkboxbloc/check_box_cubit.dart';
import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/images.dart';
import '../../../../../core/constants/textstyles.dart';
import '../bloc/createpasswordbloc/create_password_bloc.dart';
import '../widgets/password_criteria.dart';

class CreatePasswordPage extends StatefulWidget {
  const CreatePasswordPage({
    Key? key,
    this.argument,
  }) : super(key: key);

  final Object? argument;

  @override
  State<CreatePasswordPage> createState() => _CreatePasswordPageState();
}

class _CreatePasswordPageState extends State<CreatePasswordPage>
    with TextStyleMixin {
  late final TextEditingController
      _emailController; //= TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  late CreateAccountArgumentEntity createAccountArgumentEntity;

  bool isObscurePassword = true;
  bool isObscureConfirmedPassword = true;
  bool hasMin8 = false;
  bool hasNumeric = false;
  bool hasUpperLower = false;
  bool hasSpecial = false;
  bool isPasswordMatched = false;
  bool agreedToTermsAndConditions = false;

  @override
  void initState() {
    super.initState();
    argumentInitialization();
    controllerInitialization();
  }

  void argumentInitialization() {
    createAccountArgumentEntity =
        CreateAccountArgumentEntity.fromMap(widget.argument as dynamic ?? {});
  }

  void controllerInitialization() {
    _emailController =
        TextEditingController(text: createAccountArgumentEntity.email);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {},
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create your password",
                  style: headingStyle(),
                ),
                SizedBox(height: 10.h),
                Text(
                  "Please set a password for your chosen User ID",
                  style: bodyStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.w,
                  ),
                ),
                SizedBox(height: 30.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomTextField(
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Email Address (User ID)",
                                style: hintStyle(
                                    fontSize: 12.w,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.dark80),
                              ),
                              const Asterisk(),
                            ],
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SvgPicture.asset(
                              ImageConstants.envelope,
                              width: 15,
                              height: 15,
                              fit: BoxFit.fill,
                            ),
                          ),
                          controller: _emailController,
                          enabled: false,
                          onChanged: (p0) {},
                          color: Colors.transparent,
                          fontColor: const Color.fromRGBO(37, 37, 37, 0.5),
                        ),
                        SizedBox(height: 15.h),
                        BlocConsumer<CreatePasswordBloc, CreatePasswordState>(
                          listener: (context, state) {
                            if (state is ShowHidePasswordState) {
                              isObscurePassword = state.isShown;
                            }
                          },
                          builder: (context, state) {
                            return CustomTextField(
                              label: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Password",
                                    style: hintStyle(
                                        fontSize: 12.w,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.dark80),
                                  ),
                                  const Asterisk(),
                                ],
                              ),
                              controller: _passwordController,
                              onChanged: (p0) {
                                context.read<CreatePasswordBloc>().add(
                                    CheckPasswordCriteriaEvent(
                                        password: _passwordController.text));
                              },
                              hintText: "Password",
                              obscureText: isObscurePassword,
                              maxLines: 1,
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(right: 10.w),
                                child: InkWell(
                                  onTap: () {
                                    isObscurePassword
                                        ? context
                                            .read<CreatePasswordBloc>()
                                            .add(const ShowHidePasswordEvent(
                                                showPassword: true))
                                        : context
                                            .read<CreatePasswordBloc>()
                                            .add(const ShowHidePasswordEvent(
                                                showPassword: false));
                                  },
                                  child: Icon(
                                    isObscurePassword
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: AppColors.black5,
                                    size: 20.w,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 15.h),
                        BlocConsumer<CreatePasswordBloc, CreatePasswordState>(
                          listener: (context, state) {
                            if (state is HasMin8State) {
                              hasMin8 = state.hasMin8;
                            } else if (state is HasNumericState) {
                              hasNumeric = state.hasNumeric;
                            } else if (state is HasUpperLowerState) {
                              hasUpperLower = state.hasUpperLower;
                            } else if (state is HasSpecialState) {
                              hasSpecial = state.hasSpecial;
                            }
                          },
                          builder: (context, state) {
                            return PasswordCriteria(
                              criteria1Color: hasMin8
                                  ? AppColors.dark100
                                  : AppColors.red100,
                              criteria2Color: hasNumeric
                                  ? AppColors.dark100
                                  : AppColors.red100,
                              criteria3Color: hasUpperLower
                                  ? AppColors.dark100
                                  : AppColors.red100,
                              criteria4Color: hasSpecial
                                  ? AppColors.dark100
                                  : AppColors.red100,
                              criteria1Widget: hasMin8
                                  ? SvgPicture.asset(
                                      ImageConstants.checkSmall,
                                      width: 10.w,
                                      height: 10.w,
                                    )
                                  : SvgPicture.asset(
                                      ImageConstants.redCross,
                                      width: 10.w,
                                      height: 10.w,
                                    ),
                              criteria2Widget: hasNumeric
                                  ? SvgPicture.asset(
                                      ImageConstants.checkSmall,
                                      width: 10.w,
                                      height: 10.w,
                                    )
                                  : SvgPicture.asset(
                                      ImageConstants.redCross,
                                      width: 10.w,
                                      height: 10.w,
                                    ),
                              criteria3Widget: hasUpperLower
                                  ? SvgPicture.asset(
                                      ImageConstants.checkSmall,
                                      width: 10.w,
                                      height: 10.w,
                                    )
                                  : SvgPicture.asset(
                                      ImageConstants.redCross,
                                      width: 10.w,
                                      height: 10.w,
                                    ),
                              criteria4Widget: hasSpecial
                                  ? SvgPicture.asset(
                                      ImageConstants.checkSmall,
                                      width: 10.w,
                                      height: 10.w,
                                    )
                                  : SvgPicture.asset(
                                      ImageConstants.redCross,
                                      width: 10.w,
                                      height: 10.w,
                                    ),
                              backgroundColor: hasMin8 &&
                                      hasNumeric &&
                                      hasUpperLower &&
                                      hasSpecial
                                  ? AppColors.green40
                                  : AppColors.red10,
                            );
                          },
                        ),
                        SizedBox(height: 15.h),
                        Center(
                          child: BlocConsumer<CreatePasswordBloc,
                              CreatePasswordState>(
                            listener: (context, state) {
                              if (state is ShowHideConfirmedPasswordState) {
                                isObscureConfirmedPassword = state.isShown;
                              } else if (state is PasswordMatchState) {
                                isPasswordMatched = _passwordController.text ==
                                    _confirmPasswordController.text;
                              }
                            },
                            builder: (context, state) {
                              return Column(
                                children: [
                                  buildShowConfirmPassword(
                                      isObscureConfirmedPassword,
                                      isPasswordMatched),
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 9.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(height: 20.h),
              Row(
                children: [
                  BlocProvider(
                    create: (_) => CheckBoxCubit(),
                    child: buildCheckBox(agreedToTermsAndConditions),
                  ),
                  SizedBox(width: 5.w),
                  Row(
                    children: [
                      Text(
                        'I agree to the ',
                        style: bodyStyle(
                          fontSize: 14.w,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black20,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Navigator.pushNamed(
                          //     context, Routes.termsAndConditions);
                        },
                        child: Text('Terms & Conditions',
                            style: TextStyle(
                              fontSize: 14.w,
                              fontWeight: FontWeight.w400,
                              color: AppColors.green20,
                              decoration: TextDecoration.underline,
                            )),
                      ),
                      Text(
                        ' and ',
                        style: bodyStyle(
                          fontSize: 14.w,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black20,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Navigator.pushNamed(
                          //     context, Routes.privacyStatement);
                        },
                        child: Text(
                          'Privacy Policy',
                          style: TextStyle(
                            fontSize: 14.w,
                            fontWeight: FontWeight.w400,
                            color: AppColors.green20,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              Column(
                children: [
                  SizedBox(height: 10.h),
                  BlocBuilder<CreatePasswordBloc, CreatePasswordState>(
                    builder: (context, state) {
                      if (hasMin8 &&
                          hasNumeric &&
                          hasSpecial &&
                          hasUpperLower &&
                          isPasswordMatched) {
                        return GradientButton(
                          onTap: () async {
                            Navigator.pushReplacementNamed(
                              context,
                              Routes.verifyMobile,
                              arguments: MobileNumberVerificationArgumentEntity(
                                      isBusiness: false,
                                      isUpdate: false,
                                      isReKyc: false)
                                  .toMap(),
                            );
                          },
                          text: "Create Profile",
                          // auxWidget: isRegistering
                          //     ? const ButtonLoader()
                          //     : const SizedBox(),
                        );
                      } else {
                        return SolidButton(
                            onTap: () {},
                            text: "Create Profile",
                            fontColor: AppColors.black40);
                      }
                    },
                  )
                ],
              ),
              const FooterPadding(),
            ],
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      shadowColor: Colors.white,
      backgroundColor: Colors.white,
      elevation: 20,
      toolbarHeight: 70,
      title: Text(
        "Password",
        style: appBarStyle(fontWeight: FontWeight.w600),
      ),
      automaticallyImplyLeading: false,
      leading: InkWell(
          onTap: () {
            Navigator.maybePop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(23.0),
            child: SvgPicture.asset(
              ImageConstants.backButton,
              height: 20.h,
              width: 20.w,
            ),
          )),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25)),
        ),
      ),
    );
  }

  Widget buildShowConfirmPassword(
      bool isObscureConfirmedPassword, bool isPasswordMatched) {
    return Column(
      children: [
        CustomTextField(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Confirm Password",
                style: hintStyle(
                    fontSize: 12.w,
                    fontWeight: FontWeight.w500,
                    color: AppColors.dark80),
              ),
              const Asterisk(),
            ],
          ),
          controller: _confirmPasswordController,
          onChanged: (p0) {
            context.read<CreatePasswordBloc>().add(PasswordMatchEvent());
          },
          hintText: "Confirm Password",
          obscureText: isObscureConfirmedPassword,
          maxLines: 1,
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: InkWell(
              onTap: () {
                isObscureConfirmedPassword
                    ? context.read<CreatePasswordBloc>().add(
                        const ShowHideConfirmedPasswordEvent(
                            showConfirmedPassword: true))
                    : context.read<CreatePasswordBloc>().add(
                        const ShowHideConfirmedPasswordEvent(
                            showConfirmedPassword: false));
              },
              child: Icon(
                isObscureConfirmedPassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.black5,
                size: 20.w,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 8.w),
          child: Row(
            children: [
              Ternary(
                condition: isPasswordMatched ||
                    _confirmPasswordController.text.isEmpty,
                truthy: const SizedBox(),
                falsy: SvgPicture.asset(ImageConstants.warningText,
                    height: 10.h, width: 10.w),
              ),
              SizedBox(width: 5.h),
              Text(
                isPasswordMatched || _confirmPasswordController.text.isEmpty
                    ? ""
                    : "Password is not matching",
                style: bodyStyle(
                  color: isPasswordMatched ||
                          _confirmPasswordController.text.isEmpty
                      ? Colors.transparent
                      : AppColors.red110,
                  fontSize: 12.w,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget buildCheckBox(bool agreedToTermsAndConditions) {
    return BlocConsumer<CheckBoxCubit, CheckBoxState>(
      listener: (context, state) {
        if (state is CheckedBoxState) {
          agreedToTermsAndConditions = true;
        } else if (state is UncheckedBoxState) {
          agreedToTermsAndConditions = false;
        }
      },
      builder: (context, state) {
        return InkWell(
          onTap: () {
            agreedToTermsAndConditions
                ? context.read<CheckBoxCubit>().unchecked()
                : context.read<CheckBoxCubit>().checkBox();
          },
          child: Padding(
            padding: EdgeInsets.all(5.w),
            child: SvgPicture.asset(
              agreedToTermsAndConditions
                  ? ImageConstants.checkedBox
                  : ImageConstants.uncheckedBox,
              width: 14.w,
              height: 14.w,
            ),
          ),
        );
      },
    );
  }
}
