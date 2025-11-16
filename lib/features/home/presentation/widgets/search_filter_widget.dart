import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/core/widget/custom_drop_down.dart';
import 'package:summit_team/features/properties/data/models/property_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchFilterWidget extends StatefulWidget {
  const SearchFilterWidget({super.key, this.onSearch});

  final Function(SearchFilter)? onSearch;

  @override
  State<SearchFilterWidget> createState() => _SearchFilterWidgetState();
}

class _SearchFilterWidgetState extends State<SearchFilterWidget> {
  final _propertyCodeController = TextEditingController();
  final _minAreaController = TextEditingController();
  final _maxAreaController = TextEditingController();
  final _minPriceController = TextEditingController();
  final _maxPriceController = TextEditingController();

  String? selectedCity;
  String? selectedPhase;
  String? selectedModel;
  PropertyType? selectedType;
  PropertyPurpose? selectedPurpose;
  String? selectedPaymentSystem;
  String? selectedFinishingType;
  String? selectedRoomsCount;

  ValueNotifier<bool> showFilters = ValueNotifier(false);

  final List<String> cities = [
    'القاهرة',
    'الجيزة',
    'الإسكندرية',
    'الرحاب',
    'مدينتي',
    'الشروق',
    'العبور',
  ];

  final List<String> phases = [
    'المرحلة الأولى',
    'المرحلة الثانية',
    'المرحلة الثالثة',
    'المرحلة الرابعة',
  ];

  final List<String> models = ['A', 'B', 'C', 'D', 'E'];

  final List<String> paymentSystems = ['كاش', 'تقسيط'];

  final List<String> finishingTypes = ['تشطيب كامل', 'نصف تشطيب', 'بدون تشطيب'];

  final List<String> roomsCounts = ['1', '2', '3', '4', '5', '6+'];

