part of gauges;

/// Represents the painter to render axis range
class _RangePainter extends CustomPainter {
  /// Creates the range painter
  _RangePainter(this._gauge, this._axis, this._range, this._isRepaint,
      this._rangeAnimation, ValueNotifier<num> notifier)
      : super(repaint: notifier);

  /// Specifies the circular gauge
  final SfRadialGauge _gauge;

  /// Specifies the gauge axis
  final RadialAxis _axis;

  /// Specifies the needle pointer
  final GaugeRange _range;

  /// Specifies whether to redraw the pointer
  final bool _isRepaint;

  /// Specifies the range animation
  final Animation<double> _rangeAnimation;

  @override
  bool shouldRepaint(_RangePainter oldDelegate) => _isRepaint;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint;
    final Path path = Path();
    if (_range._actualStartValue != _range._actualEndValue) {
      canvas.save();
      canvas.translate(_range._center.dx - _axis._centerX,
          _range._center.dy - _axis._centerY);
      canvas.rotate(_range._rangeStartRadian);

      if (_range._rangeRect == null) {
        path.arcTo(
            _range._outerArc._arcRect,
            _degreeToRadian(_range._outerArc._startAngle),
            _degreeToRadian(_range._outerArcSweepAngle),
            false);
        path.arcTo(
            _range._innerArc._arcRect,
            _degreeToRadian(_range._innerArc._endAngle),
            _degreeToRadian(_range._innerArcSweepAngle),
            false);

        paint = _getRangePaint(true, _range._pathRect, 0);
        canvas.drawPath(path, paint);
      } else {
        paint = _getRangePaint(false, _range._rangeRect, _range._thickness);
        canvas.drawArc(
            _range._rangeRect, 0, _range._rangeEndRadian, false, paint);
      }
      canvas.restore();
    }

    if (_range.label != null) {
      _renderRangeText(canvas);
    }

    if (_gauge.axes[_gauge.axes.length - 1] == _axis &&
        _axis.ranges[_axis.ranges.length - 1] == _range &&
        _rangeAnimation != null &&
        _rangeAnimation.value == 1) {
      _gauge._needsToAnimateRanges = false;
    }
  }

  /// Returns the paint for the range
  Paint _getRangePaint(bool _isFill, Rect _rect, double _strokeWidth) {
    double _opacity = 1;
    if (_rangeAnimation != null) {
      _opacity = _rangeAnimation.value;
    }

    final Paint paint = Paint()
      ..style = _isFill ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = _strokeWidth
      ..color = _range.color ?? _gauge._gaugeTheme.rangeColor;
    final double _actualOpacity = paint.color.opacity;
    paint.color = paint.color.withOpacity(_opacity * _actualOpacity);
    if (_range.gradient != null &&
        _range.gradient.colors != null &&
        _range.gradient.colors.isNotEmpty) {
      List<Color> _colors = _range.gradient.colors;
      if (_axis.isInversed) {
        _colors = _range.gradient.colors.reversed.toList();
      }

      paint.shader = SweepGradient(colors: _colors, stops: _getGradientStops())
          .createShader(_rect);
    }
    return paint;
  }

  /// To calculate the gradient stop based on the sweep angle
  List<double> _getGradientStops() {
    final double _sweepRadian =
        _range._actualStartWidth != _range._actualEndWidth
            ? _range._rangeEndRadian - _range._rangeStartRadian
            : _range._rangeEndRadian;
    double _rangeStartAngle =
        _axis.valueToFactor(_range._actualStartValue) * _axis._sweepAngle +
            _axis.startAngle;
    if (_rangeStartAngle < 0) {
      _rangeStartAngle += 360;
    }

    if (_rangeStartAngle > 360) {
      _rangeStartAngle -= 360;
    }

    final double _sweepAngle = _radianToDegree(_sweepRadian).abs();
    return _calculateGradientStops(
        _getGradientOffset(), _axis.isInversed, _sweepAngle);
  }

  /// Returns the gradient stop of axis line gradient
  List<double> _getGradientOffset() {
    if (_range.gradient.stops != null && _range.gradient.stops.isNotEmpty) {
      return _range.gradient.stops;
    } else {
      final double _difference = 1 / _range.gradient.colors.length;
      final List<double> _offsets = List<double>(_range.gradient.colors.length);
      for (int i = 0; i < _range.gradient.colors.length; i++) {
        _offsets[i] = i * _difference;
      }

      return _offsets;
    }
  }

  /// Renders the range text
  void _renderRangeText(Canvas canvas) {
    double _opacity = 1;
    if (_rangeAnimation != null) {
      _opacity = _rangeAnimation.value;
    }

    final Color _color =
        _range.color != null ? _range.color : _gauge._gaugeTheme.rangeColor;

    final Color _labelColor =
        _range.labelStyle.color ?? _getSaturationColor(_color);
    final double _actualOpacity = _labelColor.opacity;
    final TextSpan span = TextSpan(
        text: _range.label,
        style: TextStyle(
            color: _labelColor.withOpacity(_actualOpacity * _opacity),
            fontSize: _range.labelStyle.fontSize,
            fontFamily: _range.labelStyle.fontFamily,
            fontStyle: _range.labelStyle.fontStyle,
            fontWeight: _range.labelStyle.fontWeight));
    final TextPainter textPainter = TextPainter(
        text: span,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);
    textPainter.layout();
    canvas.save();
    canvas.translate(_range._labelPosition.dx, _range._labelPosition.dy);
    canvas.rotate(_degreeToRadian(_range._labelAngle));
    canvas.scale(-1);
    textPainter.paint(canvas,
        Offset(-_range._labelSize.width / 2, -_range._labelSize.height / 2));
    canvas.restore();
  }
}
