import 'package:epifanie/screens/widgets/header.dart';
import 'package:epifanie/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
Widget build(BuildContext context) {
  return GestureDetector(

    child: Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header()
          ],
        ),
      )

    ),
  );
}

}
