import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:m_store_1/core/costants/color_manager.dart';

class CustomAuthTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final IconData? suffixIcon;

  const CustomAuthTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.suffixIcon,
  });

  @override
  State<CustomAuthTextFormField> createState() =>
      _CustomAuthTextFormFieldState();
}

class _CustomAuthTextFormFieldState
    extends State<CustomAuthTextFormField> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText.toUpperCase(),
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
            color: const Color(0xff5A5A5A),
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: widget.controller,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          obscureText: widget.isPassword ? obscure : false,
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 13.sp,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.r),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.r),
              borderSide: BorderSide(
                color: const Color(0xffD4AF37),
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.r),
              borderSide: const BorderSide(
                color: Colors.red,
              ),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18.r),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
            suffixIcon: Padding(
              padding: EdgeInsets.only(right: 14.w),
              child: widget.isPassword
                  ? IconButton(
                onPressed: () {
                  setState(() {
                    obscure = !obscure;
                  });
                },
                icon: Icon(
                  obscure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.grey.shade500,
                ),
              )
                  : Icon(
                widget.suffixIcon,
                color: Colors.grey.shade500,
              ),
            ),

            suffixIconConstraints: BoxConstraints(
              minHeight: 24.h,
              minWidth: 50.w,
            ),
          ),
        ),
      ],
    );
  }
}