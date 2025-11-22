// widgets/category_dialog.dart
import 'package:flutter/material.dart';
import 'package:summit_team/features/city/ui/models.dart';

class CategoryDialog extends StatefulWidget {
  final PropertyCategoryModel? category;
  final String cityId;
  final Function(Map<String, dynamic>) onSave;

  const CategoryDialog({
    Key? key,
    this.category,
    required this.cityId,
    required this.onSave,
  }) : super(key: key);

  @override
  State<CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameArController;
  late TextEditingController _nameEnController;
  late bool _isActive;
  late IconData _selectedIcon;

  final List<Map<String, dynamic>> _availableIcons = [
    {'icon': Icons.apartment, 'nameAr': 'شقة', 'nameEn': 'Apartment'},
    {'icon': Icons.villa, 'nameAr': 'فيلا', 'nameEn': 'Villa'},
    {'icon': Icons.store, 'nameAr': 'محل تجاري', 'nameEn': 'Shop'},
    {'icon': Icons.local_hospital, 'nameAr': 'عيادة', 'nameEn': 'Clinic'},
    {'icon': Icons.weekend, 'nameAr': 'استوديو', 'nameEn': 'Studio'},
    {'icon': Icons.business, 'nameAr': 'مكتب', 'nameEn': 'Office'},
    {'icon': Icons.warehouse, 'nameAr': 'مخزن', 'nameEn': 'Warehouse'},
    {'icon': Icons.cottage, 'nameAr': 'شاليه', 'nameEn': 'Chalet'},
    {'icon': Icons.home, 'nameAr': 'منزل', 'nameEn': 'House'},
    {'icon': Icons.hotel, 'nameAr': 'فندق', 'nameEn': 'Hotel'},
    {'icon': Icons.factory, 'nameAr': 'مصنع', 'nameEn': 'Factory'},
    {'icon': Icons.agriculture, 'nameAr': 'أرض زراعية', 'nameEn': 'Farm Land'},
  ];

  @override
  void initState() {
    super.initState();
    _nameArController = TextEditingController(text: widget.category?.nameAr ?? '');
    _nameEnController = TextEditingController(text: widget.category?.nameEn ?? '');
    _isActive = widget.category?.isActive ?? true;
    _selectedIcon = widget.category?.icon ?? Icons.apartment;
  }

  @override
  void dispose() {
    _nameArController.dispose();
    _nameEnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF16213E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: 600,
        constraints: const BoxConstraints(maxHeight: 700),
        padding: const EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4AF37).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      widget.category == null ? Icons.add_business : Icons.edit,
                      color: const Color(0xFFD4AF37),
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    widget.category == null ? 'إضافة تصنيف جديد' : 'تعديل التصنيف',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              
              // اختيار الأيقونة
              Text(
                'اختر الأيقونة',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.7),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                height: 140,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                ),
                child: GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: _availableIcons.length,
                  itemBuilder: (context, index) {
                    final iconData = _availableIcons[index];
                    final icon = iconData['icon'] as IconData;
                    final isSelected = _selectedIcon == icon;
                    
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIcon = icon;
                          if (_nameArController.text.isEmpty) {
                            _nameArController.text = iconData['nameAr'];
                          }
                          if (_nameEnController.text.isEmpty) {
                            _nameEnController.text = iconData['nameEn'];
                          }
                        });
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFD4AF37).withOpacity(0.2)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFFD4AF37)
                                : Colors.white.withOpacity(0.1),
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Icon(
                          icon,
                          color: isSelected
                              ? const Color(0xFFD4AF37)
                              : Colors.white.withOpacity(0.5),
                          size: 28,
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 24),
              
              // اسم التصنيف بالعربي
              TextFormField(
                controller: _nameArController,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: InputDecoration(
                  labelText: 'اسم التصنيف (عربي)',
                  labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                  prefixIcon: const Icon(Icons.title, color: Color(0xFFD4AF37)),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.05),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFD4AF37), width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'الرجاء إدخال اسم التصنيف بالعربي';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // اسم التصنيف بالإنجليزي
              TextFormField(
                controller: _nameEnController,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: InputDecoration(
                  labelText: 'اسم التصنيف (إنجليزي)',
                  labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                  prefixIcon: const Icon(Icons.abc, color: Color(0xFFD4AF37)),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.05),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Color(0xFFD4AF37), width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'الرجاء إدخال اسم التصنيف بالإنجليزي';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 20),
              
              // حالة التصنيف
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.toggle_on,
                      color: Color(0xFFD4AF37),
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'حالة التصنيف',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    Switch(
                      value: _isActive,
                      onChanged: (value) {
                        setState(() {
                          _isActive = value;
                        });
                      },
                      activeColor: const Color(0xFFD4AF37),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _isActive ? 'نشط' : 'غير نشط',
                      style: TextStyle(
                        color: _isActive ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // الأزرار
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                    ),
                    child: Text(
                      'إلغاء',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _handleSave,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD4AF37),
                      foregroundColor: const Color(0xFF1A1A2E),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      widget.category == null ? 'إضافة التصنيف' : 'حفظ التعديلات',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      widget.onSave({
        'nameAr': _nameArController.text.trim(),
        'nameEn': _nameEnController.text.trim(),
        'isActive': _isActive,
        'icon': _selectedIcon,
      });
    }
  }
}