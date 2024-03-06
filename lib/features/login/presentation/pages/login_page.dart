// import 'package:carpeyom/core/constants/index.dart';
// import 'package:carpeyom/features/onboarding/presentation/bloc/enableButton/enable_button_state.dart';
// import 'package:carpeyom/features/onboarding/presentation/bloc/login/login_bloc.dart';
// import 'package:carpeyom/features/onboarding/presentation/bloc/login/login_event.dart';
// import 'package:carpeyom/features/onboarding/presentation/bloc/login/login_state.dart';
// import 'package:carpeyom/features/onboarding/presentation/widgets/index.dart';
// import 'package:email_validator/email_validator.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import '../../bloc/enableButton/enable_button_bloc.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> with TextStyleMixin {
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   bool isEmailValid = false;
//   bool showPassword = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         shadowColor: Colors.white,
//         backgroundColor: Colors.white,
//         elevation: 20,
//         toolbarHeight: 70,
//         title: Padding(
//           padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
//           child: SvgPicture.asset(ImageConstants.logoIcon),
//         ),
//         automaticallyImplyLeading: false,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(23.0),
//             child: SvgPicture.asset(
//               ImageConstants.supportAgent,
//               height: 20.h,
//               width: 20.w,
//             ),
//           ),
//         ],
//         centerTitle: true,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(25),
//                 bottomRight: Radius.circular(25)),
//           ),
//         ),
//       ),
//       body: Stack(
//         children: [
//           Padding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: 16.w,
//               ),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 30.h,
//                   ),
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Log in",
//                             style: headingStyle(),
//                           ),
//                           SizedBox(
//                             height: 20.h,
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 "Please enter your email and password",
//                                 style: bodyStyle(
//                                   fontWeight: FontWeight.w400,
//                                   color: AppColors.black20,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(
//                             height: 20.h,
//                           ),
//                           BlocBuilder<LoginBloc, LoginState>(
//                             builder: (context, state) {
//                               return CustomTextField(
//                                 controller: _emailController,
//                                 label: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Text(
//                                       "Email Address (User ID)",
//                                       style: hintStyle(
//                                           fontSize: 12.w,
//                                           fontWeight: FontWeight.w500,
//                                           color: AppColors.black100),
//                                     ),
//                                     const Asterisk(),
//                                   ],
//                                 ),
//                                 prefixIcon: Padding(
//                                   padding: const EdgeInsets.all(10.0),
//                                   child: SvgPicture.asset(
//                                     ImageConstants.envelope,
//                                     width: 20,
//                                     height: 20,
//                                     fit: BoxFit.fill,
//                                   ),
//                                 ),
//                                 hintText: "Email Address (User ID)",
//                                 focussedBorderColor: state is LoginEmailState &&
//                                         state.emailSuccess
//                                     ? AppColors.black100
//                                     : AppColors.black5,
//                                 suffixIcon: state is LoginEmailState &&
//                                         state.emailSuccess
//                                     ? Padding(
//                                         padding: EdgeInsets.only(right: 10.w),
//                                         child: SvgPicture.asset(
//                                           ImageConstants.checkCircle,
//                                           width: 20.w,
//                                           height: 20.w,
//                                         ),
//                                       )
//                                     : !(state is LoginEmailState &&
//                                             state.isEmailEmpty)
//                                         ? Padding(
//                                             padding:
//                                                 EdgeInsets.only(right: 10.w),
//                                             child: InkWell(
//                                               onTap: () {
//                                                 _emailController.clear();
//                                                 context.read<LoginBloc>().add(
//                                                     LoginEmailEvent(
//                                                         email: _emailController
//                                                             .text
//                                                             .trim(),
//                                                         showEmail: false));
//                                               },
//                                               child: SvgPicture.asset(
//                                                 ImageConstants.deleteText,
//                                                 width: 17.w,
//                                                 height: 17.w,
//                                               ),
//                                             ),
//                                           )
//                                         : const SizedBox.shrink(),
//                                 onChanged: emailValidation,
//                               );
//                             },
//                           ),
//                           SizedBox(
//                             height: 24.h,
//                           ),

