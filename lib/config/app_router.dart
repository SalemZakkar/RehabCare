import 'package:flutter/material.dart';

import '../screens/home/model/model_export.dart';
import '../screens/screens_export.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case HomeScreen.routeName:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AddBeneficiaryScreen.routeName:
        return MaterialPageRoute<List<Major>>(
            builder: (context) => AddBeneficiaryScreen(
                  major: routeSettings.arguments as List<Major>,
                ));
      case SplashScreen.routeName:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case NavigationBarScreen.routeName:
        return MaterialPageRoute(builder: (_) => const NavigationBarScreen());
      case AuthenticationScreen.routeName:
        return MaterialPageRoute(builder: (_) => const AuthenticationScreen());
      case PayNowScreen.routeName:
        final args = routeSettings.arguments as PayNowScreen;
        return MaterialPageRoute(
            builder: (_) => PayNowScreen(
                  childrenParent: args.childrenParent,
                  isEditing: args.isEditing,
                ));
      case PaymentSuccessScreen.routName:
        return MaterialPageRoute(builder: (_) => const PaymentSuccessScreen());
      case ReviewsPage.routeName:
        ReviewsPage data = routeSettings.arguments as ReviewsPage;
        return MaterialPageRoute(
            builder: (context) => ReviewsPage(
                  reviewModel: data.reviewModel,
                ));
      case AllReviewsScreen.routeName:
        AllReviewsScreen data = routeSettings.arguments as AllReviewsScreen;
        return MaterialPageRoute(
            builder: (context) => AllReviewsScreen(
                  majorId: data.majorId,
                  childId: data.childId,
                ));
      case AllTreatingPlansScreen.routeName:
        AllTreatingPlansScreen data =
            routeSettings.arguments as AllTreatingPlansScreen;
        return MaterialPageRoute(
            builder: (context) => AllTreatingPlansScreen(
                  childId: data.childId,
                  majorId: data.majorId,
                ));
      case ViewTreatingPlan.routeName:
        ViewTreatingPlan data = routeSettings.arguments as ViewTreatingPlan;
        return MaterialPageRoute(
            builder: (context) => ViewTreatingPlan(
                  id: data.id,
                  name: data.name,
                ));
      case PaymentLog.routeName:
        return MaterialPageRoute(builder: (context) => const PaymentLog());
      case ContactUs.routeName:
        return MaterialPageRoute(builder: (context) => const ContactUs());
      case HelpCenter.routeName:
        return MaterialPageRoute(builder: (context) => const HelpCenter());
      case SettingScreen.routeName:
        return MaterialPageRoute(builder: (context) => const SettingScreen());
      case SelectBeneficiaryScreen.routeName:
        return MaterialPageRoute<ChildrenParent>(
            builder: (context) => const SelectBeneficiaryScreen());
      case NewPassword.routeName:
        return MaterialPageRoute<ChildrenParent>(
            builder: (context) => const NewPassword());
      case EditBeneficiaryScreen.routeName:
        return MaterialPageRoute<ChildrenParent>(
            builder: (context) => EditBeneficiaryScreen(
                childrenParent: routeSettings.arguments as ChildrenParent));
      case PersonalScreen.routeName:
        return MaterialPageRoute(builder: (context) => const PersonalScreen());
      case AttachmentScreen.routeName:
        AttachmentScreen attachmentScreen =
            routeSettings.arguments as AttachmentScreen;
        return MaterialPageRoute(
            builder: (context) => AttachmentScreen(
                  childId: attachmentScreen.childId,
                ));
      case AllVideoScreen.routeName:
        return MaterialPageRoute(
            builder: (context) => AllVideoScreen(
                  childId: routeSettings.arguments as String,
                  majorId: routeSettings.arguments as String,
                ));
      default:
        return null;
    }
  }
}
