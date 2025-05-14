import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/core/constants/app_colors.dart';
import 'package:flutter_base/theme/app_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;

  final String? label;

  final dynamic prefixIcon;
  final String? suffixIcon;
  final Color? suffixIconColor;
  final Color? borderColor;
  final Color? fillColor;
  final void Function()? onSuffixIconTap;

  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;

  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;

  final String? Function(String?)? validator;

  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool obscureText;
  final double? borderRadius;

  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(String)? onSubmitted;

  final bool? enabled;
  final bool readOnly;

  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.borderRadius,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.onSuffixIconTap,
    this.validator,
    this.hintText,
    this.hintStyle,
    this.borderColor,
    this.textStyle,
    this.textCapitalization = TextCapitalization.none,
    this.textInputAction = TextInputAction.next,
    this.inputFormatters,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength,
    this.obscureText = false,
    this.onChanged,
    this.onTap,
    this.onSubmitted,
    this.enabled,
    this.fillColor,
    this.readOnly = false,
    this.suffixIconColor,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle? hintStyle = this.hintStyle ??
        Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 14.sp,
              color: AppColors.lightFontColor,
              fontWeight: FontWeight.w400,
            );

    TextStyle? textStyle = this.textStyle ??
        Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 14.sp,
              color: AppColors.darkFontColor,
              fontWeight: FontWeight.w400,
            );

    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      style: textStyle,

      /// Text Field Box
      enabled: enabled,
      readOnly: readOnly,

      /// Cursor
      cursorColor: AppColors.primaryColor,
      cursorRadius: const Radius.circular(6),

      validator: validator,

      autocorrect: true,
      enableSuggestions: true,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      textAlignVertical: TextAlignVertical.center,
      onFieldSubmitted: onSubmitted,

      /// Decoration
      decoration: InputDecoration(
        /// Hint text
        hintText: hintText,
        hintStyle: hintStyle,
        filled: true,
        fillColor: fillColor ?? AppColors.backgroundColor,

        /// Set borderRadius to 15 and make borders transparent
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? defaultRadius),
          borderSide: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: 1), // Transparent border
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? defaultRadius),
          borderSide: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: 1), // Transparent border
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? defaultRadius),
          borderSide: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: 1), // Transparent border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? defaultRadius),
          borderSide: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: 1), // Transparent border
        ),

        /// Error Border
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? defaultRadius),
          borderSide: BorderSide(
              color: AppColors.red, width: .8), // Error border visible
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? defaultRadius),
          borderSide: BorderSide(
              color: AppColors.red, width: .8), // Error border visible
        ),

        errorMaxLines: 2,
        errorStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 10.sp,
              color: AppColors.red,
              height: 0,
            ),

        contentPadding: EdgeInsets.all(12).r,

        /// Remove the label
        label: null,
        floatingLabelStyle: null,

        /// Remove Extra Size from text field
        isCollapsed: true,
        isDense: true,

        /// Counter widget
        counter: const SizedBox.shrink(),

        /// Icons Start & End
        prefixIcon: prefixIcon is String
            ? buildIcon(icon: prefixIcon, color: AppColors.darkFontColor)
            : prefixIcon,
        suffixIcon: suffixIcon?.isNotEmpty ?? false
            ? buildIcon(
                icon: suffixIcon ?? "",
                color: suffixIconColor ?? AppColors.darkFontColor,
                onTap: onSuffixIconTap,
              )
            : null,

        prefixIconConstraints:
            prefixIconConstraints ?? BoxConstraints.tight(const Size(44, 46)),
        suffixIconConstraints:
            suffixIconConstraints ?? BoxConstraints.tight(const Size(44, 46)),
      ),

      /// Text Input Handle
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength != 0 ? maxLength : null,

      /// Activity
      onTap: onTap,
      obscureText: obscureText,
    );
  }

  Widget buildIcon({
    required String icon,
    required Color color,
    void Function()? onTap,
  }) {
    Widget child = Padding(
      padding: onTap != null
          ? EdgeInsets.only(right: 4.w, left: 4.w)
          : EdgeInsets.only(right: 10.w, left: 12.w),
      child: GetUtils.isVector(icon)
          ? SvgPicture.asset(icon,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn))
          : Image.asset(icon),
    );

    return onTap != null ? IconButton(onPressed: onTap, icon: child) : child;
  }
}

/*

 return FormField<String>(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      initialValue: widget.controller?.text.isEmpty ?? true ? "" : widget.controller?.text,

      /// Validation
      validator: widget.validator,

      builder: (FormFieldState<String> field) {
        void onChangedHandler(String value) {
          field.didChange(value);
          widget.onChanged?.call(value);
        }

        Color color;

        if (field.hasError || widget.errorText != null) {
          color = AppColors.red;
        } else if (isSelected) {
          color = AppColors.primaryColor;
        } else {
          color = AppColors.borderColor;
        }

        if (widget.prefixIcon is String) {
          prefixIcon = buildIcon(icon: widget.prefixIcon!, color: color);
        } else if (widget.prefixIcon is Widget) {
          prefixIcon = widget.prefixIcon;
        }

        if (widget.suffixIcon != null) {
          suffixIcon = buildIcon(
            icon: widget.suffixIcon!,
            onTap: widget.onSuffixIconTap,
            color: widget.suffixIconColor ?? color,
          );
        }

        return UnmanagedRestorationScope(
          bucket: field.bucket,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [

              TextFormField(
                focusNode: _focusNode,
                controller: widget.controller,
                style: textStyle,
                onChanged: onChangedHandler,
                onEditingComplete: widget.onSubmitted,

                /// Text Filed Box
                enabled: widget.enabled,
                readOnly: widget.readOnly,

                /// Cursor
                cursorColor: AppColors.primaryColor,
                cursorRadius: const Radius.circular(6),

                validator: widget.validator,

                ///decoration
                decoration: InputDecoration(
                  ///  Hint text
                  hintText: widget.hintText,
                  hintStyle: hintStyle,

                  fillColor: Colors.white,

                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(defaultRadius), borderSide: BorderSide(width: .8)),
                  enabledBorder: ,
                  disabledBorder: ,
                  focusedBorder: ,
                  errorBorder: ,
                  focusedErrorBorder: ,


                  contentPadding: const EdgeInsets.all(14),

                  /// Remove Extra Size from text filed
                  isCollapsed: true,
                  isDense: true,

                  /// Counter widget
                  counter: const SizedBox.shrink(),

                  ///Icons Start & End
                  prefixIcon: prefixIcon,
                  suffixIcon: suffixIcon,

                  // BoxConstraints.tight(const Size(48, 48))
                  prefixIconConstraints: widget.prefixIconConstraints,
                  suffixIconConstraints: widget.suffixIconConstraints,
                ),

                /// Text Input Handel
                textInputAction: widget.textInputAction,
                inputFormatters: widget.inputFormatters,
                keyboardType: widget.keyboardType,
                maxLines: widget.maxLines,
                minLines: widget.minLines,
                // maxLength: widget.maxLength,
                maxLength: widget.maxLength != 0 ? widget.maxLength : null,

                /// Activity
                onTap: widget.onTap,
                obscureText: widget.obscureText,
              ),
              if (field.hasError || widget.errorText != null) ...[buildError(field.errorText)]
            ],
          ),
        );
      },
    );

 */
