// screens/categories/widgets/category_dialog.dart

import 'package:flutter/material.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/features/city/model/data.dart';


class CategoryDialog extends StatefulWidget {
  final PropertyCategoryModel? category;
  final Function(Map<String, dynamic>) onSave;

  const CategoryDialog({
    super.key,
    this.category,
    required this.onSave,
  });

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



// screens/categories/categories_screen.dart

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final List<PropertyCategoryModel> categories = [];
  bool isLoading = false;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    setState(() => isLoading = true);
    
    await Future.delayed(const Duration(milliseconds: 800));
    
    setState(() {
      categories.addAll([
        PropertyCategoryModel(
          id: '1',
          nameAr: 'شقة',
          nameEn: 'Apartment',
          order: 1,
          isActive: true,
          icon: Icons.apartment,
          createdAt: DateTime.now().subtract(const Duration(days: 10)),
        ),
        PropertyCategoryModel(
          id: '2',
          nameAr: 'فيلا',
          nameEn: 'Villa',
          order: 2,
          isActive: true,
          icon: Icons.villa,
          createdAt: DateTime.now().subtract(const Duration(days: 9)),
        ),
        PropertyCategoryModel(
          id: '3',
          nameAr: 'محل تجاري',
          nameEn: 'Shop',
          order: 3,
          isActive: true,
          icon: Icons.store,
          createdAt: DateTime.now().subtract(const Duration(days: 8)),
        ),
        PropertyCategoryModel(
          id: '4',
          nameAr: 'عيادة',
          nameEn: 'Clinic',
          order: 4,
          isActive: true,
          icon: Icons.local_hospital,
          createdAt: DateTime.now().subtract(const Duration(days: 7)),
        ),
        PropertyCategoryModel(
          id: '5',
          nameAr: 'استوديو',
          nameEn: 'Studio',
          order: 5,
          isActive: true,
          icon: Icons.weekend,
          createdAt: DateTime.now().subtract(const Duration(days: 6)),
        ),
        PropertyCategoryModel(
          id: '6',
          nameAr: 'مكتب',
          nameEn: 'Office',
          order: 6,
          isActive: false,
          icon: Icons.business,
          createdAt: DateTime.now().subtract(const Duration(days: 5)),
        ),
        PropertyCategoryModel(
          id: '7',
          nameAr: 'مخزن',
          nameEn: 'Warehouse',
          order: 7,
          isActive: true,
          icon: Icons.warehouse,
          createdAt: DateTime.now().subtract(const Duration(days: 4)),
        ),
        PropertyCategoryModel(
          id: '8',
          nameAr: 'شاليه',
          nameEn: 'Chalet',
          order: 8,
          isActive: true,
          icon: Icons.cottage,
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
        ),
      ]);
      isLoading = false;
    });
  }

  List<PropertyCategoryModel> get filteredCategories {
    if (searchQuery.isEmpty) return categories;
    return categories.where((category) {
      return category.nameAr.contains(searchQuery) ||
          category.nameEn.toLowerCase().contains(searchQuery.toLowerCase());
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
                : _buildCategoriesGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AlessamyColors.backgroundColor,
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
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
              Icons.category,
              color: Color(0xFFD4AF37),
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'إدارة تصنيفات العقارات',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'إضافة وتعديل وترتيب تصنيفات العقارات',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: () => _showCategoryDialog(),
            icon: const Icon(Icons.add),
            label: const Text('إضافة تصنيف جديد'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD4AF37),
              foregroundColor: const Color(0xFF1A1A2E),
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
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
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'ابحث عن تصنيف...',
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
              ),
            ),
          ),
          const SizedBox(width: 16),
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
                  'إجمالي التصنيفات: ${filteredCategories.length}',
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

  Widget _buildCategoriesGrid() {
    final displayCategories = filteredCategories;
    displayCategories.sort((a, b) => a.order.compareTo(b.order));

    if (displayCategories.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              searchQuery.isEmpty
                  ? Icons.category_outlined
                  : Icons.search_off,
              size: 64,
              color: Colors.white.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              searchQuery.isEmpty
                  ? 'لا توجد تصنيفات مضافة'
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

    return ReorderableListView.builder(
      padding: const EdgeInsets.all(24),
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
          final category = displayCategories.removeAt(oldIndex);
          displayCategories.insert(newIndex, category);
          
          // تحديث الترتيب
          for (int i = 0; i < displayCategories.length; i++) {
            displayCategories[i] = displayCategories[i].copyWith(order: i + 1);
          }
        });
      },
      itemCount: displayCategories.length,
      itemBuilder: (context, index) {
        final category = displayCategories[index];
        return _buildCategoryCard(category, index, key: ValueKey(category.id));
      },
    );
  }

  Widget _buildCategoryCard(PropertyCategoryModel category, int index, {required Key key}) {
    return Container(
      key: key,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // أيقونة السحب للترتيب
            ReorderableDragStartListener(
              index: index,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.drag_indicator,
                  color: Colors.white.withOpacity(0.5),
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 16),
            
            // رقم الترتيب
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFD4AF37).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFFD4AF37),
                  width: 1,
                ),
              ),
              child: Center(
                child: Text(
                  '${category.order}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD4AF37),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            
            // أيقونة التصنيف
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFD4AF37).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                category.icon,
                color: const Color(0xFFD4AF37),
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            
            // اسم التصنيف
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.nameAr,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category.nameEn,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            
            // تاريخ الإضافة
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'تاريخ الإضافة',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatDate(category.createdAt),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            
            // الحالة
            _buildStatusChip(category.isActive),
            const SizedBox(width: 16),
            
            // أزرار التحكم
            Row(
              children: [
                _buildActionButton(
                  icon: Icons.edit,
                  color: const Color(0xFFD4AF37),
                  tooltip: 'تعديل',
                  onPressed: () => _showCategoryDialog(category: category),
                ),
                const SizedBox(width: 8),
                _buildActionButton(
                  icon: Icons.delete,
                  color: Colors.red,
                  tooltip: 'حذف',
                  onPressed: () => _confirmDelete(category),
                ),
              ],
            ),
          ],
        ),
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
            border: Border.all(
              color: color.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            color: color,
            size: 18,
          ),
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

  void _showCategoryDialog({PropertyCategoryModel? category}) {
    showDialog(
      context: context,
      builder: (context) => CategoryDialog(
        category: category,
        onSave: (categoryData) async {
          if (category == null) {
            setState(() {
              categories.add(PropertyCategoryModel(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                nameAr: categoryData['nameAr']!,
                nameEn: categoryData['nameEn']!,
                order: categories.length + 1,
                isActive: categoryData['isActive'] as bool,
                icon: categoryData['icon'] as IconData,
                createdAt: DateTime.now(),
              ));
            });
          } else {
            final index = categories.indexWhere((c) => c.id == category.id);
            if (index != -1) {
              setState(() {
                categories[index] = category.copyWith(
                  nameAr: categoryData['nameAr'],
                  nameEn: categoryData['nameEn'],
                  isActive: categoryData['isActive'] as bool,
                  icon: categoryData['icon'] as IconData,
                );
              });
            }
          }
          Navigator.pop(context);
          _showSuccessSnackBar(
            category == null ? 'تم إضافة التصنيف بنجاح' : 'تم تعديل التصنيف بنجاح',
          );
        },
      ),
    );
  }

  void _confirmDelete(PropertyCategoryModel category) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF16213E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'تأكيد الحذف',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'هل أنت متأكد من حذف تصنيف "${category.nameAr}"؟',
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
                      'قد يؤثر هذا على العقارات المرتبطة بهذا التصنيف',
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
                categories.removeWhere((c) => c.id == category.id);
                // إعادة ترتيب التصنيفات
                for (int i = 0; i < categories.length; i++) {
                  categories[i] = categories[i].copyWith(order: i + 1);
                }
              });
              Navigator.pop(context);
              _showSuccessSnackBar('تم حذف التصنيف بنجاح');
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}