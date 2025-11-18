import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/features/properties/data/models/property_model.dart';

/// ---------------------------------------------------------------------------
/// 📋 PropertiesTableWidget — جدول العقارات في الداشبورد
/// ---------------------------------------------------------------------------
class PropertiesTableWidget extends StatelessWidget {
  const PropertiesTableWidget({super.key, required this.properties});

  final List<PropertyModel> properties;

  @override
  Widget build(BuildContext context) {
    if (properties.isEmpty) {
      return _buildEmptyState();
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        headingRowColor: WidgetStateProperty.all(
          AlessamyColors.primaryGold.withValues(alpha: 0.1),
        ),
        dataRowColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return AlessamyColors.primaryGold.withValues(alpha: 0.05);
          }
          return Colors.transparent;
        }),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        columns: [
          _buildColumn('الكود'),
          _buildColumn('العنوان'),
          _buildColumn('المدينة'),
          _buildColumn('الفئة'),
          _buildColumn('النوع'),
          _buildColumn('المساحة'),
          _buildColumn('السعر'),
          _buildColumn('الحالة'),
          _buildColumn('الإجراءات'),
        ],
        rows: properties.map((property) {
          return DataRow(
            cells: [
              _buildCell(property.code),
              _buildCell(property.title, maxWidth: 200),
              _buildCell(property.city),
              _buildCell(property.category?.arabicName ?? '-'),
              _buildCell(property.type.arabicName),
              _buildCell('${property.area.toStringAsFixed(0)} م²'),
              _buildCell(_formatPrice(property.price)),
              _buildStatusCell(property.purpose),
              _buildActionsCell(context, property),
            ],
          );
        }).toList(),
      ),
    );
  }

  DataColumn _buildColumn(String label) {
    return DataColumn(
      label: Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AlessamyColors.white,
        ),
      ),
    );
  }

  DataCell _buildCell(String text, {double? maxWidth}) {
    return DataCell(
      SizedBox(
        width: maxWidth,
        child: Text(
          text,
          style: TextStyle(fontSize: 13, color: AlessamyColors.textLight),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  DataCell _buildStatusCell(PropertyPurpose purpose) {
    Color bgColor;
    Color textColor;
    String label;

    switch (purpose) {
      case PropertyPurpose.sale:
        bgColor = Colors.green.withValues(alpha: 0.2);
        textColor = Colors.green;
        label = 'للبيع';
        break;
      case PropertyPurpose.rent:
        bgColor = Colors.blue.withValues(alpha: 0.2);
        textColor = Colors.blue;
        label = 'للإيجار';
        break;
      case PropertyPurpose.both:
        bgColor = Colors.orange.withValues(alpha: 0.2);
        textColor = Colors.orange;
        label = 'للبيع والإيجار';
        break;
    }

    return DataCell(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }

  DataCell _buildActionsCell(BuildContext context, PropertyModel property) {
    return DataCell(
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              // TODO: View property details
            },
            icon: Icon(
              Icons.visibility,
              size: 20,
              color: AlessamyColors.primaryGold,
            ),
            tooltip: 'عرض',
          ),
          IconButton(
            onPressed: () {
              // TODO: Edit property
            },
            icon: Icon(Icons.edit, size: 20, color: Colors.blue),
            tooltip: 'تعديل',
          ),
          IconButton(
            onPressed: () {
              // TODO: Delete property
              _showDeleteDialog(context, property);
            },
            icon: Icon(Icons.delete, size: 20, color: Colors.red),
            tooltip: 'حذف',
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(48),
        child: Column(
          children: [
            Icon(
              Icons.home_work_outlined,
              size: 80,
              color: AlessamyColors.textLight.withValues(alpha: 0.5),
            ),
            SizedBox(height: 16),
            Text(
              'لا توجد عقارات بعد',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AlessamyColors.textLight,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'ابدأ بإضافة عقار جديد من الزر في الأسفل',
              style: TextStyle(
                fontSize: 14,
                color: AlessamyColors.textLight.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatPrice(double price) {
    final formatter = NumberFormat('#,###', 'ar');
    return '${formatter.format(price)} ج.م';
  }

  void _showDeleteDialog(BuildContext context, PropertyModel property) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AlessamyColors.cardBackground,
        title: Text(
          'تأكيد الحذف',
          style: TextStyle(
            color: AlessamyColors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'هل أنت متأكد من حذف العقار "${property.title}"؟',
          style: TextStyle(color: AlessamyColors.textLight, fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'إلغاء',
              style: TextStyle(color: AlessamyColors.textLight, fontSize: 15),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Delete property from database
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text(
              'حذف',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
