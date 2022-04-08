import 'package:flutter/cupertino.dart';

final List<CardEditorTextManager> cardManagers = [
    CardEditorTextManager("Set  a card title (e.g Work or Personal)"),
    CardEditorTextManager("Enter your first name"),
    CardEditorTextManager("Enter your last name"),
    CardEditorTextManager("Enter your job title"),
    CardEditorTextManager("Enter your company name"),
  ]; 
  
  class CardEditorTextManager {

  final String title;
  final TextEditingController controller = TextEditingController();

  CardEditorTextManager(this.title);

  void dispose() {
    controller.dispose();
  }
}