  @override
  void dispose() {
    _propertyCodeController.dispose();
    _minAreaController.dispose();
    _maxAreaController.dispose();
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AlessamyColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// العنوان
          Row(
            children: [
              Icon(
                Icons.home_work,
                color: AlessamyColors.primaryGold,
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                'ابحث عن عقارك',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AlessamyColors.white,
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {
                  showFilters.value = !showFilters.value;
                },
                icon: Icon(
                  Icons.filter_list,
                  color: AlessamyColors.primaryGold,
                  size: 24,
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          /// الفلاتر
          ValueListenableBuilder(
            valueListenable: showFilters,
            builder: (context, value, child) {
              if (!value) return SizedBox.shrink();

              return LayoutBuilder(
                builder: (context, constraints) {
                  bool isWeb = constraints.maxWidth > 900;
                  int columns = isWeb ? 3 : 1;

                  return Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      SizedBox(
                        width: _fieldWidth(columns, constraints.maxWidth),
                        child: _buildTextField(
                          label: 'ابحث بكود العقار',
                          controller: _propertyCodeController,
                          hint: 'أدخل كود العقار',
                        ),
                      ),

                      /// المدينة
                      SizedBox(
                        width: _fieldWidth(columns, constraints.maxWidth),
                        child: CustomDropdown<String>(
                          label: 'المدينة',
                          value: selectedCity,
                          items: cities,
                          onChanged: (value) => setState(() => selectedCity = value),
                          itemBuilder: (city) => city,
                        ),
                      ),

                      /// المرحلة
                      SizedBox(
                        width: _fieldWidth(columns, constraints.maxWidth),
                        child: CustomDropdown<String>(
                          label: 'المرحلة',
                          value: selectedPhase,
                          items: phases,
                          onChanged: (value) => setState(() => selectedPhase = value),
                          itemBuilder: (phase) => phase,
                        ),
                      ),

                      /// النموذج
                      SizedBox(
                        width: _fieldWidth(columns, constraints.maxWidth),
                        child: CustomDropdown<String>(
                          label: 'النموذج',
                          value: selectedModel,
                          items: models,
                          onChanged: (value) => setState(() => selectedModel = value),
                          itemBuilder: (model) => model,
                        ),
                      ),

                      /// نوع العقار
                      SizedBox(
                        width: _fieldWidth(columns, constraints.maxWidth),
                        child: CustomDropdown<PropertyType>(
                          label: 'نوع العقار',
                          value: selectedType,
                          items: PropertyType.values,
                          onChanged: (value) => setState(() => selectedType = value),
                          itemBuilder: (type) => type.arabicName,
                        ),
                      ),

                      /// الغرض
                      SizedBox(
                        width: _fieldWidth(columns, constraints.maxWidth),
                        child: CustomDropdown<PropertyPurpose>(
                          label: 'الغرض',
                          value: selectedPurpose,
                          items: PropertyPurpose.values,
                          onChanged: (value) => setState(() => selectedPurpose = value),
                          itemBuilder: (purpose) => purpose.arabicName,
                        ),
                      ),

                      /// نظام الدفع
                      SizedBox(
                        width: _fieldWidth(columns, constraints.maxWidth),
                        child: CustomDropdown<String>(
                          label: 'نظام الدفع',
                          value: selectedPaymentSystem,
                          items: paymentSystems,
                          onChanged: (value) => setState(() => selectedPaymentSystem = value),
                          itemBuilder: (payment) => payment,
                        ),
                      ),

                      /// التشطيب
                      SizedBox(
                        width: _fieldWidth(columns, constraints.maxWidth),
                        child: CustomDropdown<String>(
                          label: 'نوع التشطيب',
                          value: selectedFinishingType,
                          items: finishingTypes,
                          onChanged: (value) => setState(() => selectedFinishingType = value),
                          itemBuilder: (finishing) => finishing,
                        ),
                      ),

                      /// عدد الغرف
                      SizedBox(
                        width: _fieldWidth(columns, constraints.maxWidth),
                        child: CustomDropdown<String>(
                          label: 'عدد الغرف',
                          value: selectedRoomsCount,
                          items: roomsCounts,
                          onChanged: (value) => setState(() => selectedRoomsCount = value),
                          itemBuilder: (rooms) => rooms,
                        ),
                      ),

                      /// المساحة
                      SizedBox(
                        width: _fieldWidth(columns, constraints.maxWidth),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'المساحة',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AlessamyColors.textSecondary,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildTextField(
                                    label: 'من',
                                    controller: _minAreaController,
                                    hint: 'من',
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: _buildTextField(
                                    label: 'إلى',
                                    controller: _maxAreaController,
                                    hint: 'إلى',
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      /// السعر
                      SizedBox(
                        width: _fieldWidth(columns, constraints.maxWidth),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'السعر',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AlessamyColors.textSecondary,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildTextField(
                                    label: 'من',
                                    controller: _minPriceController,
                                    hint: 'من',
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: _buildTextField(
                                    label: 'إلى',
                                    controller: _maxPriceController,
                                    hint: 'إلى',
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      /// زر البحث
                      SizedBox(
                        width: isWeb ? 250 : double.infinity,
                        child: ElevatedButton(
                          onPressed: _performSearch,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AlessamyColors.primaryGold,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.search, color: AlessamyColors.black),
                              SizedBox(width: 8),
                              Text(
                                'بحث',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AlessamyColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  /// حقل نص
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != 'من' && label != 'إلى')
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AlessamyColors.textSecondary,
            ),
          ),
        if (label != 'من' && label != 'إلى')
          SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 14, color: AlessamyColors.textLight),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AlessamyColors.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AlessamyColors.borderLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide(color: AlessamyColors.primaryGold),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ],
    );
  }

  /// حساب عرض كل عنصر حسب عدد الأعمدة
  double _fieldWidth(int columns, double maxWidth) {
    if (columns == 1) return maxWidth;
    return (maxWidth / columns) - 30;
  }

  void _performSearch() {
    final filter = SearchFilter(
      propertyCode: _propertyCodeController.text.isEmpty
          ? null
          : _propertyCodeController.text,
      city: selectedCity,
      phase: selectedPhase,
      model: selectedModel,
      type: selectedType,
      purpose: selectedPurpose,
      paymentSystem: selectedPaymentSystem,
      finishingType: selectedFinishingType,
      roomsCount: selectedRoomsCount,
      minPrice: _minPriceController.text.isEmpty
          ? 0
          : double.tryParse(_minPriceController.text) ?? 0,
      maxPrice: _maxPriceController.text.isEmpty
          ? double.infinity
          : double.tryParse(_maxPriceController.text) ?? double.infinity,
      minArea: _minAreaController.text.isEmpty
          ? 0
          : double.tryParse(_minAreaController.text) ?? 0,
      maxArea: _maxAreaController.text.isEmpty
          ? double.infinity
          : double.tryParse(_maxAreaController.text) ?? double.infinity,
    );

    widget.onSearch?.call(filter);
  }
}

/// فلتر البحث
class SearchFilter {
  final String? propertyCode;
  final String? city;
  final String? phase;
  final String? model;
  final PropertyType? type;
  final PropertyPurpose? purpose;
  final String? paymentSystem;
  final String? finishingType;
  final String? roomsCount;
  final double minPrice;
  final double maxPrice;
  final double minArea;
  final double maxArea;

  const SearchFilter({
    this.propertyCode,
    this.city,
    this.phase,
    this.model,
    this.type,
    this.purpose,
    this.paymentSystem,
    this.finishingType,
    this.roomsCount,
    this.minPrice = 0,
    this.maxPrice = double.infinity,
    this.minArea = 0,
    this.maxArea = double.infinity,
  });
}
