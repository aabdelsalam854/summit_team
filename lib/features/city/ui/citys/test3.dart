import 'package:flutter/material.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/features/city/model/data.dart';

class PropertiesScreen extends StatefulWidget {
  final DistrictModel? selectedDistrict;

  const PropertiesScreen({super.key, this.selectedDistrict});

  @override
  State<PropertiesScreen> createState() => _PropertiesScreenState();
}

class _PropertiesScreenState extends State<PropertiesScreen> {
  final List<CityModel> cities = [];
  final List<DistrictModel> districts = [];
  final List<PropertyCategoryModel> categories = [];
  final List<PropertyModel> properties = [];

  bool isLoading = false;
  String searchQuery = '';
  CityModel? selectedCity;
  DistrictModel? selectedDistrict;
  PropertyCategoryModel? selectedCategory;
  String? selectedStatus; // 'all', 'active', 'inactive'

  @override
  void initState() {
    super.initState();
    selectedDistrict = widget.selectedDistrict;
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => isLoading = true);

    await Future.delayed(const Duration(milliseconds: 800));

    setState(() {
      // تحميل المدن
      cities.addAll([
        CityModel(
          id: '1',
          nameAr: 'القاهرة',
          nameEn: 'Cairo',
          isActive: true,
          createdAt: DateTime.now(),
        ),
        CityModel(
          id: '2',
          nameAr: 'الجيزة',
          nameEn: 'Giza',
          isActive: true,
          createdAt: DateTime.now(),
        ),
      ]);

      // تحميل المناطق
      districts.addAll([
        DistrictModel(
          id: 'dist1',
          nameAr: 'مصر الجديدة',
          nameEn: 'Heliopolis',
          cityId: '1',
          isActive: true,
          createdAt: DateTime.now(),
        ),
        DistrictModel(
          id: 'dist2',
          nameAr: 'المعادي',
          nameEn: 'Maadi',
          cityId: '1',
          isActive: true,
          createdAt: DateTime.now(),
        ),
        DistrictModel(
          id: 'dist3',
          nameAr: 'المهندسين',
          nameEn: 'Mohandessin',
          cityId: '2',
          isActive: true,
          createdAt: DateTime.now(),
        ),
      ]);

      // تحميل التصنيفات
      categories.addAll([
        PropertyCategoryModel(
          id: 'cat1',
          nameAr: 'شقة',
          nameEn: 'Apartment',
          order: 1,
          isActive: true,
          icon: Icons.apartment,
          createdAt: DateTime.now(),
        ),
        PropertyCategoryModel(
          id: 'cat2',
          nameAr: 'فيلا',
          nameEn: 'Villa',
          order: 2,
          isActive: true,
          icon: Icons.villa,
          createdAt: DateTime.now(),
        ),
        PropertyCategoryModel(
          id: 'cat3',
          nameAr: 'محل تجاري',
          nameEn: 'Shop',
          order: 3,
          isActive: true,
          icon: Icons.store,
          createdAt: DateTime.now(),
        ),
      ]);

      // تحميل العقارات الوهمية
      properties.addAll([
        PropertyModel(
          id: '1',
          titleAr: 'شقة فاخرة في مصر الجديدة',
          titleEn: 'Luxury Apartment in Heliopolis',
          descriptionAr: 'شقة مميزة 3 غرف نوم + 2 حمام مع بلكونة واسعة',
          descriptionEn:
              'Premium 3 bedroom + 2 bathroom apartment with spacious balcony',
          districtId: 'dist1',
          categoryId: 'cat1',
          price: 2500000,
          area: 150,
          bedrooms: 3,
          bathrooms: 2,
          floor: 5,
          hasParking: true,
          hasElevator: true,
          hasGarden: false,
          isActive: true,
          images: [],
          ownerName: 'أحمد محمد',
          ownerPhone: '01012345678',
          createdAt: DateTime.now().subtract(const Duration(days: 5)),
        ),
        PropertyModel(
          id: '2',
          titleAr: 'فيلا راقية في المعادي',
          titleEn: 'Elegant Villa in Maadi',
          descriptionAr: 'فيلا فخمة 4 غرف نوم + 3 حمام مع حديقة وجراج',
          descriptionEn:
              'Luxurious 4 bedroom + 3 bathroom villa with garden and garage',
          districtId: 'dist2',
          categoryId: 'cat2',
          price: 8500000,
          area: 350,
          bedrooms: 4,
          bathrooms: 3,
          floor: 0,
          hasParking: true,
          hasElevator: false,
          hasGarden: true,
          isActive: true,
          images: [],
          ownerName: 'محمود علي',
          ownerPhone: '01098765432',
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
        ),
        PropertyModel(
          id: '3',
          titleAr: 'محل تجاري في المهندسين',
          titleEn: 'Commercial Shop in Mohandessin',
          descriptionAr: 'محل على شارع رئيسي موقع ممتاز للاستثمار',
          descriptionEn: 'Shop on main street, excellent investment location',
          districtId: 'dist3',
          categoryId: 'cat3',
          price: 1500000,
          area: 50,
          bedrooms: 0,
          bathrooms: 1,
          floor: 0,
          hasParking: false,
          hasElevator: false,
          hasGarden: false,
          isActive: false,
          images: [],
          ownerName: 'خالد حسن',
          ownerPhone: '01055555555',
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
      ]);

      isLoading = false;
    });
  }

