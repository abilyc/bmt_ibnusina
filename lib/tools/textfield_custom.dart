import 'package:flutter/material.dart';

class TextFieldCust extends StatelessWidget {
  final String? label;
  final double? width;
  final double? height;
  final IconData? icon;
  final bool enabled;
  final TextEditingController? controller;
  final Function? onPressed;
  const TextFieldCust(
      {Key? key,
      this.label,
      this.icon,
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
          controller: controller,
          style: TextStyle(color: Theme.of(context).primaryColorDark),
          decoration: InputDecoration(
            isDense: true,
            isCollapsed: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            label: (label != null) ? Text(label!) : null,
            fillColor: enabled ? Theme.of(context).primaryColorLight : Theme.of(context).disabledColor,
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
            // suffixIcon: IconButton(
            //     onPressed: () {
            //       print('seacrh');
            //     },
            //     icon: const Icon(icon)
            // ),
          )),
    );
  }
}
