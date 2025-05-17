import 'dart:developer';

import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:fair_share/constant/colors.dart';
import 'package:fair_share/providers/custom_method_provider/custom_method_provider.dart';
import 'package:fair_share/providers/firebase_method/firebase_method.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drop_down_list/drop_down_list.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController descController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  List<String> tempList = [];
  String? selectedGroup;

  @override
  void initState() {
    getValue();
    super.initState();
  }

  Future<void> getValue() async {
    Future.delayed(Duration.zero, () {
      context.read<CustomMethodProvider>().changeValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = context.watch<CustomMethodProvider>().getLoading();
    tempList = context.watch<FirebaseMethodProvider>().groupNameList;
    List<SelectedListItem<String>> groupNameList =
        tempList.map((toElement) => SelectedListItem(data: toElement)).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AllColors.purple0xFFC135E3,
        title: Text("Add Expense"),
        actions: [
          IconButton(
            onPressed: () async {
              if (descController.text.isEmpty ||
                  amountController.text.isEmpty) {
                log("empty");
                return;
              } else {
                if (selectedGroup != null) {
                  log("selected group $selectedGroup");
                  await context
                      .read<FirebaseMethodProvider>()
                      .addExpenseWithGroupName(
                        selectedGroup!,
                        descController.text,
                        amountController.text,
                      );
                } else {
                  bool value = await context
                      .read<FirebaseMethodProvider>()
                      .addExpense(descController.text, amountController.text);
                  if (value) {
                    log("check value $value");
                    descController.clear();
                    amountController.clear();
                  }
                }
              }
            },
            icon: Icon(Icons.check, color: AllColors.white),
          ),
        ],
      ),
      body:
          isLoading
              ? Center(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  color: AllColors.grey,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Consumer(
                        builder: (ctx, provider, child) {
                          return TextField(
                            decoration: InputDecoration(hintText: "Group Name"),
                            // enabled: false,
                            readOnly: true,
                            controller: TextEditingController(
                              text:
                                  ctx
                                      .read<FirebaseMethodProvider>()
                                      .selectedGroupName,
                            ),
                            onTap: () {
                              DropDownState<String>(
                                dropDown: DropDown<String>(
                                  isDismissible: true,
                                  bottomSheetTitle: const Text(
                                    "Select City",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  submitButtonText: 'Save',
                                  clearButtonText: 'Clear',
                                  data: groupNameList,
                                  onSelected: (selectedItems) {
                                    if (selectedItems.isEmpty) return;
                                    selectedGroup = selectedItems[0].data;

                                    List<String> list =
                                        selectedItems
                                            .map((e) => e.data)
                                            .toList();
                                    ctx
                                        .read<FirebaseMethodProvider>()
                                        .selectedGroupName = list[0];
                                    log(
                                      "selected list ${ctx.read<FirebaseMethodProvider>().selectedGroupName}",
                                    );
                                  },
                                  enableMultipleSelection: false,
                                  maxSelectedItems: 1,
                                ),
                              ).showModal(ctx);
                            },
                          );
                        },
                      ),

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
                              child: Icon(
                                Icons.document_scanner_sharp,
                                size: 40,
                              ),
                            ),
                            SizedBox(width: 10),
                            SizedBox(
                              width: 200,
                              height: 50,
                              child: TextField(
                                controller: descController,
                                decoration: InputDecoration(
                                  hintText: "Enter a description",
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
                              child: Icon(Icons.attach_money_rounded, size: 40),
                            ),
                            SizedBox(width: 10),
                            SizedBox(
                              width: 200,
                              height: 50,
                              child: TextField(
                                controller: amountController,
                                decoration: InputDecoration(
                                  hintText: "0.00",
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
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Paid by ",
                            style: TextStyle(color: AllColors.white),
                          ),
                          SizedBox(width: 10),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(color: AllColors.white),
                            ),
                            child: Text(
                              "You",
                              style: TextStyle(color: AllColors.white),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Spilt by ",
                            style: TextStyle(color: AllColors.white),
                          ),
                          SizedBox(width: 10),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              border: Border.all(color: AllColors.white),
                            ),
                            child: Text(
                              "Equally",
                              style: TextStyle(color: AllColors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
              : Center(child: CircularProgressIndicator()),
      floatingActionButton: SizedBox(
        height: 70, // custom height
        width: 120,
        child: FloatingActionButton(
          backgroundColor: AllColors.purple0xFFC135E3,
          onPressed: () {
            // Navigator.pushNamed(context, RoutesName.addExpense);
          },
          child: Text("Show Group", style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}