  List<PropertyModel> get filteredProperties {
    var result = properties;

    // فلتر حسب المدينة
    if (selectedCity != null) {
      final cityDistricts = districts
          .where((d) => d.cityId == selectedCity!.id)
          .map((d) => d.id)
          .toList();
      result = result
          .where((p) => cityDistricts.contains(p.districtId))
          .toList();
    }

    // فلتر حسب المنطقة
    if (selectedDistrict != null) {
      result = result
          .where((p) => p.districtId == selectedDistrict!.id)
          .toList();
    }

    // فلتر حسب التصنيف
    if (selectedCategory != null) {
      result = result
          .where((p) => p.categoryId == selectedCategory!.id)
          .toList();
    }

    // فلتر حسب الحالة
    if (selectedStatus == 'active') {
      result = result.where((p) => p.isActive).toList();
    } else if (selectedStatus == 'inactive') {
      result = result.where((p) => !p.isActive).toList();
    }

    // البحث
    if (searchQuery.isNotEmpty) {
      result = result.where((p) {
        return p.titleAr.contains(searchQuery) ||
            p.titleEn.toLowerCase().contains(searchQuery.toLowerCase()) ||
            p.descriptionAr.contains(searchQuery) ||
            p.ownerName.contains(searchQuery) ||
            p.ownerPhone.contains(searchQuery);
      }).toList();
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AlessamyColors.backgroundColor,
      body: Column(
        children: [
          _buildHeader(),
          _buildFilters(),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildPropertiesTable(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AlessamyColors.cardBackground,
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFD4AF37).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.home_work,
              color: Color(0xFFD4AF37),
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'إدارة العقارات',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'عرض وإدارة جميع العقارات',
                style: TextStyle(fontSize: 14, color: Colors.white54),
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Navigate to add property
            },
            icon: const Icon(Icons.add),
            label: const Text('إضافة عقار جديد'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD4AF37),
              foregroundColor: const Color(0xFF1A1A2E),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // الصف الأول - الفلاتر
          Row(
            children: [
              // اختيار المدينة
              Expanded(
                child: _buildDropdown(
                  hint: 'جميع المدن',
                  value: selectedCity?.id,
                  items: cities.map((city) {
                    return DropdownMenuItem<String>(
                      value: city.id,
                      child: Text(city.nameAr),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCity = cities.firstWhere((c) => c.id == value);
                      selectedDistrict = null;
                    });
                  },
                  icon: Icons.location_city,
                ),
              ),
              const SizedBox(width: 16),

              // اختيار المنطقة
              Expanded(
                child: _buildDropdown(
                  hint: 'جميع المناطق',
                  value: selectedDistrict?.id,
                  items: districts
                      .where(
                        (d) =>
                            selectedCity == null ||
                            d.cityId == selectedCity!.id,
                      )
                      .map((district) {
                        return DropdownMenuItem<String>(
                          value: district.id,
                          child: Text(district.nameAr),
                        );
                      })
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedDistrict = districts.firstWhere(
                        (d) => d.id == value,
                      );
                    });
                  },
                  icon: Icons.map,
                ),
              ),
              const SizedBox(width: 16),

              // اختيار التصنيف
              Expanded(
                child: _buildDropdown(
                  hint: 'جميع التصنيفات',
                  value: selectedCategory?.id,
                  items: categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category.id,
                      child: Row(
                        children: [
                          Icon(
                            category.icon,
                            size: 18,
                            color: const Color(0xFFD4AF37),
                          ),
                          const SizedBox(width: 8),
                          Text(category.nameAr),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = categories.firstWhere(
                        (c) => c.id == value,
                      );
                    });
                  },
                  icon: Icons.category,
                ),
              ),
              const SizedBox(width: 16),

              // اختيار الحالة
              Expanded(
                child: _buildDropdown(
                  hint: 'جميع الحالات',
                  value: selectedStatus,
                  items: const [
                    DropdownMenuItem(value: 'all', child: Text('الكل')),
                    DropdownMenuItem(value: 'active', child: Text('نشط')),
                    DropdownMenuItem(value: 'inactive', child: Text('غير نشط')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = value == 'all' ? null : value;
                    });
                  },
                  icon: Icons.filter_alt,
                ),
              ),
              const SizedBox(width: 16),

