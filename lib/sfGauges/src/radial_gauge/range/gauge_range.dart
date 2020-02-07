part of gauges;

/// Represents the gauge range.
///
/// ```dart
/// Widget build(BuildContext context) {
///    return Container(
///        child: SfRadialGauge(
///          axes:<RadialAxis>[RadialAxis(
///          ranges: <GaugeRange>[GaugeRange(startValue: 50,
///          endValue: 100)],
///            )]
///        ));
///}
/// ```
class GaugeRange {
  /// Creates the gauge range
  GaugeRange(
      {@required this.startValue,
      @required this.endValue,
      double startWidth,
      double endWidth,
      this.sizeUnit = GaugeSizeUnit.logicalPixel,
      this.color,
      this.gradient,
      this.rangeOffset = 0,
      this.label,
      GaugeTextStyle labelStyle})
      : startWidth =
            startWidth == null ? label != null ? startWidth : 10 : startWidth,
        endWidth = endWidth == null ? label != null ? endWidth : 10 : endWidth,
        labelStyle = labelStyle ??
            GaugeTextStyle(
                fontSize: 12.0,
                fontFamily: 'Segoe UI',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal),
        assert(startValue != null),
        assert(endValue != null),
        assert((gradient != null && gradient is SweepGradient) ||
            gradient == null) {
    _needsRepaintRange = true;
  }

  /// Specifies the range start value.
  ///
  /// Defaults to null
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///          ranges: <GaugeRange>[GaugeRange(startValue: 50,
  ///          endValue: 100)],
  ///            )]
  ///        ));
  ///}
  /// ```
  final double startValue;

  /// Specifies the range end value.
  ///
  /// Defaults to null
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///          ranges: <GaugeRange>[GaugeRange(startValue: 50,
  ///          endValue: 100)],
  ///            )]
  ///        ));
  ///}
  /// ```
  final double endValue;

  /// Specifies the range start width either in logical pixel or radius factor
  ///
  /// Defaults to 10
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///          ranges: <GaugeRange>[GaugeRange(startValue: 50,
  ///          endValue: 100, startWidth: 20)],
  ///            )]
  ///        ));
  ///}
  /// ```
  final double startWidth;

  /// Specifies the range end width either in logical pixel or radius factor.
  ///
  /// Defaults to 10
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///          ranges: <GaugeRange>[GaugeRange(startValue: 50,
  ///          endValue: 100, endWidth: 40)],
  ///            )]
  ///        ));
  ///}
  /// ```
  final double endWidth;

  /// Calculates the range position and size either in logical pixel or radius factor.
  ///
  /// Also refer [GaugeSizeUnit]
  /// Defaults to SizeUnit.logicalPixel
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///          ranges: <GaugeRange>[GaugeRange(startValue: 50,
  ///          endValue: 100, rangeOffset: 0.1, sizeUnit: GaugeSizeUnit.factor)],
  ///            )]
  ///        ));
  ///}
  /// ```
  final GaugeSizeUnit sizeUnit;

  /// Specifies the range position value either in logical pixel or radius factor.
  ///
  /// Defaults to 0
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///          ranges: <GaugeRange>[GaugeRange(startValue: 50,
  ///          endValue: 100, rangeOffset: 10)],
  ///            )]
  ///        ));
  ///}
  /// ```
  final double rangeOffset;

  /// Specifies the range color.
  ///
  /// Defaults to null
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///          ranges: <GaugeRange>[GaugeRange(startValue: 50,
  ///          endValue: 100, color: Colors.blue)],
  ///            )]
  ///        ));
  ///}
  /// ```
  final Color color;

  /// Customizes the label for range.
  ///
  /// Also refer [GaugeTextStyle]
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///          ranges: <GaugeRange>[GaugeRange(startValue: 50,
  ///          endValue: 100, label: 'High',
  ///          labelStyle: GaugeTextStyle(fontSize: 20)
  ///          )],
  ///            )]
  ///        ));
  ///}
  /// ```
  final GaugeTextStyle labelStyle;

  /// Specifies the text for range.
  ///
  /// Defaults to null
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///          ranges: <GaugeRange>[GaugeRange(startValue: 50,
  ///          endValue: 100, label: 'High')],
  ///            )]
  ///        ));
  ///}
  /// ```
  final String label;

