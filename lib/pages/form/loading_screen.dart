// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// class LoadingScreen extends StatefulWidget {
//   const LoadingScreen({Key? key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _LoadingScreenState();
// }

// class _LoadingScreenState extends State<LoadingScreen> {
//  // static final AuthService _authService = AuthService();

//   @override
//   Widget build(BuildContext context) {
//     const margin = SizedBox(height: 40);
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(32.0),
//         child: Column(
//           children: const [
//             margin,
//             Text(
//               'Hang tight, we\'re signing you in!',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 24,
//               ),
//             ),
//             Expanded(
//               // This expands the row element vertically because it's inside a column
//               child: SpinKitRing(
//                 color: homeColor,
//                 size: 50,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     registerUser(
//       form: ModalRoute.of(context)!.settings.arguments as Map<String, String>,
//       context: context,
//     );
//   }

//   void sendToFirestore({required Map<String, String> form}) async {
//     form['uid'] = _authService.getUser()!.uid;
//     final LoggedUser model = LoggedUser.fromMap(form);
//     final database = Database();
//     database.addUser(model: model);
//     Navigator.pushNamed(context, homePage);
//   //  RegistrationFormTemplateState.form.clear();
//   }

//   void registerUser({
//     required Map<String, String> form,
//     required BuildContext context,
//   }) async {
//     try {
//       await _authService.createUser(
//         email: form['email']!,
//         password: form['password']!,
//       );
//       sendToFirestore(form: form);
//       print('created user successfully');
//     } on FirebaseAuthException catch (exception) {
//       print('EXCEPTION: ${exception.code}');
//       switch (exception.code) {
//         case 'email-already-in-use':
//           createDialog(
//             content: const Text(
//               'Your email address is already being used. Try a different one.',
//             ),
//             routePage: RegistrationScreen.contactPage,
//             context: context,
//           );
//           break;

//         default:
//           createDialog(
//             content: const Text(
//               'An unknown error happened. Try later.',
//             ),
//             context: context,
//           );
//           break;
//       }
//     }
//   }

//   void createDialog({
//     required final Text content,
//     required BuildContext context,
//     final String routePage = welcomePage,
//   }) {
//     showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//         content: content,
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.popUntil(
//                 context,
//                 ModalRoute.withName(
//                   routePage,
//                 ),
//               );
//             },
//             child: const Text(
//               'GOT IT',
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }


//   // void attemptToRegister() async {
//   //   await LoadingScreen.authServiceProvider
//   //       .createUser(
//   //         email: Get.arguments['email'],
//   //         password: Get.arguments['password'],
//   //       )
//   //       .then(
//   //         (value) => {
//   //           createUserModel(value!),
//   //         },
//   //       );
//   // }


