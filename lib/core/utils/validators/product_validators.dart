import 'package:flutter/material.dart';
import 'package:m_store_1/l10n/app_localizations.dart';

class ProductValidators {
  static String? validateProductNumber(
      String? value,
      BuildContext context,
      ) {
    final appLocalizations = AppLocalizations.of(context)!;

    if (value == null || value.trim().isEmpty) {
      return appLocalizations.this_field_is_required;
    }

    return null;
  }

  static String? validateProductName(
      String? value,
      BuildContext context,
      ) {
    final appLocalizations = AppLocalizations.of(context)!;

    if (value == null || value.trim().isEmpty) {
      return appLocalizations.this_field_is_required;
    }

    if (value.trim().length < 3) {
      return appLocalizations.name_must_be_at_least_characters;
    }

    return null;
  }

  static String? validateCategory(
      String? value,
      BuildContext context,
      ) {
    final appLocalizations = AppLocalizations.of(context)!;

    if (value == null || value.trim().isEmpty) {
      return appLocalizations.this_field_is_required;
    }

    return null;
  }

  static String? validateDescription(
      String? value,
      BuildContext context,
      ) {
    final appLocalizations = AppLocalizations.of(context)!;

    if (value == null || value.trim().isEmpty) {
      return appLocalizations.this_field_is_required;
    }

    return null;
  }

  static String? validateMaterial(
      String? value,
      BuildContext context,
      ) {
    final appLocalizations = AppLocalizations.of(context)!;

    if (value == null || value.trim().isEmpty) {
      return appLocalizations.this_field_is_required;
    }

    return null;
  }

  static String? validateColor(
      String? value,
      BuildContext context,
      ) {
    final appLocalizations = AppLocalizations.of(context)!;

    if (value == null || value.trim().isEmpty) {
      return appLocalizations.this_field_is_required;
    }

    return null;
  }

  static String? validateSize(
      String? value,
      BuildContext context,
      ) {
    final appLocalizations = AppLocalizations.of(context)!;

    if (value == null || value.trim().isEmpty) {
      return appLocalizations.this_field_is_required;
    }

    return null;
  }

  static String? validateQuantity(
      String? value,
      BuildContext context,
      ) {
    final appLocalizations = AppLocalizations.of(context)!;

    if (value == null || value.trim().isEmpty) {
      return appLocalizations.this_field_is_required;
    }

    if (int.tryParse(value) == null) {
      return appLocalizations.enter_valid_number;
    }

    if (int.parse(value) <= 0) {
      return appLocalizations.enter_valid_number;
    }

    return null;
  }

  static String? validatePrice(
      String? value,
      BuildContext context,
      ) {
    final appLocalizations = AppLocalizations.of(context)!;

    if (value == null || value.trim().isEmpty) {
      return appLocalizations.this_field_is_required;
    }

    if (double.tryParse(value) == null) {
      return appLocalizations.enter_valid_number;
    }

    if (double.parse(value) < 0) {
      return appLocalizations.enter_valid_number;
    }

    return null;
  }
}