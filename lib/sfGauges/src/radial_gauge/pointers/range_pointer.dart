part of gauges;

/// Customizes the range pointer.
///
/// ```dart
/// Widget build(BuildContext context) {
///    return Container(
///        child: SfRadialGauge(
///          axes:<RadialAxis>[RadialAxis(
///             pointers: <GaugePointer>[RangePointer( value: 20)],
///            )]
///        ));
///}
/// ```
class RangePointer extends GaugePointer {
  /// Creates the range pointer
  RangePointer(
      {double value = 0,
      bool enableDragging,
      ValueChanged<double> onValueChanged,
      ValueChanged<double> onValueChangeStart,
      ValueChanged<double> onValueChangeEnd,
      ValueChanged<ValueChangingArgs> onValueChanging,
      AnimationType animationType,
      this.cornerStyle = CornerStyle.bothFlat,
      this.gradient,
      bool enableAnimation,
      double animationDuration = 1000,
      this.pointerOffset = 0,
      this.sizeUnit = GaugeSizeUnit.logicalPixel,
      this.width = 10,
      this.color})
      : assert(animationDuration > 0),
        assert(value != null),
        assert(width >= 0),
        assert(pointerOffset != null),
        assert((gradient != null && gradient is SweepGradient) ||
            gradient == null),
        super(
            value: value ?? 0,
            enableDragging: enableDragging ?? false,
            animationType: animationType ?? AnimationType.ease,
            onValueChanged: onValueChanged,
            onValueChangeStart: onValueChangeStart,
            onValueChangeEnd: onValueChangeEnd,
            onValueChanging: onValueChanging,
            enableAnimation: enableAnimation ?? false,
            animationDuration: animationDuration ?? 1000);

  /// Specifies the position value for pointer either in logical pixel or radius factor.
  ///
  /// Defaults to 0
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///             pointers: <GaugePointer>[RangePointer(pointerOffset: 30, value: 20)],
  ///            )]
  ///        ));
  ///}
  /// ```
  final double pointerOffset;

  /// Calculates the position and size for pointer either in logical pixel or radius factor.
  ///
  /// Defaults to SizeUnit.logicalPixel
  ///
  /// Also refer [GaugeSizeUnit]
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///             pointers: <GaugePointer>[RangePointer(pointerOffset: 0.3,  value: 20,
  ///             sizeUnit: GaugeSizeUnit.factor, width: 0.5
  ///             )],
  ///            )]
  ///        ));
  ///}
  /// ```
  final GaugeSizeUnit sizeUnit;

  /// Specifies the pointer width either in logical pixel or radius factor.
  ///
  /// Defaults to 10
  /// ```Dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///             pointers: <GaugePointer>[RangePointer(width: 20 , value: 20)],
  ///            )]
  ///        ));
  ///}
  /// ```
  final double width;

  /// Specifies the pointer color.
  ///
  /// Defaults to  null
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///             pointers: <GaugePointer>[RangePointer(
  ///             color: Colors.red , value: 20)],
  ///            )]
  ///        ));
  ///}
  /// ```
  final Color color;

  /// Specifies the corner style of range pointer.
  ///
  /// Also refer [CornerStyle]
  ///
  /// Defaults to CornerStyle.bothFlat
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///             pointers: <GaugePointer>[RangePointer(value: 20,
  ///             cornerStyle: CornerStyle.bothCurve)],
  ///            )]
  ///        ));
  ///}
  /// ```
  final CornerStyle cornerStyle;

  /// Specifies the gradient color for the rage pointer
  ///
  /// Defaults to null
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///             pointers: <GaugePointer>[RangePointer(value: 20,
  ///              gradient:SweepGradient(
  ///             colors: const <Color>[Colors.red, Color(0xFFFFDD00), Color(0xFFFFDD00), Color(0xFF30B32D),],
  ///             stops: const <double>[0, 0.2722222, 0.5833333, 0.777777,],
  ///           ))],
  ///            )]
  ///        ));
  ///}
  /// ```
  final Gradient gradient;

  /// Holds the start arc value
  double _startArc;

  /// Holds the end arc value
  double _endArc;

  /// Holds the actual range thickness
  double _actualRangeThickness;

  /// Specifies the range arc top
  double _rangeArcTop;

  /// Specifies the range arc bottom
  double _rangeArcBottom;

  /// Specifies the range arc left
  double _rangeArcLeft;

  /// Specifies the range arc right
  double _rangeArcRight;

