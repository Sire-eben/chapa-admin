import "package:chapa_admin/utils/__utils.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
// import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:gap/gap.dart";

class CustomTextField extends StatelessWidget {
  final String? labelText, prefixText;
  final String? initialValue;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final FormFieldSetter<String>? onChanged;
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
  final bool showCounter;
  final bool filled;

  const CustomTextField({
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
    this.showCounter = false,
    this.filled = false,
    this.fillColor,
    this.borderColor,
    this.textAlign = TextAlign.left,
    this.textInputAction = TextInputAction.done,
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
            labelText!,
            style: labelStyle ??
                AppStyles.urbanist14Md
                    .copyWith(color: AppColors.appBlack, fontSize: 13),
          ),
          const Gap(10),
        ],
        TextFormField(
          controller: controller,
          textAlign: textAlign,
          onSaved: (input) => onSaved?.call((input ?? "").trim()),
          autovalidateMode: autoValidateMode,
          obscureText: obscureText,
          maxLines: maxLines,
          maxLength: maxLength,
          focusNode: focusNode,
          inputFormatters: inputFormatters,
          initialValue: initialValue,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          enabled: enabled,
          onChanged: onChanged,
          validator: validator,
          textAlignVertical: TextAlignVertical.center,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          style: style ??
              AppStyles.urbanist14Md.copyWith(color: AppColors.appBlack),
          cursorColor: AppColors.appBlack,
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          decoration: decoration ??
              InputDecoration(
                counterText: showCounter ? null : "",
                filled: filled,
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
                            width: 1.4,
                            color: borderColor ?? AppColors.textFieldBorder),
                      )
                    : underlinedInputBorder,
                focusedBorder: withBorder
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            width: 1.4,
                            color: borderColor ?? AppColors.textFieldBorder),
                      )
                    : underlinedInputBorder,
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.error,
                      width: 1,
                    )),
                focusedErrorBorder: underlinedInputErrorBorder,
                disabledBorder: withBorder
                    ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            width: 1.4,
                            color: borderColor ?? AppColors.textFieldBorder),
                      )
                    : underlinedInputBorder,
              ),
        ),
        if (withBottomInset) const Gap(Insets.l),
      ],
    );
  }
}

// class MapTextField extends StatefulWidget {
//   final String? labelText, prefixText;
//   final String? initialValue;
//   final Widget? suffixIcon;
//   final TextInputType? keyboardType;
//   final FormFieldValidator<String>? validator;
//   final FormFieldSetter<String>? onSaved;
//   final FormFieldSetter<String>? onChanged;
//   final Function(dynamic) onSuggestionSelected;
//   final TextEditingController controller;
//   final AutovalidateMode? autoValidateMode;
//   final String? hintText;
//   final bool withBorder, withBottomInset;
//   final Color? fillColor, borderColor;

//   const MapTextField({
//     super.key,
//     this.labelText,
//     this.prefixText,
//     this.initialValue,
//     this.suffixIcon,
//     this.keyboardType,
//     this.onChanged,
//     required this.onSuggestionSelected,
//     this.onSaved,
//     this.validator,
//     this.hintText,
//     required this.controller,
//     this.autoValidateMode,
//     this.withBorder = true,
//     this.withBottomInset = true,
//     this.fillColor,
//     this.borderColor,
//   });

//   @override
//   State<MapTextField> createState() => _MapTextFieldState();
// }

// class _MapTextFieldState extends State<MapTextField> {
//   final kGoogleApiKey = 'AIzaSyCkZ3tJPAMR5wcFMp7CzpuL28s8G4ZKB2Q';

//   @override
//   Widget build(BuildContext context) {
//     final underlinedInputBorder = OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: BorderSide(
//           color: AppColors.textFieldBorder,
//           width: 1,
//         ));

//     final underlinedInputErrorBorder = underlinedInputBorder.copyWith(
//       borderSide: underlinedInputBorder.borderSide.copyWith(
//         color: AppColors.error,
//       ),
//     );

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (widget.labelText != null) ...[
//           Text(
//             widget.labelText!,
//             style: AppStyles.urbanist14Md
//                 .copyWith(color: AppColors.appBlack, fontSize: 13.sp),
//           ),
//           const Gap(10),
//         ],
//         MapAutoCompleteField(
//           googleMapApiKey: kGoogleApiKey,
//           controller: widget.controller,
//           validator: widget.validator,
//           itemBuilder: (BuildContext context, suggestion) {
//             return Row(
//               children: [
//                 const Gap(12),
//                 Container(
//                   constraints: BoxConstraints(maxWidth: context.getWidth(.8)),
//                   padding: const EdgeInsets.symmetric(
//                       vertical: Insets.md, horizontal: Insets.l),
//                   child: ClipRRect(
//                     child: Text(
//                       suggestion.description,
//                       style: AppStyles.urbanist14Md,
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//           onSuggestionSelected: widget.onSuggestionSelected,
//           inputDecoration: InputDecoration(
//             filled: true,
//             fillColor: widget.fillColor ?? AppColors.fillColor,
//             // suffixText: "Change",
//             hintText: widget.hintText ?? "Enter location",
//             prefixText: widget.prefixText,
//             suffixIcon: widget.suffixIcon,
//             suffixIconColor: AppColors.primary,
//             errorStyle: AppStyles.urbanist12Rg,
//             prefixStyle: AppStyles.urbanist12Rg,
//             hintStyle:
//                 AppStyles.urbanist12Rg.copyWith(color: AppColors.appBlack),
//             contentPadding:
//                 const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//             border: widget.withBorder
//                 ? OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide(
//                         width: 1.2,
//                         color: widget.borderColor ?? AppColors.textFieldBorder),
//                   )
//                 : underlinedInputBorder,
//             enabledBorder: widget.withBorder
//                 ? OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide(
//                         width: 1.2,
//                         color: widget.borderColor ?? AppColors.textFieldBorder),
//                   )
//                 : underlinedInputBorder,
//             focusedBorder: widget.withBorder
//                 ? OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide(
//                         width: 1.2,
//                         color: widget.borderColor ?? AppColors.textFieldBorder),
//                   )
//                 : underlinedInputBorder,
//             errorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: const BorderSide(
//                   color: AppColors.error,
//                   width: 1,
//                 )),
//             focusedErrorBorder: underlinedInputErrorBorder,
//             disabledBorder: widget.withBorder
//                 ? OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide(
//                         width: 1.2,
//                         color: widget.borderColor ?? AppColors.textFieldBorder),
//                   )
//                 : underlinedInputBorder,
//           ),
//         ),
//         if (widget.withBottomInset) const Gap(Insets.l),
//       ],
//     );
//   }
// }
