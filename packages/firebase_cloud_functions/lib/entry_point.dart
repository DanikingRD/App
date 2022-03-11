library firebase_cloud_functions;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class FirebaseCloudFunctions {
  /// Initializes a new [FirebaseApp] instance.
   static Future<void> init() async  {
      WidgetsFlutterBinding.ensureInitialized(); 
      await Firebase.initializeApp();
   }
}