  /// Specifies the gradient for range
  ///
  /// Defaults to null
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///          ranges: <GaugeRange>[GaugeRange(startValue: 0,
  ///          endValue: 100, startWidth: 10, endWidth: 10,
  ///          gradient:SweepGradient(
  //            colors: const <Color>[Colors.red, Color(0xFFFFDD00), Color(0xFFFFDD00), Color(0xFF30B32D),],
  //            stops: const <double>[0, 0.2722222, 0.5833333, 0.777777,],
  //          ))],
  ///            )]
  ///        ));
  ///}
  /// ```
  final Gradient gradient;

  /// Specifies whether to repaint the range
  bool _needsRepaintRange;

  /// Specifies the range axis
  RadialAxis _axis;

  /// Specifies the start width
  double _actualStartWidth;

  /// Specifies the actual end width
  double _actualEndWidth;

  /// Specifies the outer start offset
  double _outerStartOffset;

  /// Specifies the outer end offset
  double _outerEndOffset;

  /// Specifies the inner start offset
  double _innerStartOffset;

  /// Specifies the inner end offset
  double _innerEndOffset;

  /// Specifies the outer arc
  _ArcData _outerArc;

  /// Specifies the inner arc
  _ArcData _innerArc;

  /// Specifies the outer arc sweep angle
  double _outerArcSweepAngle;

  /// Specifies the inner arc sweep angle
  double _innerArcSweepAngle;

  /// Specifies the thickness value
  double _thickness;

  /// Specifies the range rect
  Rect _rangeRect;

  /// Specifies the range start radian
  double _rangeStartRadian;

  /// Specifies the range end radian
  double _rangeEndRadian;

  /// Specifies the range mid radian
  double _rangeMidRadian;

  /// Specifies the center value
  Offset _center;

  /// Specifies the maximum angle
  double _maxAngle;

  /// Specifies the range start value
  double _rangeStartValue;

  /// Specifies the range ed value
  double _rangeEndValue;

  /// Specifies the range mid value
  double _rangeMidValue;

  /// Specifies the label angle
  double _labelAngle;

  /// Holds the label position
  Offset _labelPosition;

  /// Holds the label size
  Size _labelSize;

  /// Holds the actual start value
  double _actualStartValue;

  /// Holds the actual end value
  double _actualEndValue;

  /// Holds the total offset
  double _totalOffset;

  /// Specifies the actual range offset
  double _actualRangeOffset;

  /// Specifies the path rect
  Rect _pathRect;

  /// Calculates the range position
  void _calculateRangePosition() {
    _calculateActualWidth();
    _actualRangeOffset =
        _axis._calculateActualValue(rangeOffset, sizeUnit, true);
    _center = Offset(_axis._axisSize.width / 2, _axis._axisSize.height / 2);
    _totalOffset = _actualRangeOffset < 0
        ? _axis._calculateAxisOffset() + _actualRangeOffset
        : (_actualRangeOffset + _axis._axisOffset);
    _maxAngle = _axis._sweepAngle;
    _actualStartValue =
        _minMax(startValue ?? _axis.minimum, _axis.minimum, _axis.maximum);
    _actualEndValue =
        _minMax(endValue ?? _axis.maximum, _axis.minimum, _axis.maximum);
    _calculateRangeAngle();
    if (_actualStartWidth != _actualEndWidth) {
      _calculateInEqualWidthArc();
    } else {
      _calculateEqualWidthArc();
    }

    if (label != null) {
      _labelSize = _measureText(label, labelStyle);
      _calculateLabelPosition();
    }
  }

  /// Method to calculate rect for in equal width range
  void _calculateInEqualWidthArc() {
    _outerEndOffset = 0;
    _outerStartOffset = _outerEndOffset;
    _innerStartOffset = _actualStartWidth;
    _innerEndOffset = _actualEndWidth;

    _outerArc = _radiusToAngleConversion(_outerStartOffset, _outerEndOffset);
    _innerArc = _radiusToAngleConversion(_innerStartOffset, _innerEndOffset);

    _outerArcSweepAngle =
        _getSweepAngle(_outerArc._endAngle - _outerArc._startAngle);
    _innerArcSweepAngle =
        _getSweepAngle(_innerArc._endAngle - _innerArc._startAngle);
    _innerArcSweepAngle *= -1;

    final double _left = _outerArc._arcRect.left < _innerArc._arcRect.left
        ? _outerArc._arcRect.left
        : _innerArc._arcRect.left;
    final double _top = _outerArc._arcRect.top < _innerArc._arcRect.top
        ? _outerArc._arcRect.top
        : _innerArc._arcRect.top;
    final double _right = _outerArc._arcRect.right < _innerArc._arcRect.right
        ? _innerArc._arcRect.right
        : _outerArc._arcRect.right;
    final double _bottom = _outerArc._arcRect.bottom < _innerArc._arcRect.bottom
        ? _innerArc._arcRect.bottom
        : _outerArc._arcRect.bottom;
    _pathRect = Rect.fromLTRB(_left, _top, _right, _bottom);
  }

