// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorSuccessScreen extends StatefulWidget {
  const ErrorSuccessScreen({
    Key? key,
    this.argument,
  }) : super(key: key);

  final Object? argument;

  @override
  State<ErrorSuccessScreen> createState() => _ErrorSuccessScreenState();
}

class _ErrorSuccessScreenState extends State<ErrorSuccessScreen> {
  late ErrorSuccessArgumentModel errorSuccessArgument;

  @override
  void initState() {
    super.initState();
    errorSuccessArgument =
        ErrorSuccessArgumentModel.fromMap(widget.argument as dynamic ?? {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: errorSuccessArgument.header,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            Expanded(
                child: errorSuccessArgument.body ?? const SizedBox.shrink()),
            errorSuccessArgument.footer ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class ErrorSuccessArgumentModel {
  final PreferredSizeWidget? header;
  final Widget? body;
  final Widget? footer;
  ErrorSuccessArgumentModel({
    this.header,
    this.body,
    this.footer,
  });

  ErrorSuccessArgumentModel copyWith({
    PreferredSizeWidget? header,
    Widget? body,
    Widget? footer,
  }) {
    return ErrorSuccessArgumentModel(
      header: header ?? this.header,
      body: body ?? this.body,
      footer: footer ?? this.footer,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'header': header,
      'body': body,
      'footer': footer,
    };
  }

  factory ErrorSuccessArgumentModel.fromMap(Map<String, dynamic> map) {
    return ErrorSuccessArgumentModel(
      header: map['header'] as PreferredSizeWidget?,
      body: map['body'] as Widget?,
      footer: map['footer'] as Widget?,
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorSuccessArgumentModel.fromJson(String source) =>
      ErrorSuccessArgumentModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ErrorSuccessArgumentModel(header: $header, body: $body, footer: $footer)';

  @override
  bool operator ==(covariant ErrorSuccessArgumentModel other) {
    if (identical(this, other)) return true;

    return other.header == header &&
        other.body == body &&
        other.footer == footer;
  }

  @override
  int get hashCode => header.hashCode ^ body.hashCode ^ footer.hashCode;
}
