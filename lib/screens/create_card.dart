import 'package:flutter/material.dart';

class CreateCardScreen extends StatefulWidget {
  const CreateCardScreen({ Key? key }) : super(key: key);

  @override
  State<CreateCardScreen> createState() => _CreateCardScreenState();
}

class _CreateCardScreenState extends State<CreateCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Create a card"),
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      
    );
  }
}