  /// Calculates the range angle
  void _calculateRangeAngle() {
    if (!_axis.isInversed) {
      _rangeStartValue = _axis.startAngle +
          (_maxAngle /
              ((_axis.maximum - _axis.minimum) /
                  (_actualStartValue - _axis.minimum)));
      _rangeEndValue = _axis.startAngle +
          (_maxAngle /
              ((_axis.maximum - _axis.minimum) /
                  (_actualEndValue - _axis.minimum)));
      _rangeMidValue = _axis.startAngle +
          (_maxAngle /
              ((_axis.maximum - _axis.minimum) /
                  ((_actualEndValue - _actualStartValue) / 2 +
                      _actualStartValue)));
    } else {
      _rangeStartValue = _axis.startAngle +
          _maxAngle -
          (_maxAngle /
              ((_axis.maximum - _axis.minimum) /
                  (_actualStartValue - _axis.minimum)));
      _rangeEndValue = _axis.startAngle +
          _maxAngle -
          (_maxAngle /
              ((_axis.maximum - _axis.minimum) /
                  (_actualEndValue - _axis.minimum)));
      _rangeMidValue = _axis.startAngle +
          _maxAngle -
          (_maxAngle /
              ((_axis.maximum - _axis.minimum) /
                  ((_actualEndValue - _actualStartValue) / 2 +
                      _actualStartValue)));
    }

    _rangeStartRadian = _degreeToRadian(_rangeStartValue);
    _rangeEndRadian = _degreeToRadian(_rangeEndValue);
    _rangeMidRadian = _degreeToRadian(_rangeMidValue);
  }

  /// Method to calculate the rect for range with equal start and end width
  void _calculateEqualWidthArc() {
    _thickness = _actualStartWidth;
    _rangeStartRadian = _degreeToRadian(
        (_axis.valueToFactor(_actualStartValue) * _axis._sweepAngle) +
            _axis.startAngle);
    final double _endRadian = _degreeToRadian(
        (_axis.valueToFactor(_actualEndValue) * _axis._sweepAngle) +
            _axis.startAngle);
    _rangeEndRadian = _endRadian - _rangeStartRadian;

    _rangeRect = Rect.fromLTRB(
        -(_axis._radius - (_actualStartWidth / 2 + _totalOffset)),
        -(_axis._radius - (_actualStartWidth / 2 + _totalOffset)),
        _axis._radius - (_actualStartWidth / 2 + _totalOffset),
        _axis._radius - (_actualStartWidth / 2 + _totalOffset));
  }

  /// Method to calculate the sweep angle
  double _getSweepAngle(double _sweepAngle) {
    if (_sweepAngle < 0 && !_axis.isInversed) {
      _sweepAngle += 360;
    }

    if (_sweepAngle > 0 && _axis.isInversed) {
      _sweepAngle -= 360;
    }
    return _sweepAngle;
  }

  /// Converts radius to angle
  _ArcData _radiusToAngleConversion(double _startOffset, double _endOffset) {
    final double _startRadius = _axis._radius - _startOffset;
    final double _endRadius = _axis._radius - _endOffset;
    final double _midRadius = _axis._radius - (_startOffset + _endOffset) / 2;

    final double _startX = _startRadius * math.cos(_degreeToRadian(0));
    final double _startY = _startRadius * math.sin(_degreeToRadian(0));
    final Offset _rangeStartOffset = Offset(_startX, _startY);

    final double _endX =
        _endRadius * math.cos(_rangeEndRadian - _rangeStartRadian);
    final double _endY =
        _endRadius * math.sin(_rangeEndRadian - _rangeStartRadian);
    final Offset _rangeEndOffset = Offset(_endX, _endY);

    final double _midX =
        _midRadius * math.cos(_rangeMidRadian - _rangeStartRadian);
    final double _midY =
        _midRadius * math.sin(_rangeMidRadian - _rangeStartRadian);
    final Offset _rangeMidOffset = Offset(_midX, _midY);
    return _createArcData(_rangeStartOffset, _rangeEndOffset, _rangeMidOffset);
  }

