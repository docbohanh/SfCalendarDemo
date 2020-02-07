part of gauges;

/// Custom painter to paint gauge axis
class _AxisPainter extends CustomPainter {
  _AxisPainter(
      this._gauge,
      this._axis,
      this._isRepaint,
      ValueNotifier<num> notifier,
      this._axisLineAnimation,
      this._axisElementsAnimation)
      : super(repaint: notifier);

  /// Specifies the circular gauge
  final SfRadialGauge _gauge;

  /// Specifies whether to repaint the series
  final bool _isRepaint;

  /// Specifies the axis of the painter
  final RadialAxis _axis;

  /// Specifies the animation for axis line
  final Animation<double> _axisLineAnimation;

  /// Specifies the animation for axis elements
  final Animation<double> _axisElementsAnimation;

  /// Holds the gradient color for axis line
  SweepGradient _gradient;

  /// Specifies whether the dash array is enabled for axis
  bool _isDashedAxisLine;

  // Specifies whether the style of paint is fill
  bool _isFill;

  @override
  void paint(Canvas canvas, Size size) {
    if (_axis.backgroundImage != null &&
        _axis._backgroundImageInfo?.image != null) {
      final double _radius =
          math.min(_axis._axisSize.width, _axis._axisSize.height) / 2;
      final Rect _rect = Rect.fromLTRB(
        _axis._axisSize.width / 2 - _radius - _axis._centerX,
        _axis._axisSize.height / 2 - _radius - _axis._centerY,
        _axis._axisSize.width / 2 + _radius - _axis._centerX,
        _axis._axisSize.height / 2 + _radius - _axis._centerY,
      );

      paintImage(
        canvas: canvas,
        rect: _rect,
        scale: _axis._backgroundImageInfo.scale ?? 1,
        image: _axis._backgroundImageInfo.image,
        fit: BoxFit.fill,
      );
    }

    if (_axis.showAxisLine && _axis._actualAxisWidth > 0) {
      _drawAxisLine(canvas);
    }

    if (_axis.showTicks) {
      _drawMajorTicks(canvas);
      _drawMinorTicks(canvas);
    }

    if (_axis.showLabels) {
      _drawAxisLabels(canvas);
    }

    if (_gauge.axes[_gauge.axes.length - 1] == _axis &&
        _gauge._needsToAnimateAxes &&
        _hasAxisLineAnimation() &&
        _hasAxisElementsAnimation()) {
      _gauge._needsToAnimateAxes = false;
    }
  }

  /// Checks whether the show axis line is enabled
  bool _hasAxisLineAnimation() {
    return (_axisLineAnimation != null && _axisLineAnimation.value == 1) ||
        _axisLineAnimation == null;
  }

  /// Checks whether the labels and the ticks are enabled
  bool _hasAxisElementsAnimation() {
    return (_axisElementsAnimation != null &&
            _axisElementsAnimation.value == 1) ||
        _axisElementsAnimation == null;
  }

  /// Method to draw the axis line
  void _drawAxisLine(Canvas canvas) {
    _isDashedAxisLine = _isDashedLine();
    if (_axis.axisLineStyle.gradient != null &&
        _axis.axisLineStyle.gradient.colors != null &&
        _axis.axisLineStyle.gradient.colors.isNotEmpty) {
      _gradient = SweepGradient(
          stops: _calculateGradientStops(
              _getGradientOffset(), _axis.isInversed, _axis._sweepAngle),
          colors: _axis.isInversed
              ? _axis.axisLineStyle.gradient.colors.reversed.toList()
              : _axis.axisLineStyle.gradient.colors);
    }
    if (_axis.axisLineStyle.cornerStyle == CornerStyle.bothFlat ||
        _isDashedAxisLine) {
      _drawAxisPath(canvas, _axis._startRadian, _axis._endRadian);
    } else {
      _drawAxisPath(
        canvas,
        _axis._startCornerRadian,
        _axis._sweepCornerRadian,
      );
    }
  }

  /// Returns the gradient stop of axis line gradient
  List<double> _getGradientOffset() {
    if (_axis.axisLineStyle.gradient.stops != null &&
        _axis.axisLineStyle.gradient.stops.isNotEmpty) {
      return _axis.axisLineStyle.gradient.stops;
    } else {
      final double _difference = 1 / _axis.axisLineStyle.gradient.colors.length;
      final List<double> _offsets =
          List<double>(_axis.axisLineStyle.gradient.colors.length);
      for (int i = 0; i < _axis.axisLineStyle.gradient.colors.length; i++) {
        _offsets[i] = i * _difference;
      }

      return _offsets;
    }
  }

