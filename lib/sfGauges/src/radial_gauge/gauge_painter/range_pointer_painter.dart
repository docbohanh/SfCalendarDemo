part of gauges;

/// Represents the painter to render the range pointer
class _RangePointerPainter extends CustomPainter {
  /// Creates the range pointer
  _RangePointerPainter(this._gauge, this._axis, this._rangePointer,
      this._isRepaint, this._pointerAnimation, ValueNotifier<num> notifier)
      : super(repaint: notifier);

  /// Specifies the circular gauge
  final SfRadialGauge _gauge;

  /// Specifies the gauge axis
  final RadialAxis _axis;

  /// Specifies the needle pointer
  final RangePointer _rangePointer;

  /// Specifies whether to redraw the pointer
  final bool _isRepaint;

  /// Specifies the pointer animation
  final Animation<double> _pointerAnimation;

  /// Specifies the gradient color for the range pointer;
  Gradient _gradient;

  /// Holds the color for gradient
  List<Color> _gradientColors;

  /// Specifies whether the painting style is fill
  bool _isFill;

  @override
  void paint(Canvas canvas, Size size) {
    final bool _needsToAnimatePointer = _needsPointerAnimation();
    double _sweepRadian =
        _getPointerSweepRadian(_rangePointer._sweepCornerRadian);
    final double _outerRadius = _axis._radius - _rangePointer._totalOffset;
    final double _innerRadius =
        _outerRadius - _rangePointer._actualRangeThickness;
    final double _cornerRadius = (_innerRadius - _outerRadius).abs() / 2;
    final double _value = (2 *
            math.pi *
            (_innerRadius + _outerRadius) /
            2 *
            _radianToDegree(_rangePointer._sweepCornerRadian) /
            360)
        .abs();
    final Path path = Path();
    if (_rangePointer._currentValue > _axis.minimum) {
      canvas.save();
      canvas.translate(_axis._axisSize.width / 2 - _axis._centerX,
          _axis._axisSize.height / 2 - _axis._centerY);
      canvas.rotate(_degreeToRadian(_rangePointer._startArc));
      final double _curveRadius =
          _rangePointer.cornerStyle != CornerStyle.bothFlat
              ? _rangePointer.cornerStyle == CornerStyle.startCurve
                  ? _cornerRadius
                  : _cornerRadius * 2
              : 0;
      if (_rangePointer.cornerStyle != CornerStyle.bothFlat &&
          (_value.floorToDouble() > _curveRadius)) {
        _isFill = true;
        if (_rangePointer.cornerStyle == CornerStyle.startCurve ||
            _rangePointer.cornerStyle == CornerStyle.bothCurve) {
          if (_needsToAnimatePointer) {
            _drawStartCurve(path, _innerRadius, _outerRadius);
          }
        }

        if (_needsToAnimatePointer) {
          path.addArc(
              Rect.fromCircle(center: const Offset(0, 0), radius: _outerRadius),
              _rangePointer._startCornerRadian,
              _sweepRadian);
        }

        if (_rangePointer.cornerStyle == CornerStyle.endCurve ||
            _rangePointer.cornerStyle == CornerStyle.bothCurve) {
          if (_needsToAnimatePointer) {
            _drawEndCurve(path, _sweepRadian, _innerRadius, _outerRadius);
          }
        }

        if (_needsToAnimatePointer) {
          path.arcTo(
              Rect.fromCircle(center: const Offset(0, 0), radius: _innerRadius),
              _sweepRadian + _rangePointer._startCornerRadian,
              -_sweepRadian,
              false);
        }
      } else {
        _isFill = false;
        _sweepRadian = _rangePointer.cornerStyle == CornerStyle.bothFlat
            ? _sweepRadian
            : _degreeToRadian(_rangePointer._endArc);

        path.addArc(_rangePointer._arcRect, 0, _sweepRadian);
      }

      final Paint paint = _getPointerPaint(_rangePointer._arcRect);
      canvas.drawPath(path, paint);
      canvas.restore();
      _updateAnimation(_sweepRadian);
    }
  }

  /// Draws the start corner style
  void _drawStartCurve(Path path, double _innerRadius, double _outerRadius) {
    final Offset midPoint = _degreeToPoint(
        _axis.isInversed
            ? -_rangePointer._cornerAngle
            : _rangePointer._cornerAngle,
        (_innerRadius + _outerRadius) / 2,
        const Offset(0, 0));
    final double midStartAngle = _degreeToRadian(180);

    double midEndAngle = midStartAngle + _degreeToRadian(180);
    midEndAngle = _axis.isInversed ? -midEndAngle : midEndAngle;
    path.addArc(
        Rect.fromCircle(
            center: midPoint, radius: (_innerRadius - _outerRadius).abs() / 2),
        midStartAngle,
        midEndAngle);
  }