//                           BlocBuilder<LoginBloc, LoginState>(
//                             builder: (context, state) {
//                               // if (state is ShowHideInitial) {
//                               return buildShowPassword(context, state);
//                               // }
//                               // if (state is HideState) {
//                               //   return buildShowPassword(context, state.isHide);
//                               // }
//                               // if (state is ShowState) {
//                               //   return buildShowPassword(context, state.isHide);
//                               // }
//                               // return const SizedBox();
//                             },
//                           ),

//                           //buildShowPassword,

//                           SizedBox(
//                             height: 36.h,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               InkWell(
//                                 onTap: () {
//                                   // Navigator.pushNamed(
//                                   //   context,
//                                   //   Routes.forgotPassword,
//                                   // );
//                                 },
//                                 // onForgotEmailPwd,
//                                 child: Text(
//                                   "Forgot Password?",
//                                   style: bodyStyle(
//                                     fontWeight: FontWeight.w600,
//                                     color: AppColors.green20,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 24,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Column(
//                     children: [
//                       InkWell(
//                         onTap: () {
//                           // Navigator.pushNamed(
//                           //   context,
//                           //   Routes.registration,
//                           //   arguments: RegistrationArgumentModel(
//                           //     isInitial: true,
//                           //     isUpdateCorpEmail: false,
//                           //   ).toMap(),
//                           // );
//                         },
//                         child: RichText(
//                           text: TextSpan(
//                             text: "Don't have an account?  ",
//                             style: bodyStyle(
//                               fontWeight: FontWeight.w400,
//                               color: AppColors.black100,
//                             ),
//                             children: const <TextSpan>[
//                               TextSpan(
//                                 text: "Register Now",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   color: AppColors.green20,
//                                   decoration: TextDecoration.underline,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20.h,
//                       ),
//                       BlocBuilder<EnableButtonBloc, EnableButtonState>(
//                         builder: (context, state) {
//                           if (state is DisabledButtonState ||
//                               state is EnableButtonInit) {
//                             return SolidButton(onTap: () {}, text: "Log In");
//                           } else {
//                             return GradientButton(
//                               onTap: () {
//                                 //onLogin(context);
//                               },
//                               text: "Log In",

//                               // auxWidget: state is LoginLoading
//                               //     ? const LoaderRow()
//                               //     : const SizedBox(),
//                             );
//                           }
//                         },

//                         //buildSubmitButton,
//                       ),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 20.h,
//                   ),
//                 ],
//               )
//               //   },
//               // ),
//               ),
//         ],
//       ),
//     );
//   }

//   void emailValidation(String stEmail) {
//     isEmailValid = EmailValidator.validate(stEmail);
//     context
//         .read<LoginBloc>()
//         .add(LoginEmailEvent(email: stEmail, showEmail: isEmailValid));
//     // context.read<EmailBloc>().add(ShowIcon(stEmail));
//     // isEmailValid = EmailValidator.validate(stEmail);
//     // context.read<EnableButtonBloc>().add(EnableButton(isEmailValid));
//     // context.read<EnableButtonBloc>().add(
//     //     EnableButton(!(!isEmailValid || _passwordController.text.length < 8)));
//   }

//   Widget buildShowPassword(
//     BuildContext context,
//     LoginState state,
//   ) {
//     return CustomTextField(
//       controller: _passwordController,
//       onChanged: (p0) {
//         // context.read<EnableButtonBloc>().add(EnableButton(isEmailValid));
//         // context.read<EnableButtonBloc>().add(EnableButton(
//         //     !(!isEmailValid || _passwordController.text.length < 8)));
//       },
//       label: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             "Password",
//             style: hintStyle(
//                 fontSize: 12.w,
//                 fontWeight: FontWeight.w500,
//                 color: AppColors.black100),
//           ),
//           const Asterisk(),
//         ],
//       ),
//       hintText: "Enter Password",
//       obscureText: state is LoginShowHideState && state.show,
//       maxLines: 1,
//       suffixIcon: Padding(
//         padding: EdgeInsets.only(right: 10.w),
//         child: InkWell(
//           onTap: () {
//             // if (state is LoginShowHideState) {
//             context
//                 .read<LoginBloc>()
//                 .add(LoginShowHidePasswordEvent(isShow: false));
//             // }
//           },
//           child: Icon(
//             state is LoginShowHideState && state.show
//                 ? Icons.visibility_off_outlined
//                 : Icons.visibility_outlined,
//             color: AppColors.black5,
//             size: 20.w,
//           ),
//         ),
//       ),
//     );
//   }
// }
