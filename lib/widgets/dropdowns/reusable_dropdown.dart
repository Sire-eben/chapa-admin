import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../utils/__utils.dart';

class ReusableDropdownFormField<T> extends StatelessWidget {
  final FormFieldValidator<T>? validator;
  final String? hint, disabledHint, labelText;
  final InputDecoration? decoration;
  final T? value;
  final List<DropdownMenuItem<T>>? items;
  final ValueChanged<T?>? onChanged;
  final bool isCompulsory, withBottomInset;
  final bool withBorder, enabled;
  final Widget? prefixIcon;
  final EdgeInsets? contentPadding;
  final TextStyle? hintStyle;
  final Widget? icon;

  const ReusableDropdownFormField({
    super.key,
    this.validator,
    this.hint,
    this.disabledHint,
    this.decoration,
    this.value,
    this.items,
    this.onChanged,
    this.labelText,
    this.isCompulsory = false,
    this.withBorder = false,
    this.enabled = true,
    this.withBottomInset = true,
    this.prefixIcon,
    this.contentPadding,
    this.hintStyle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final underlinedInputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: AppColors.idleState,
          width: 1,
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
            labelText!,
            style: AppStyles.urbanist12Md.copyWith(color: AppColors.appBlack),
          ),
          10.height,
        ],
        DropdownButtonFormField<T>(
          validator: validator,
          hint: Text(
            hint ?? 'Select item',
            style: hintStyle ??
                AppStyles.urbanist12Md.copyWith(color: AppColors.appBlack),
          ),
          disabledHint: Text(
            disabledHint ?? 'Select item',
            style: hintStyle ??
                AppStyles.urbanist12Md.copyWith(color: AppColors.appBlack),
          ),
          dropdownColor: AppColors.white,
          elevation: 25,
          icon: icon ?? Icon(Icons.arrow_drop_down),
          iconEnabledColor: Colors.black,
          iconDisabledColor: Colors.grey,
          style: AppStyles.urbanist12Md,
          decoration: decoration ??
              InputDecoration(
                  prefixIcon: prefixIcon,
                  enabled: enabled,
                  filled: true,
                  fillColor: AppColors.fillColor,
                  hintStyle: hintStyle ??
                      AppStyles.urbanist12Md.copyWith(
                          color: enabled
                              ? AppColors.textFieldBorder
                              : AppColors.black,
                          fontSize: enabled ? 12 : 14),
                  contentPadding: contentPadding ??
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                  enabledBorder: withBorder
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              width: 1.2, color: AppColors.textFieldBorder),
                        )
                      : underlinedInputBorder,
                  focusedBorder: withBorder
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                              width: 1.2, color: AppColors.textFieldBorder),
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
                              width: 1.2, color: AppColors.textFieldBorder),
                        )
                      : underlinedInputBorder),
          value: value,
          items: items,
          onChanged: onChanged,
        ),
        if (withBottomInset) 20.height,
      ],
    );
  }
}