  ///Draws the end corner curve
  void _drawEndCurve(Path path, double _sweepRadian, double _innerRadius,
      double _outerRadius) {
    final double _cornerAngle =
        _rangePointer.cornerStyle == CornerStyle.bothCurve
            ? _rangePointer._cornerAngle
            : 0;
    final double _angle = _axis.isInversed
        ? _radianToDegree(_sweepRadian) - _cornerAngle
        : _radianToDegree(_sweepRadian) + _cornerAngle;
    final Offset midPoint = _degreeToPoint(
        _angle, (_innerRadius + _outerRadius) / 2, const Offset(0, 0));

    final double midStartAngle = _sweepRadian / 2;

    final double midEndAngle = _axis.isInversed
        ? midStartAngle - _degreeToRadian(180)
        : midStartAngle + _degreeToRadian(180);

    path.arcTo(
        Rect.fromCircle(
            center: midPoint, radius: (_innerRadius - _outerRadius).abs() / 2),
        midStartAngle,
        midEndAngle,
        false);
  }

  /// Updates the range pointer animation based on the sweep angle
  void _updateAnimation(double _sweepRadian) {
    final bool _isPointerEndAngle = _isEndAngle(_sweepRadian);

    if (_rangePointer._isPointerAnimationEnabled() && _isPointerEndAngle) {
      _rangePointer._needsAnimate = false;
    }

    if (_gauge._needsToAnimatePointers &&
        _gauge.axes[_gauge.axes.length - 1] == _axis &&
        _axis.pointers[_axis.pointers.length - 1] == _rangePointer &&
        (_isPointerEndAngle || _pointerAnimation.isCompleted)) {
      _gauge._needsToAnimatePointers = false;
    }
  }

  /// Checks whether the current angle is end angle
  bool _isEndAngle(double _sweepRadian) {
    return _sweepRadian == _rangePointer._sweepCornerRadian ||
        (_rangePointer.cornerStyle != CornerStyle.bothFlat &&
            _isFill &&
            _sweepRadian == _degreeToRadian(_rangePointer._endArc));
  }

  /// Returns the sweep radian for pointer
  double _getPointerSweepRadian(double _sweepRadian) {
    if (_gauge._needsToAnimatePointers ||
        _rangePointer._isPointerAnimationEnabled()) {
      return _degreeToRadian(_axis._sweepAngle * _pointerAnimation.value);
    } else {
      return _sweepRadian;
    }
  }

  /// Returns whether to animate the pointers
  bool _needsPointerAnimation() {
    return _pointerAnimation == null ||
        !_rangePointer._needsAnimate ||
        (_pointerAnimation.value.abs() > 0 &&
            (_gauge._needsToAnimatePointers || _rangePointer._needsAnimate));
  }

  /// Returns the paint for the pointer
  Paint _getPointerPaint(Rect _rect) {
    final Paint _paint = Paint()
      ..color = _rangePointer.color ?? _gauge._gaugeTheme.rangePointerColor
      ..strokeWidth = _rangePointer._actualRangeThickness
      ..style = _isFill ? PaintingStyle.fill : PaintingStyle.stroke;
    if (_rangePointer.gradient != null &&
        _rangePointer.gradient.colors != null &&
        _rangePointer.gradient.colors.isNotEmpty) {
      final double _sweepAngle =
          _radianToDegree(_rangePointer._sweepCornerRadian).abs();
      final List<double> _offsets = _getGradientOffsets();
      _gradientColors = _rangePointer.gradient.colors;
      if (_axis.isInversed) {
        _gradientColors = _rangePointer.gradient.colors.reversed.toList();
      }
      _gradient = SweepGradient(
          colors: _gradientColors,
          stops:
              _calculateGradientStops(_offsets, _axis.isInversed, _sweepAngle));
      _paint.shader = _gradient.createShader(_rect);
    }

    return _paint;
  }

  /// Returns the gradient offset
  List<double> _getGradientOffsets() {
    if (_rangePointer.gradient.stops != null &&
        _rangePointer.gradient.stops.isNotEmpty) {
      return _rangePointer.gradient.stops;
    } else {
      final double _difference = 1 / _rangePointer.gradient.colors.length;
      final List<double> _offsets =
          List<double>(_rangePointer.gradient.colors.length);
      for (int i = 0; i < _rangePointer.gradient.colors.length; i++) {
        _offsets[i] = i * _difference;
      }

      return _offsets;
    }
  }

  @override
  bool shouldRepaint(_RangePointerPainter oldDelegate) => _isRepaint;
}
