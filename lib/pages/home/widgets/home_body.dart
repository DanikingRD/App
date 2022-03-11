import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeBodyWidget extends StatefulWidget {

  @override
  State<HomeBodyWidget> createState() => _HomeBodyWidgetState();
}

class _HomeBodyWidgetState extends State<HomeBodyWidget> {
  @override
  Widget build(BuildContext context) {
    print('BUILD()========================================================');
    final users = Provider.of<Object>(context);
  
    // final query = Provider.of<List<UserModel>>(context);
    // for (var i in query) {
    //   print(i);
    // }
    
    return Container();
  }

 Widget insertEntry({
    required String field,
    required String data,
    required IconData icon,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(data),
      subtitle: Text(field),
    );
  } 
}