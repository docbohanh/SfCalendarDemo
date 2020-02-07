part of gauges;

/// Represents the marker pointer
///
/// ```dart
/// Widget build(BuildContext context) {
///    return Container(
///        child: SfRadialGauge(
///          axes:<RadialAxis>[RadialAxis(
///             pointers: <GaugePointer>[MarkerPointer(value: 50,
///             )],
///            )]
///        ));
///}
/// ```
class MarkerPointer extends GaugePointer {
  /// Creates the marker pointer
  MarkerPointer(
      {double value = 0,
      bool enableDragging,
      ValueChanged<double> onValueChanged,
      ValueChanged<double> onValueChangeStart,
      ValueChanged<double> onValueChangeEnd,
      ValueChanged<ValueChangingArgs> onValueChanging,
      this.markerType = MarkerType.invertedTriangle,
      this.color,
      this.markerWidth = 10,
      this.markerHeight = 10,
      this.borderWidth = 0,
      this.markerOffset = 0,
      this.text,
      this.borderColor,
      this.offsetUnit = GaugeSizeUnit.logicalPixel,
      this.imageUrl,
      AnimationType animationType,
      GaugeTextStyle textStyle,
      bool enableAnimation,
      double animationDuration = 1000})
      : textStyle = textStyle ??
            GaugeTextStyle(
                fontSize: 12.0,
                fontFamily: 'Segoe UI',
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.normal),
        assert(animationDuration > 0),
        assert(value != null),
        assert(markerWidth >= 0),
        assert(markerHeight >= 0),
        assert(borderWidth >= 0),
        assert(markerOffset != null),
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

  /// Specifies the marker type for the pointer.
  ///
  /// Defaults to MarkerType.invertedTriangle
  ///
  /// Also refer [MarkerType.invertedTriangle]
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///             pointers: <GaugePointer>[MarkerPointer(value: 50,
  ///             markerType: MarkerType.circle)],
  ///            )]
  ///        ));
  ///}
  /// ```
  final MarkerType markerType;

  /// Specifies the marker color.
  ///
  /// Defaults to null
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///             pointers: <GaugePointer>[MarkerPointer(value: 50,
  ///             color: Colors.red)],
  ///            )]
  ///        ));
  ///}
  /// ```
  final Color color;

  /// Specifies the marker height in logical pixel.
  ///
  /// Defaults to 10
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///             pointers: <GaugePointer>[MarkerPointer(value: 50,
  ///             markerHeight: 20
  ///             )],
  ///            )]
  ///        ));
  ///}
  /// ```
  final double markerHeight;

  /// Specifies the marker width in logical pixel.
  ///
  /// Defaults to 10
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///             pointers: <GaugePointer>[MarkerPointer(value: 50,
  ///             markerWidth: 20
  ///             )],
  ///            )]
  ///        ));
  ///}
  /// ```
  final double markerWidth;

  /// Specifies the image Url.
  ///
  /// Defaults to null
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///             pointers: <GaugePointer>[MarkerPointer(value: 50,
  ///             imageUrl:'images/pin.png',
  ///             markerType: MarkerShape.image
  ///             )],
  ///            )]
  ///        ));
  ///}
  /// ```
  final String imageUrl;

  /// Specifies the marker text.
  ///
  /// Defaults to null
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///             pointers: <GaugePointer>[MarkerPointer(value: 50,
  ///             text: 'marker',
  ///             markerType: MarkerShape.text
  ///             )],
  ///            )]
  ///        ));
  ///}
  /// ```
  final String text;

  /// Customizes the marker text.
  ///
  /// Defaults to null
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///             pointers: <GaugePointer>[MarkerPointer(value: 50,
  ///             text: 'marker', textStyle:
  ///             GaugeTextStyle(fontSize: 20, fontStyle: FontStyle.italic),
  ///             markerType: MarkerType.text
  ///             )],
  ///            )]
  ///        ));
  ///}
  /// ```
  final GaugeTextStyle textStyle;

  /// Specifies the marker position value either in logical pixel or radius factor.
  ///
  /// Defaults to 0
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///             pointers: <GaugePointer>[MarkerPointer(value: 50,
  ///             markerOffset: 10
  ///             )],
  ///            )]
  ///        ));
  ///}
  /// ```
  final double markerOffset;

  /// Calculates the marker position either in logical pixel or radius factor.
  ///
  /// Also refer [GaugeSizeUnit]
  ///
  /// Defaults to SizeUnit.logicalPixel
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///             pointers: <GaugePointer>[MarkerPointer(value: 50,
  ///             markerUnit: GaugeSizeUnit.factor, markerOffset = 0.2
  ///             )],
  ///            )]
  ///        ));
  ///}
  /// ```
  final GaugeSizeUnit offsetUnit;

