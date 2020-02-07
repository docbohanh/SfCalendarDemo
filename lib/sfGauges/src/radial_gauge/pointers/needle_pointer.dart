part of gauges;

/// Represents the needle pointer.
///
/// ```dart
///Widget build(BuildContext context) {
///    return Container(
///        child: SfRadialGauge(
///          axes:<RadialAxis>[RadialAxis
///          ( pointers: <GaugePointer>[
///             NeedlePointer( value: 30,
///           )])]
///        ));
///}
/// ```
class NeedlePointer extends GaugePointer {
  /// Creates the needle pointer
  NeedlePointer(
      {double value = 0,
      bool enableDragging,
      ValueChanged<double> onValueChanged,
      ValueChanged<double> onValueChangeStart,
      ValueChanged<double> onValueChangeEnd,
      ValueChanged<ValueChangingArgs> onValueChanging,
      KnobStyle knobStyle,
      this.tailStyle,
      this.gradient,
      this.needleLength = 0.6,
      this.lengthUnit = GaugeSizeUnit.factor,
      this.needleStartWidth = 1,
      this.needleEndWidth = 10,
      bool enableAnimation,
      double animationDuration = 1000,
      AnimationType animationType,
      this.needleColor})
      : knobStyle = knobStyle ?? KnobStyle(knobRadius: 0.08),
        assert(animationDuration > 0),
        assert(value != null),
        assert(needleLength >= 0),
        assert(needleStartWidth >= 0),
        assert(needleEndWidth >= 0),
        super(
            value: value,
            enableDragging: enableDragging ?? false,
            onValueChanged: onValueChanged,
            onValueChangeStart: onValueChangeStart,
            onValueChangeEnd: onValueChangeEnd,
            onValueChanging: onValueChanging,
            animationType: animationType ?? AnimationType.ease,
            enableAnimation: enableAnimation ?? false,
            animationDuration: animationDuration);

  /// Customizes the knob in radial gauge.
  ///
  /// Also refer [KnobStyle]
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///          ( pointers: <GaugePointer>[
  ///             NeedlePointer( value: 30,
  ///              knobStyle: KnobStyle(knobRadius: 0.1),
  ///           )])]
  ///        ));
  ///}
  /// ```
  final KnobStyle knobStyle;

  /// Customizes the needle tail in radial gauge.
  ///
  /// Also refer [TailStyle]
  ///
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///          ( pointers: <GaugePointer>[
  ///             NeedlePointer( value: 20, tailStyle:
  ///                 TailStyle(width: 5, lengthFactor: 0.2)
  ///           )])]
  ///        ));
  ///}
  /// ```
  final TailStyle tailStyle;

  /// Specifies the length of the needle pointer either in logical pixel or radius factor.
  ///
  /// Defaults to 0.6
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///          ( pointers: <GaugePointer>[
  ///             NeedlePointer( needleLength: 0.8, value: 20,
  ///           )])]
  ///        ));
  ///}
  /// ```
  final double needleLength;

  /// Calculates the needle pointer length either in logical pixel or radius factor.
  ///
  /// Also refer [GaugeSizeUnit]
  ///
  /// Defaults to SizeUnit.factor
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///          ( pointers: <GaugePointer>[
  ///             NeedlePointer( needleLength: 30,
  ///             lengthUnit: GaugeSizeUnit.logicalPixel
  ///           )])]
  ///        ));
  ///}
  /// ```
  final GaugeSizeUnit lengthUnit;

  /// Specifies the start width of the needle pointer either in logical pixel or radius factor.
  ///
  ///  Defaults to 1
  ///  ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///          ( pointers: <GaugePointer>[
  ///             NeedlePointer( startWidth: 20, value: 30
  ///           )])]
  ///        ));
  ///}
  ///  ```
  final double needleStartWidth;

  /// Specifies the end width of the needle pointer either in logical pixel or radius factor.
  ///
  /// Defaults to 10
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///          ( pointers: <GaugePointer>[
  ///             NeedlePointer( endWidth: 30
  ///           )])]
  ///        ));
  ///}
  /// ```
  final double needleEndWidth;

  /// Specifies the color of the needle pointer.
  ///
  /// Defaults to null
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///          ( pointers: <GaugePointer>[
  ///             NeedlePointer( color: Colors.blue, value: 30
  ///           )])]
  ///        ));
  ///}
  /// ```
  final Color needleColor;

  /// Specifies the gradient of the needle pointer.
  ///
  /// Defaults to null
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis
  ///          ( pointers: <GaugePointer>[
  ///             NeedlePointer( color: Colors.blue, value: 30
  ///             gradient: LinearGradient(
  //                colors: const <Color>[Color.fromRGBO(28, 114, 189, 1),Color.fromRGBO(28, 114, 189, 1),
  //                  Color.fromRGBO(23, 173, 234, 1),Color.fromRGBO(23, 173, 234, 1)],
  //                stops: const <double>[0,0.5,0.5,1],
  //
  //            )
  ///           )])]
  ///        ));
  ///}
  /// ```
  final LinearGradient gradient;

