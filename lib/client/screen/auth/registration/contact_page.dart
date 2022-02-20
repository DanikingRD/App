import 'package:digital_card_app/client/screen/home_screen.dart';
import 'package:digital_card_app/common/constants.dart';
import 'package:digital_card_app/common/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContactPage extends StatelessWidget {

  final EdgeInsetsGeometry _margin;

  ContactPage(this._margin);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: _margin,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('How do we contanct you? ', style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 32),
                    AppUtil.textInputWithBorder(ctx: context, label: 'Email Address', action: TextInputAction.next),
                    AppUtil.textInputWithBorder(ctx: context, label: 'Phone Number', action: TextInputAction.done),
                    const SizedBox(height: 32),
                    Align(
                      alignment: Alignment.topRight,
                      child: FloatingActionButton(  
                      child: const Icon(Icons.navigate_next),
                      backgroundColor: primaryColor,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                           return HomeScreen();
                        }));
                      }
                    ),
                  )
                  ],
              ),
            ),
          ),
        ),
    );
  }
}