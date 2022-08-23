import 'package:flutter/services.dart';

class MyFormatter extends TextInputFormatter {
  final String sample;
  final String sparator;

  MyFormatter({
    required this.sample,
    required this.sparator
  });
  // final sampleNumber = '0000 0000 0000 0000';

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > oldValue.text.length) {
      // If newly entered text length exceeds sample number's length
      // then return the old value.
      if (newValue.text.length > sample.length) {
        return oldValue;
      }

      // Check if the recently entered character is a digit or not.
      // final lastEnteredLetter =
      //     newValue.text.substring(newValue.text.length - 1);
      // if (!RegExp(r'[0-9]').hasMatch(lastEnteredLetter)) {
      //   return oldValue;
      // }

      // If the index of the last entered character in the `newValue`
      // is n, and in the n-th index of the sampleNumber there is a
      // separator, then modify the text.
      if (newValue.text.isNotEmpty && sample[newValue.text.length - 1] == sparator) {
        return TextEditingValue(
          text:
              '${oldValue.text}$sparator${newValue.text.substring(newValue.text.length - 1)}',
          selection:
              TextSelection.collapsed(offset: newValue.selection.end + 1),
        );
      }
    }
    return newValue;
  }
}

// ***** USAGE *****

// TextField(
//   keyboardType: TextInputType.number,
//   inputFormatters: [
//     CardNumberFormatter(),
//   ],
// ),