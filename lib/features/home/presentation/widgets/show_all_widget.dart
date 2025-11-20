
// import 'package:flutter/material.dart';

// class SectionHeaderWidget extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final VoidCallback onViewAll;

//   const SectionHeaderWidget({
//     super.key,
//     required this.title,
//     required this.subtitle,
//     required this.onViewAll,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 48),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white, // AlessamyColors.textOnBlack
//                 ),
//               ),
//               const SizedBox(height: 6),
//               Text(
//                 subtitle,
//                 style: const TextStyle(fontSize: 15, color: Colors.grey),
//               ),
//             ],
//           ),

//           // زر View All
//           ElevatedButton.icon(
//             onPressed: onViewAll,
//             icon: const Icon(Icons.arrow_forward, size: 20),
//             label: const Text(
//               'View All',
//               style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//             ),
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.amber, // AlessamyColors.primaryGold
//               foregroundColor: Colors.black,
//               padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(14),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
