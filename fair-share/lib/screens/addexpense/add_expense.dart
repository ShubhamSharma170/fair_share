import 'dart:developer';

import 'package:fair_share/constant/colors.dart';
import 'package:fair_share/providers/firebase_method/firebase_method.dart';
import 'package:fair_share/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  @override
  Widget build(BuildContext context) {
    TextEditingController descController = TextEditingController();
    TextEditingController amountController = TextEditingController();

    List tempList = ["test", "test2", "test3", "test4", "test5"];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AllColors.purple0xFFC135E3,
        title: Text("Add Expense"),
        actions: [
          IconButton(
            onPressed: () async {
              bool value = await context
                  .read<FirebaseMethodProvider>()
                  .addExpense(descController.text, amountController.text);
              if (value) {
                log("check value $value");
                descController.clear();
                amountController.clear();
              }
            },
            icon: Icon(Icons.check, color: AllColors.white),
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
              DropdownButton(
                items:
                    tempList
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                onChanged: (value) {},
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
                      child: Icon(Icons.document_scanner_sharp, size: 40),
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
                  Text("Paid by ", style: TextStyle(color: AllColors.white)),
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
                  Text("Spilt by ", style: TextStyle(color: AllColors.white)),
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
      ),
      floatingActionButton: SizedBox(
        height: 70, // custom height
        width: 120,
        child: FloatingActionButton(
          backgroundColor: AllColors.purple0xFFC135E3,
          onPressed: () {
            Navigator.pushNamed(context, RoutesName.addExpense);
          },
          child: Text("Show Group", style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}
