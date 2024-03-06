// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:carpeyom/core/widgets/index.dart';
import 'package:carpeyom/features/emiratesIdVerification/presntation/bloc/eidSummary/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carpeyom/core/constants/index.dart';

class EidSummaryPage extends StatefulWidget {
  const EidSummaryPage({
    Key? key,
    this.argument,
  }) : super(key: key);

  final Object? argument;

  @override
  State<EidSummaryPage> createState() => _EidSummaryPageState();
}

class _EidSummaryPageState extends State<EidSummaryPage> with TextStyleMixin {
  late EidSummaryArgumentModel eidSummaryArgument;

  @override
  void initState() {
    super.initState();
    argumentInitialization();
  }

  void argumentInitialization() {
    eidSummaryArgument =
        EidSummaryArgumentModel.fromMap(widget.argument as dynamic ?? {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shape: appBarShape(),
        shadowColor: Colors.white,
        elevation: 2,
        toolbarHeight: 56.h,
        title: Text("Summary", style: appBarStyle()),
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
                    "Emirates ID Details",
                    style: headingStyle(),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Review the details of your scanned Emirates ID",
                    style: bodyStyle(color: AppColors.black80),
                  ),
                  SizedBox(height: 16.h),
                  DetailsTile(
                    length: eidSummaryArgument.details.length,
                    details: eidSummaryArgument.details,
                    boldIndices: const [],
                  ),
                ],
              ),
            ),
            BlocBuilder<EidSummaryBloc, EidSummaryState>(
              builder: (context, state) {
                return Column(
                  children: [
                    CheckBoxWithMessage(
                      onTap: () {
                        context.read<EidSummaryBloc>().add(
                              EidSummaryToggleEvent(),
                            );
                      },
                      icon:
                          state is EidSummaryAceptedState ? Icons.check : null,
                      text:
                          "I confirm the above-mentioned information is the same as on my Emirates ID card",
                    ),
                    SizedBox(height: 16.h),
                    state is EidSummaryAceptedState
                        ? GradientButton(
                            onTap: () {
                              EidSummaryBloc().onProceed(context);
                            },
                            text: "Proceed",
                          )
                        : SolidButton(onTap: () {}, text: "Proceed"),
                    SizedBox(height: 16.h),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () {
                          if (state is EidSummaryNotAcceptedState) {
                            Navigator.pop(context, true);
                          }
                        },
                        child: Text(
                          "Rescan Emirates ID",
                          style: bodyStyle(
                            fontWeight: FontWeight.bold,
                            color: state is EidSummaryAceptedState
                                ? AppColors.black40
                                : AppColors.green20,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.paddingOf(context).bottom)
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class EidSummaryArgumentModel {
  final List<DetailsTileModel> details;
  EidSummaryArgumentModel({
    required this.details,
  });

  EidSummaryArgumentModel copyWith({
    List<DetailsTileModel>? details,
  }) {
    return EidSummaryArgumentModel(
      details: details ?? this.details,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'details': details,
    };
  }

  factory EidSummaryArgumentModel.fromMap(Map<String, dynamic> map) {
    return EidSummaryArgumentModel(
      details: map['details'] as List<DetailsTileModel>,
    );
  }

  String toJson() => json.encode(toMap());

  factory EidSummaryArgumentModel.fromJson(String source) =>
      EidSummaryArgumentModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'EidSummaryArgumentModel(details: $details)';

  @override
  bool operator ==(covariant EidSummaryArgumentModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.details, details);
  }

  @override
  int get hashCode => details.hashCode;
}
