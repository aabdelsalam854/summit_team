import 'package:flutter/material.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/core/widget/custom_text_form_field.dart';
import 'package:summit_team/features/city/model/data.dart';




class CityDialog extends StatefulWidget {
  final CityModel? city;
  final Function(Map<String, dynamic>) onSave;

  const CityDialog({super.key, this.city, required this.onSave});

  @override
  State<CityDialog> createState() => _CityDialogState();
}

class _CityDialogState extends State<CityDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameArController;
  late TextEditingController _nameEnController;
  late bool _isActive;

  @override
  void initState() {
    super.initState();
    _nameArController = TextEditingController(text: widget.city?.nameAr ?? '');
    _nameEnController = TextEditingController(text: widget.city?.nameEn ?? '');
    _isActive = widget.city?.isActive ?? true;
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
      backgroundColor: AlessamyColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 500,
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
                      widget.city == null
                          ? Icons.add_location
                          : Icons.edit_location,
                      color: const Color(0xFFD4AF37),
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    widget.city == null ? 'إضافة مدينة جديدة' : 'تعديل المدينة',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              CustomTextFormField(
                controller: _nameArController,
                hintText: 'اسم المدينة (عربي)',
                icon: const Icon(Icons.location_city),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'الرجاء إدخال اسم المدينة بالعربي';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                controller: _nameEnController,
                hintText: 'اسم المدينة (إنجليزي)',
                icon: Icon(Icons.abc),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'الرجاء إدخال اسم المدينة بالإنجليزي';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),
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
                      'حالة المدينة',
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
                      widget.city == null ? 'إضافة' : 'حفظ التعديلات',
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
      });
    }
  }
}
