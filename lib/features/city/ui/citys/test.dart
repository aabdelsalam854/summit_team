// screens/cities/cities_screen.dart
import 'package:flutter/material.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/core/widget/custom_text_form_field.dart';
import 'package:summit_team/features/city/model/data.dart';
import 'package:summit_team/features/city/ui/widget/city_dialog.dart';
import 'package:summit_team/features/city/ui/widget/stat_card.dart';

class CitiesScreensss extends StatefulWidget {
  const CitiesScreensss({Key? key}) : super(key: key);

  @override
  State<CitiesScreensss> createState() => _CitiesScreensssState();
}

class _CitiesScreensssState extends State<CitiesScreensss> {
  final List<CityModel> cities = [];
  bool isLoading = false;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadCities();
  }

  Future<void> _loadCities() async {
    setState(() => isLoading = true);

    await Future.delayed(const Duration(milliseconds: 800));

    setState(() {
      cities.addAll([
        CityModel(
          id: '1',
          nameAr: 'القاهرة',
          nameEn: 'Cairo',
          isActive: true,
          createdAt: DateTime.now().subtract(const Duration(days: 30)),
        ),
        CityModel(
          id: '2',
          nameAr: 'الإسكندرية',
          nameEn: 'Alexandria',
          isActive: true,
          createdAt: DateTime.now().subtract(const Duration(days: 28)),
        ),
        CityModel(
          id: '3',
          nameAr: 'الجيزة',
          nameEn: 'Giza',
          isActive: true,
          createdAt: DateTime.now().subtract(const Duration(days: 25)),
        ),
        CityModel(
          id: '4',
          nameAr: 'الشرقية',
          nameEn: 'Sharqia',
          isActive: true,
          createdAt: DateTime.now().subtract(const Duration(days: 22)),
        ),
        CityModel(
          id: '5',
          nameAr: 'المنوفية',
          nameEn: 'Menofia',
          isActive: false,
          createdAt: DateTime.now().subtract(const Duration(days: 20)),
        ),
      ]);
      isLoading = false;
    });
  }

  List<CityModel> get filteredCities {
    if (searchQuery.isEmpty) return cities;
    return cities.where((city) {
      return city.nameAr.contains(searchQuery) ||
          city.nameEn.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AlessamyColors.backgroundColor,
      body: Column(
        children: [
          _buildHeader(),
          _buildSearchBar(),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildCitiesTable(),
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
              Icons.location_city,
              color: Color(0xFFD4AF37),
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'إدارة المدن',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'إضافة وتعديل وحذف المدن',
                style: TextStyle(fontSize: 14, color: Colors.white54),
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: () => _showCityDialog(),
            icon: const Icon(Icons.add),
            label: const Text('إضافة مدينة جديدة'),
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

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            child: CustomTextFormField(
              hintText: 'ابحث عن مدينة...',
              icon: Icon(Icons.search, color: Colors.white.withOpacity(0.5)),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          const SizedBox(width: 16),
          StatCard(filteredCities: filteredCities),
        ],
      ),
    );
  }

  Widget _buildCitiesTable() {
    final displayCities = filteredCities;

    if (displayCities.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              searchQuery.isEmpty
                  ? Icons.location_city_outlined
                  : Icons.search_off,
              size: 64,
              color: Colors.white.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              searchQuery.isEmpty ? 'لا توجد مدن مضافة' : 'لا توجد نتائج للبحث',
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
          color: const Color(0xFF16213E),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
        ),
        child: Column(
          children: [
            _buildTableHeader(),
            ...displayCities.asMap().entries.map((entry) {
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
            flex: 2,
            child: Text(
              'اسم المدينة (عربي)',
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
              'اسم المدينة (إنجليزي)',
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
          Expanded(
            child: Text(
              'تاريخ الإضافة',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
          SizedBox(
            width: 200,
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

  Widget _buildTableRow(CityModel city, int index) {
    final isEven = index % 2 == 0;
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
          Expanded(
            flex: 2,
            child: Text(
              city.nameAr,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              city.nameEn,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
          Expanded(child: _buildStatusChip(city.isActive)),
          Expanded(
            child: Text(
              _formatDate(city.createdAt),
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildActionButton(
                  icon: Icons.map,
                  color: Colors.blue,
                  tooltip: 'إدارة المناطق',
                  onPressed: () => _navigateToDistricts(city),
                ),
                const SizedBox(width: 8),
                _buildActionButton(
                  icon: Icons.edit,
                  color: const Color(0xFFD4AF37),
                  tooltip: 'تعديل',
                  onPressed: () => _showCityDialog(city: city),
                ),
                const SizedBox(width: 8),
                _buildActionButton(
                  icon: Icons.delete,
                  color: Colors.red,
                  tooltip: 'حذف',
                  onPressed: () => _confirmDelete(city),
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
          child: Icon(icon, color: color, size: 18),
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _navigateToDistricts(CityModel city) {
    _showSuccessSnackBar('الانتقال إلى مناطق ${city.nameAr}');
  }

  void _showCityDialog({CityModel? city}) {
    showDialog(
      context: context,
      builder: (context) => CityDialog(
        city: city,
        onSave: (cityData) async {
          if (city == null) {
            setState(() {
              cities.add(
                CityModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  nameAr: cityData['nameAr']!,
                  nameEn: cityData['nameEn']!,
                  isActive: cityData['isActive'] as bool,
                  createdAt: DateTime.now(),
                ),
              );
            });
          } else {
            final index = cities.indexWhere((c) => c.id == city.id);
            if (index != -1) {
              setState(() {
                cities[index] = city.copyWith(
                  nameAr: cityData['nameAr'],
                  nameEn: cityData['nameEn'],
                  isActive: cityData['isActive'] as bool,
                );
              });
            }
          }
          Navigator.pop(context);
          _showSuccessSnackBar(
            city == null ? 'تم إضافة المدينة بنجاح' : 'تم تعديل المدينة بنجاح',
          );
        },
      ),
    );
  }

  void _confirmDelete(CityModel city) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF16213E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('تأكيد الحذف', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'هل أنت متأكد من حذف مدينة "${city.nameAr}"؟',
              style: TextStyle(color: Colors.white.withOpacity(0.7)),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning, color: Colors.red, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'سيتم حذف جميع المناطق والعقارات المرتبطة بهذه المدينة',
                      style: TextStyle(
                        color: Colors.red.shade300,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                cities.removeWhere((c) => c.id == city.id);
              });
              Navigator.pop(context);
              _showSuccessSnackBar('تم حذف المدينة بنجاح');
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



// screens/cities/widgets/city_dialog.dart

// import 'package:flutter/material.dart';
// import '../../../models/location_models.dart';

// screens/districts/districts_screen.dart

// import 'package:flutter/material.dart';
// import '../../models/location_models.dart';
// import 'widgets/district_dialog.dart';

class DistrictsScreen extends StatefulWidget {
  final CityModel? selectedCity;

  const DistrictsScreen({Key? key, this.selectedCity}) : super(key: key);

  @override
  State<DistrictsScreen> createState() => _DistrictsScreenState();
}

class _DistrictsScreenState extends State<DistrictsScreen> {
  final List<CityModel> cities = [];
  final Map<String, List<DistrictModel>> citiesDistricts = {};
  bool isLoading = false;
  String searchQuery = '';
  CityModel? selectedCity;

  @override
  void initState() {
    super.initState();
    selectedCity = widget.selectedCity;
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
          nameAr: 'الإسكندرية',
          nameEn: 'Alexandria',
          isActive: true,
          createdAt: DateTime.now(),
        ),
        CityModel(
          id: '3',
          nameAr: 'الجيزة',
          nameEn: 'Giza',
          isActive: true,
          createdAt: DateTime.now(),
        ),
      ]);

      // تحميل المناطق الوهمية للقاهرة
      citiesDistricts['1'] = [
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
          nameAr: 'مدينة نصر',
          nameEn: 'Nasr City',
          cityId: '1',
          isActive: true,
          createdAt: DateTime.now(),
        ),
        DistrictModel(
          id: 'dist4',
          nameAr: 'التجمع الخامس',
          nameEn: '5th Settlement',
          cityId: '1',
          isActive: true,
          createdAt: DateTime.now(),
        ),
        DistrictModel(
          id: 'dist5',
          nameAr: 'الزمالك',
          nameEn: 'Zamalek',
          cityId: '1',
          isActive: false,
          createdAt: DateTime.now(),
        ),
      ];

      // مناطق للإسكندرية
      citiesDistricts['2'] = [
        DistrictModel(
          id: 'dist6',
          nameAr: 'ميامي',
          nameEn: 'Miami',
          cityId: '2',
          isActive: true,
          createdAt: DateTime.now(),
        ),
        DistrictModel(
          id: 'dist7',
          nameAr: 'سموحة',
          nameEn: 'Smouha',
          cityId: '2',
          isActive: true,
          createdAt: DateTime.now(),
        ),
      ];

      // مناطق للجيزة
      citiesDistricts['3'] = [
        DistrictModel(
          id: 'dist8',
          nameAr: 'المهندسين',
          nameEn: 'Mohandessin',
          cityId: '3',
          isActive: true,
          createdAt: DateTime.now(),
        ),
        DistrictModel(
          id: 'dist9',
          nameAr: 'الدقي',
          nameEn: 'Dokki',
          cityId: '3',
          isActive: true,
          createdAt: DateTime.now(),
        ),
        DistrictModel(
          id: 'dist10',
          nameAr: '6 أكتوبر',
          nameEn: '6th October',
          cityId: '3',
          isActive: true,
          createdAt: DateTime.now(),
        ),
      ];

      isLoading = false;
    });
  }

  List<DistrictModel> get filteredDistricts {
    if (selectedCity == null) return [];

    final districts = citiesDistricts[selectedCity!.id] ?? [];

    if (searchQuery.isEmpty) return districts;

    return districts.where((district) {
      return district.nameAr.contains(searchQuery) ||
          district.nameEn.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AlessamyColors.backgroundColor,
      body: Column(
        children: [
          _buildHeader(),
          _buildFiltersBar(),
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : selectedCity == null
                ? _buildEmptyState()
                : _buildDistrictsTable(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E),
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_forward, color: Colors.white),
            tooltip: 'رجوع',
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFD4AF37).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.map, color: Color(0xFFD4AF37), size: 32),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'إدارة المناطق',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              if (selectedCity != null) ...[
                const SizedBox(height: 4),
                Text(
                  'مدينة ${selectedCity!.nameAr}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              ],
            ],
          ),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: selectedCity != null
                ? () => _showDistrictDialog()
                : null,
            icon: const Icon(Icons.add),
            label: const Text('إضافة منطقة جديدة'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD4AF37),
              foregroundColor: const Color(0xFF1A1A2E),
              disabledBackgroundColor: Colors.grey,
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

  Widget _buildFiltersBar() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          // اختيار المدينة
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF16213E),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedCity?.id,
                hint: Text(
                  'اختر المدينة',
                  style: TextStyle(color: Colors.white.withOpacity(0.5)),
                ),
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Color(0xFFD4AF37),
                ),
                dropdownColor: const Color(0xFF16213E),
                style: const TextStyle(color: Colors.white, fontSize: 16),
                items: cities.map((city) {
                  return DropdownMenuItem<String>(
                    value: city.id,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_city,
                          color: Color(0xFFD4AF37),
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(city.nameAr),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (cityId) {
                  setState(() {
                    selectedCity = cities.firstWhere((c) => c.id == cityId);
                    searchQuery = '';
                  });
                },
              ),
            ),
          ),
          const SizedBox(width: 16),

          // شريط البحث
          Expanded(
            child: TextField(
              enabled: selectedCity != null,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'ابحث عن منطقة...',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white.withOpacity(0.5),
                ),
                filled: true,
                fillColor: const Color(0xFF16213E),
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
                  borderSide: const BorderSide(color: Color(0xFFD4AF37)),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.05)),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // عدد المناطق
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF16213E),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.filter_list,
                  color: Color(0xFFD4AF37),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'إجمالي المناطق: ${filteredDistricts.length}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_city,
            size: 80,
            color: Colors.white.withOpacity(0.3),
          ),
          const SizedBox(height: 24),
          Text(
            'اختر مدينة من القائمة',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'لعرض وإدارة المناطق الخاصة بها',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDistrictsTable() {
    final displayDistricts = filteredDistricts;

    if (displayDistricts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              searchQuery.isEmpty ? Icons.map_outlined : Icons.search_off,
              size: 64,
              color: Colors.white.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              searchQuery.isEmpty
                  ? 'لا توجد مناطق مضافة لهذه المدينة'
                  : 'لا توجد نتائج للبحث',
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
            ...displayDistricts.asMap().entries.map((entry) {
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
        color: AlessamyColors.backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'اسم المنطقة (عربي)',
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
              'اسم المنطقة (إنجليزي)',
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
          Expanded(
            child: Text(
              'تاريخ الإضافة',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
          SizedBox(
            width: 200,
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

  Widget _buildTableRow(DistrictModel district, int index) {
    final isEven = index % 2 == 0;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: isEven
            ? Colors.transparent
            : AlessamyColors.backgroundColor.withOpacity(0.02),
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.05), width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              district.nameAr,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              district.nameEn,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
          Expanded(child: _buildStatusChip(district.isActive)),
          Expanded(
            child: Text(
              _formatDate(district.createdAt),
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildActionButton(
                  icon: Icons.home_work,
                  color: Colors.blue,
                  tooltip: 'عرض العقارات',
                  onPressed: () => _navigateToProperties(district),
                ),
                const SizedBox(width: 8),
                _buildActionButton(
                  icon: Icons.edit,
                  color: const Color(0xFFD4AF37),
                  tooltip: 'تعديل',
                  onPressed: () => _showDistrictDialog(district: district),
                ),
                const SizedBox(width: 8),
                _buildActionButton(
                  icon: Icons.delete,
                  color: Colors.red,
                  tooltip: 'حذف',
                  onPressed: () => _confirmDelete(district),
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
          child: Icon(icon, color: color, size: 18),
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _navigateToProperties(DistrictModel district) {
    // TODO: Navigate to properties screen
    _showSuccessSnackBar('الانتقال إلى عقارات منطقة ${district.nameAr}');
  }

  void _showDistrictDialog({DistrictModel? district}) {
    if (selectedCity == null) return;

    showDialog(
      context: context,
      builder: (context) => DistrictDialog(
        district: district,
        cityId: selectedCity!.id,
        cityName: selectedCity!.nameAr,
        onSave: (districtData) async {
          final districts = citiesDistricts[selectedCity!.id] ?? [];

          if (district == null) {
            setState(() {
              districts.add(
                DistrictModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  nameAr: districtData['nameAr']!,
                  nameEn: districtData['nameEn']!,
                  cityId: selectedCity!.id,
                  isActive: districtData['isActive'] as bool,
                  createdAt: DateTime.now(),
                ),
              );
              citiesDistricts[selectedCity!.id] = districts;
            });
          } else {
            final index = districts.indexWhere((d) => d.id == district.id);
            if (index != -1) {
              setState(() {
                districts[index] = district.copyWith(
                  nameAr: districtData['nameAr'],
                  nameEn: districtData['nameEn'],
                  isActive: districtData['isActive'] as bool,
                );
              });
            }
          }
          Navigator.pop(context);
          _showSuccessSnackBar(
            district == null
                ? 'تم إضافة المنطقة بنجاح'
                : 'تم تعديل المنطقة بنجاح',
          );
        },
      ),
    );
  }

  void _confirmDelete(DistrictModel district) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF16213E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('تأكيد الحذف', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'هل أنت متأكد من حذف منطقة "${district.nameAr}"؟',
              style: TextStyle(color: Colors.white.withOpacity(0.7)),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning, color: Colors.red, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'سيتم حذف جميع العقارات المرتبطة بهذه المنطقة',
                      style: TextStyle(
                        color: Colors.red.shade300,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                final districts = citiesDistricts[selectedCity!.id]!;
                districts.removeWhere((d) => d.id == district.id);
              });
              Navigator.pop(context);
              _showSuccessSnackBar('تم حذف المنطقة بنجاح');
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
// screens/districts/widgets/district_dialog.dart

class DistrictDialog extends StatefulWidget {
  final DistrictModel? district;
  final String cityId;
  final String cityName;
  final Function(Map<String, dynamic>) onSave;

  const DistrictDialog({
    Key? key,
    this.district,
    required this.cityId,
    required this.cityName,
    required this.onSave,
  }) : super(key: key);

  @override
  State<DistrictDialog> createState() => _DistrictDialogState();
}

class _DistrictDialogState extends State<DistrictDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameArController;
  late TextEditingController _nameEnController;
  late bool _isActive;

  @override
  void initState() {
    super.initState();
    _nameArController = TextEditingController(
      text: widget.district?.nameAr ?? '',
    );
    _nameEnController = TextEditingController(
      text: widget.district?.nameEn ?? '',
    );
    _isActive = widget.district?.isActive ?? true;
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
                      widget.district == null
                          ? Icons.add_location_alt
                          : Icons.edit_location_alt,
                      color: const Color(0xFFD4AF37),
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.district == null
                              ? 'إضافة منطقة جديدة'
                              : 'تعديل المنطقة',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'مدينة ${widget.cityName}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              TextFormField(
                controller: _nameArController,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: InputDecoration(
                  labelText: 'اسم المنطقة (عربي)',
                  labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                  prefixIcon: const Icon(Icons.map, color: Color(0xFFD4AF37)),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.05),
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
                    borderSide: const BorderSide(
                      color: Color(0xFFD4AF37),
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'الرجاء إدخال اسم المنطقة بالعربي';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameEnController,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: InputDecoration(
                  labelText: 'اسم المنطقة (إنجليزي)',
                  labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                  prefixIcon: const Icon(Icons.abc, color: Color(0xFFD4AF37)),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.05),
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
                    borderSide: const BorderSide(
                      color: Color(0xFFD4AF37),
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'الرجاء إدخال اسم المنطقة بالإنجليزي';
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
                      'حالة المنطقة',
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
                      widget.district == null ? 'إضافة' : 'حفظ التعديلات',
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
