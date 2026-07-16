import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/feature/add_product/data/model/buyer_data.dart';
import 'package:m_store_1/feature/add_product/presentation/widgets/buyer_information_section.dart';
import 'package:m_store_1/feature/add_product/presentation/widgets/core_information_section.dart';
import 'package:m_store_1/feature/add_product/presentation/widgets/physical_attributes_section.dart';
import 'package:m_store_1/feature/add_product/presentation/widgets/product_images_uploader.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _productNumberController = TextEditingController();
  final _categoryController = TextEditingController();
  final _productNameController = TextEditingController();
  final _descriptionController = TextEditingController();

  final _materialController = TextEditingController();
  final _primaryColorController = TextEditingController(text: "Brown");

  final _sizeController = TextEditingController();
  final _quantityController = TextEditingController(text: "1");
  final _purchasePriceController = TextEditingController(text: "0.00");
  final _sellingPriceController = TextEditingController(text: "0.00");

  final List<BuyerData> _buyers = [];
  String? _mainImagePath;
  final List<String> _additionalImages = [];

  Color _selectedColor = const Color(0xFF3E2723);

  final Map<String, Color> _colorNamesMap = {
    "red": Colors.red,
    "pink": Colors.pink,
    "purple": Colors.purple,
    "deep purple": Colors.deepPurple,
    "indigo": Colors.indigo,
    "blue": Colors.blue,
    "light blue": Colors.lightBlue,
    "cyan": Colors.cyan,
    "teal": Colors.teal,
    "green": Colors.green,
    "light green": Colors.lightGreen,
    "lime": Colors.lime,
    "yellow": Colors.yellow,
    "amber": Colors.amber,
    "orange": Colors.orange,
    "deep orange": Colors.deepOrange,
    "brown": Colors.brown,
    "grey": Colors.grey,
    "blue grey": Colors.blueGrey,
    "black": Colors.black,
    "white": Colors.white,
  };

  @override
  void initState() {
    super.initState();
    _addNewBuyer();
  }

  void _addNewBuyer() {
    setState(() {
      _buyers.add(
        BuyerData(
          nameController: TextEditingController(),
          addressController: TextEditingController(),
          phoneController: TextEditingController(),
        ),
      );
    });
  }

  void _removeBuyer(int index) {
    if (_buyers.length > 1) {
      setState(() {
        _buyers[index].nameController.dispose();
        _buyers[index].addressController.dispose();
        _buyers[index].phoneController.dispose();
        _buyers.removeAt(index);
      });
    }
  }

  String _getColorName(Color color) {
    for (var entry in _colorNamesMap.entries) {
      if (entry.value.value == color.value) {
        return entry.key.split(' ').map((word) => word.substring(0, 1).toUpperCase() + word.substring(1)).join(' ');
      }
    }
    return '#${color.value.toRadixString(16).substring(2, 8).toUpperCase()}';
  }

  void _openColorPickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Select Primary Color',
            style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: MaterialPicker(
              pickerColor: _selectedColor,
              onColorChanged: (Color color) {
                setState(() {
                  _selectedColor = color;
                  _primaryColorController.text = _getColorName(color);
                });
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
    );
  }

  void _onColorTextChanged(String value) {
    final cleanValue = value.trim().toLowerCase();

    if (_colorNamesMap.containsKey(cleanValue)) {
      setState(() {
        _selectedColor = _colorNamesMap[cleanValue]!;
      });
    } else if (cleanValue.startsWith('#') && (cleanValue.length == 7 || cleanValue.length == 9)) {
      final hexColor = cleanValue.replaceFirst('#', '');
      final parsedColor = int.tryParse(hexColor, radix: 16);
      if (parsedColor != null) {
        setState(() {
          _selectedColor = Color(
            hexColor.length == 6 ? (0xFF000000 + parsedColor) : parsedColor,
          );
        });
      }
    }
  }

  void _saveProduct() {
    print("Product Number: ${_productNumberController.text}");
    print("Primary Color Text: ${_primaryColorController.text}");
    print("Main Image: $_mainImagePath");
    print("Additional Images count: ${_additionalImages.length}");

    for (var i = 0; i < _buyers.length; i++) {
      print(
        "Buyer ${i + 1}: Name: ${_buyers[i].nameController.text}, Phone: ${_buyers[i].phoneController.text}",
      );
    }
  }

  @override
  void dispose() {
    _productNumberController.dispose();
    _categoryController.dispose();
    _productNameController.dispose();
    _descriptionController.dispose();

    _materialController.dispose();
    _primaryColorController.dispose();
    _sizeController.dispose();
    _quantityController.dispose();
    _purchasePriceController.dispose();
    _sellingPriceController.dispose();

    for (var buyer in _buyers) {
      buyer.nameController.dispose();
      buyer.addressController.dispose();
      buyer.phoneController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: Text(appLocalizations.addProduct, style: textTheme.titleMedium),
      ),

      bottomNavigationBar: SafeArea(
        minimum: REdgeInsets.all(20),
        child: SizedBox(
          height: 54.h,
          child: ElevatedButton(
            onPressed: _saveProduct,
            child: Text(appLocalizations.save),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: REdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImagesUploader(
              mainImagePath: _mainImagePath,
              additionalImages: _additionalImages,
              onPickMainImage: () {},
              onPickAdditionalImage: (index) {},
            ),
            SizedBox(height: 24.h),
            CoreInformationSection(
              productNumberController: _productNumberController,
              categoryController: _categoryController,
              productNameController: _productNameController,
              descriptionController: _descriptionController,
            ),
            SizedBox(height: 24.h),
            PhysicalAttributesSection(
              materialController: _materialController,
              primaryColorController: _primaryColorController,
              sizeController: _sizeController,
              quantityController: _quantityController,
              purchasePriceController: _purchasePriceController,
              sellingPriceController: _sellingPriceController,
              colorSuffixIcon: Padding(
                padding: REdgeInsets.only(right: 16),
                child: UnconstrainedBox(
                  child: GestureDetector(
                    onTap: _openColorPickerDialog,
                    child: Container(
                      width: 24.w,
                      height: 24.w,
                      decoration: BoxDecoration(
                        color: _selectedColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ColorManager.lightGreyEF,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              onChangedColor: _onColorTextChanged,
              onColorTap: _openColorPickerDialog,
            ),
            SizedBox(height: 24.h),
            BuyerInformationSection(
              buyers: _buyers,
              onAddBuyer: _addNewBuyer,
              onRemoveBuyer: _removeBuyer,
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}