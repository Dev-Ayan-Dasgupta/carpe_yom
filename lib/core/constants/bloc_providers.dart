import 'package:carpeyom/features/createpassword/presentation/bloc/createpasswordbloc/create_password_bloc.dart';
import 'package:carpeyom/features/emailVerification/presentation/bloc/letsStartbloc/lets_start_bloc.dart';
import 'package:carpeyom/features/emiratesIdVerification/presntation/bloc/eidSummary/index.dart';
import 'package:carpeyom/features/exploreMode/presentation/bloc/explorebloc/explore_home_bloc.dart';
import 'package:carpeyom/features/idVerification/presentation/bloc/emiratesIdVerification/index.dart';
import 'package:carpeyom/features/liveness/presentation/bloc/livenessCheck/index.dart';
import 'package:carpeyom/features/mobileNumberVerification/presentation/bloc/addmobilenumberbloc/add_mobile_number_bloc.dart';
import 'package:carpeyom/features/otpVerification/presentation/bloc/processVerification/process_verification_bloc.dart';
import 'package:carpeyom/features/securityQuestions/presentation/bloc/securityquestionbloc/security_questions_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class BlocProviders {
  static List<BlocProvider> blocProviders = [
    BlocProvider<IdVerificationBloc>(
      create: (context) => IdVerificationBloc(),
    ),
    BlocProvider<EidSummaryBloc>(
      create: (context) => EidSummaryBloc(),
    ),
    BlocProvider<LivenessCheckBloc>(
      create: (context) => LivenessCheckBloc(),
    ),
    BlocProvider<SecurityQuestionBloc>(
        create: (context) => SecurityQuestionBloc()),
    BlocProvider<LetsStartBloc>(create: (context) => LetsStartBloc()),
    BlocProvider<ExploreHomeBloc>(create: (context) => ExploreHomeBloc()),
    BlocProvider<ProcessVerificationBloc>(
        create: (context) => ProcessVerificationBloc()),
    BlocProvider<CreatePasswordBloc>(create: (context) => CreatePasswordBloc()),
    BlocProvider<AddMobileNumberBloc>(
        create: (context) => AddMobileNumberBloc()),
    // BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
    // // BlocProvider<ShowHideBloc>(create: (context) => ShowHideBloc()),
    // BlocProvider<EnableButtonBloc>(create: (context) => EnableButtonBloc()),
    // BlocProvider<EmailBloc>(create: (context) => EmailBloc()),
  ];
}
