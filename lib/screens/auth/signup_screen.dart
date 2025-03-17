import 'package:fair_share/constant/colors.dart';
import 'package:fair_share/providers/auth_provider/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey formKey = GlobalKey<FormState>();
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AllColors.black,
      appBar: AppBar(title: Text("Sign Up")),
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
                        validator: (value) {},
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
                      Consumer<AuthProvider>(
                        builder: (ctx, value, child) {
                          var loadingData =
                              ctx.watch<AuthProvider>().getLoading();
                          return CupertinoButton(
                            child:
                                loadingData
                                    ? CircularProgressIndicator()
                                    : Text(
                                      "Register",
                                      style: TextStyle(
                                        color: AllColors.black,
                                        fontSize: 22,
                                      ),
                                    ),
                            onPressed: () {
                              ctx.read<AuthProvider>().userSignUp(
                                emailController.text,
                                passwordController.text,
                              );
                            },
                          );
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
