import 'package:flutter/material.dart';
import 'package:lenden/main.dart';
import 'package:lenden/views/permissions-views/AppUsage.views.dart';
import 'package:lenden/views/permissions-views/EmailUsage.views.dart';
import 'package:lenden/views/permissions-views/PhoneData.views.dart';
import 'package:lenden/views/survey-views/Survey.views.dart';
import 'package:lenden/form/ImageQues.views.dart';

import '../form/qp7.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => EmailUsage(),
        );
      case '/AppUsage':
        //eine emne conditon diya diya validation korte hoy bujsos???
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => AppUsageData(
                    data: args,
                  ));
        }
        return _errorRoute();

      case '/phoneData':
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => PhoneData(
                    data: args,
                  ));
        }
        return _errorRoute();

      case '/imageQues':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => ImageQues(data: args),
          );
        }
        return _errorRoute();

      case '/quesSeven':
        if (args is List) {
          return MaterialPageRoute(builder: (_) => Qp7(data: args));
        }
        return _errorRoute();

      case '/survey':
        if (args is String) {
          return MaterialPageRoute(builder: (_) => Survey(data: args));
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
