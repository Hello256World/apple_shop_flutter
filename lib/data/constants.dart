import 'dart:ui';

class CustomColor {
  static const Color blueColor = Color(0xff3B5EDF);
  static const Color whiteColor = Color(0xffEEEEEE);
  static const Color greenColor = Color(0xff1DB68B);
  static const Color redColor = Color(0xffD02026);
  static const Color greyColor = Color(0xff858585);
}

extension StringExtension on String {
  Color toHexColor() {
    var hexColor = int.parse('ff$this', radix: 16);
    return Color(hexColor);
  }
}