  /// Specifies the border color for marker.
  ///
  /// Defaults to null
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///             pointers: <GaugePointer>[MarkerPointer(value: 50,
  ///             borderColor: Colors.red, borderWidth : 2)],
  ///            )]
  ///        ));
  ///}
  /// ```
  final Color borderColor;

  /// Specifies the border width for marker.
  ///
  /// Defaults to 0
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///             pointers: <GaugePointer>[MarkerPointer(value: 50,
  ///             borderColor: Colors.red, borderWidth : 2)],
  ///            )]
  ///        ));
  ///}
  /// ```
  final double borderWidth;

  /// Specifies the marker image
  dart_ui.Image _image;

  /// Specifies the marker offset
  Offset _offset;

  /// Specifies the radian value of the marker
  double _radian;

  /// Specifies the angle value
  double _angle;

  /// Specifies the marker text size
  Size _textSize;

  /// Specifies the total offset considering axis element
  double _totalOffset;

  /// Specifies actual marker offset value
  double _actualMarkerOffset;

  /// Specifies the margin for calculating
  /// marker pointer rect
  final double _margin = 15;

  /// method to calculate the marker position
  @override
  void _calculatePosition() {
    _angle = _getPointerAngle();
    _radian = _degreeToRadian(_angle);
    final Offset _offset = _calculateMarkerOffset(_radian);
    if (markerType == MarkerType.image && imageUrl != null) {
      _loadImage();
    } else if (markerType == MarkerType.text && text != null) {
      _textSize = _measureText(text, textStyle);
    }

    _pointerRect = Rect.fromLTRB(
        _offset.dx - markerWidth / 2 - _margin,
        _offset.dy - markerHeight / 2 - _margin,
        _offset.dx + markerWidth / 2 + _margin,
        _offset.dy + markerHeight / 2 + _margin);
  }

  /// Method returns the angle of  current pointer alue
  double _getPointerAngle() {
    _currentValue = _minMax(_currentValue, _axis.minimum, _axis.maximum);
    return (_axis.valueToFactor(_currentValue) * _axis._sweepAngle) +
        _axis.startAngle;
  }

  /// Method returns the sweep angle of pointer
  double _getSweepAngle() {
    return _axis.valueToFactor(_currentValue);
  }

  /// Calculates the marker offset position
  Offset _calculateMarkerOffset(double _markerRadian) {
    _actualMarkerOffset =
        _axis._calculateActualValue(markerOffset, offsetUnit, true);
    _totalOffset = _actualMarkerOffset < 0
        ? _axis._calculateAxisOffset() + _actualMarkerOffset
        : (_actualMarkerOffset + _axis._axisOffset);
    final double _x = (_axis._axisSize.width / 2) +
        (_axis._radius - _totalOffset - (_axis._actualAxisWidth / 2)) *
            math.cos(_markerRadian) -
        _axis._centerX;
    final double _y = (_axis._axisSize.height / 2) +
        (_axis._radius - _totalOffset - (_axis._actualAxisWidth / 2)) *
            math.sin(_markerRadian) -
        _axis._centerY;
    _offset = Offset(_x, _y);
    return _offset;
  }

  /// To load the image from the image url
// ignore: avoid_void_async
  void _loadImage() async {
    await _renderImage();
    _axis._gauge._radialGaugeState.pointerRepaintNotifier.value++;
  }

  /// Renders the image from the image url
// ignore: prefer_void_to_null
  Future<Null> _renderImage() async {
    final ByteData _imageData = await rootBundle.load(imageUrl);
    final dart_ui.Codec _imageCodec =
        await dart_ui.instantiateImageCodec(_imageData.buffer.asUint8List());
    final dart_ui.FrameInfo _frameInfo = await _imageCodec.getNextFrame();
    _image = _frameInfo.image;
  }

  @override
  void drawPointer(Canvas canvas, double animationValue, Offset startPosition,
      Offset endPosition, double pointerAngle) {
    final Paint paint = Paint()
      ..color = color ?? _axis._gauge._gaugeTheme.markerColor
      ..style = PaintingStyle.fill;

    Paint _borderPaint;
    if (borderWidth != null && borderWidth > 0) {
      _borderPaint = Paint()
        ..color = borderColor ?? _axis._gauge._gaugeTheme.markerBorderColor
        ..strokeWidth = borderWidth
        ..style = PaintingStyle.stroke;
    }

    canvas.save();
    switch (markerType) {
      case MarkerType.circle:
        _drawCircle(canvas, paint, startPosition, _borderPaint);
        break;
      case MarkerType.rectangle:
        _drawRectangle(
            canvas, paint, startPosition, pointerAngle, _borderPaint);
        break;
      case MarkerType.image:
        _drawMarkerImage(canvas, paint, startPosition, pointerAngle);
        break;
      case MarkerType.triangle:
      case MarkerType.invertedTriangle:
        _drawTriangle(canvas, paint, startPosition, pointerAngle, _borderPaint);
        break;
      case MarkerType.diamond:
        _drawDiamond(canvas, paint, startPosition, pointerAngle, _borderPaint);
        break;
      case MarkerType.text:
        if (text != null) {
          _drawText(canvas, paint, startPosition, pointerAngle);
        }

        break;
    }

    canvas.restore();
  }

