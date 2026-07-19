import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m_store_1/core/costants/color_manager.dart';
import 'package:m_store_1/core/utils/ui_utils.dart';
import 'package:m_store_1/feature/add_product/data/cubit/add_product_cubit.dart';
import 'package:m_store_1/feature/add_product/data/cubit/add_product_state.dart';
import 'package:m_store_1/feature/add_product/data/model/buyer_data.dart';
import 'package:m_store_1/feature/add_product/presentation/widgets/buyer_information_section.dart';
import 'package:m_store_1/feature/add_product/presentation/widgets/core_information_section.dart';
import 'package:m_store_1/feature/add_product/presentation/widgets/physical_attributes_section.dart';
import 'package:m_store_1/feature/add_product/presentation/widgets/product_images_uploader.dart';
import 'package:m_store_1/feature/main_layout/products/data/model/product_model.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class AddProduct extends StatefulWidget {
  final ProductModel? product;

  const AddProduct({super.key, this.product});

  bool get isEdit => product != null;

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
  final _formKey = GlobalKey<FormState>();

  final List<BuyerData> _buyers = [];
  final ImagePicker _picker = ImagePicker();
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

  String _getColorName(Color color) {
    for (var entry in _colorNamesMap.entries) {
      if (entry.value.value == color.value) {
        final name = entry.key
            .split(' ')
            .map(
              (word) => word.substring(0, 1).toUpperCase() + word.substring(1),
            )
            .join(' ');
        final hex =
            '#${color.value.toRadixString(16).substring(2, 8).toUpperCase()}';
        return "$name | $hex";
      }
    }
    final hex =
        '#${color.value.toRadixString(16).substring(2, 8).toUpperCase()}';
    return hex;
  }

  void _openColorPickerDialog() {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            appLocalizations.selectPrimaryColor,
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

  @override
  void initState() {
    super.initState();

    if (widget.isEdit) {
      final product = widget.product!;

      _productNumberController.text = product.productNumber;
      _categoryController.text = product.category;
      _productNameController.text = product.productName;
      _descriptionController.text = product.description;

      _materialController.text = product.material;
      _primaryColorController.text = product.color;

      _sizeController.text = product.dimensions;
      _quantityController.text = product.quantity.toString();

      _purchasePriceController.text = product.purchasePrice.toString();

      _sellingPriceController.text = product.sellingPrice.toString();

      _mainImagePath = product.mainImage;

      _additionalImages.addAll(product.images);

      if (product.isSold && product.buyers.isNotEmpty) {
        for (var buyer in product.buyers) {
          _buyers.add(
            BuyerData(
              nameController: TextEditingController(text: buyer["name"]),
              phoneController: TextEditingController(text: buyer["phone"]),
              addressController: TextEditingController(text: buyer["address"]),
              quantityController: TextEditingController(
                text: buyer["quantity"].toString(),
              ),
            ),
          );
        }
      }
    } else {
      _addNewBuyer();
    }
  }

  void _addNewBuyer() {
    setState(() {
      _buyers.add(
        BuyerData(
          nameController: TextEditingController(),
          addressController: TextEditingController(),
          phoneController: TextEditingController(),
          quantityController: TextEditingController(
            text: "1",
          ),
        ),
      );
    });
  }

  Future<void> _pickMainImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    setState(() {
      _mainImagePath = image.path;
    });
  }

  Future<void> _pickAdditionalImage(int index) async {
    final image = await _picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    setState(() {
      if (index < _additionalImages.length) {
        _additionalImages[index] = image.path;
      } else {
        _additionalImages.add(image.path);
      }
    });
  }

  void _removeBuyer(int index) {
    if (_buyers.length > 1) {
      setState(() {
        _buyers[index].nameController.dispose();
        _buyers[index].addressController.dispose();
        _buyers[index].phoneController.dispose();
        _buyers[index].quantityController.dispose();
        _buyers.removeAt(index);
      });
    }
  }

  // String _getColorName(Color color) {
  //   for (var entry in _colorNamesMap.entries) {
  //     if (entry.value.value == color.value) {
  //       return entry.key
  //           .split(' ')
  //           .map(
  //             (word) => word.substring(0, 1).toUpperCase() + word.substring(1),
  //           )
  //           .join(' ');
  //     }
  //   }
  //   return '#${color.value.toRadixString(16).substring(2, 8).toUpperCase()}';
  // }
  //
  // void _openColorPickerDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(
  //           'Select Primary Color',
  //           style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold),
  //         ),
  //         content: SingleChildScrollView(
  //           child: MaterialPicker(
  //             pickerColor: _selectedColor,
  //             onColorChanged: (Color color) {
  //               setState(() {
  //                 _selectedColor = color;
  //                 _primaryColorController.text = _getColorName(color);
  //               });
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  void _onColorTextChanged(String value) {
    final cleanValue = value.trim().toLowerCase();

    if (_colorNamesMap.containsKey(cleanValue)) {
      setState(() {
        _selectedColor = _colorNamesMap[cleanValue]!;
      });
    } else if (cleanValue.startsWith('#') &&
        (cleanValue.length == 7 || cleanValue.length == 9)) {
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

  Future<void> _saveProduct() async {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (_mainImagePath == null) {
      UiUtils.showError(
        context,
        appLocalizations.please_select_a_main_image,
      );
      return;
    }

    if (!_mainImagePath!.startsWith("http")) {
      final mainImageFile = File(_mainImagePath!);

      if (!await mainImageFile.exists()) {
        UiUtils.showError(
          context,
          appLocalizations.main_image_is_missing_from_cache_please_re_pick_it,
        );
        return;
      }
    }

    final List<File> validAdditionalImages = [];
    for (String path in _additionalImages) {
      final file = File(path);
      if (await file.exists()) {
        validAdditionalImages.add(file);
      }
    }
    final oldImages = _additionalImages
        .where((e) => e.startsWith("http"))
        .toList();

    final newImages = _additionalImages
        .where((e) => !e.startsWith("http"))
        .map(File.new)
        .toList();

    final quantity = int.parse(_quantityController.text);
    final purchasePrice = double.parse(_purchasePriceController.text);
    final sellingPrice = double.parse(_sellingPriceController.text);

    final validBuyers = _buyers.where((buyer) {
      return buyer.nameController.text.trim().isNotEmpty;
    }).toList();

    final buyers = validBuyers.map((buyer) {
      return {
        "name": buyer.nameController.text.trim(),
        "phone": buyer.phoneController.text.trim(),
        "address": buyer.addressController.text.trim(),
        "quantity": int.tryParse(
          buyer.quantityController.text.trim(),
        ) ??
            1,
      };
    }).toList();

    final bool isSold = widget.isEdit
        ? widget.product!.isSold
        : false;
    final product = ProductModel(
      id: widget.product?.id ?? "",
      productNumber: _productNumberController.text.trim(),
      productName: _productNameController.text.trim(),
      description: _descriptionController.text.trim(),
      category: _categoryController.text.trim(),
      material: _materialController.text.trim(),
      color: _primaryColorController.text.trim(),
      dimensions: _sizeController.text.trim(),
      purchasePrice: purchasePrice,
      sellingPrice: sellingPrice,
      quantity: quantity,
      soldQuantity: widget.isEdit ? widget.product!.soldQuantity : 0,

      availableQuantity: widget.isEdit
          ? widget.product!.availableQuantity
          : quantity,

      isSold: widget.isEdit ? widget.product!.isSold : false,
      buyers: widget.isEdit
          ? (widget.product!.isSold ? buyers : widget.product!.buyers)
          : buyers,
      mainImage: widget.isEdit
          ? widget.product!.mainImage
          : "",
      images: [],
      createdAt: widget.isEdit
          ? widget.product!.createdAt
          : DateTime.now(),

      updatedAt: widget.isEdit
          ? widget.product!.updatedAt
          : null,
    );

    if (widget.isEdit) {
      await AddProductCubit.get(context).updateProduct(
        product: product,
        mainImage: _mainImagePath!.startsWith("http")
            ? null
            : File(_mainImagePath!),
        images: newImages,
        oldImages: oldImages,
      );
    } else {
      await AddProductCubit.get(context).addProduct(
        product: product,
        mainImage: File(_mainImagePath!),
        images: _additionalImages.map(File.new).toList(),
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
      buyer.quantityController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return BlocConsumer<AddProductCubit, AddProductState>(
      listener: (context, state) {
        if (state is AddProductLoadingState) {
          UiUtils.showLoading(context, isDismissible: false);
        }
        if (state is AddProductSuccessState) {
          UiUtils.hideLoading(context);
          UiUtils.showToast(appLocalizations.product_added_successfully);
          Navigator.pop(context);
        }
        if (state is AddProductErrorState) {
          UiUtils.hideLoading(context);
          UiUtils.showError(context, state.message);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
            title: Text(
              widget.isEdit ? appLocalizations.editProduct : appLocalizations.addProduct,
              style: textTheme.titleMedium,
            ),
          ),

          bottomNavigationBar: SafeArea(
            minimum: REdgeInsets.all(20),
            child: SizedBox(
              height: 54.h,
              child: ElevatedButton(
                onPressed: _saveProduct,
                child: Text(
                  widget.isEdit ? appLocalizations.updateProduct : appLocalizations.save,
                ),
              ),
            ),
          ),

          body: SingleChildScrollView(
            padding: REdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductImagesUploader(
                    mainImagePath: _mainImagePath,
                    additionalImages: _additionalImages,
                    onPickMainImage: _pickMainImage,
                    onPickAdditionalImage: _pickAdditionalImage,
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
                  if (!widget.isEdit || widget.product!.isSold)
                    BuyerInformationSection(
                      buyers: _buyers,
                      onAddBuyer: _addNewBuyer,
                      onRemoveBuyer: _removeBuyer,
                    ),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
