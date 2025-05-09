import 'package:fair_share/providers/auth_provider/auth_provider.dart';
import 'package:fair_share/providers/counter_provider.dart';
import 'package:fair_share/providers/custom_method_provider/custom_method_provider.dart';
import 'package:fair_share/providers/firebase_method/firebase_method.dart';

import 'package:fair_share/providers/list_map_provider.dart';
import 'package:fair_share/utils/routes/routes_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'utils/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    // MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(create: (_) => CounterProvider()),
    //     ChangeNotifierProvider(create: (_) => ListMapProvider()),
    //     ChangeNotifierProvider(create: (_) => AuthProviderClass()),
    //   ],
    //   child: const MyApp(),
    // ),
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterProvider()),
        ChangeNotifierProvider(create: (_) => ListMapProvider()),
        ChangeNotifierProvider(create: (_) => AuthProviderClass()),
        ChangeNotifierProvider(create: (_) => FirebaseMethodProvider()),
        ChangeNotifierProvider(create: (_) => CustomMethodProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        // home: user != null ? const HomeScreen() : const SignupScreen(),
        initialRoute: user != null ? RoutesName.home : RoutesName.signIn,
        onGenerateRoute: (settings) => Routes.generateRoutes(settings),
        // home: ChangeNotifierProvider(create: (_)=> CounterProvider(),child: HomePage(),),
      ),
    );
  }
}