  /// Specifies the actual tail length
  double _actualTailLength;

  /// Specifies the actual length of the pointer based on the coordinate unit
  double _actualNeedleLength;

  /// Specifies the actual knob radius
  double _actualCapRadius;

  /// Specifies the angle of the needle pointer
  double _angle;

  /// Specifies the radian value of needle pointer
  double _radian;

  /// Specifies the stop x value
  double _stopX;

  /// Specifies the stop y value
  double _stopY;

  /// Specifies the start left x value
  double _startLeftX;

  /// Specifies the start left y value
  double _startLeftY;

  /// Specifies the start right x value
  double _startRightX;

  /// Specifies the start right y value
  double _startRightY;

  /// Specifies the stop left x value
  double _stopLeftX;

  /// Specifies the stop left y value
  double _stopLeftY;

  /// Specifies the stop right x value
  double _stopRightX;

  /// Specifies the stop right y value
  double _stopRightY;

  /// Specifies the start x value
  double _startX;

  /// Specifies the start y value
  double _startY;

  /// Specifies the tail left start x value
  double _tailLeftStartX;

  /// Specifies the tail left start y value
  double _tailLeftStartY;

  /// Specifies the tail left end x value
  double _tailLeftEndX;

  /// Specifies the tail left end y value
  double _tailLeftEndY;

  /// Specifies the tail right start x value
  double _tailRightStartX;

  /// Specifies the tail right start y value
  double _tailRightStartY;

  /// Specifies the tail right end x value
  double _tailRightEndX;

  /// Specifies the tail right end y value
  double _tailRightEndY;

  Offset _centerPoint;

  /// Calculates the needle position
  @override
  void _calculatePosition() {
    _calculateDefaultValue();
    _calculateNeedleOffset();
  }

  /// Calculates the sweep angle of the pointer
  double _getSweepAngle() {
    return _axis.valueToFactor(_currentValue);
  }

  /// Calculates the default value
  void _calculateDefaultValue() {
    _actualNeedleLength =
        _axis._calculateActualValue(needleLength, lengthUnit, false);
    _actualCapRadius = _axis._calculateActualValue(
        knobStyle.knobRadius, knobStyle.sizeUnit, false);
    _currentValue = _minMax(_currentValue, _axis.minimum, _axis.maximum);
    _angle = (_axis.valueToFactor(_currentValue) * _axis._sweepAngle) +
        _axis.startAngle;
    _radian = _degreeToRadian(_angle);
    _centerPoint = Offset(_axis._axisSize.width / 2 - _axis._centerX,
        _axis._axisSize.height / 2 - _axis._centerY);
  }

  void _calculateNeedleOffset() {
    final double _needleRadian = _degreeToRadian(-90);
    _stopX = _actualNeedleLength * math.cos(_needleRadian);
    _stopY = _actualNeedleLength * math.sin(_needleRadian);
    _startX = 0;
    _startY = 0;

    if (needleEndWidth != null) {
      _startLeftX = _startX - needleEndWidth * math.cos(_needleRadian - 90);
      _startLeftY = _startY - needleEndWidth * math.sin(_needleRadian - 90);
      _startRightX = _startX - needleEndWidth * math.cos(_needleRadian + 90);
      _startRightY = _startY - needleEndWidth * math.sin(_needleRadian + 90);
    }

    if (needleStartWidth != null) {
      _stopLeftX = _stopX - needleStartWidth * math.cos(_needleRadian - 90);
      _stopLeftY = _stopY - needleStartWidth * math.sin(_needleRadian - 90);
      _stopRightX = _stopX - needleStartWidth * math.cos(_needleRadian + 90);
      _stopRightY = _stopY - needleStartWidth * math.sin(_needleRadian + 90);
    }

    _calculatePointerRect();
    if (tailStyle != null && tailStyle.width != null && tailStyle.width > 0) {
      _calculateTailPosition(_needleRadian);
    }
  }

  /// Calculates the needle pointer rect based on
  /// its start and the stop value
  void _calculatePointerRect() {
    double _x1 = _centerPoint.dx;
    double _x2 = _centerPoint.dx + _actualNeedleLength * math.cos(_radian);
    double _y1 = _centerPoint.dy;
    double _y2 = _centerPoint.dy + _actualNeedleLength * math.sin(_radian);

    if (_x1 > _x2) {
      final double _temp = _x1;
      _x1 = _x2;
      _x2 = _temp;
    }

    if (_y1 > _y2) {
      final double _temp = _y1;
      _y1 = _y2;
      _y2 = _temp;
    }

    if (_y2 - _y1 < 20) {
      _y1 -= 10;
      _y2 += 10;
    }

    if (_x2 - _x1 < 20) {
      _x1 -= 10;
      _x2 += 10;
    }

    _pointerRect = Rect.fromLTRB(_x1, _y1, _x2, _y2);
  }

