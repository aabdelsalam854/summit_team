// import 'package:flutter/material.dart';
// import 'package:summit_team/core/extensions/size.dart';
// import 'package:summit_team/core/utils/app_colors.dart';
// import 'package:summit_team/core/extensions/translate.dart';
// import 'package:summit_team/features/app/data/models/on_boarding_model.dart';

// class OnBoardingItem extends StatelessWidget {
//   final OnBoardingModel model;
//   const OnBoardingItem({super.key, required this.model});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 100,
//       height: 70,
//       alignment: Alignment.bottomCenter,
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           fit: BoxFit.fitHeight,
//           image: AssetImage(model.img),
//         ),
//       ),
//       child: Container(
//         width: 100,
//         height: 26,
//         padding: EdgeInsets.all(4),
//         decoration: BoxDecoration(
//           color: AppColors.white,
//           borderRadius: BorderRadius.vertical(
//             top: Radius.circular(3),
//           ),
//         ),
//         child: Column(
//           children: [
//             SizedBox(height: 3),
//             Text(
//               model.title.tr,
//               style: Theme.of(context).textTheme.headlineLarge,
//             ),
//             SizedBox(height: 3),
//             Text(
//               model.body.tr,
//               textAlign: TextAlign.center,
//               style: Theme.of(context).textTheme.titleSmall,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
