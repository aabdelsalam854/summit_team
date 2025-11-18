import 'package:flutter/material.dart';
import 'package:summit_team/core/utils/app_styles.dart';
import 'package:summit_team/features/resposive/widgets/custom_background_container.dart';
import 'package:summit_team/features/resposive/widgets/custom_text_field.dart';
import 'package:summit_team/features/resposive/widgets/latest_transction.dart';
import 'package:summit_team/features/resposive/widgets/latest_transction_list_view.dart';
import 'package:summit_team/features/resposive/widgets/quick_invoice_form.dart';
import 'package:summit_team/features/resposive/widgets/quick_invoice_header.dart';
import 'package:summit_team/features/resposive/widgets/title_text_field.dart';

class QuickInvoice extends StatelessWidget {
  const QuickInvoice({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomBackgroundContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuickInvoiceHeader(),
          LatestTransction(),
          Divider(height: 48, color: Color(0xffF1F1F1)),
          QuickInvoiceForm(),
        ],
      ),
    );
  }
}