  /// To render the MarkerShape.Text
  void _drawText(
      Canvas canvas, Paint paint, Offset startPosition, double pointerAngle) {
    final TextSpan span = TextSpan(
        text: text,
        style: TextStyle(
            color: textStyle.color ?? _axis._gauge._gaugeTheme.axisLabelColor,
            fontSize: textStyle.fontSize,
            fontFamily: textStyle.fontFamily,
            fontStyle: textStyle.fontStyle,
            fontWeight: textStyle.fontWeight));
    final TextPainter textPainter = TextPainter(
        text: span,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);
    textPainter.layout();
    canvas.save();
    canvas.translate(startPosition.dx, startPosition.dy);
    canvas.rotate(_degreeToRadian(pointerAngle - 90));
    canvas.scale(-1);
    textPainter.paint(
        canvas, Offset(-_textSize.width / 2, -_textSize.height / 2));
    canvas.restore();
  }

  /// Renders the MarkerShape.circel
  void _drawCircle(
      Canvas canvas, Paint paint, Offset startPosition, Paint _borderPaint) {
    final Rect _rect = Rect.fromLTRB(
        startPosition.dx - markerWidth / 2,
        startPosition.dy - markerHeight / 2,
        startPosition.dx + markerWidth / 2,
        startPosition.dy + markerHeight / 2);
    canvas.drawOval(_rect, paint);
    if (_borderPaint != null) {
      canvas.drawOval(_rect, _borderPaint);
    }
  }

  /// Renders the MarkerShape.rectangle
  void _drawRectangle(Canvas canvas, Paint paint, Offset startPosition,
      double pointerAngle, Paint _borderPaint) {
    canvas.translate(startPosition.dx, startPosition.dy);
    canvas.rotate(_degreeToRadian(pointerAngle));
    canvas.drawRect(
        Rect.fromLTRB(-markerWidth / 2, -markerHeight / 2, markerWidth / 2,
            markerHeight / 2),
        paint);
    if (_borderPaint != null) {
      canvas.drawRect(
          Rect.fromLTRB(-markerWidth / 2, -markerHeight / 2, markerWidth / 2,
              markerHeight / 2),
          _borderPaint);
    }
  }

  /// Renders the MarkerShape.image
  void _drawMarkerImage(
      Canvas canvas, Paint paint, Offset startPosition, double pointerAngle) {
    canvas.translate(startPosition.dx, startPosition.dy);
    canvas.rotate(_degreeToRadian(pointerAngle + 90));
    final Rect _rect = Rect.fromLTRB(
        -markerWidth / 2, -markerHeight / 2, markerWidth / 2, markerHeight / 2);
    if (_image != null) {
      canvas.drawImageNine(_image, _rect, _rect, paint);
    }
  }

  /// Renders the MarkerShape.diamond
  void _drawDiamond(Canvas canvas, Paint paint, Offset startPosition,
      double pointerAngle, Paint _borderPaint) {
    canvas.translate(startPosition.dx, startPosition.dy);
    canvas.rotate(_degreeToRadian(pointerAngle - 90));
    final Path path = Path();
    path.moveTo(-markerWidth / 2, 0);
    path.lineTo(0, markerHeight / 2);
    path.lineTo(markerWidth / 2, 0);
    path.lineTo(0, -markerHeight / 2);
    path.lineTo(-markerWidth / 2, 0);
    path.close();
    canvas.drawPath(path, paint);
    if (_borderPaint != null) {
      canvas.drawPath(path, _borderPaint);
    }
  }

  /// Renders the triangle and the inverted triangle
  void _drawTriangle(Canvas canvas, Paint paint, Offset startPosition,
      double pointerAngle, Paint _borderPaint) {
    canvas.translate(startPosition.dx, startPosition.dy);
    final double _triangleAngle = markerType == MarkerType.triangle
        ? pointerAngle + 90
        : pointerAngle - 90;
    canvas.rotate(_degreeToRadian(_triangleAngle));

    final Path path = Path();
    path.moveTo(-markerWidth / 2, markerHeight / 2);
    path.lineTo(markerWidth / 2, markerHeight / 2);
    path.lineTo(0, -markerHeight / 2);
    path.lineTo(-markerWidth / 2, markerHeight / 2);
    path.close();
    canvas.drawPath(path, paint);
    if (_borderPaint != null) {
      canvas.drawPath(path, _borderPaint);
    }
  }
}
