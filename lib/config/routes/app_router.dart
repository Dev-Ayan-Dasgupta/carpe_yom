import 'package:carpeyom/core/widgets/index.dart';
import 'package:carpeyom/features/createpassword/presentation/pages/create_password_page.dart';
import 'package:carpeyom/features/emailVerification/presentation/pages/lets_start_page.dart';
import 'package:carpeyom/features/emiratesIdVerification/presntation/pages/index.dart';
import 'package:carpeyom/features/exploreMode/presentation/pages/explore_dashboard_page.dart';
import 'package:carpeyom/features/exploreMode/presentation/pages/product_listing_explore_page.dart';
import 'package:carpeyom/features/fatcaCrs/presentation/pages/index.dart';
import 'package:carpeyom/features/launch/presentation/pages/splash_page.dart';
import 'package:carpeyom/features/launch/presentation/pages/stories_page.dart';
import 'package:carpeyom/features/liveness/presentation/pages/liveness_check.dart';
import 'package:carpeyom/features/mobileNumberVerification/presentation/pages/mobile_number_verification_page.dart';
import 'package:carpeyom/features/otpVerification/presentation/pages/otp_page.dart';
import 'package:carpeyom/features/securityQuestions/presentation/pages/security_question_page.dart';
import 'package:flutter/material.dart';
import 'package:carpeyom/config/routes/routes.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;
    switch (routeSettings.name) {
      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
        );
      case Routes.stories:
        return MaterialPageRoute(
          builder: (_) => const StoriesPage(),
        );
      case Routes.registration:
        return MaterialPageRoute(
          builder: (_) => LetsStartPage(
            argument: args,
          ),
        );
      case Routes.exploreDashboard:
        return MaterialPageRoute(
          builder: (_) => const ExploreDashboardPage(),
        );

      case Routes.exploreProductList:
        return MaterialPageRoute(
          builder: (_) => const ExploreProductListPage(),
        );

      case Routes.otp:
        return MaterialPageRoute(
          builder: (_) => OTPPage(
            argument: args,
          ),
        );
      case Routes.errorSuccess:
        return MaterialPageRoute(
          builder: (_) => ErrorSuccessScreen(
            argument: args,
          ),
        );

      case Routes.verificationInitializing:
        return MaterialPageRoute(
          builder: (_) => VerificationInitializingScreen(
            argument: args,
          ),
        );
      case Routes.idVerification:
        return MaterialPageRoute(
          builder: (_) => const IdVerificationScreen(),
        );
      case Routes.eidSummary:
        return MaterialPageRoute(
          builder: (_) => EidSummaryPage(
            argument: args,
          ),
        );
      case Routes.livenessCheck:
        return MaterialPageRoute(
          builder: (_) => const LivenessCheckScreen(),
        );

      case Routes.addressDetails:
        return MaterialPageRoute(
          builder: (_) => const AddressDetailsScreen(),
        );

      case Routes.createPasword:
        return MaterialPageRoute(
          builder: (_) => CreatePasswordPage(
            argument: args,
          ),
        );
      case Routes.verifyMobile:
        return MaterialPageRoute(
          builder: (_) => MobileNumberVerificationPage(
            argument: args,
          ),
        );

      case Routes.securityQuestion:
        return MaterialPageRoute(
          builder: (_) => const SecurityQuestionPage(),
        );

      // case Routes.login:
      //   return MaterialPageRoute(
      //     builder: (_) => const LoginPage(),
      //   );

      // case Routes.home:
      //   return MaterialPageRoute(
      //     builder: (_) => const HomePage(),
      //   );

      // case Routes.productList:
      //   return MaterialPageRoute(
      //     builder: (_) => const ProductListPage(),
      //   );

      // case Routes.productListDetails:
      //   return MaterialPageRoute(
      //     builder: (_) => const ProductListDetailsPage(),
      //   );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text("Empty Screen"),
            ),
          ),
        );
    }
  }
}
