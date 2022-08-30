import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldCust extends StatelessWidget {
  final String? label;
  final TextAlign align;
  final bool readOnly;
  final Function(String)? onChanged;
  final String? hint;
  final bool obscure;
  final double? width;
  final double? height;
  final List<TextInputFormatter>? inputFormatter;
  final IconData? icon;
  final bool enabled;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Function? onPressed;
  final FocusNode? focusNode;
  const TextFieldCust(
      {Key? key,
      this.readOnly = false,
      this.inputFormatter,
      this.onChanged,
      this.hint,
      this.obscure = false,
      this.focusNode,
      this.label,
      this.align = TextAlign.left,
      this.icon,
      this.keyboardType,
      this.height = 34,
      this.width,
      this.controller,
      this.enabled = true,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (width != null) ? width : double.infinity,
      height: height,
      child: TextField(
          readOnly: readOnly,
          onChanged: onChanged,
          obscureText: obscure,
          textAlign: align,
          enabled: enabled,
          inputFormatters: inputFormatter,
          keyboardType: keyboardType ?? TextInputType.text,
          controller: controller,
          decoration: InputDecoration(
            hintStyle: const TextStyle(fontSize: 13, color: Colors.deepOrange),
            hintText: hint ?? '',
            isDense: true,
            isCollapsed: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            label: (label != null) ? Text(label!) : null,
            fillColor: enabled
                ? Theme.of(context).primaryColorLight
                : Theme.of(context).disabledColor,
            filled: true,
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
              color: Colors.transparent,
            )),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            suffixIcon: (icon != null)
                ? IconButton(
                    onPressed: onPressed != null ? () => onPressed!() : null,
                    icon: Icon(
                      icon!,
                      size: 16,
                    ))
                : null,
          )),
    );
  }
}
