part of gauges;

/// Represents the theme color for gauge elements
class GaugeTheme {
  /// Creates gauge theme
  GaugeTheme();

  /// Specifies the title color
  Color titleColor;

  /// Specifies the axis label color
  Color axisLabelColor;

  /// Specifies the axis line color
  Color axisLineColor;

  /// Specifies the major tick line color
  Color majorTickColor;

  /// Specifies the minor tick line color
  Color minorTickColor;

  /// Specifies the marker color
  Color markerColor;

  /// Specifies the marker border color
  Color markerBorderColor;

  /// Specifies the needle color
  Color needleColor;

  /// Specifies the knob color
  Color knobColor;

  /// Specifies the knob border color
  Color knobBorderColor;

  /// Specifies the tail color
  Color tailColor;

  /// Specifies the tail border color
  Color tailBorderColor;

  /// Specifies the range pointer color
  Color rangePointerColor;

  /// Specifies the range color
  Color rangeColor;

  /// Specifies the title border color
  Color titleBorderColor;

  /// Specifies the title background color
  Color titleBackgroundColor;

  /// Specifies the theme brightness
  Brightness brightness;

  /// Initializes the gauge theme
  void initializeGaugeTheme(ThemeData theme) {
    switch (theme.brightness) {
      case Brightness.light:
        {
          titleColor = const Color(0xFF333333);
          titleBorderColor = Colors.transparent;
          titleBackgroundColor = Colors.transparent;
          axisLabelColor = const Color(0xFF333333);
          axisLineColor = const Color(0xFFDADADA);
          majorTickColor = const Color(0xFF999999);
          minorTickColor = const Color(0xFFC4C4C4);
          markerColor = const Color(0xFF00A8B5);
          markerBorderColor = Colors.transparent;
          needleColor = const Color(0xFF3A3A3A);
          knobColor = const Color(0xFF3A3A3A);
          knobBorderColor = Colors.transparent;
          tailColor = const Color(0xFF3A3A3A);
          tailBorderColor = Colors.transparent;
          rangePointerColor = const Color(0xFF00A8B5);
          rangeColor = const Color(0xFFF67280);
          brightness = Brightness.light;
          break;
        }
      case Brightness.dark:
        {
          titleBorderColor = Colors.transparent;
          titleBackgroundColor = Colors.transparent;
          titleColor = const Color(0xFFF5F5F5);
          axisLabelColor = const Color(0xFFF5F5F5);
          axisLineColor = const Color(0xFF555555);
          majorTickColor = const Color(0xFF888888);
          minorTickColor = const Color(0xFF666666);
          markerColor = const Color(0xFF00A8B5);
          markerBorderColor = Colors.transparent;
          needleColor = const Color(0xFFEEEEEE);
          knobColor = const Color(0xFFEEEEEE);
          knobBorderColor = Colors.transparent;
          tailColor = const Color(0xFFEEEEEE);
          tailBorderColor = Colors.transparent;
          rangePointerColor = const Color(0xFF00A8B5);
          rangeColor = const Color(0xFFF67280);
          brightness = Brightness.dark;
          break;
        }
      default:
        {
          brightness = Brightness.light;
          break;
        }
    }
  }
}
