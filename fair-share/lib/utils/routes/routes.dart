import 'package:fair_share/screens/addexpense/add_expense.dart';
import 'package:fair_share/screens/auth/login_screen.dart';
import 'package:fair_share/screens/auth/signup_screen.dart';
import 'package:fair_share/screens/createGroup/create_group_screen.dart';
import 'package:fair_share/screens/home/home_screen.dart';
import 'package:fair_share/screens/non-expenses/non-expenses_screen.dart';
import 'package:fair_share/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.home:
        return MaterialPageRoute(
          builder: (BuildContext context) => const HomeScreen(),
        );
      case RoutesName.signUp:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SignupScreen(),
        );
      case RoutesName.signIn:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SignInScreen(),
        );
      case RoutesName.addExpense:
        return MaterialPageRoute(
          builder: (BuildContext context) => const AddExpense(),
        );
      case RoutesName.nonExpenses:
        return MaterialPageRoute(
          builder: (BuildContext context) => const NonExpensesScreen(),
        );
      case RoutesName.createGroup:
        return MaterialPageRoute(
          builder: (BuildContext context) => const CreateGroupScreen(),
        );
      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text("No Route Found"))),
        );
    }
  }
}
