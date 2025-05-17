import 'package:fair_share/providers/auth_provider/auth_provider.dart';
import 'package:fair_share/providers/counter_provider.dart';

import 'package:fair_share/providers/list_map_provider.dart';
import 'package:fair_share/routes/routes.dart';
import 'package:fair_share/routes/routes_name.dart';
import 'package:fair_share/screens/auth/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(
    // MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(create: (_) => CounterProvider()),
    //     ChangeNotifierProvider(create: (_) => ListMapProvider()),
    //     ChangeNotifierProvider(create: (_) => AuthProvider()),
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterProvider()),
        ChangeNotifierProvider(create: (_) => ListMapProvider()),
        ChangeNotifierProvider(create: (_) => AuthProviderClass()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: SignupScreen(),
        initialRoute: RoutesName.signIn,
        onGenerateRoute: (settings) => Routes.generateRoutes(settings),
        // home: ChangeNotifierProvider(create: (_)=> CounterProvider(),child: HomePage(),),
      ),
    );
  }
}
