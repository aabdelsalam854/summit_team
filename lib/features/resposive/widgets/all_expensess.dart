import 'package:flutter/material.dart';
import 'package:summit_team/features/resposive/widgets/all_expensess_header.dart';
import 'package:summit_team/features/resposive/widgets/all_expensess_items_list_view.dart';
import 'package:summit_team/features/resposive/widgets/custom_background_container.dart';

class AllExpenses extends StatelessWidget {
  const AllExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomBackgroundContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AllExpensessHeader(),
          SizedBox(height: 16),
          AllExpensessItemsListView(),
        ],
      ),
    );
  }
}