  /// Method to create the arc data
  _ArcData _createArcData(Offset _rangeStartOffset, Offset _rangeEndOffset,
      Offset _rangeMidOffset) {
    final Offset _controlPoint =
        _pointConversion(_rangeStartOffset, _rangeEndOffset, _rangeMidOffset);

    final double _distance = math.sqrt(
        math.pow(_rangeStartOffset.dx - _controlPoint.dx, 2) +
            math.pow(_rangeStartOffset.dy - _controlPoint.dy, 2));

    double _actualStartAngle = _radianToDegree(math.atan2(
      _rangeStartOffset.dy - _controlPoint.dy,
      _rangeStartOffset.dx - _controlPoint.dx,
    ));
    double _actualEndAngle = _radianToDegree(math.atan2(
      _rangeEndOffset.dy - _controlPoint.dy,
      _rangeEndOffset.dx - _controlPoint.dx,
    ));

    if (_actualStartAngle < 0) {
      _actualStartAngle += 360;
    }

    if (_actualEndAngle < 0) {
      _actualEndAngle += 360;
    }

    if (_actualStartValue > _actualEndValue) {
      final double _temp = _actualEndAngle;
      _actualEndAngle = _actualStartAngle;
      _actualStartAngle = _temp;
    }

    final _ArcData _arcData = _ArcData();
    _arcData._startAngle = _actualStartAngle;
    _arcData._endAngle = _actualEndAngle;
    _arcData._arcRect = Rect.fromLTRB(
        _controlPoint.dx - _distance + _totalOffset,
        _controlPoint.dy - _distance + _totalOffset,
        _controlPoint.dx + _distance - _totalOffset,
        _controlPoint.dy + _distance - _totalOffset);
    return _arcData;
  }

  /// calculates the control point for range arc
  Offset _pointConversion(Offset _offset1, Offset _offset2, Offset _offset3) {
    double _distance1 =
        (_offset1.dy - _offset2.dy) / (_offset1.dx - _offset2.dx);
    _distance1 =
        (_offset1.dy - _offset2.dy) == 0 || (_offset1.dx - _offset2.dx) == 0
            ? 0
            : _distance1;
    double _distance2 =
        (_offset3.dy - _offset2.dy) / (_offset3.dx - _offset2.dx);
    _distance2 =
        (_offset3.dy - _offset2.dy) == 0 || (_offset3.dx - _offset2.dx) == 0
            ? 0
            : _distance2;
    double _x = (_distance1 * _distance2 * (_offset3.dy - _offset1.dy) +
            _distance1 * (_offset2.dx + _offset3.dx) -
            _distance2 * (_offset1.dx + _offset2.dx)) /
        (2 * (_distance1 - _distance2));
    final double _diff = (1 / _distance1).isInfinite ? 0 : (1 / _distance1);
    double _y = -_diff * (_x - ((_offset1.dx + _offset2.dx) / 2)) +
        ((_offset1.dy + _offset2.dy) / 2);
    _x = _x.isNaN ? 0 : _x;
    _y = _y.isNaN ? 0 : _y;
    return Offset(_x, _y);
  }

  /// Calculates the actual range width
  void _calculateActualWidth() {
    _actualStartWidth = _calculateActualValue(startWidth);
    _actualEndWidth = _calculateActualValue(endWidth);
  }

  /// Calculates the actual value
  double _calculateActualValue(double _value) {
    double _actualValue = 0;
    if (_value != null) {
      switch (sizeUnit) {
        case GaugeSizeUnit.factor:
          {
            _actualValue = _value * _axis._radius;
          }
          break;
        case GaugeSizeUnit.logicalPixel:
          {
            _actualValue = _value;
          }
      }
    } else if (label != null) {
      final Size _size = _measureText(label, labelStyle);
      _actualValue = _size.height;
    }

    return _actualValue;
  }

  /// Calculates the label position
  void _calculateLabelPosition() {
    final double _midAngle =
        (_axis.valueToFactor((_actualEndValue + _actualStartValue) / 2) *
                _axis._sweepAngle) +
            _axis.startAngle;
    final double _labelRadian = _degreeToRadian(_midAngle);
    _labelAngle = _midAngle - 90;
    final double _height = _actualStartWidth != _actualEndWidth
        ? (_actualEndWidth - _actualStartWidth).abs() / 2
        : _actualEndWidth / 2;
    final double _x = _axis._axisSize.width / 2 +
        ((_axis._radius - (_totalOffset + _height)) * math.cos(_labelRadian)) -
        _axis._centerX;
    final double _y = _axis._axisSize.height / 2 +
        ((_axis._radius - (_totalOffset + _height)) * math.sin(_labelRadian)) -
        _axis._centerY;
    _labelPosition = Offset(_x, _y);
  }
}
