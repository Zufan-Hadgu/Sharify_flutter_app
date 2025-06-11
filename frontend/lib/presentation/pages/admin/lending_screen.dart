// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../auth/base_screen.dart';
//
// class AdminLendingScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BaseScreen(
//       role: "admin",
//       currentRoute: '/lending',
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.library_books, size: 60, color: Colors.orange),
//             SizedBox(height: 20),
//             Text(
//               "Lending Management",
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             // Example action buttons
//             ElevatedButton.icon(
//               onPressed: () {},
//               icon: Icon(Icons.add),
//               label: Text("Add New Item"),
//             ),
//             SizedBox(height: 10),
//             ElevatedButton.icon(
//               onPressed: () {},
//               icon: Icon(Icons.list),
//               label: Text("View All Items"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }