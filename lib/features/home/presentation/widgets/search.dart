import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/features/properties/data/models/property_model.dart';

class ModernSearchFilterWidget extends StatefulWidget {
  const ModernSearchFilterWidget({super.key, this.onSearch});

  final Function(SearchFilter)? onSearch;

  @override
  State<ModernSearchFilterWidget> createState() => _ModernSearchFilterWidgetState();
}

class _ModernSearchFilterWidgetState extends State<ModernSearchFilterWidget> {
  final _propertyCodeController = TextEditingController();
  final _minPriceController = TextEditingController();
  final _maxPriceController = TextEditingController();
  final _minAreaController = TextEditingController();
  final _maxAreaController = TextEditingController();

  late final ValueNotifier<PropertyPurpose?> selectedPurpose;
  late final ValueNotifier<double> minPrice;
  late final ValueNotifier<double> maxPrice;
  late final ValueNotifier<String?> selectedCity;
  late final ValueNotifier<String?> selectedPhase;
  late final ValueNotifier<String?> selectedModel;
  late final ValueNotifier<PropertyType?> selectedType;
  late final ValueNotifier<String?> selectedPaymentSystem;
  late final ValueNotifier<String?> selectedFinishingType;
  late final ValueNotifier<String?> selectedRoomsCount;
  late final ValueNotifier<int?> selectedRating;
  late final ValueNotifier<List<String>> selectedExtras;

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
  final List<int> ratings = [1, 2, 3, 4, 5];
  final List<String> finishingTypes = ['تشطيب كامل', 'نصف تشطيب', 'بدون تشطيب'];
  final List<String> paymentSystems = ['كاش', 'تقسيط'];
  final List<String> roomsCounts = ['1', '2', '3', '4', '5', '6+'];

  @override
  void initState() {
    super.initState();
    selectedPurpose = ValueNotifier(PropertyPurpose.sale);
    minPrice = ValueNotifier(0);
    maxPrice = ValueNotifier(10000);
    selectedCity = ValueNotifier(null);
    selectedPhase = ValueNotifier(null);
    selectedModel = ValueNotifier(null);
    selectedType = ValueNotifier(null);
    selectedPaymentSystem = ValueNotifier(null);
    selectedFinishingType = ValueNotifier(null);
    selectedRoomsCount = ValueNotifier(null);
    selectedRating = ValueNotifier(null);
    selectedExtras = ValueNotifier([]);
  }

  @override
  void dispose() {
    _propertyCodeController.dispose();
    _minPriceController.dispose();
    _maxPriceController.dispose();
    _minAreaController.dispose();
    _maxAreaController.dispose();
    selectedPurpose.dispose();
    minPrice.dispose();
    maxPrice.dispose();
    selectedCity.dispose();
    selectedPhase.dispose();
    selectedModel.dispose();
    selectedType.dispose();
    selectedPaymentSystem.dispose();
    selectedFinishingType.dispose();
    selectedRoomsCount.dispose();
    selectedRating.dispose();
    selectedExtras.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AlessamyColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Property Code Search
            _buildSectionTitle('كود العقار'),
            SizedBox(height: 12),
            _buildPropertyCodeField(),

            SizedBox(height: 24),

            // Purpose Selection (للبيع / للإيجار)
            _buildSectionTitle('الغرض من العقار'),
            SizedBox(height: 12),
            _buildPurposeButtons(),

            SizedBox(height: 24),

            // Budget Section
            _buildSectionTitle('الميزانية'),
            SizedBox(height: 12),
            _buildBudgetSlider(),

            SizedBox(height: 24),

            // City Filter
            _buildSectionTitle('المدينة'),
            SizedBox(height: 12),
            _buildCityDropdown(),

            SizedBox(height: 24),

            // Phase Filter
            _buildSectionTitle('المرحلة'),
            SizedBox(height: 12),
            _buildPhaseDropdown(),

            SizedBox(height: 24),

            // Model Filter
            _buildSectionTitle('النموذج'),
            SizedBox(height: 12),
            _buildModelDropdown(),

            SizedBox(height: 24),

            // Property Type
            _buildSectionTitle('نوع العقار'),
            SizedBox(height: 12),
            _buildPropertyTypeDropdown(),

            SizedBox(height: 24),

            // Payment System
            _buildSectionTitle('نظام الدفع'),
            SizedBox(height: 12),
            _buildPaymentSystemDropdown(),

            SizedBox(height: 24),

            // Finishing Type
            _buildSectionTitle('نوع التشطيب'),
            SizedBox(height: 12),
            _buildFinishingTypeDropdown(),

            SizedBox(height: 24),

            // Rooms Count
            _buildSectionTitle('عدد الغرف'),
            SizedBox(height: 12),
            _buildRoomsCountDropdown(),

            SizedBox(height: 24),

            // Area Range
            _buildSectionTitle('المساحة'),
            SizedBox(height: 12),
            _buildAreaFields(),

            SizedBox(height: 24),

            // Rating Section
            _buildSectionTitle('التقييم'),
            SizedBox(height: 12),
            _buildRatingButtons(),

            SizedBox(height: 24),

            // Extras Section
            _buildSectionTitle('إضافات'),
            SizedBox(height: 12),
            _buildExtrasGrid(),

            SizedBox(height: 24),

            // Search Button
            SizedBox(
              width: double.infinity,
              height: 48,
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
                    Icon(Icons.search, color: AlessamyColors.black, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'بحث',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AlessamyColors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AlessamyColors.white,
      ),
    );
  }

  Widget _buildPropertyCodeField() {
    return TextField(
      controller: _propertyCodeController,
      decoration: InputDecoration(
        hintText: 'أدخل كود العقار',
        hintStyle: TextStyle(fontSize: 14, color: AlessamyColors.textLight),
        prefixIcon: Icon(Icons.qr_code, color: AlessamyColors.primaryGold),
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
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
    );
  }

  Widget _buildPurposeButtons() {
    return ValueListenableBuilder<PropertyPurpose?>(
      valueListenable: selectedPurpose,
      builder: (context, purpose, child) {
        return Row(
          children: PropertyPurpose.values.map((purposeValue) {
            final isSelected = purpose == purposeValue;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                    right: purposeValue == PropertyPurpose.values.last ? 0 : 8),
                child: GestureDetector(
                  onTap: () => selectedPurpose.value = purposeValue,
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AlessamyColors.primaryGold
                          : AlessamyColors.cardBackground,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected
                            ? AlessamyColors.primaryGold
                            : AlessamyColors.borderLight,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        purposeValue.arabicName,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? AlessamyColors.black
                              : AlessamyColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildBudgetSlider() {
    return ValueListenableBuilder<double>(
      valueListenable: minPrice,
      builder: (context, min, child) {
        return ValueListenableBuilder<double>(
          valueListenable: maxPrice,
          builder: (context, max, child) {
            return Column(
              children: [
                // Visual Budget Bars
                Container(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(11, (index) {
                      final isActive = index >= 3 && index <= 7;
                      final isCenter = index == 5;
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        child: Container(
                          width: 16,
                          height: isCenter ? 100 : isActive ? 80 : 40,
                          decoration: BoxDecoration(
                            color: isActive
                                ? AlessamyColors.primaryGold
                                : AlessamyColors.borderLight,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(height: 12),
                // Price Range
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${min.toInt().toString()} ج.م',
                      style: TextStyle(
                        fontSize: 14,
                        color: AlessamyColors.textSecondary,
                      ),
                    ),
                    Text(
                      '${max.toInt().toString()} ج.م',
                      style: TextStyle(
                        fontSize: 14,
                        color: AlessamyColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                // Slider
                RangeSlider(
                  values: RangeValues(min, max),
                  min: 0,
                  max: 10000000,
                  divisions: 100,
                  activeColor: AlessamyColors.primaryGold,
                  inactiveColor: AlessamyColors.borderLight,
                  onChanged: (values) {
                    minPrice.value = values.start;
                    maxPrice.value = values.end;
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildCityDropdown() {
    return ValueListenableBuilder<String?>(
      valueListenable: selectedCity,
      builder: (context, city, child) {
        return _buildDropdown(
          'اختر المدينة',
          city,
          cities,
          (value) => selectedCity.value = value,
        );
      },
    );
  }

  Widget _buildPhaseDropdown() {
    return ValueListenableBuilder<String?>(
      valueListenable: selectedPhase,
      builder: (context, phase, child) {
        return _buildDropdown(
          'اختر المرحلة',
          phase,
          phases,
          (value) => selectedPhase.value = value,
        );
      },
    );
  }

  Widget _buildModelDropdown() {
    return ValueListenableBuilder<String?>(
      valueListenable: selectedModel,
      builder: (context, model, child) {
        return _buildDropdown(
          'اختر النموذج',
          model,
          models,
          (value) => selectedModel.value = value,
        );
      },
    );
  }

  Widget _buildPropertyTypeDropdown() {
    return ValueListenableBuilder<PropertyType?>(
      valueListenable: selectedType,
      builder: (context, type, child) {
        return _buildDropdown(
          'اختر نوع العقار',
          type?.arabicName,
          PropertyType.values.map((e) => e.arabicName).toList(),
          (value) {
            final newType =
                PropertyType.values.firstWhere((e) => e.arabicName == value);
            selectedType.value = newType;
          },
        );
      },
    );
  }

  Widget _buildPaymentSystemDropdown() {
    return ValueListenableBuilder<String?>(
      valueListenable: selectedPaymentSystem,
      builder: (context, payment, child) {
        return _buildDropdown(
          'اختر نظام الدفع',
          payment,
          paymentSystems,
          (value) => selectedPaymentSystem.value = value,
        );
      },
    );
  }

  Widget _buildFinishingTypeDropdown() {
    return ValueListenableBuilder<String?>(
      valueListenable: selectedFinishingType,
      builder: (context, finishing, child) {
        return _buildDropdown(
          'اختر نوع التشطيب',
          finishing,
          finishingTypes,
          (value) => selectedFinishingType.value = value,
        );
      },
    );
  }

  Widget _buildRoomsCountDropdown() {
    return ValueListenableBuilder<String?>(
      valueListenable: selectedRoomsCount,
      builder: (context, rooms, child) {
        return _buildDropdown(
          'اختر عدد الغرف',
          rooms,
          roomsCounts,
          (value) => selectedRoomsCount.value = value,
        );
      },
    );
  }

  Widget _buildAreaFields() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _minAreaController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'من',
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
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: TextField(
            controller: _maxAreaController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'إلى',
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
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(
      String label, String? value, List<String> items, Function(String?) onChanged) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AlessamyColors.cardBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AlessamyColors.borderLight),
      ),
      child: DropdownButton<String>(
        value: value,
        hint: Text(
          label,
          style: TextStyle(fontSize: 14, color: AlessamyColors.textSecondary),
        ),
        isExpanded: true,
        underline: SizedBox(),
        dropdownColor: AlessamyColors.cardBackground,
        icon: Icon(Icons.keyboard_arrow_down, color: AlessamyColors.textSecondary),
        style: TextStyle(fontSize: 14, color: AlessamyColors.white),
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildRatingButtons() {
    return ValueListenableBuilder<int?>(
      valueListenable: selectedRating,
      builder: (context, rating, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: ratings.map((rate) {
            final isSelected = rating == rate;
            return GestureDetector(
              onTap: () => selectedRating.value = rate,
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AlessamyColors.primaryGold
                      : AlessamyColors.cardBackground,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? AlessamyColors.primaryGold
                        : AlessamyColors.borderLight,
                  ),
                ),
                child: Center(
                  child: Text(
                    rate.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? AlessamyColors.black
                          : AlessamyColors.textSecondary,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildExtrasGrid() {
    final extras = [
      {'icon': Icons.garage, 'label': 'جراج'},
      {'icon': Icons.pool, 'label': 'مسبح'},
      {'icon': Icons.fitness_center, 'label': 'جيم'},
      {'icon': Icons.local_parking, 'label': 'باركينج'},
    ];

    return ValueListenableBuilder<List<String>>(
      valueListenable: selectedExtras,
      builder: (context, extras_list, child) {
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: extras.map((extra) {
            final isSelected = extras_list.contains(extra['label']);
            return GestureDetector(
              onTap: () {
                final newList = List<String>.from(extras_list);
                if (isSelected) {
                  newList.remove(extra['label']);
                } else {
                  newList.add(extra['label'] as String);
                }
                selectedExtras.value = newList;
              },
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AlessamyColors.primaryGold
                      : AlessamyColors.cardBackground,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? AlessamyColors.primaryGold
                        : AlessamyColors.borderLight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      extra['icon'] as IconData,
                      color: isSelected
                          ? AlessamyColors.black
                          : AlessamyColors.textSecondary,
                      size: 20,
                    ),
                    SizedBox(height: 4),
                    Text(
                      extra['label'] as String,
                      style: TextStyle(
                        fontSize: 10,
                        color: isSelected
                            ? AlessamyColors.black
                            : AlessamyColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  void _performSearch() {
    final filter = SearchFilter(
      propertyCode: _propertyCodeController.text.isEmpty
          ? null
          : _propertyCodeController.text,
      city: selectedCity.value,
      phase: selectedPhase.value,
      model: selectedModel.value,
      type: selectedType.value,
      purpose: selectedPurpose.value,
      paymentSystem: selectedPaymentSystem.value,
      finishingType: selectedFinishingType.value,
      roomsCount: selectedRoomsCount.value,
      minPrice: minPrice.value,
      maxPrice: maxPrice.value,
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