  /// Specifies the arc rect
  Rect _arcRect;

  /// Specifies the arc path
  Path _arcPath;

  /// Specifies the start radian of range arc
  double _startCornerRadian;

  /// Specifies the sweep radian of range arc
  double _sweepCornerRadian;

  /// Specifies the center value for range corner
  double _cornerCenter;

  /// Specifies the angle for corner cap
  double _cornerAngle;

  /// Specifies the actual pointer offset value
  double _actualPointerOffset;

  /// Specifies total offset for the range pointer
  double _totalOffset;

  /// Method to calculate pointer position
  @override
  void _calculatePosition() {
    _currentValue = _minMax(_currentValue, _axis.minimum, _axis.maximum);
    _actualRangeThickness = _axis._calculateActualValue(width, sizeUnit, false);
    _actualPointerOffset =
        _axis._calculateActualValue(pointerOffset, sizeUnit, true);
    _totalOffset = _actualPointerOffset < 0
        ? _axis._calculateAxisOffset() + _actualPointerOffset
        : (_actualPointerOffset + _axis._axisOffset);
    _startArc = (_axis.valueToFactor(_axis.minimum) * _axis._sweepAngle) +
        _axis.startAngle;
    final double _endAngle =
        (_axis.valueToFactor(_currentValue) * _axis._sweepAngle) +
            _axis.startAngle;
    _endArc = _endAngle - _startArc;

    _rangeArcLeft =
        -(_axis._radius - (_actualRangeThickness / 2 + _totalOffset));
    _rangeArcTop =
        -(_axis._radius - (_actualRangeThickness / 2 + _totalOffset));
    _rangeArcRight = _axis._radius - (_actualRangeThickness / 2 + _totalOffset);
    _rangeArcBottom =
        _axis._radius - (_actualRangeThickness / 2 + _totalOffset);

    _createRangeRect();
  }

  /// To creates the arc rect for range pointer
  void _createRangeRect() {
    _arcRect = Rect.fromLTRB(
        _rangeArcLeft, _rangeArcTop, _rangeArcRight, _rangeArcBottom);
    _pointerRect = Rect.fromLTRB(
        _rangeArcLeft, _rangeArcTop, _rangeArcRight, _rangeArcBottom);
    _arcPath = Path();
    _arcPath.arcTo(
        _arcRect, _degreeToRadian(_startArc), _degreeToRadian(_endArc), true);
    _calculateCornerStylePosition();
  }

  /// Calculates the rounded corner position
  void _calculateCornerStylePosition() {
    _cornerCenter = (_arcRect.right - _arcRect.left) / 2;
    _cornerAngle = _cornerRadiusAngle(_cornerCenter, _actualRangeThickness / 2);

    switch (cornerStyle) {
      case CornerStyle.startCurve:
        {
          _startCornerRadian = _axis.isInversed
              ? _degreeToRadian(-_cornerAngle)
              : _degreeToRadian(_cornerAngle);
          _sweepCornerRadian = _axis.isInversed
              ? _degreeToRadian(_endArc + _cornerAngle)
              : _degreeToRadian(_endArc - _cornerAngle);
        }
        break;
      case CornerStyle.endCurve:
        {
          _startCornerRadian = _degreeToRadian(0);
          _sweepCornerRadian = _axis.isInversed
              ? _degreeToRadian(_endArc + _cornerAngle)
              : _degreeToRadian(_endArc - _cornerAngle);
        }
        break;
      case CornerStyle.bothCurve:
        {
          _startCornerRadian = _axis.isInversed
              ? _degreeToRadian(-_cornerAngle)
              : _degreeToRadian(_cornerAngle);
          _sweepCornerRadian = _axis.isInversed
              ? _degreeToRadian(_endArc + 2 * _cornerAngle)
              : _degreeToRadian(_endArc - 2 * _cornerAngle);
        }
        break;
      case CornerStyle.bothFlat:
        {
          _startCornerRadian = _degreeToRadian(_startArc);
          _sweepCornerRadian = _degreeToRadian(_endArc);
        }
        break;
    }
  }

  /// Calculates the range sweep angle
  double _getSweepAngle() {
    return _radianToDegree(_sweepCornerRadian) / _axis._sweepAngle;
  }

  /// Method to draw the range pointer
  /// @override
  void drawPointer(Canvas canvas, double animationValue, Offset startOffset,
      Offset offset, double _angle) {}
}
