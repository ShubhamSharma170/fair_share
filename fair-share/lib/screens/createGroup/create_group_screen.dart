import 'package:fair_share/constant/colors.dart';
import 'package:flutter/material.dart';

class CreateGroupScreen extends StatelessWidget {
  const CreateGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Group Screen"),
        backgroundColor: AllColors.purple0xFFC135E3,
      ),
    );
  }
}
