// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fair_share/constant/colors.dart';
import 'package:flutter/material.dart';

class NonExpensesScreen extends StatelessWidget {
  const NonExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(32),
      bottomLeft: Radius.circular(32),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Non Expenses Screen"),
        backgroundColor: AllColors.purple0xFFC135E3,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 10, top: 10),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('expense').snapshots(),
          builder: (context, snapshot) {
            // ✅ Loading state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // ✅ Error handling
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            // ✅ If no data
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No expenses found.'));
            }

            // ✅ Access documents
            final expenseDocs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: expenseDocs.length,
              itemBuilder: (context, index) {
                final doc = expenseDocs[index];
                final data = doc.data();

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    title: Text(data['description'] ?? 'No description'),
                    subtitle: Text('₹ ${data['amount'] ?? 0}'),
                    subtitleTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                    titleTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                    leading: Icon(Icons.group, color: AllColors.white),
                    // subtitle: Text("Expense Name"),
                    shape: RoundedRectangleBorder(borderRadius: borderRadius),
                    selectedTileColor: AllColors.grey,
                    style: ListTileStyle.drawer,
                    tileColor: AllColors.purple0xFFC135E3,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