  /// Method to draw axis line
  void _drawAxisPath(Canvas canvas, double _startRadian, double _endRadian) {
    if (_axisLineAnimation != null) {
      _endRadian = _endRadian * _axisLineAnimation.value;
    }

    canvas.save();
    canvas.translate(_axis._axisSize.width / 2 - _axis._centerX,
        _axis._axisSize.height / 2 - _axis._centerY);
    canvas.rotate(_axis.isInversed
        ? _degreeToRadian(_axis.startAngle + _axis._sweepAngle)
        : _degreeToRadian(_axis.startAngle));

    Path path = Path();
    if (_axis.axisLineStyle.cornerStyle != CornerStyle.bothFlat) {
      if (_isDashedAxisLine) {
        path = _getPath(_endRadian);
      } else {
        _isFill = true;
        final double _outerRadius = _axis._radius - _axis._axisOffset;
        final double _innerRadius = _outerRadius - _axis._actualAxisWidth;

        if (_axis.axisLineStyle.cornerStyle == CornerStyle.startCurve ||
            _axis.axisLineStyle.cornerStyle == CornerStyle.bothCurve) {
          _drawStartCurve(path, _endRadian, _innerRadius, _outerRadius);
        }

        path.addArc(
            Rect.fromCircle(center: const Offset(0, 0), radius: _outerRadius),
            _axis._startCornerRadian,
            _endRadian);

        if (_axis.axisLineStyle.cornerStyle == CornerStyle.endCurve ||
            _axis.axisLineStyle.cornerStyle == CornerStyle.bothCurve) {
          _drawEndCurve(path, _endRadian, _innerRadius, _outerRadius);
        }
        path.arcTo(
            Rect.fromCircle(center: const Offset(0, 0), radius: _innerRadius),
            _endRadian + _axis._startCornerRadian,
            -_endRadian,
            false);
      }
    } else {
      path = _getPath(_endRadian);
    }

    final Paint _paint = _getPaint();
    if (!_isDashedAxisLine) {
      canvas.drawPath(path, _paint);
    } else {
      canvas.drawPath(
          _dashPath(path,
              dashArray:
                  _CircularIntervalList<double>(_axis.axisLineStyle.dashArray)),
          _paint);
    }

    canvas.restore();
  }

  /// Returns the axis path
  Path _getPath(double _endRadian) {
    final Path _path = Path();
    _isFill = false;
    if (_axis.isInversed) {
      _endRadian = _endRadian * -1;
    }

    _path.addArc(_axis._axisRect, 0, _endRadian);
    return _path;
  }

  Paint _getPaint() {
    final Paint _paint = Paint()
      ..color = _axis.axisLineStyle.color ?? _gauge._gaugeTheme.axisLineColor
      ..style = !_isFill ? PaintingStyle.stroke : PaintingStyle.fill
      ..strokeWidth = _axis._actualAxisWidth;
    if (_gradient != null) {
      _paint.shader = _gradient.createShader(_axis._axisRect);
    }

    return _paint;
  }

