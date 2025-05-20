// ignore_for_file: use_build_context_synchronously

import 'package:fair_share/constant/colors.dart';
import 'package:fair_share/providers/auth_provider/auth_provider.dart';
import 'package:fair_share/routes/routes_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AllColors.black,
      appBar: AppBar(
        title: Text("LogIn"),
        titleTextStyle: TextStyle(color: AllColors.white, fontSize: 22),
        backgroundColor: AllColors.purple0xFFC135E3,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Container(
          decoration: BoxDecoration(
            color: AllColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(15),
          child: Center(
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Text(
                        "Welcome Back",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: AllColors.purple0xFFC135E3,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * .05),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "Enter your Email",
                          labelText: "Email",
                        ),
                        validator: (value) {
                          return null;
                          // ToDo
                        },
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "Enter your Password",
                          labelText: "Password",
                        ),
                      ),

                      SizedBox(height: height * .2),
                      Consumer<AuthProviderClass>(
                        builder: (ctx, value, child) {
                          var loadingData =
                              ctx.watch<AuthProviderClass>().getLoading();
                          return CupertinoButton(
                            color: AllColors.purple0xFFC135E3,
                            child:
                                loadingData
                                    ? CircularProgressIndicator()
                                    : Text(
                                      "Login",
                                      style: TextStyle(
                                        color: AllColors.white,
                                        fontSize: 22,
                                      ),
                                    ),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                bool value = await ctx
                                    .read<AuthProviderClass>()
                                    .signIn(
                                      emailController.text,
                                      passwordController.text,
                                    );
                                if (value) {
                                  emailController.clear();
                                  passwordController.clear();
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    RoutesName.home,
                                    (route) => false,
                                  );
                                }
                              }
                            },
                          );
                        },
                      ),
                      SizedBox(height: height * .01),
                      Text(
                        "Don't have an account?",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: height * .01),
                      CupertinoButton(
                        color: AllColors.purple0xFFC135E3,
                        child: Text(
                          "Register",
                          style: TextStyle(
                            color: AllColors.white,
                            fontSize: 22,
                          ),
                        ),
                        onPressed: () async {
                          Navigator.pushNamed(context, RoutesName.signUp);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
