import 'package:flutter/material.dart';
import 'package:lenden/main.dart';
import 'package:lenden/views/permissions-views/AppUsage.views.dart';
import 'package:lenden/views/permissions-views/EmailUsage.views.dart';
import 'package:lenden/views/permissions-views/PhoneData.views.dart';
import 'package:lenden/views/survey-views/Survey.views.dart';

import '../form/qp7.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => EmailUsage(),
        );
      case '/AppUsage':
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => AppUsage(
                    data: args,
                  ));
        }
        return _errorRoute();

      case '/phoneData':
        return MaterialPageRoute(
          builder: (_) => PhoneData(),
        );

      case '/quesSeven':
        return MaterialPageRoute(
          builder: (_) => Qp7(),
        );

      case '/survey':
        return MaterialPageRoute(
          builder: (_) => Survey(),
        );

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
