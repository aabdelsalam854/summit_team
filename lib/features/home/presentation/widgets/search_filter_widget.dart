import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/core/widget/custom_drop_down.dart';
import 'package:summit_team/features/properties/data/models/property_model.dart';
import 'package:flutter/material.dart';

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
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AlessamyColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// العنوان أو حقل البحث للموبايل
          if (isMobile)
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _propertyCodeController,
                    decoration: InputDecoration(
                      hintText: 'ابحث عن عقارك...',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: AlessamyColors.textLight,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AlessamyColors.primaryGold,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: AlessamyColors.borderLight,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: AlessamyColors.borderLight,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: AlessamyColors.primaryGold,
                          width: 2,
                        ),
                      ),
                      filled: true,
                      fillColor: AlessamyColors.cardBackground,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    style: TextStyle(color: AlessamyColors.white),
                    onSubmitted: (value) => _performSearch(),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  onPressed: () => _openMobileFilter(),
                  icon: Icon(
                    Icons.filter_list,
                    color: AlessamyColors.primaryGold,
                    size: 24,
                  ),
                ),
              ],
            )
          else
            Row(
              children: [
                Icon(
                  Icons.home_work,
                  color: AlessamyColors.primaryGold,
                  size: 24,
                ),
                SizedBox(width: 8),
                // Text(
                //   'ابحث عن عقارك',
                //   style: TextStyle(
                //     fontSize: 20,
                //     fontWeight: FontWeight.bold,
                //     color: AlessamyColors.white,
                //   ),
                // ),
                SizedBox(
                  width: 200,
                  child: _buildTextField(
                    'ابحث بكود العقار',
                    _propertyCodeController,
                    'أدخل كود العقار',
                  ),
                ),
                Spacer(),

                /// زر الفلتر
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

          /// الفلاتر في الويب
          ValueListenableBuilder(
            valueListenable: showFilters,
            builder: (context, value, child) {
              if (!value || isMobile) return SizedBox.shrink();

              return _buildWebFilters(context);
            },
          ),
        ],
      ),
    );
  }

  /// ---------------------------
  ///  ويب: Grid Filters Layout
  /// ---------------------------

  Widget _buildWebFilters(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int columns = constraints.maxWidth > 900 ? 4 : 1;
        return Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            _wrapField(
              _buildTextField(
                'ابحث بكود العقار',
                _propertyCodeController,
                'أدخل كود العقار',
              ),
              columns,
              constraints.maxWidth,
            ),

            _wrapField(
              _dropdown(
                label: 'المدينة',
                value: selectedCity,
                items: cities,
                onChanged: (v) => setState(() => selectedCity = v),
              ),
              columns,
              constraints.maxWidth,
            ),

            _wrapField(
              _dropdown(
                label: 'المرحلة',
                value: selectedPhase,
                items: phases,
                onChanged: (v) => setState(() => selectedPhase = v),
              ),
              columns,
              constraints.maxWidth,
            ),

            _wrapField(
              _dropdown(
                label: 'النموذج',
                value: selectedModel,
                items: models,
                onChanged: (v) => setState(() => selectedModel = v),
              ),
              columns,
              constraints.maxWidth,
            ),

            _wrapField(
              _dropdown(
                label: 'نوع العقار',
                value: selectedType,
                items: PropertyType.values,
                itemBuilder: (t) => t.arabicName,
                onChanged: (v) => setState(() => selectedType = v),
              ),
              columns,
              constraints.maxWidth,
            ),

            _wrapField(
              _dropdown(
                label: 'الغرض',
                value: selectedPurpose,
                items: PropertyPurpose.values,
                itemBuilder: (t) => t.arabicName,
                onChanged: (v) => setState(() => selectedPurpose = v),
              ),
              columns,
              constraints.maxWidth,
            ),

            _wrapField(
              _dropdown(
                label: 'نظام الدفع',
                value: selectedPaymentSystem,
                items: paymentSystems,
                onChanged: (v) => setState(() => selectedPaymentSystem = v),
              ),
              columns,
              constraints.maxWidth,
            ),

            _wrapField(
              _dropdown(
                label: 'نوع التشطيب',
                value: selectedFinishingType,
                items: finishingTypes,
                onChanged: (v) => setState(() => selectedFinishingType = v),
              ),
              columns,
              constraints.maxWidth,
            ),

            _wrapField(
              _dropdown(
                label: 'عدد الغرف',
                value: selectedRoomsCount,
                items: roomsCounts,
                onChanged: (v) => setState(() => selectedRoomsCount = v),
              ),
              columns,
              constraints.maxWidth,
            ),

            /// المساحة
            _wrapField(
              _rangeFields('المساحة', _minAreaController, _maxAreaController),
              columns,
              constraints.maxWidth,
            ),

            /// السعر
            _wrapField(
              _rangeFields('السعر', _minPriceController, _maxPriceController),
              columns,
              constraints.maxWidth,
            ),

            /// زر البحث
            SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: _performSearch,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AlessamyColors.primaryGold,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
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
  }

  Widget _wrapField(Widget child, int columns, double width) {
    if (columns == 1) return child;
    return SizedBox(width: (width / columns) - 30, child: child);
  }

  /// ---------------------------
  ///  Mobile Bottom Sheet
  /// ---------------------------

  void _openMobileFilter() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          maxChildSize: 0.95,
          minChildSize: 0.4,
          builder: (_, controller) {
            return Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AlessamyColors.cardBackground,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: SingleChildScrollView(
                controller: controller,
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 5,
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    /// الفلاتر
                    _buildMobileFilters(),

                    SizedBox(height: 20),

                    /// زر البحث
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _performSearch();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AlessamyColors.primaryGold,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search, color: Colors.black),
                          SizedBox(width: 8),
                          Text(
                            'بحث',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// ---------------------------
  ///  Mobile Filters Content
  /// ---------------------------

  Widget _buildMobileFilters() {
    return Column(
      children: [
        _buildTextField(
          'ابحث بكود العقار',
          _propertyCodeController,
          'أدخل كود العقار',
        ),
        SizedBox(height: 15),
        _dropdown(
          label: 'المدينة',
          value: selectedCity,
          items: cities,
          onChanged: (v) => setState(() => selectedCity = v),
        ),
        SizedBox(height: 15),
        _dropdown(
          label: 'المرحلة',
          value: selectedPhase,
          items: phases,
          onChanged: (v) => setState(() => selectedPhase = v),
        ),
        SizedBox(height: 15),
        _dropdown(
          label: 'النموذج',
          value: selectedModel,
          items: models,
          onChanged: (v) => setState(() => selectedModel = v),
        ),
        SizedBox(height: 15),
        _dropdown(
          label: 'نوع العقار',
          value: selectedType,
          items: PropertyType.values,
          itemBuilder: (t) => t.arabicName,
          onChanged: (v) => setState(() => selectedType = v),
        ),
        SizedBox(height: 15),
        _dropdown(
          label: 'الغرض',
          value: selectedPurpose,
          items: PropertyPurpose.values,
          itemBuilder: (t) => t.arabicName,
          onChanged: (v) => setState(() => selectedPurpose = v),
        ),
        SizedBox(height: 15),
        _dropdown(
          label: 'نظام الدفع',
          value: selectedPaymentSystem,
          items: paymentSystems,
          onChanged: (v) => setState(() => selectedPaymentSystem = v),
        ),
        SizedBox(height: 15),
        _dropdown(
          label: 'نوع التشطيب',
          value: selectedFinishingType,
          items: finishingTypes,
          onChanged: (v) => setState(() => selectedFinishingType = v),
        ),
        SizedBox(height: 15),
        _dropdown(
          label: 'عدد الغرف',
          value: selectedRoomsCount,
          items: roomsCounts,
          onChanged: (v) => setState(() => selectedRoomsCount = v),
        ),
        SizedBox(height: 20),
        _rangeFields('المساحة', _minAreaController, _maxAreaController),
        SizedBox(height: 20),
        _rangeFields('السعر', _minPriceController, _maxPriceController),
      ],
    );
  }

  /// ---------------------------
  ///  Widgets
  /// ---------------------------

  Widget _dropdown<T>({
    required String label,
    required T? value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
    String Function(T item)? itemBuilder,
  }) {
    return CustomDropdown<T>(
      label: label,
      value: value,
      items: items,
      onChanged: onChanged,
      itemBuilder: itemBuilder ?? (item) => item.toString(),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    String hint,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AlessamyColors.textSecondary,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 14, color: AlessamyColors.textLight),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AlessamyColors.borderLight),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AlessamyColors.borderLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AlessamyColors.primaryGold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _rangeFields(
    String label,
    TextEditingController minCtrl,
    TextEditingController maxCtrl,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AlessamyColors.textSecondary,
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _buildTextField('من', minCtrl, 'من')),
            SizedBox(width: 12),
            Expanded(child: _buildTextField('إلى', maxCtrl, 'إلى')),
          ],
        ),
      ],
    );
  }

  /// ---------------------------
  ///  Perform Search
  /// ---------------------------

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
