import 'package:fair_share/constant/colors.dart';
import 'package:fair_share/providers/firebase_method/firebase_method.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateGroupScreen extends StatelessWidget {
  const CreateGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController groupNameController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Group Screen"),
        backgroundColor: AllColors.purple0xFFC135E3,
        actions: [
          IconButton(
            icon: Icon(Icons.check, color: AllColors.white),
            onPressed: () async {
              bool value = await context
                  .read<FirebaseMethodProvider>()
                  .addGroupName(groupNameController.text);
              if (value) {
                groupNameController.clear();
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          color: AllColors.grey,
          width: MediaQuery.of(context).size.width,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // description
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
                        border: Border.all(color: AllColors.white),
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
                            color: AllColors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
