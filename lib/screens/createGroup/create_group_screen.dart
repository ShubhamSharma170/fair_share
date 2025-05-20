import 'package:fair_share/constant/colors.dart';
import 'package:fair_share/providers/firebase_method/firebase_method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateGroupScreen extends StatelessWidget {
  const CreateGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController groupNameController = TextEditingController();
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Group Screen"),
        backgroundColor: AllColors.purple0xFFC135E3,
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.check, color: AllColors.white),
        //     onPressed: () async {
        //       bool value = await context
        //           .read<FirebaseMethodProvider>()
        //           .addGroupName(groupNameController.text);
        //       if (value) {
        //         groupNameController.clear();
        //       }
        //     },
        //   ),
        // ],
      ),
      body: Center(
        child: Container(
          color: AllColors.grey,
          width: MediaQuery.of(context).size.width,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Container(
                width: 300,
                height: height * 0.3,
                decoration: BoxDecoration(
                  border: Border.all(color: AllColors.white),
                  borderRadius: BorderRadius.circular(10),
                  color: AllColors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(height: height * 0.025),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Group Name",
                        style: TextStyle(
                          color: AllColors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              border: Border.all(color: AllColors.black),
                            ),
                            child: Icon(Icons.group, size: 40),
                          ),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 200,
                            height: 50,
                            child: TextField(
                              controller: groupNameController,
                              decoration: InputDecoration(
                                hintText: "Enter a group name",
                                hintStyle: TextStyle(
                                  color: AllColors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.05),
                    CupertinoButton(
                      onPressed: () async {
                        bool value = await context
                            .read<FirebaseMethodProvider>()
                            .addGroupName(groupNameController.text);
                        if (value) {
                          groupNameController.clear();
                        }
                      },
                      color: AllColors.purple0xFFC135E3,
                      child: Text(
                        "Create Group",
                        style: TextStyle(color: AllColors.white),
                      ),
                    ),
                  ],
                ),
              ),

              // description
            ],
          ),
        ),
      ),
    );
  }
}
