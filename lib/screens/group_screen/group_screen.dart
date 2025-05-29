// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:developer';

import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:fair_share/constant/colors.dart';
import 'package:fair_share/providers/firebase_method/firebase_method.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupScreen extends StatefulWidget {
  String groupName;
  GroupScreen({required this.groupName, super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  List<String> tempUserList = [];
  List<SelectedListItem<String>> selectedUserList = [];
  List<dynamic> userLit = [];
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await context.read<FirebaseMethodProvider>().showUserNameList();
      tempUserList =
          context.read<FirebaseMethodProvider>().getUserNameList()
              as List<String>;
      log("tempUserList $tempUserList");
      selectedUserList =
          tempUserList.map((e) => SelectedListItem(data: e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    userLit = context.watch<FirebaseMethodProvider>().getSelectedUserNameList();
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupName),
        backgroundColor: AllColors.purple0xFFC135E3,
      ),
      body: SizedBox(
        height: height,
        child: Column(
          children: [
            Text(
              "User List",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 10,
                  right: 10,
                  bottom: 10,
                ),
                child:
                    userLit.isEmpty
                        ? const Center(child: Text("No User Found"))
                        : ListView.builder(
                          itemCount: userLit.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(title: Text(userLit[index])),
                            );
                          },
                        ),
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: SizedBox(
        width: 130,
        height: 50,
        child: Consumer(
          builder: (ctx, provider, child) {
            return FloatingActionButton(
              backgroundColor: AllColors.purple0xFFC135E3,
              onPressed: () {
                DropDownState<String>(
                  dropDown: DropDown<String>(
                    isDismissible: true,
                    bottomSheetTitle: const Text(
                      "Select Group Name",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    submitButtonText: 'Save',
                    clearButtonText: 'Clear',
                    data: selectedUserList,
                    onSelected: (selectedItems) {
                      if (selectedItems.isEmpty) return;
                      // log("selectedItems ${selectedItems[1].data}");
                      for (var element in selectedItems) {
                        log("element ${element.data}");
                      }
                      ctx.read<FirebaseMethodProvider>().addUserInGroup(
                        selectedItems.map((e) => e.data).toList(),
                        widget.groupName,
                      );
                    },
                    enableMultipleSelection: true,
                    // maxSelectedItems: 1,
                  ),
                ).showModal(ctx);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Colors.white),
                  Text(
                    "Add Member",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
