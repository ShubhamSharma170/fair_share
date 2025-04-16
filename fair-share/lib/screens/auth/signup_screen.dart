// ignore_for_file: use_build_context_synchronously

import 'package:fair_share/constant/colors.dart';
import 'package:fair_share/providers/auth_provider/auth_provider.dart';
import 'package:fair_share/utils/routes/routes_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AllColors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Sign Up"),
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
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "Enter your name",
                          labelText: "Name",
                        ),
                      ),
                      SizedBox(height: 15),
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

                      SizedBox(height: height * .1),
                      Consumer<AuthProviderClass>(
                        builder: (ctx, value, child) {
                          var loadingData =
                              ctx.watch<AuthProviderClass>().getLoading();
                          var loadingGoogleData =
                              ctx.watch<AuthProviderClass>().getGoogleLoading();
                          return Column(
                            children: [
                              CupertinoButton(
                                color: AllColors.purple0xFFC135E3,
                                child:
                                    loadingData
                                        ? CircularProgressIndicator(
                                          color: AllColors.white,
                                        )
                                        : Text(
                                          "Register",
                                          style: TextStyle(
                                            color: AllColors.white,
                                            fontSize: 22,
                                          ),
                                        ),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    bool value = await ctx
                                        .read<AuthProviderClass>()
                                        .userSignUp(
                                          emailController.text,
                                          passwordController.text,
                                        );
                                    if (value) {
                                      emailController.clear();
                                      passwordController.clear();
                                      nameController.clear();
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        RoutesName.home,
                                        (route) => false,
                                      );
                                    }
                                  }
                                },
                              ),
                              SizedBox(height: height * .01),
                              SizedBox(
                                width: width * .5,
                                height: 60,
                                child: CupertinoButton(
                                  color: AllColors.purple0xFFC135E3,
                                  child:
                                      loadingGoogleData
                                          ? CircularProgressIndicator(
                                            color: AllColors.white,
                                          )
                                          : Text(
                                            "Google Sign In",
                                            style: TextStyle(
                                              color: AllColors.white,
                                              fontSize: 22,
                                            ),
                                          ),
                                  onPressed: () async {
                                    bool value =
                                        await ctx
                                            .read<AuthProviderClass>()
                                            .googleSignIn();
                                    if (value) {
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        RoutesName.home,
                                        (route) => false,
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: height * .01),
                      Text(
                        "Already have an account?",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(height: height * .01),
                      CupertinoButton(
                        color: AllColors.purple0xFFC135E3,
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: AllColors.white,
                            fontSize: 22,
                          ),
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
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
