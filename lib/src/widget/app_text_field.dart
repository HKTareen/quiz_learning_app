import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    this.borderColor,
    super.key,
    this.hint,
    this.onTap,
    this.label,
    this.value,
    this.obscure = false,
    this.suffix,
    this.onSaved,
    this.onChanged,
    this.readonly = false,
    this.validator,
    this.keyboardType,
    this.floatLabel = false,
    this.textEditingController,
    this.isBold = false,
    this.maxLines = 1,
    this.textInputAction = TextInputAction.next,
    this.fillColor,
    this.style,
    this.bottomPadding,
    this.focusedBorderColor,
    this.prefix,
    this.hintStyle,
    this.hintColor,
    this.showBorder = true,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 13,
      horizontal: 14,
    ),
    this.borderRadius,
    this.focusNode,
    this.inputFormatters,
    this.cursorColor,
    this.autoFillHints,
    this.magnifierConfiguration = TextMagnifierConfiguration.disabled,
  });

  final Color? cursorColor;
  final FocusNode? focusNode;
  final EdgeInsets contentPadding;
  final bool? isBold;
  final double? bottomPadding;
  final TextStyle? style;
  final bool? obscure;
  final String? hint;
  final String? label;
  final String? value;
  final bool readonly;
  final Widget? suffix;
  final bool? floatLabel;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final FormFieldSetter<String>? onSaved;
  final FormFieldSetter<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextEditingController? textEditingController;
  final int? maxLines;
  final Color? fillColor;
  final TextInputAction? textInputAction;
  final Color? focusedBorderColor;
  final Widget? prefix;
  final TextStyle? hintStyle;
  final Color? hintColor;
  final bool showBorder;
  final double? borderRadius;
  final Color? borderColor;
  final List<TextInputFormatter>? inputFormatters;
  final List<String>? autoFillHints;
  final TextMagnifierConfiguration magnifierConfiguration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding ?? 12),
      child: TextFormField(
        magnifierConfiguration: magnifierConfiguration,
        autofillHints: autoFillHints,
        onTap: onTap,
        onSaved: onSaved,
        focusNode: focusNode,
        onChanged: onChanged,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        initialValue: value,
        maxLines: maxLines,
        readOnly: readonly,
        //minLines: minLines,
        validator: validator,
        obscureText: obscure ?? false,
        controller: textEditingController,
        scrollPadding: const EdgeInsets.all(100),
        cursorColor: cursorColor ?? Colors.black,
        style: style,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          contentPadding: contentPadding,
          prefixIcon: prefix,
          suffixIcon: suffix,
          labelText: label,
          hintText: hint ?? '',
          hintStyle:
              hintStyle ??
              TextStyle(fontWeight: FontWeight.w500, color: hintColor),
          labelStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black.withValues(alpha: .5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: showBorder
                  ? borderColor ?? Colors.black
                  : Colors.transparent,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
          errorStyle: const TextStyle(color: Colors.black),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: showBorder
                  ? borderColor ?? Colors.black
                  : Colors.transparent,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: showBorder
                  ? focusedBorderColor == null
                        ? Colors.black
                        : focusedBorderColor!
                  : Colors.transparent,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
          filled: true,
          fillColor: fillColor ?? Colors.white,
        ),
      ),
    );
  }
}

class AppPasswordField extends StatefulWidget {
  const AppPasswordField({
    super.key,
    this.icon,
    this.label,
    this.validator,
    this.hint,
    this.context,
    this.iconBool,
    this.textEditingController,
    this.padding,
    this.textInputAction,
    this.magnifierConfiguration = TextMagnifierConfiguration.disabled,
    this.readonly = false,
  });

  final IconData? icon;
  final String? hint;
  final bool? iconBool;
  final String? label;
  final BuildContext? context;
  final FormFieldValidator<String>? validator;
  final TextEditingController? textEditingController;
  final EdgeInsetsGeometry? padding;
  final TextInputAction? textInputAction;
  final TextMagnifierConfiguration magnifierConfiguration;
  final bool readonly;

  @override
  State createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _show = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        magnifierConfiguration: widget.magnifierConfiguration,
        validator: widget.validator,
        obscureText: _show,
        readOnly: widget.readonly,
        controller: widget.textEditingController,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        onFieldSubmitted: (v) {
          FocusScope.of(context).nextFocus();
        },
        scrollPadding: const EdgeInsets.all(100),
        cursorColor: Colors.black,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 13,
            horizontal: 14,
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          errorStyle: const TextStyle(color: Colors.black),
          labelText: widget.label,
          labelStyle: const TextStyle(
            color: Color(0xFF95A1AC),
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          hintText: widget.hint,
          hintStyle: const TextStyle(fontWeight: FontWeight.w500),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: InkWell(
            onTap: () => setState(() => _show = !_show),
            child: Icon(
              _show ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              color: const Color(0xFF95A1AC),
              size: 22,
            ),
          ),
        ),
      ),
    );
  }
}
