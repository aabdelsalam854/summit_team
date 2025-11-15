import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:summit_team/core/adaptive_layout/adaptive_layout_widget.dart';
import 'package:summit_team/core/utils/alessamy_colors.dart';
import 'package:summit_team/features/auth/presentation/widgets/custom_text_field_widget.dart';
import 'package:summit_team/features/dashboard/presentation/screens/desktop_dashboard_layout.dart';
import 'package:summit_team/features/dashboard/presentation/widgets/custom_drower.dart';
import 'package:summit_team/features/properties/data/models/property_model.dart';
import 'package:summit_team/features/dashboard/presentation/widgets/property_form_section_widget.dart';
import 'package:summit_team/features/dashboard/presentation/widgets/property_text_field_widget.dart';
import 'package:summit_team/features/dashboard/presentation/widgets/property_dropdown_widget.dart';
import 'package:summit_team/features/dashboard/presentation/widgets/property_date_picker_widget.dart';
import 'package:summit_team/features/dashboard/presentation/widgets/property_checkbox_widget.dart';

class PropertyFormScreen extends StatefulWidget {
  const PropertyFormScreen({super.key, this.property});

  final PropertyModel? property;

  @override
  State<PropertyFormScreen> createState() => _PropertyFormScreenState();
}

class _PropertyFormScreenState extends State<PropertyFormScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _codeController = TextEditingController();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _locationController = TextEditingController();
  final _cityController = TextEditingController();
  final _groupController = TextEditingController();
  final _buildingController = TextEditingController();
  final _unitController = TextEditingController();
  final _floorController = TextEditingController();
  final _areaController = TextEditingController();
  final _bedroomsController = TextEditingController();
  final _bathroomsController = TextEditingController();
  final _viewDirectionController = TextEditingController();
  final _gardenAreaController = TextEditingController();
  final _installmentMonthsController = TextEditingController();
  final _downPaymentController = TextEditingController();
  final _overPriceController = TextEditingController();
  final _installmentDetailsController = TextEditingController();
  final _notesController = TextEditingController();

  // Selected values
  PropertyType _selectedType = PropertyType.apartment;
  PropertyPurpose _selectedPurpose = PropertyPurpose.sale;
  PropertyCategory? _selectedCategory;
  DeliveryStatus? _selectedDeliveryStatus;
  DateTime? _reservationDate;
  bool _isFeatured = false;

  @override
  void initState() {
    super.initState();
    if (widget.property != null) {
      _loadPropertyData(widget.property!);
    }
  }

  void _loadPropertyData(PropertyModel property) {
    _codeController.text = property.code;
    _titleController.text = property.title;
    _descriptionController.text = property.description;
    _priceController.text = property.price.toString();
    _locationController.text = property.location;
    _cityController.text = property.city;
    _groupController.text = property.group ?? '';
    _buildingController.text = property.building ?? '';
    _unitController.text = property.unit ?? '';
    _floorController.text = property.floor?.toString() ?? '';
    _areaController.text = property.area.toString();
    _bedroomsController.text = property.bedrooms.toString();
    _bathroomsController.text = property.bathrooms.toString();
    _viewDirectionController.text = property.viewDirection ?? '';
    _gardenAreaController.text = property.gardenArea?.toString() ?? '';
    _installmentMonthsController.text =
        property.installmentMonths?.toString() ?? '';
    _downPaymentController.text = property.downPayment?.toString() ?? '';
    _overPriceController.text = property.overPrice?.toString() ?? '';
    _installmentDetailsController.text = property.installmentDetails ?? '';
    _notesController.text = property.notes ?? '';

    _selectedType = property.type;
    _selectedPurpose = property.purpose;
    _selectedCategory = property.category;
    _selectedDeliveryStatus = property.deliveryStatus;
    _reservationDate = property.reservationDate;
    _isFeatured = property.isFeatured;
  }

  @override
  void dispose() {
    _codeController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _locationController.dispose();
    _cityController.dispose();
    _groupController.dispose();
    _buildingController.dispose();
    _unitController.dispose();
    _floorController.dispose();
    _areaController.dispose();
    _bedroomsController.dispose();
    _bathroomsController.dispose();
    _viewDirectionController.dispose();
    _gardenAreaController.dispose();
    _installmentMonthsController.dispose();
    _downPaymentController.dispose();
    _overPriceController.dispose();
    _installmentDetailsController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.property != null;

    return Scaffold(
      backgroundColor: AlessamyColors.backgroundColor,
      // appBar: AppBar(
      //   backgroundColor: AlessamyColors.cardBackground,
      //   elevation: 0,
      //   title: Text(
      //     isEdit ? 'تعديل العقار' : 'إضافة عقار جديد',
      //     style: TextStyle(
      //       fontSize: 20.sp,
      //       fontWeight: FontWeight.bold,
      //       color: AlessamyColors.white,
      //     ),
      //   ),
      //   leading: IconButton(
      //     onPressed: () => Navigator.pop(context),
      //     icon: Icon(Icons.arrow_back, color: AlessamyColors.white),
      //   ),
      // ),
      body: Form(
        key: _formKey,
        child: AdaptiveLayout(
          desktopLayout: (context) => desktopLayout(context, isEdit),
          tabletLayout: (context) => tabletLayout(context, isEdit),
          mobileLayout: (context) => mobileLayout(context, isEdit),
        ),
      ),
    );
  }

  CustomScrollView tabletLayout(BuildContext context, bool isEdit) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: 24.h)),

        // المعلومات الأساسية
        SliverToBoxAdapter(child: BasicInformation()),

        SliverToBoxAdapter(child: SizedBox(height: 24.h)),

        // العنوان
        SliverToBoxAdapter(child: location()),

        SliverToBoxAdapter(child: SizedBox(height: 24.h)),

        // مواصفات الوحدة
        UnitSpecifications(),

        SliverToBoxAdapter(child: SizedBox(height: 24.h)),

        // تاريخ الحجز ومدة القسط
        Bookingdateandinstallmentperiod(),

        SliverToBoxAdapter(child: SizedBox(height: 24.h)),

        // التفاصيل المالية
        SliverToBoxAdapter(child: FinancialDetails()),

        SliverToBoxAdapter(child: SizedBox(height: 24.h)),

        // ملاحظات وإعدادات إضافية
        SliverToBoxAdapter(child: AdditionalNotes()),

        SliverToBoxAdapter(child: SizedBox(height: 32.h)),

        // Action Buttons
        SliverToBoxAdapter(child: buttons(context, isEdit)),

        SliverToBoxAdapter(child: SizedBox(height: 32.h)),
      ],
    );
  }

  Padding buttons(BuildContext context, bool isEdit) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AlessamyColors.textLight),
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'إلغاء',
                style: TextStyle(
                  fontSize: 16,
                  color: AlessamyColors.textLight,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _saveProperty,
              style: ElevatedButton.styleFrom(
                backgroundColor: AlessamyColors.primaryGold,
                foregroundColor: AlessamyColors.black,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                isEdit ? 'حفظ التعديلات' : 'إضافة العقار',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  PropertyFormSectionWidget AdditionalNotes() {
    return PropertyFormSectionWidget(
      title: '✅ ملاحظات وإعدادات',
      children: [
        PropertyTextFieldWidget(
          controller: _notesController,
          label: 'ملاحظات',
          hint: 'مثال: تشطيبات الترا سوبر لوكس',
          icon: Icons.note,
          maxLines: 3,
        ),
        PropertyDropdownWidget<PropertyPurpose>(
          label: 'الغرض *',
          value: _selectedPurpose,
          items: PropertyPurpose.values,
          itemLabel: (item) => item.arabicName,
          onChanged: (value) => setState(() => _selectedPurpose = value!),
          icon: Icons.sell,
        ),
        PropertyCheckboxWidget(
          label: 'عقار مميز',
          value: _isFeatured,
          onChanged: (value) => setState(() => _isFeatured = value ?? false),
        ),
      ],
    );
  }

  PropertyFormSectionWidget FinancialDetails() {
    return PropertyFormSectionWidget(
      title: '💰 التفاصيل المالية',
      children: [
        PropertyTextFieldWidget(
          controller: _downPaymentController,
          label: 'المدفوعات',
          hint: 'مثال: 500000',
          icon: Icons.payments,
          keyboardType: TextInputType.number,
        ),
        PropertyTextFieldWidget(
          controller: _overPriceController,
          label: 'أوفر برايس',
          hint: 'مثال: 100000',
          icon: Icons.attach_money,
          keyboardType: TextInputType.number,
        ),
        PropertyTextFieldWidget(
          controller: _priceController,
          label: 'أصل العقد أو ثمن الكاش *',
          hint: 'مثال: 5000000',
          icon: Icons.price_change,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value?.isEmpty ?? true) return 'السعر مطلوب';
            return null;
          },
        ),
        PropertyTextFieldWidget(
          controller: _installmentDetailsController,
          label: 'تفاصيل الأقساط',
          hint: 'تفاصيل الأقساط',
          icon: Icons.notes,
          maxLines: 2,
        ),
      ],
    );
  }

  PropertyFormSectionWidget Bookingdateandinstallmentperiod() {
    return PropertyFormSectionWidget(
      title: '❇ تاريخ الحجز ومدة القسط',
      children: [
        PropertyDatePickerWidget(
          label: 'تاريخ الحجز',
          date: _reservationDate,
          onChanged: (date) => setState(() => _reservationDate = date),
        ),
        PropertyTextFieldWidget(
          controller: _installmentMonthsController,
          label: 'مدة القسط (بالشهور)',
          hint: 'مثال: 60',
          icon: Icons.calendar_month,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  PropertyFormSectionWidget UnitSpecifications() {
    return PropertyFormSectionWidget(
      title: '✍ مواصفات الوحدة',
      children: [
        PropertyDropdownWidget<PropertyType>(
          label: 'النوع *',
          value: _selectedType,
          items: PropertyType.values,
          itemLabel: (item) => item.arabicName,
          onChanged: (value) => setState(() => _selectedType = value!),
          icon: Icons.home,
        ),
        PropertyDropdownWidget<DeliveryStatus>(
          label: 'الاستلام',
          value: _selectedDeliveryStatus,
          items: DeliveryStatus.values,
          itemLabel: (item) => item.arabicName,
          onChanged: (value) => setState(() => _selectedDeliveryStatus = value),
          icon: Icons.check_circle,
        ),
        PropertyTextFieldWidget(
          controller: _viewDirectionController,
          label: 'الواجهة',
          hint: 'مثال: فيو وايد جاردن',
          icon: Icons.visibility,
        ),
        PropertyTextFieldWidget(
          controller: _areaController,
          label: 'المساحة (م²) *',
          hint: 'مثال: 96',
          icon: Icons.square_foot,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value?.isEmpty ?? true) return 'المساحة مطلوبة';
            return null;
          },
        ),
        PropertyTextFieldWidget(
          controller: _gardenAreaController,
          label: 'مساحة الجاردن/تراس (م²)',
          hint: 'اختياري',
          icon: Icons.grass,
          keyboardType: TextInputType.number,
        ),
        PropertyTextFieldWidget(
          controller: _bedroomsController,
          label: 'غرف النوم *',
          hint: 'مثال: 3',
          icon: Icons.bed,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value?.isEmpty ?? true) return 'عدد الغرف مطلوب';
            return null;
          },
        ),
        PropertyTextFieldWidget(
          controller: _bathroomsController,
          label: 'الحمامات *',
          hint: 'مثال: 2',
          icon: Icons.bathroom,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value?.isEmpty ?? true) return 'عدد الحمامات مطلوب';
            return null;
          },
        ),
      ],
    );
  }

  PropertyFormSectionWidget location() {
    return PropertyFormSectionWidget(
      title: '🏩 العنوان',
      children: [
        PropertyTextFieldWidget(
          controller: _locationController,
          label: 'المنطقة *',
          hint: 'مثال: B11',
          icon: Icons.location_on,
          validator: (value) {
            if (value?.isEmpty ?? true) return 'المنطقة مطلوبة';
            return null;
          },
        ),
        PropertyTextFieldWidget(
          controller: _groupController,
          label: 'المجموعة',
          hint: 'اختياري',
          icon: Icons.group_work,
        ),
        PropertyTextFieldWidget(
          controller: _buildingController,
          label: 'العمارة',
          hint: 'اختياري',
          icon: Icons.apartment,
        ),
        PropertyTextFieldWidget(
          controller: _unitController,
          label: 'الوحدة',
          hint: 'اختياري',
          icon: Icons.door_front_door,
        ),
        PropertyTextFieldWidget(
          controller: _floorController,
          label: 'الدور',
          hint: 'مثال: 5',
          icon: Icons.stairs,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  PropertyFormSectionWidget BasicInformation() {
    return PropertyFormSectionWidget(
      title: '📎 المعلومات الأساسية',
      children: [
        PropertyTextFieldWidget(
          controller: _codeController,
          label: 'كود العقار *',
          hint: 'مثال: 5008',
          icon: Icons.tag,
          validator: (value) {
            if (value?.isEmpty ?? true) return 'الكود مطلوب';
            return null;
          },
        ),
        PropertyTextFieldWidget(
          controller: _titleController,
          label: 'العنوان *',
          hint: 'مثال: شقة فاخرة في الرحاب',
          icon: Icons.title,
          validator: (value) {
            if (value?.isEmpty ?? true) return 'العنوان مطلوب';
            return null;
          },
        ),
        PropertyTextFieldWidget(
          controller: _descriptionController,
          label: 'الوصف *',
          hint: 'وصف تفصيلي للعقار',
          icon: Icons.description,
          maxLines: 3,
          validator: (value) {
            if (value?.isEmpty ?? true) return 'الوصف مطلوب';
            return null;
          },
        ),
        PropertyDropdownWidget<PropertyCategory>(
          label: 'الفئة *',
          value: _selectedCategory,
          items: PropertyCategory.values,
          itemLabel: (item) => item.arabicName,
          onChanged: (value) => _selectedCategory = value,
          icon: Icons.category,
        ),
        PropertyTextFieldWidget(
          controller: _cityController,
          label: 'المدينة *',
          hint: 'مثال: مدينتي',
          icon: Icons.location_city,
          validator: (value) {
            if (value?.isEmpty ?? true) return 'المدينة مطلوبة';
            return null;
          },
        ),
      ],
    );
  }

  SafeArea desktopLayout(BuildContext context, bool isEdit) {
    return SafeArea(
      child: Row(
        children: [
          Expanded(flex: 1, child: CustomDrower()),

          Expanded(
            flex: 5,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            "SUMMIT TEAM ",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AlessamyColors.white,
                            ),
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: CustomTextFieldWidget(
                            hintText: 'بحث...',
                            controller: TextEditingController(),
                            prefixIcon: Icons.search,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: AlessamyColors.primaryGold,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.person,
                                    color: AlessamyColors.white,
                                  ),
                                ),
                              ),

                              SizedBox(width: 5),
                              Column(
                                children: [
                                  Text(
                                    'اسم المستخدم',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AlessamyColors.white,
                                    ),
                                  ),
                                  Text(
                                    'دور المستخدم',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AlessamyColors.textLight,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => context.pop(),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: AlessamyColors.white,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          isEdit ? 'تعديل العقار' : 'إضافة عقار جديد',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AlessamyColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // المعلومات الأساسية
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(child: BasicInformation()),
                      SizedBox(width: 24),
                      Expanded(child: UnitSpecifications()),
                    ],
                  ),
                ),

                SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(child: location()),
                      SizedBox(width: 24),
                      Expanded(child: FinancialDetails()),
                    ],
                  ),
                ),
                // العنوان

                // تاريخ الحجز ومدة القسط
                SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(child: Bookingdateandinstallmentperiod()),
                      SizedBox(width: 24),
                      Expanded(child: AdditionalNotes()),
                    ],
                  ),
                ),

                // التفاصيل المالية
                SliverToBoxAdapter(child: SizedBox(height: 32.h)),

                // Action Buttons
                SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(
                        child: PropertyFormSectionWidget(
                          title: "",
                          children: [
                            PropertyTextFieldWidget(
                              controller: _descriptionController,
                              label: 'كود الموظف',
                              hint: 'مثال: 5008',
                              icon: Icons.description,
                              maxLines: 3,
                              validator: (value) {
                                if (value?.isEmpty ?? true)
                                  return 'الوصف مطلوب';
                                return null;
                              },
                            ),
                            PropertyTextFieldWidget(
                              controller: _descriptionController,
                              label: 'رقم هاتف صاحب العقار',
                              hint: 'مثال: 0101234567891',
                              icon: Icons.phone_android,
                              maxLines: 3,
                              validator: (value) {
                                if (value?.isEmpty ?? true)
                                  return 'الوصف مطلوب';
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: PropertyFormSectionWidget(
                          children: [buttons(context, isEdit)],
                          title: "",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  CustomScrollView mobileLayout(BuildContext context, bool isEdit) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: 24.h)),

        // المعلومات الأساسية
        SliverToBoxAdapter(
          child: PropertyFormSectionWidget(
            title: '📎 المعلومات الأساسية',
            children: [
              PropertyTextFieldWidget(
                controller: _codeController,
                label: 'كود العقار *',
                hint: 'مثال: 5008',
                icon: Icons.tag,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'الكود مطلوب';
                  return null;
                },
              ),
              PropertyTextFieldWidget(
                controller: _titleController,
                label: 'العنوان *',
                hint: 'مثال: شقة فاخرة في الرحاب',
                icon: Icons.title,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'العنوان مطلوب';
                  return null;
                },
              ),
              PropertyTextFieldWidget(
                controller: _descriptionController,
                label: 'الوصف *',
                hint: 'وصف تفصيلي للعقار',
                icon: Icons.description,
                maxLines: 3,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'الوصف مطلوب';
                  return null;
                },
              ),
              PropertyDropdownWidget<PropertyCategory>(
                label: 'الفئة *',
                value: _selectedCategory,
                items: PropertyCategory.values,
                itemLabel: (item) => item.arabicName,
                onChanged: (value) => setState(() => _selectedCategory = value),
                icon: Icons.category,
              ),
              PropertyTextFieldWidget(
                controller: _cityController,
                label: 'المدينة *',
                hint: 'مثال: مدينتي',
                icon: Icons.location_city,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'المدينة مطلوبة';
                  return null;
                },
              ),
            ],
          ),
        ),

        SliverToBoxAdapter(child: SizedBox(height: 24.h)),

        // العنوان
        SliverToBoxAdapter(
          child: PropertyFormSectionWidget(
            title: '🏩 العنوان',
            children: [
              PropertyTextFieldWidget(
                controller: _locationController,
                label: 'المنطقة *',
                hint: 'مثال: B11',
                icon: Icons.location_on,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'المنطقة مطلوبة';
                  return null;
                },
              ),
              PropertyTextFieldWidget(
                controller: _groupController,
                label: 'المجموعة',
                hint: 'اختياري',
                icon: Icons.group_work,
              ),
              PropertyTextFieldWidget(
                controller: _buildingController,
                label: 'العمارة',
                hint: 'اختياري',
                icon: Icons.apartment,
              ),
              PropertyTextFieldWidget(
                controller: _unitController,
                label: 'الوحدة',
                hint: 'اختياري',
                icon: Icons.door_front_door,
              ),
              PropertyTextFieldWidget(
                controller: _floorController,
                label: 'الدور',
                hint: 'مثال: 5',
                icon: Icons.stairs,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),

        SliverToBoxAdapter(child: SizedBox(height: 24.h)),

        // مواصفات الوحدة
        SliverToBoxAdapter(
          child: PropertyFormSectionWidget(
            title: '✍ مواصفات الوحدة',
            children: [
              PropertyDropdownWidget<PropertyType>(
                label: 'النوع *',
                value: _selectedType,
                items: PropertyType.values,
                itemLabel: (item) => item.arabicName,
                onChanged: (value) => setState(() => _selectedType = value!),
                icon: Icons.home,
              ),
              PropertyDropdownWidget<DeliveryStatus>(
                label: 'الاستلام',
                value: _selectedDeliveryStatus,
                items: DeliveryStatus.values,
                itemLabel: (item) => item.arabicName,
                onChanged: (value) =>
                    setState(() => _selectedDeliveryStatus = value),
                icon: Icons.check_circle,
              ),
              PropertyTextFieldWidget(
                controller: _viewDirectionController,
                label: 'الواجهة',
                hint: 'مثال: فيو وايد جاردن',
                icon: Icons.visibility,
              ),
              PropertyTextFieldWidget(
                controller: _areaController,
                label: 'المساحة (م²) *',
                hint: 'مثال: 96',
                icon: Icons.square_foot,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'المساحة مطلوبة';
                  return null;
                },
              ),
              PropertyTextFieldWidget(
                controller: _gardenAreaController,
                label: 'مساحة الجاردن/تراس (م²)',
                hint: 'اختياري',
                icon: Icons.grass,
                keyboardType: TextInputType.number,
              ),
              PropertyTextFieldWidget(
                controller: _bedroomsController,
                label: 'غرف النوم *',
                hint: 'مثال: 3',
                icon: Icons.bed,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'عدد الغرف مطلوب';
                  return null;
                },
              ),
              PropertyTextFieldWidget(
                controller: _bathroomsController,
                label: 'الحمامات *',
                hint: 'مثال: 2',
                icon: Icons.bathroom,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'عدد الحمامات مطلوب';
                  return null;
                },
              ),
            ],
          ),
        ),

        SliverToBoxAdapter(child: SizedBox(height: 24.h)),

        // تاريخ الحجز ومدة القسط
        SliverToBoxAdapter(
          child: PropertyFormSectionWidget(
            title: '❇ تاريخ الحجز ومدة القسط',
            children: [
              PropertyDatePickerWidget(
                label: 'تاريخ الحجز',
                date: _reservationDate,
                onChanged: (date) => setState(() => _reservationDate = date),
              ),
              PropertyTextFieldWidget(
                controller: _installmentMonthsController,
                label: 'مدة القسط (بالشهور)',
                hint: 'مثال: 60',
                icon: Icons.calendar_month,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),

        SliverToBoxAdapter(child: SizedBox(height: 24.h)),

        // التفاصيل المالية
        SliverToBoxAdapter(
          child: PropertyFormSectionWidget(
            title: '💰 التفاصيل المالية',
            children: [
              PropertyTextFieldWidget(
                controller: _downPaymentController,
                label: 'المدفوعات',
                hint: 'مثال: 500000',
                icon: Icons.payments,
                keyboardType: TextInputType.number,
              ),
              PropertyTextFieldWidget(
                controller: _overPriceController,
                label: 'أوفر برايس',
                hint: 'مثال: 100000',
                icon: Icons.attach_money,
                keyboardType: TextInputType.number,
              ),
              PropertyTextFieldWidget(
                controller: _priceController,
                label: 'أصل العقد أو ثمن الكاش *',
                hint: 'مثال: 5000000',
                icon: Icons.price_change,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'السعر مطلوب';
                  return null;
                },
              ),
              PropertyTextFieldWidget(
                controller: _installmentDetailsController,
                label: 'تفاصيل الأقساط',
                hint: 'تفاصيل الأقساط',
                icon: Icons.notes,
                maxLines: 2,
              ),
            ],
          ),
        ),

        SliverToBoxAdapter(child: SizedBox(height: 24.h)),

        // ملاحظات وإعدادات إضافية
        SliverToBoxAdapter(
          child: PropertyFormSectionWidget(
            title: '✅ ملاحظات وإعدادات',
            children: [
              PropertyTextFieldWidget(
                controller: _notesController,
                label: 'ملاحظات',
                hint: 'مثال: تشطيبات الترا سوبر لوكس',
                icon: Icons.note,
                maxLines: 3,
              ),
              PropertyDropdownWidget<PropertyPurpose>(
                label: 'الغرض *',
                value: _selectedPurpose,
                items: PropertyPurpose.values,
                itemLabel: (item) => item.arabicName,
                onChanged: (value) => setState(() => _selectedPurpose = value!),
                icon: Icons.sell,
              ),
              PropertyCheckboxWidget(
                label: 'عقار مميز',
                value: _isFeatured,
                onChanged: (value) =>
                    setState(() => _isFeatured = value ?? false),
              ),
            ],
          ),
        ),

        SliverToBoxAdapter(child: SizedBox(height: 32.h)),

        // Action Buttons
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AlessamyColors.textLight),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'إلغاء',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AlessamyColors.textLight,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _saveProperty,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AlessamyColors.primaryGold,
                      foregroundColor: AlessamyColors.black,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      isEdit ? 'حفظ التعديلات' : 'إضافة العقار',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        SliverToBoxAdapter(child: SizedBox(height: 32.h)),
      ],
    );
  }

  void _saveProperty() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.property != null
                ? 'تم تحديث العقار بنجاح'
                : 'تم إضافة العقار بنجاح',
          ),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }
}
