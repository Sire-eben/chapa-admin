import "package:chapa_admin/utils/app_themes.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
// import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:intl/intl.dart";
import "package:nb_utils/nb_utils.dart";

class AmountTextField extends StatelessWidget {
  final String? labelText, prefixText;
  final String? initialValue;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? Function(String? input)? validator;
  final Function(String input)? onChanged;
  final Function(String?)? onSaved;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines, maxLength;
  final FocusNode? focusNode;
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final bool enabled;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle, prefixStyle;
  final TextStyle? errorStyle;
  final TextStyle? style;
  final String? suffixText;
  final InputDecoration? decoration;
  final AutovalidateMode? autoValidateMode;
  final TextCapitalization? textCapitalization;
  final bool withBorder, withBottomInset;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor, borderColor;
  final TextAlign textAlign;

  const AmountTextField({
    super.key,
    this.contentPadding,
    this.labelText,
    this.prefixText,
    this.initialValue,
    this.style,
    this.suffixIcon,
    this.keyboardType,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.inputFormatters,
    this.focusNode,
    this.hintText,
    this.errorText,
    this.prefixIcon,
    this.controller,
    this.labelStyle,
    this.hintStyle,
    this.prefixStyle,
    this.errorStyle,
    this.suffixText,
    this.decoration,
    this.autoValidateMode,
    this.maxLines = 1,
    this.maxLength,
    this.enabled = true,
    this.obscureText = false,
    this.textCapitalization,
    this.withBorder = true,
    this.withBottomInset = true,
    this.fillColor,
    this.borderColor,
    this.textAlign = TextAlign.left,
  });

  @override
  Widget build(BuildContext context) {
    final underlinedInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: !withBorder
            ? BorderSide.none
            : BorderSide(
                color: borderColor ?? AppColors.textFieldBorder,
                width: 1.4,
              ));

    final underlinedInputErrorBorder = underlinedInputBorder.copyWith(
      borderSide: underlinedInputBorder.borderSide.copyWith(
        color: AppColors.error,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null) ...[
          Text(
            labelText ?? "Enter Amount",
            style: labelStyle ??
                AppStyles.urbanist14Md
                    .copyWith(color: AppColors.appBlack, fontSize: 13),
          ),
          10.height,
        ],
        TextFormField(
          controller: controller,
          textAlign: textAlign,
          onSaved: (input) => onSaved?.call((input ?? "").trim()),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: obscureText,
          maxLines: maxLines,
          maxLength: maxLength,
          focusNode: focusNode,
          inputFormatters: [AmountFormatter()],
          initialValue: initialValue,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          enabled: enabled,
          onChanged: onChanged,
          validator: validator,
          textAlignVertical: TextAlignVertical.center,
          style: style ??
              AppStyles.urbanist14Md.copyWith(color: AppColors.appBlack),
          cursorColor: AppColors.appBlack,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          decoration: decoration ??
              InputDecoration(
                filled: true,
                fillColor: fillColor,
                suffixText: suffixText,
                prefixText: prefixText,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                suffixIconColor: AppColors.primary,
                hintText: hintText,
                errorText: errorText,
                errorStyle: errorStyle ??
                    AppStyles.urbanist12Rg.copyWith(color: AppColors.error),
                prefixStyle:
                    prefixStyle ?? AppStyles.interGeneral(14, FontWeight.w600),
                labelStyle: labelStyle ??
                    AppStyles.urbanist14Md
                        .copyWith(color: AppColors.secondaryIconColor),
                // labelText: labelText,
                hintStyle: hintStyle ??
                    AppStyles.urbanist12Rg.copyWith(color: AppColors.appBlack),
                contentPadding: contentPadding ??
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 28),
                enabledBorder: withBorder
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            width: 1.2,
                            color: borderColor ?? AppColors.textFieldBorder),
                      )
                    : underlinedInputBorder,
                focusedBorder: withBorder
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            width: 1.2,
                            color: borderColor ?? AppColors.textFieldBorder),
                      )
                    : underlinedInputBorder,
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: AppColors.error,
                      width: 1,
                    )),
                focusedErrorBorder: underlinedInputErrorBorder,
                disabledBorder: withBorder
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            width: 1.2,
                            color: borderColor ?? AppColors.textFieldBorder),
                      )
                    : underlinedInputBorder,
              ),
        ),
        if (withBottomInset) 20.height,
      ],
    );
  }
}

class AmountFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final double value =
        double.tryParse(newValue.text.replaceAll(',', '')) ?? 0.0;
    final String formattedText = NumberFormat('#,###.##').format(value);

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(
        offset: formattedText.length,
      ),
    );
  }
}
