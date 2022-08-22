import 'package:flutter/material.dart';

class TextFieldCust extends StatelessWidget {
  final String? label;
  final double? width;
  final double? height;
  final IconData? icon;
  final bool enabled;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final Function? onPressed;
  final FocusNode? focusNode;
  const TextFieldCust(
      {Key? key,
      this.focusNode,
      this.label,
      this.icon,
      this.keyboardType,
      this.height = 30,
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
          enabled: enabled,
          keyboardType: keyboardType ?? TextInputType.text,
          controller: controller,
          style: TextStyle(color: Theme.of(context).primaryColorDark),
          decoration: InputDecoration(
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