  /// Draws the start corner style
  void _drawStartCurve(
      Path path, double _endRadian, double _innerRadius, double _outerRadius) {
    final Offset midPoint = _degreeToPoint(
        _axis.isInversed ? -_axis._cornerAngle : _axis._cornerAngle,
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
        _axis.axisLineStyle.cornerStyle == CornerStyle.bothCurve
            ? _axis._cornerAngle
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

  /// Checks whether the axis line is dashed line
  bool _isDashedLine() {
    return _axis.axisLineStyle.dashArray != null &&
        _axis.axisLineStyle.dashArray.isNotEmpty &&
        _axis.axisLineStyle.dashArray.length > 1 &&
        _axis.axisLineStyle.dashArray[0] > 0 &&
        _axis.axisLineStyle.dashArray[1] > 0;
  }

  /// Method to draw the major ticks
  void _drawMajorTicks(Canvas canvas) {
    double _length = _axis._majorTickOffsets.length.toDouble();
    if (_axisElementsAnimation != null) {
      _length = _axis._majorTickOffsets.length * _axisElementsAnimation.value;
    }

    if (_axis._actualMajorTickLength > 0 &&
        _axis.majorTickStyle.thickness != null &&
        _axis.majorTickStyle.thickness > 0) {
      final Paint _tickPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = _axis.majorTickStyle.thickness;
      for (num i = 0; i < _length; i++) {
        final _TickOffset _tickOffset = _axis._majorTickOffsets[i];
        if (!(i == 0 && _axis._sweepAngle == 360)) {
          _tickPaint.color = _axis.useRangeColorForAxis
              ? _axis._getRangeColor(_tickOffset.value) ??
                  _axis.majorTickStyle.color ??
                  _gauge._gaugeTheme.majorTickColor
              : _axis.majorTickStyle.color ?? _gauge._gaugeTheme.majorTickColor;

          if (_axis.majorTickStyle.dashArray != null &&
              _axis.majorTickStyle.dashArray.isNotEmpty) {
            final Path path = Path()
              ..moveTo(_tickOffset.startPoint.dx, _tickOffset.startPoint.dy)
              ..lineTo(_tickOffset.endPoint.dx, _tickOffset.endPoint.dy);
            canvas.drawPath(
                _dashPath(path,
                    dashArray: _CircularIntervalList<double>(
                        _axis.majorTickStyle.dashArray)),
                _tickPaint);
          } else {
            if ((i == _axis._majorTickOffsets.length - 1) &&
                _axis._sweepAngle == 360) {
              final double _x1 = (_axis._majorTickOffsets[0].startPoint.dx +
                      _axis._majorTickOffsets[i].startPoint.dx) /
                  2;
              final double _y1 = (_axis._majorTickOffsets[0].startPoint.dy +
                      _axis._majorTickOffsets[i].startPoint.dy) /
                  2;
              final double _x2 = (_axis._majorTickOffsets[0].endPoint.dx +
                      _axis._majorTickOffsets[i].endPoint.dx) /
                  2;
              final double _y2 = (_axis._majorTickOffsets[0].endPoint.dy +
                      _axis._majorTickOffsets[i].endPoint.dy) /
                  2;
              canvas.drawLine(Offset(_x1, _y1), Offset(_x2, _y2), _tickPaint);
            } else {
              canvas.drawLine(
                  _tickOffset.startPoint, _tickOffset.endPoint, _tickPaint);
            }
          }
        }
      }
    }
  }

  /// Method to draw the mior ticks
  void _drawMinorTicks(Canvas canvas) {
    double _length = _axis._minorTickOffsets.length.toDouble();
    if (_axisElementsAnimation != null) {
      _length = _axis._minorTickOffsets.length * _axisElementsAnimation.value;
    }
    if (_axis._actualMinorTickLength > 0 &&
        _axis.minorTickStyle.thickness != null &&
        _axis.minorTickStyle.thickness > 0) {
      final Paint _tickPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = _axis.minorTickStyle.thickness;
      for (int i = 0; i < _length; i++) {
        final _TickOffset _tickOffset = _axis._minorTickOffsets[i];
        _tickPaint.color = _axis.useRangeColorForAxis
            ? _axis._getRangeColor(_tickOffset.value) ??
                _axis.minorTickStyle.color ??
                _gauge._gaugeTheme.minorTickColor
            : _axis.minorTickStyle.color ?? _gauge._gaugeTheme.minorTickColor;
        if (_axis.minorTickStyle.dashArray != null &&
            _axis.minorTickStyle.dashArray.isNotEmpty) {
          final Path path = Path()
            ..moveTo(_tickOffset.startPoint.dx, _tickOffset.startPoint.dy)
            ..lineTo(_tickOffset.endPoint.dx, _tickOffset.endPoint.dy);
          canvas.drawPath(
              _dashPath(path,
                  dashArray: _CircularIntervalList<double>(
                      _axis.minorTickStyle.dashArray)),
              _tickPaint);
        } else {
          canvas.drawLine(
              _tickOffset.startPoint, _tickOffset.endPoint, _tickPaint);
        }
      }
    }
  }

  /// Method to draw the axis labels
  void _drawAxisLabels(Canvas canvas) {
    double _length = _axis._axisLabels.length.toDouble();
    if (_axisElementsAnimation != null) {
      _length = _axis._axisLabels.length * _axisElementsAnimation.value;
    }
    for (int i = 0; i < _length; i++) {
      if (!((i == 0 && !_axis.showFirstLabel) ||
          (i == _axis._axisLabels.length - 1 && !_axis.showLastLabel))) {
        final CircularAxisLabel label = _axis._axisLabels[i];
        final Color _labelColor =
            label.labelStyle.color ?? _gauge._gaugeTheme.axisLabelColor;
        final TextSpan span = TextSpan(
            text: label.text,
            style: TextStyle(
                color: _axis.ranges != null &&
                        _axis.ranges.isNotEmpty &&
                        _axis.useRangeColorForAxis
                    ? _axis._getRangeColor(label.value) ?? _labelColor
                    : _labelColor,
                fontSize: label.labelStyle.fontSize,
                fontFamily: label.labelStyle.fontFamily,
                fontStyle: label.labelStyle.fontStyle,
                fontWeight: label.labelStyle.fontWeight));

        final TextPainter textPainter = TextPainter(
            text: span,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.center);
        textPainter.layout();

        if (_axis.needsRotateLabels || label._needsRotateLabel) {
          canvas.save();
          canvas.translate(label.position.dx, label.position.dy);
          canvas.rotate(_degreeToRadian(label.angle));
          canvas.scale(-1);
          textPainter.paint(canvas,
              Offset(-label.labelSize.width / 2, -label.labelSize.height / 2));
          canvas.restore();
        } else {
          textPainter.paint(
              canvas,
              Offset(label.position.dx - label.labelSize.width / 2,
                  label.position.dy - label.labelSize.height / 2));
        }
      }
    }
  }

  @override
  bool shouldRepaint(_AxisPainter oldDelegate) => _isRepaint;
}
