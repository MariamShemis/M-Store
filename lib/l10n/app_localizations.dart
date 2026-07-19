import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @m_Store.
  ///
  /// In en, this message translates to:
  /// **'M Store'**
  String get m_Store;

  /// No description provided for @iNITIALIZING.
  ///
  /// In en, this message translates to:
  /// **'INITIALIZING'**
  String get iNITIALIZING;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @enterYourPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Phone'**
  String get enterYourPhone;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterYourEmail;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @enterYourName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterYourName;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forgetPassword;

  /// No description provided for @forget_password_.
  ///
  /// In en, this message translates to:
  /// **'Forget Password ?'**
  String get forget_password_;

  /// No description provided for @pleaseEnterYourEmailToReceiveAConfirmationCodeToSetANewPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email to receive a confirmation code to set a new password'**
  String get pleaseEnterYourEmailToReceiveAConfirmationCodeToSetANewPassword;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'Or continue with'**
  String get orContinueWith;

  /// No description provided for @dontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAnAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get sign_up;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @welcome_back_Please_sign_in_to_access_your_collection.
  ///
  /// In en, this message translates to:
  /// **'Welcome back. Please sign in to access your collection.'**
  String get welcome_back_Please_sign_in_to_access_your_collection;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @welcome_.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get welcome_;

  /// No description provided for @welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcome_back;

  /// No description provided for @login_with_Google.
  ///
  /// In en, this message translates to:
  /// **'Login with Google'**
  String get login_with_Google;

  /// No description provided for @please_enter_your_email_to_receive_a_confirmation_code_to_set_a_new_password.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email to receive a confirmation code to set a new password'**
  String get please_enter_your_email_to_receive_a_confirmation_code_to_set_a_new_password;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @lE.
  ///
  /// In en, this message translates to:
  /// **'LE'**
  String get lE;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @saved_Successfully.
  ///
  /// In en, this message translates to:
  /// **'Saved Successfully'**
  String get saved_Successfully;

  /// No description provided for @general_settings.
  ///
  /// In en, this message translates to:
  /// **'General Settings'**
  String get general_settings;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @account_Security.
  ///
  /// In en, this message translates to:
  /// **'Account & Security'**
  String get account_Security;

  /// No description provided for @log_out.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get log_out;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @are_you_sure_you_want_to_log_out.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out'**
  String get are_you_sure_you_want_to_log_out;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @this_field_is_required.
  ///
  /// In en, this message translates to:
  /// **'this field is required'**
  String get this_field_is_required;

  /// No description provided for @name_must_be_at_least_characters.
  ///
  /// In en, this message translates to:
  /// **'Name must be at least 3 characters'**
  String get name_must_be_at_least_characters;

  /// No description provided for @enter_a_valid_email.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get enter_a_valid_email;

  /// No description provided for @enter_a_valid_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number'**
  String get enter_a_valid_phone_number;

  /// No description provided for @password_must_contain_at_least_characters.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least 8 characters'**
  String get password_must_contain_at_least_characters;

  /// No description provided for @passwords_do_not_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwords_do_not_match;

  /// No description provided for @join_MSTORE_and_simplify_the_way_you_organize_your_products_and_manage_your_inventory.
  ///
  /// In en, this message translates to:
  /// **'Join M STORE and simplify the way you organize your products and manage your inventory.'**
  String get join_MSTORE_and_simplify_the_way_you_organize_your_products_and_manage_your_inventory;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @products.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products;

  /// No description provided for @sales.
  ///
  /// In en, this message translates to:
  /// **'Sales'**
  String get sales;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @sold.
  ///
  /// In en, this message translates to:
  /// **'Sold'**
  String get sold;

  /// No description provided for @capital.
  ///
  /// In en, this message translates to:
  /// **'Capital'**
  String get capital;

  /// No description provided for @profit.
  ///
  /// In en, this message translates to:
  /// **'Profit'**
  String get profit;

  /// No description provided for @revenue.
  ///
  /// In en, this message translates to:
  /// **'Revenue'**
  String get revenue;

  /// No description provided for @last.
  ///
  /// In en, this message translates to:
  /// **'Last'**
  String get last;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get days;

  /// No description provided for @topCategories.
  ///
  /// In en, this message translates to:
  /// **'Top Categories'**
  String get topCategories;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @buy.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get buy;

  /// No description provided for @sell.
  ///
  /// In en, this message translates to:
  /// **'Sell'**
  String get sell;

  /// No description provided for @productInventory.
  ///
  /// In en, this message translates to:
  /// **'Product Inventory'**
  String get productInventory;

  /// No description provided for @manage_and_organize_your_store_products.
  ///
  /// In en, this message translates to:
  /// **'Manage and organize your store products.'**
  String get manage_and_organize_your_store_products;

  /// No description provided for @your_Inventory_is_Empty.
  ///
  /// In en, this message translates to:
  /// **'Your Inventory is Empty'**
  String get your_Inventory_is_Empty;

  /// No description provided for @start_building_your_inventory_by_adding_your_first_product.
  ///
  /// In en, this message translates to:
  /// **'Start building your inventory by adding your first product.'**
  String get start_building_your_inventory_by_adding_your_first_product;

  /// No description provided for @inStock.
  ///
  /// In en, this message translates to:
  /// **'In Stock'**
  String get inStock;

  /// No description provided for @buyerInformation.
  ///
  /// In en, this message translates to:
  /// **'Buyer Information'**
  String get buyerInformation;

  /// No description provided for @buyer.
  ///
  /// In en, this message translates to:
  /// **'Buyer'**
  String get buyer;

  /// No description provided for @buyerName.
  ///
  /// In en, this message translates to:
  /// **'Buyer Name'**
  String get buyerName;

  /// No description provided for @enter_buyer_name.
  ///
  /// In en, this message translates to:
  /// **'Enter buyer name'**
  String get enter_buyer_name;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @enter_buyer_address.
  ///
  /// In en, this message translates to:
  /// **'Enter buyer address'**
  String get enter_buyer_address;

  /// No description provided for @enter_buyer_phone_number.
  ///
  /// In en, this message translates to:
  /// **'Enter buyer phone number'**
  String get enter_buyer_phone_number;

  /// No description provided for @coreIdentity.
  ///
  /// In en, this message translates to:
  /// **'Core Identity'**
  String get coreIdentity;

  /// No description provided for @productNumber.
  ///
  /// In en, this message translates to:
  /// **'Product Number'**
  String get productNumber;

  /// No description provided for @enter_product_number.
  ///
  /// In en, this message translates to:
  /// **'Enter product number'**
  String get enter_product_number;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @enter_category.
  ///
  /// In en, this message translates to:
  /// **'Enter category'**
  String get enter_category;

  /// No description provided for @productName.
  ///
  /// In en, this message translates to:
  /// **'Product Name'**
  String get productName;

  /// No description provided for @enter_product_name.
  ///
  /// In en, this message translates to:
  /// **'Enter product name'**
  String get enter_product_name;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @enter_description.
  ///
  /// In en, this message translates to:
  /// **'Enter description'**
  String get enter_description;

  /// No description provided for @physicalAttributes.
  ///
  /// In en, this message translates to:
  /// **'Physical Attributes'**
  String get physicalAttributes;

  /// No description provided for @material.
  ///
  /// In en, this message translates to:
  /// **'Material'**
  String get material;

  /// No description provided for @enter_material.
  ///
  /// In en, this message translates to:
  /// **'Enter material'**
  String get enter_material;

  /// No description provided for @primaryColor.
  ///
  /// In en, this message translates to:
  /// **'Primary Color'**
  String get primaryColor;

  /// No description provided for @enter_color.
  ///
  /// In en, this message translates to:
  /// **'Enter color'**
  String get enter_color;

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get size;

  /// No description provided for @dimensions.
  ///
  /// In en, this message translates to:
  /// **'Dimensions'**
  String get dimensions;

  /// No description provided for @enter_size.
  ///
  /// In en, this message translates to:
  /// **'Enter size'**
  String get enter_size;

  /// No description provided for @initialQuantity.
  ///
  /// In en, this message translates to:
  /// **'Initial Quantity'**
  String get initialQuantity;

  /// No description provided for @enter_quantity.
  ///
  /// In en, this message translates to:
  /// **'Enter quantity'**
  String get enter_quantity;

  /// No description provided for @purchasePrice.
  ///
  /// In en, this message translates to:
  /// **'Purchase Price'**
  String get purchasePrice;

  /// No description provided for @sellingPrice.
  ///
  /// In en, this message translates to:
  /// **'Selling Price'**
  String get sellingPrice;

  /// No description provided for @productImagery.
  ///
  /// In en, this message translates to:
  /// **'Product Imagery'**
  String get productImagery;

  /// No description provided for @upload_Main_Image.
  ///
  /// In en, this message translates to:
  /// **'Upload Main Image'**
  String get upload_Main_Image;

  /// No description provided for @pricing.
  ///
  /// In en, this message translates to:
  /// **'pricing'**
  String get pricing;

  /// No description provided for @addProduct.
  ///
  /// In en, this message translates to:
  /// **'Add Product'**
  String get addProduct;

  /// No description provided for @search_by_ID_Name_or_Category.
  ///
  /// In en, this message translates to:
  /// **'Search by ID, Name, or Category'**
  String get search_by_ID_Name_or_Category;

  /// No description provided for @iD.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get iD;

  /// No description provided for @enter_valid_number.
  ///
  /// In en, this message translates to:
  /// **'Enter valid number'**
  String get enter_valid_number;

  /// No description provided for @productDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Product Deleted Successfully'**
  String get productDeletedSuccessfully;

  /// No description provided for @productDetails.
  ///
  /// In en, this message translates to:
  /// **'Product Details'**
  String get productDetails;

  /// No description provided for @quantity_is_greater_than_available_quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity is greater than available quantity'**
  String get quantity_is_greater_than_available_quantity;

  /// No description provided for @deleteProduct.
  ///
  /// In en, this message translates to:
  /// **'Delete Product'**
  String get deleteProduct;

  /// No description provided for @are_you_sure_you_want_to_delete_this_product_.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this product?'**
  String get are_you_sure_you_want_to_delete_this_product_;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @sellProduct.
  ///
  /// In en, this message translates to:
  /// **'Sell Product'**
  String get sellProduct;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @retailPrice.
  ///
  /// In en, this message translates to:
  /// **'Retail Price'**
  String get retailPrice;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @units.
  ///
  /// In en, this message translates to:
  /// **'Units'**
  String get units;

  /// No description provided for @modified.
  ///
  /// In en, this message translates to:
  /// **'Modified'**
  String get modified;

  /// No description provided for @availableQuantity.
  ///
  /// In en, this message translates to:
  /// **'Available Quantity'**
  String get availableQuantity;

  /// No description provided for @please_select_a_main_image.
  ///
  /// In en, this message translates to:
  /// **'Please select a main image'**
  String get please_select_a_main_image;

  /// No description provided for @main_image_is_missing_from_cache_please_re_pick_it.
  ///
  /// In en, this message translates to:
  /// **'Main image is missing from cache, please re-pick it'**
  String get main_image_is_missing_from_cache_please_re_pick_it;

  /// No description provided for @added.
  ///
  /// In en, this message translates to:
  /// **'Added'**
  String get added;

  /// No description provided for @product_added_successfully.
  ///
  /// In en, this message translates to:
  /// **'Product added successfully'**
  String get product_added_successfully;

  /// No description provided for @editProduct.
  ///
  /// In en, this message translates to:
  /// **'Edit Product'**
  String get editProduct;

  /// No description provided for @updateProduct.
  ///
  /// In en, this message translates to:
  /// **'Update Product'**
  String get updateProduct;

  /// No description provided for @selectPrimaryColor.
  ///
  /// In en, this message translates to:
  /// **'Select Primary Color'**
  String get selectPrimaryColor;

  /// No description provided for @qTY.
  ///
  /// In en, this message translates to:
  /// **'QTY'**
  String get qTY;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
