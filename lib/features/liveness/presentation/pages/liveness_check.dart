import 'package:carpeyom/core/constants/index.dart';
import 'package:carpeyom/core/widgets/index.dart';
import 'package:carpeyom/features/liveness/presentation/bloc/livenessCheck/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LivenessCheckScreen extends StatefulWidget {
  const LivenessCheckScreen({super.key});

  @override
  State<LivenessCheckScreen> createState() => _LivenessCheckScreenState();
}

class _LivenessCheckScreenState extends State<LivenessCheckScreen>
    with TextStyleMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shape: appBarShape(),
        shadowColor: Colors.white,
        elevation: 2,
        toolbarHeight: 56.h,
        title: Text("Liveness Check", style: appBarStyle()),
        automaticallyImplyLeading: false,
        centerTitle: true,
        flexibleSpace: const AppBarFlexibleSpace(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  Text(
                    "Smile, Camera, Action! It will help to complete your verification",
                    style: headingStyle(),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Look into the camera frame, follow the screen prompts and your good to go.",
                    style: bodyStyle(color: AppColors.black20),
                  ),
                  SizedBox(height: 64.h),
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(ImageConstants.livenessCheck),
                  )
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15.sp)),
                    color: AppColors.green10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Instructions",
                        style: bodyStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                          color: AppColors.black100,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Make sure your phone camera is steady and equally lit under the light.",
                        style: bodyStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                          color: AppColors.black100,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                BlocConsumer<LivenessCheckBloc, LivenessCheckState>(
                  listener: (context, state) {
                    if (state is LivenessCheckSuccessState) {
                      LivenessCheckBloc().showLivenessCheckSuccess(context);
                    } else if (state is LivenessCheckFailedState) {
                      LivenessCheckBloc().showLivenessCheckFailed(context);
                    }
                  },
                  builder: (context, state) {
                    return GradientButton(
                      onTap: () {
                        context
                            .read<LivenessCheckBloc>()
                            .add(LivenessCheckEvent());
                      },
                      text: "Proceed",
                      auxWidget: state is LivenessCheckScanningState
                          ? const ButtonLoader()
                          : const SizedBox.shrink(),
                    );
                  },
                ),
                SizedBox(height: MediaQuery.paddingOf(context).bottom),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
