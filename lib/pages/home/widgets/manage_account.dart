
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class ManageAccountPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     const SizedBox margin = SizedBox(
//       height: 30,
//     );
//     const divider = Divider(
//       height: 60,
//       thickness: 1.5,
//       color: Color.fromARGB(255, 206, 206, 206),
//     );
//     const padding = EdgeInsets.symmetric(horizontal: 20);
//     const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
//     final authService = Provider.of<AuthService>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Manage my account',
//           style: TextStyle(
//             fontSize: 18,
//           ),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.close),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           splashRadius: appSplashRadius,
//         ),
//       ),
//       body: ListView(
//         children: [
//           margin,
//           const Padding(
//             padding: padding,
//             child: Text(
//               'Login email: luisinuz@gmail.com',
//               style: style,
//             ),
//           ),
//           divider,
//           Padding(
//             padding: padding,
//             child: Row(
//               children: [
//                 const Text(
//                   'Sign out',
//                   style: style,
//                 ),
//                 Expanded(
//                   child: Align(
//                     alignment: Alignment.topRight,
//                     child: GestureDetector(
//                       child: const Icon(
//                         Icons.navigate_next,
//                         color: Colors.black,
//                         size: 40,
//                       ),
//                       onTap: () {
//                         showDialog(
//                           context: context,
//                           builder: (ctx) {
//                             return AlertDialog(
//                               content: const Text(
//                                 'Are you sure you want to sign out?',
//                               ),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () => Navigator.pop(context),
//                                   child: const Text('NO'),
                                
//                                 ),
//                                 TextButton(
//                                   onPressed: () async {
//                                      await authService.signOut();
//                                   //   Navigator.pop(context);
//                                   },
//                                   child: const Text('YES'),
//                                 )
//                               ],
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           divider
//         ],
//       ),
//     );
//   }
// }