              // زر مسح الفلاتر
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    selectedCity = null;
                    selectedDistrict = null;
                    selectedCategory = null;
                    selectedStatus = null;
                    searchQuery = '';
                  });
                },
                icon: const Icon(Icons.clear_all, size: 18),
                label: const Text('مسح الفلاتر'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.withOpacity(0.2),
                  foregroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // الصف الثاني - البحث والإحصائيات
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'ابحث عن عقار (العنوان، الوصف، المالك...)...',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white.withOpacity(0.5),
                    ),
                    filled: true,
                    fillColor: AlessamyColors.cardBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFD4AF37)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // إحصائيات
              _buildStatCard(
                'إجمالي العقارات',
                '${filteredProperties.length}',
                Icons.home_work,
              ),
              const SizedBox(width: 12),
              _buildStatCard(
                'العقارات النشطة',
                '${filteredProperties.where((p) => p.isActive).length}',
                Icons.check_circle,
                color: Colors.green,
              ),
              const SizedBox(width: 12),
              _buildStatCard(
                'العقارات غير النشطة',
                '${filteredProperties.where((p) => !p.isActive).length}',
                Icons.cancel,
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<DropdownMenuItem<String>> items,
    required Function(String?) onChanged,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AlessamyColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Row(
            children: [
              Icon(icon, color: Colors.white.withOpacity(0.5), size: 18),
              const SizedBox(width: 8),
              Text(
                hint,
                style: TextStyle(color: Colors.white.withOpacity(0.5)),
              ),
            ],
          ),
          icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFFD4AF37)),
          dropdownColor: AlessamyColors.cardBackground,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          isExpanded: true,
          items: items,
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon, {
    Color? color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AlessamyColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color ?? const Color(0xFFD4AF37), size: 20),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: TextStyle(
                  color: color ?? Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPropertiesTable() {
    final displayProperties = filteredProperties;

    if (displayProperties.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              searchQuery.isNotEmpty ||
                      selectedCity != null ||
                      selectedDistrict != null
                  ? Icons.search_off
                  : Icons.home_work_outlined,
              size: 64,
              color: Colors.white.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              searchQuery.isNotEmpty ||
                      selectedCity != null ||
                      selectedDistrict != null
                  ? 'لا توجد عقارات مطابقة للفلاتر'
                  : 'لا توجد عقارات مضافة',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Container(
        decoration: BoxDecoration(
          color: AlessamyColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
        ),
        child: Column(
          children: [
            _buildTableHeader(),
            ...displayProperties.asMap().entries.map((entry) {
              return _buildTableRow(entry.value, entry.key);
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F3460),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              'العقار',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'الموقع',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
          Expanded(
            child: Text(
              'النوع',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
          Expanded(
            child: Text(
              'السعر',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
          Expanded(
            child: Text(
              'المساحة',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
          Expanded(
            child: Text(
              'المالك',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
          Expanded(
            child: Text(
              'الحالة',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
          SizedBox(
            width: 150,
            child: Text(
              'الإجراءات',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(PropertyModel property, int index) {
    final isEven = index % 2 == 0;
    final district = districts.firstWhere((d) => d.id == property.districtId);
    final city = cities.firstWhere((c) => c.id == district.cityId);
    final category = categories.firstWhere((c) => c.id == property.categoryId);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: isEven ? Colors.transparent : Colors.white.withOpacity(0.02),
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.05), width: 1),
        ),
      ),
      child: Row(
        children: [
          // معلومات العقار
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  property.titleAr,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.bed,
                      size: 14,
                      color: Colors.white.withOpacity(0.5),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${property.bedrooms} غرفة',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      Icons.bathtub,
                      size: 14,
                      color: Colors.white.withOpacity(0.5),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${property.bathrooms} حمام',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // الموقع
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  district.nameAr,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
                Text(
                  city.nameAr,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),

          // النوع
          Expanded(
            child: Row(
              children: [
                Icon(category.icon, size: 18, color: const Color(0xFFD4AF37)),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    category.nameAr,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.7),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          // السعر
          Expanded(
            child: Text(
              '${_formatPrice(property.price)} ج.م',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFFD4AF37),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // المساحة
          Expanded(
            child: Text(
              '${property.area.toInt()} م²',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),

          // المالك
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  property.ownerName,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  property.ownerPhone,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),

          // الحالة
          Expanded(child: _buildStatusChip(property.isActive)),

          // الإجراءات
          SizedBox(
            width: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildActionButton(
                  icon: Icons.visibility,
                  color: Colors.blue,
                  tooltip: 'عرض التفاصيل',
                  onPressed: () {
                    // TODO: View details
                  },
                ),
                const SizedBox(width: 8),
                _buildActionButton(
                  icon: Icons.edit,
                  color: const Color(0xFFD4AF37),
                  tooltip: 'تعديل',
                  onPressed: () {
                    // TODO: Edit property
                  },
                ),
                const SizedBox(width: 8),
                _buildActionButton(
                  icon: Icons.delete,
                  color: Colors.red,
                  tooltip: 'حذف',
                  onPressed: () => _confirmDelete(property),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withOpacity(0.3), width: 1),
          ),
          child: Icon(icon, color: color, size: 16),
        ),
      ),
    );
  }

  Widget _buildStatusChip(bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive
            ? Colors.green.withOpacity(0.2)
            : Colors.red.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive ? Colors.green : Colors.red,
          width: 1,
        ),
      ),
      child: Text(
        isActive ? 'نشط' : 'غير نشط',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 12,
          color: isActive ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _formatPrice(double price) {
    if (price >= 1000000) {
      return '${(price / 1000000).toStringAsFixed(1)} مليون';
    } else if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(0)} ألف';
    }
    return price.toStringAsFixed(0);
  }

  void _confirmDelete(PropertyModel property) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AlessamyColors.cardBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('تأكيد الحذف', style: TextStyle(color: Colors.white)),
        content: Text(
          'هل أنت متأكد من حذف العقار "${property.titleAr}"؟',
          style: TextStyle(color: Colors.white.withOpacity(0.7)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                properties.removeWhere((p) => p.id == property.id);
              });
              Navigator.pop(context);
              _showSuccessSnackBar('تم حذف العقار بنجاح');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
