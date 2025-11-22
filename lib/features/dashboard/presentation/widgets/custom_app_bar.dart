import 'package:flutter/material.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/core/utils/app_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String userName;
  final String userRole;
  final String? searchHint;
  final TextEditingController? searchController;
  final VoidCallback? onProfileTap;
  final ValueChanged<String>? onSearchChanged;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.userName,
    required this.userRole,
    this.searchHint = 'بحث...',
    this.searchController,
    this.onProfileTap,
    this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: AlessamyColors.primaryGold,
      elevation: 0,
      // toolbarHeight: 80,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.white), // 👈 غير اللون هنا
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),

      title: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: AppStyles.styleBold18(
                context,
              ).copyWith(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 16),
          // Expanded(
          //   flex: 3,
          //   child: SizedBox(
          //     height: 40,
          //     child: TextField(
          //       controller: searchController,
          //       onChanged: onSearchChanged,
          //       decoration: InputDecoration(
          //         hintText: searchHint,
          //         prefixIcon: const Icon(Icons.search),
          //         filled: true,
          //         fillColor: Colors.white,
          //         contentPadding: const EdgeInsets.symmetric(
          //           vertical: 0,
          //           horizontal: 12,
          //         ),
          //         border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(12),
          //           borderSide: BorderSide.none,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child:
                // UserInfoListTile(
                //   userInfoModel: UserInfoModel(
                //     image: 'assets/images/user_avatar.png',
                //     title: userName,
                //     subTitle: userRole,
                //   ),
                // ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: AlessamyColors.primaryGold,
                      child: IconButton(
                        onPressed: onProfileTap,
                        icon: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              userName,
                              style: AppStyles.styleRegular12(
                                context,
                              ).copyWith(color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              userRole,
                              style: AppStyles.styleRegular12(
                                context,
                              ).copyWith(color: Colors.white70),

                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
          ),
        ],
      ),
      actions: const [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
