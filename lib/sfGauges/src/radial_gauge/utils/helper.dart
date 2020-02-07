part of gauges;

/// Converts degree to radian
double _degreeToRadian(double degree) {
  return degree * (math.pi / 180);
}

/// Converts radian to degree
double _radianToDegree(double _radian) {
  return 180 / math.pi * _radian;
}

/// To get the degree from the point
Offset _degreeToPoint(double degree, double radius, Offset center) {
  degree = _degreeToRadian(degree);
  return Offset(center.dx + math.cos(degree) * radius,
      center.dy + math.sin(degree) * radius);
}

/// Methods to get the saturation color
Color _getSaturationColor(Color color) {
  Color saturationColor;
  final num contrast =
      ((color.red * 299 + color.green * 587 + color.blue * 114) / 1000).round();
  saturationColor =
      contrast >= 128 ? const Color(0xFF333333) : const Color(0xFFF5F5F5);
  return saturationColor;
}

/// Method to check whether the value ranges between
/// the minimum and maximum value
double _minMax(double value, double min, double max) {
  return value > max ? max : (value < min ? min : value);
}

// Measure the text and return the text size
Size _measureText(String textValue, GaugeTextStyle textStyle, [int angle]) {
  Size size;
  final TextPainter textPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
    text: TextSpan(
        text: textValue,
        style: TextStyle(
            color: textStyle.color,
            fontSize: textStyle.fontSize,
            fontFamily: textStyle.fontFamily,
            fontStyle: textStyle.fontStyle,
            fontWeight: textStyle.fontWeight)),
  );
  textPainter.layout();
  size = Size(textPainter.width, textPainter.height);

  return size;
}

/// Returns the revised gradient stop
List<double> _calculateGradientStops(
    List<double> _offsets, bool _isInversed, double _sweepAngle) {
  final List<double> _gradientStops = List<double>(_offsets.length);
  for (num i = 0; i < _offsets.length; i++) {
    final double _offset = _offsets[i];
    double _stop = ((_sweepAngle / 360) * _offset).abs();
    if (_isInversed) {
      _stop = 1 - _stop;
    }
    _gradientStops[i] = _stop;
  }

  return _isInversed ? _gradientStops.reversed.toList() : _gradientStops;
}

/// Represents the circular interval list
class _CircularIntervalList<T> {
  /// Creates the circular interval list
  _CircularIntervalList(this._values);

  /// Specifies the list of value
  final List<T> _values;

  /// Specifies the index value
  int _index = 0;

  T get next {
    if (_index >= _values.length) {
      _index = 0;
    }
    return _values[_index++];
  }
}

/// Method to draw the dashed path
Path _dashPath(Path source,
    {@required _CircularIntervalList<double> dashArray}) {
  final Path path = Path();
  const double intialValue = 0.0;

  if (source == null) {
    return null;
  }

  for (final PathMetric measurePath in source.computeMetrics()) {
    double distance = intialValue;
    bool draw = true;
    while (distance < measurePath.length) {
      final double length = dashArray.next;
      if (draw) {
        path.addPath(
            measurePath.extractPath(distance, distance + length), Offset.zero);
      }
      distance += length;
      draw = !draw;
    }
  }
  return path;
}

/// Calculates the corner radius angle
double _cornerRadiusAngle(double _totalRadius, double _circleRadius) {
  final double _perimeter = (_totalRadius + _totalRadius + _circleRadius) / 2;
  final double _area = math.sqrt(_perimeter *
      (_perimeter - _totalRadius) *
      (_perimeter - _totalRadius) *
      (_perimeter - _circleRadius));
  final double _cornerRadiusAngle =
      math.asin((2 * _area) / (_totalRadius * _totalRadius)) * (180 / math.pi);
  return _cornerRadiusAngle;
}
