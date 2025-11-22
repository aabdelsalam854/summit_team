// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import 'package:summit_team/core/utils/app_styles.dart';
// import 'package:summit_team/features/dashboard/presentation/model/user_info_model.dart';

// class UserInfoListTile extends StatelessWidget {
//   const UserInfoListTile({super.key, required this.userInfoModel});
//   final UserInfoModel userInfoModel;
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ListTile(
//  leading: SizedBox(
//   width: 40,
//   height: 40,
//   child: ClipRRect(
//     borderRadius: BorderRadius.circular(8),
//     child: Image.network(
//       userInfoModel.image,
//       fit: BoxFit.cover,
//       errorBuilder: (context, error, stackTrace) {
//         return Icon(Icons.person);
//       },
//     ),
//   ),
// ),

//         title: FittedBox(
//           fit: BoxFit.scaleDown,
//           alignment: AlignmentDirectional.centerStart,
//           child: Text(
//             userInfoModel.title,
//             style: AppStyles.styleSemiBold16(context),
//           ),
//         ),
//         subtitle: FittedBox(
//           fit: BoxFit.scaleDown,
//           alignment: AlignmentDirectional.centerStart,
//           child: Text(
//             userInfoModel.subTitle,
//             style: AppStyles.styleRegular12(context),
//           ),
//         ),
//       ),
//     );
//   }
// }