  /// Calculates the values to render the needle tail
  void _calculateTailPosition(double _needleRadian) {
    final double _pointerWidth = tailStyle.width;
    _actualTailLength = _axis._calculateActualValue(
        tailStyle.length, tailStyle.lengthUnit, false);
    if (_actualTailLength > 0) {
      final double _tailEndX =
          _startX - _actualTailLength * math.cos(_needleRadian);
      final double _tailEndY =
          _startY - _actualTailLength * math.sin(_needleRadian);
      _tailLeftStartX = _startX - _pointerWidth * math.cos(_needleRadian - 90);
      _tailLeftStartY = _startY - _pointerWidth * math.sin(_needleRadian - 90);
      _tailRightStartX = _startX - _pointerWidth * math.cos(_needleRadian + 90);
      _tailRightStartY = _startY - _pointerWidth * math.sin(_needleRadian + 90);

      _tailLeftEndX = _tailEndX - _pointerWidth * math.cos(_needleRadian - 90);
      _tailLeftEndY = _tailEndY - _pointerWidth * math.sin(_needleRadian - 90);
      _tailRightEndX = _tailEndX - _pointerWidth * math.cos(_needleRadian + 90);
      _tailRightEndY = _tailEndY - _pointerWidth * math.sin(_needleRadian + 90);
    }
  }

  /// Method to draw pointer needle Pointer
  @override
  void drawPointer(Canvas canvas, double animationValue, Offset startPosition,
      Offset endPosition, double pointerAngle) {
    final double _pointerRadian = _degreeToRadian(pointerAngle);
    if (_actualNeedleLength != null && _actualNeedleLength > 0) {
      _renderNeedle(canvas, _pointerRadian);
    }

    if (_actualTailLength != null && _actualTailLength > 0) {
      _renderTail(canvas, _pointerRadian);
    }

    _renderCap(canvas);
  }

  /// To render the needle of the pointer
  void _renderNeedle(Canvas canvas, double _pointerRadian) {
    final Paint paint = Paint()
      ..color = needleColor ?? _axis._gauge._gaugeTheme.needleColor
      ..style = PaintingStyle.fill;
    final Path path = Path();
    path.moveTo(_startLeftX, _startLeftY);
    path.lineTo(_stopLeftX, _stopLeftY);
    path.lineTo(_stopRightX, _stopRightY);
    path.lineTo(_startRightX, _startRightY);
    path.close();

    if (gradient != null) {
      paint.shader = gradient.createShader(path.getBounds());
    }

    canvas.save();
    canvas.translate(_centerPoint.dx, _centerPoint.dy);
    canvas.rotate(_pointerRadian);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  /// To render the tail of the pointer
  void _renderTail(Canvas canvas, double _pointerRadian) {
    final Path _tailPath = Path();
    _tailPath.moveTo(_tailLeftStartX, _tailLeftStartY);
    _tailPath.lineTo(_tailLeftEndX, _tailLeftEndY);
    _tailPath.lineTo(_tailRightEndX, _tailRightEndY);
    _tailPath.lineTo(_tailRightStartX, _tailRightStartY);
    _tailPath.close();

    canvas.save();
    canvas.translate(_centerPoint.dx, _centerPoint.dy);
    canvas.rotate(_pointerRadian);

    final Paint _tailPaint = Paint()
      ..color = tailStyle.color ?? _axis._gauge._gaugeTheme.tailColor;
    if (tailStyle.gradient != null) {
      _tailPaint.shader =
          tailStyle.gradient.createShader(_tailPath.getBounds());
    }

    canvas.drawPath(_tailPath, _tailPaint);

    if (tailStyle.borderWidth > 0) {
      final Paint _tailStrokePaint = Paint()
        ..color =
            tailStyle.borderColor ?? _axis._gauge._gaugeTheme.tailBorderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = tailStyle.borderWidth;
      canvas.drawPath(_tailPath, _tailStrokePaint);
    }

    canvas.restore();
  }

  /// To render the cap of needle
  void _renderCap(Canvas canvas) {
    if (_actualCapRadius > 0) {
      final Paint knobPaint = Paint()
        ..color = knobStyle.color ?? _axis._gauge._gaugeTheme.knobColor;
      canvas.drawCircle(
          Offset(_axis._axisSize.width / 2 - _axis._centerX,
              _axis._axisSize.height / 2 - _axis._centerY),
          _actualCapRadius,
          knobPaint);

      if (knobStyle.borderWidth > 0) {
        final double _actualBorderWidth = _axis._calculateActualValue(
            knobStyle.borderWidth, knobStyle.sizeUnit, false);
        final Paint _strokePaint = Paint()
          ..color =
              knobStyle.borderColor ?? _axis._gauge._gaugeTheme.knobBorderColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = _actualBorderWidth;
        canvas.drawCircle(_centerPoint, _actualCapRadius, _strokePaint);
      }
    }
  }
}
