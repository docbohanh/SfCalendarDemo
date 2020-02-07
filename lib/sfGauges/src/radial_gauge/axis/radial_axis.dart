part of gauges;

/// Renders the radial axis in radial gauge.
///
/// ```dart
/// Widget build(BuildContext context) {
///    return Container(
///        child: SfRadialGauge(
///          axes:<RadialAxis>[RadialAxis(
///            )]
///        ));
///}
/// ```
class RadialAxis extends GaugeAxis {
  RadialAxis(
      {this.startAngle = 130,
      this.endAngle = 50,
      this.radiusFactor = 0.95,
      this.centerX = 0.5,
      this.onLabelCreated,
      this.onAxisTapped,
      this.needsRotateLabels = false,
      this.centerY = 0.5,
      this.showFirstLabel = true,
      this.showLastLabel = true,
      List<GaugeRange> ranges,
      List<GaugePointer> pointers,
      List<GaugeAnnotation> annotations,
      GaugeTextStyle axisLabelStyle,
      AxisLineStyle axisLineStyle,
      MajorTickStyle majorTickStyle,
      MinorTickStyle minorTickStyle,
      this.backgroundImage,
      double minimum = 0,
      double maximum = 100,
      double interval,
      double minorTicksPerInterval,
      bool showLabels,
      bool showAxisLine,
      bool showTicks,
      double tickOffset = 0,
      double labelOffset = 15,
      bool isInversed,
      GaugeSizeUnit offsetUnit,
      num maximumLabels = 3,
      bool useRangeColorForAxis,
      String labelFormat,
      NumberFormat numberFormat,
      ElementsPosition ticksPosition,
      ElementsPosition labelsPosition})
      : assert(minimum != null),
        assert(maximum != null),
        assert(startAngle != null),
        assert(endAngle != null),
        assert(radiusFactor != null),
        assert(centerX != null),
        assert(centerY != null),
        assert(radiusFactor >= 0),
        assert(centerX >= 0),
        assert(centerY >= 0),
        assert(minimum < maximum),
        assert(tickOffset != null),
        assert(labelOffset != null),
        super(
            ranges: ranges,
            annotations: annotations,
            pointers: pointers,
            minimum: minimum,
            maximum: maximum,
            interval: interval,
            minorTicksPerInterval: minorTicksPerInterval ?? 1,
            showLabels: showLabels ?? true,
            showAxisLine: showAxisLine ?? true,
            showTicks: showTicks ?? true,
            tickOffset: tickOffset,
            labelOffset: labelOffset,
            isInversed: isInversed ?? false,
            maximumLabels: maximumLabels,
            useRangeColorForAxis: useRangeColorForAxis ?? false,
            labelFormat: labelFormat,
            offsetUnit: offsetUnit ?? GaugeSizeUnit.logicalPixel,
            numberFormat: numberFormat,
            ticksPosition: ticksPosition ?? ElementsPosition.inside,
            labelsPosition: labelsPosition ?? ElementsPosition.inside,
            axisLabelStyle: axisLabelStyle ??
                GaugeTextStyle(
                    fontSize: 12.0,
                    fontFamily: 'Segoe UI',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.normal),
            axisLineStyle: axisLineStyle ??
                AxisLineStyle(
                  thickness: 10,
                ),
            majorTickStyle: majorTickStyle ?? MajorTickStyle(),
            minorTickStyle: minorTickStyle ?? MinorTickStyle()) {
    _needsRepaintAxis = true;
  }

  /// Specifies the start angle of axis.
  ///
  /// Defaults to 130
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///           startAngle: 90,
  ///            )]
  ///        ));
  ///}
  /// ```
  final double startAngle;

  /// Specifies the end angle of axis
  ///
  /// Defaults to 50
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///           endAngle: 90,
  ///            )]
  ///        ));
  ///}
  /// ```
  final double endAngle;

  /// Radius of the radial gauge. This value ranges from 0 to 1.
  ///
  /// Defaults to 0.95
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///           radiusFactor: 0.8,
  ///            )]
  ///        ));
  ///}
  /// ```
  final double radiusFactor;

  /// Center X value for placing the axis in radial gauge. This value ranges from 0 to 1.
  ///
  /// Defaults to 0.5
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///           centerX: 0.2,
  ///            )]
  ///        ));
  ///}
  /// ```
  final double centerX;

  /// Center Y value for placing the axis in radial gauge. This value ranges from 0 to 1.
  ///
  /// Defaults to 0.5
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///           centerY: 0.2,
  ///            )]
  ///        ));
  ///}
  /// ```
  final double centerY;

  /// Shows or hides the first label of axis.
  ///
  /// Defaults to true
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///           showFirstLabel: false,
  ///            )]
  ///        ));
  ///}
  /// ```
  final bool showFirstLabel;

  /// Shows or hides the last label of axis.
  ///
  /// Defaults to true
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///           showLastLabel: false,
  ///            )]
  ///        ));
  ///}
  /// ```
  final bool showLastLabel;

  /// Called when an axis label is created.
  ///
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///           labelCreated: _axisLabelCreated,
  ///            )]
  ///        ));
  ///}
  ///
  ///   void _axisLabelCreated(AxisLabelCreatedArgs args){
  //    if(args.text == '100'){
  //      args.text = 'Completed';
  //      args.canRotate = true;
  //    }
  //  }
  /// ```
  final ValueChanged<AxisLabelCreatedArgs> onLabelCreated;

  /// Called when an axis is tapped.
  ///
  /// ``` dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///           axisTapped: _axisTapped,
  ///            )]
  ///        ));
  ///}
  ///
  ///  void _axisTapped(double value){
  //    final double value = value;
  //  }
  /// ```
  final ValueChanged<double> onAxisTapped;

  /// Specifies whether to rotate the labels.
  ///
  /// Defaults to false
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///           needsRotateLabels: true,
  ///            )]
  ///        ));
  ///}
  /// ```
  final bool needsRotateLabels;

  /// Specifies the background image for axis.
  ///
  /// Defaults to null.
  ///```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///           backgroundImage: AssetImage('images/dark_background.png')
  ///            )]
  ///        ));
  ///}
  ///```
  final ImageProvider backgroundImage;

  ///Specifies the axis rect
  Rect _axisRect;

  /// Specifies the start radian value
  double _startRadian;

  /// Specifies the end radian value
  double _endRadian;

  ///Specifies the radius value
  double _radius;

  ///Specifies the axis center
  double _center;

  ///Specifies the center X value of axis
  double _centerX;

  ///Specifies the center Y value od axis
  double _centerY;

  /// Specifies the actual axis width
  double _actualAxisWidth;

  ///Specifies the circular gauge
  SfRadialGauge _gauge;

  /// Specifies the list of axis labels
  List<CircularAxisLabel> _axisLabels;

  /// Specifies the offset value of major ticks
  List<_TickOffset> _majorTickOffsets;

  /// Specifies the offset value of minor ticks
  List<_TickOffset> _minorTickOffsets;

  /// Specifies the major tick count
  num _majorTicksCount;

  ///Holds the sweep angle of the axis
  double _sweepAngle;

  /// Holds the size of the axis
  Size _axisSize;

  /// Holds the length of major tick based on coordinate unit
  double _actualMajorTickLength;

  /// Holds the length of minor tick based on coordinate unit
  double _actualMinorTickLength;

  /// Specifies the maximum label size
  Size _maximumLabelSize;

  /// Specifies whether the ticks are placed outside
  bool _isTicksOutside;

  /// Specifies whether the labels are placed outside
  bool _isLabelsOutside;

  /// Specifies the maximum length of tick by comparing major and minor tick
  double _maximumTickLength;

  /// Specifies whether to repaint the axis;
  bool _needsRepaintAxis;

  /// Specifies the axis path
  Path _axisPath;

  /// Specifies the axis feature offset value
  double _axisFeatureOffset;

  /// Specifies the axis offset
  double _axisOffset;

  /// Specifies the start corner radian
  double _startCornerRadian;

  /// Specifies the sweep corner radian
  double _sweepCornerRadian;

  /// Specifies the actual label offset
  double _actualLabelOffset;

  /// Specifies the actual tick offset
  double _actualTickOffset;

  /// Specifies the corner angle
  double _cornerAngle;

  /// Specifies whether to include axis elements when calculating the radius
  final bool _useAxisElementsInsideRadius = true;

  /// Specifies the build context
  BuildContext _context;

  /// Specifies the listener
  ImageStreamListener _listener;

  /// Specifies the background image info;
  ImageInfo _backgroundImageInfo;

  /// Specifies the image stream
  ImageStream _imageStream;

  /// Calculates the default values of the axis
  void _calculateDefaultValues() {
    _startRadian = _degreeToRadian(startAngle);
    _sweepAngle = _calculateSweepAngle();
    _endRadian = _degreeToRadian(_sweepAngle);
    _center = math.min(_axisSize.width / 2, _axisSize.height / 2);
    _radius = _center * radiusFactor;
    _centerX = (_axisSize.width / 2) - (centerX * _axisSize.width);
    _centerY = (_axisSize.height / 2) - (centerY * _axisSize.height);
    _actualAxisWidth = _calculateActualValue(
        axisLineStyle.thickness, axisLineStyle.thicknessUnit, false);
    _actualMajorTickLength = _calculateTickLength(true);
    _actualMinorTickLength = _calculateTickLength(false);
    _maximumTickLength = _actualMajorTickLength > _actualMinorTickLength
        ? _actualMajorTickLength
        : _actualMinorTickLength;
    _actualLabelOffset = _calculateActualValue(labelOffset, offsetUnit, true);
    _actualTickOffset = _calculateActualValue(tickOffset, offsetUnit, true);
    if (backgroundImage != null) {
      _listener = ImageStreamListener(_updateBackgroundImage);
    }
  }

  /// Method to calculate the axis range
  void _calculateAxisRange(BoxConstraints constraints) {
    _axisSize = Size(constraints.maxWidth, constraints.maxHeight);
    _calculateAxisElementsPosition();
    if (pointers != null && pointers.isNotEmpty) {
      _renderPointers();
    }

    if (ranges != null && ranges.isNotEmpty) {
      _renderRanges();
    }

    if (annotations != null && annotations.isNotEmpty) {
      _addGaugeAnnotation();
    }
  }

  /// Method to add the annotation
  void _addGaugeAnnotation() {
    if (annotations.isNotEmpty) {
      for (num i = 0; i < annotations.length; i++) {
        annotations[i]._axis = this;
        annotations[i]._calculatePosition();
      }
    }
  }

  /// Methods to calculate axis elements position
  void _calculateAxisElementsPosition() {
    _isTicksOutside = ticksPosition == ElementsPosition.outside;
    _isLabelsOutside = labelsPosition == ElementsPosition.outside;
    _calculateDefaultValues();
    _axisLabels = generateVisibleLabels();
    _calculateAxisFeatureOffset();
    if (showLabels) {
      _measureAxisLabels();
    }

    _axisOffset = _useAxisElementsInsideRadius ? _calculateAxisOffset() : 0;

    if (showTicks) {
      _calculateMajorTicksPosition();
      _calculateMinorTickPosition();
    }

    if (showLabels) {
      _calculateAxisLabelsPosition();
    }

    _calculateAxisRect();
    if (showAxisLine) {
      _calculateCornerStylePosition();
    }

    if (backgroundImage != null && _backgroundImageInfo?.image == null) {
      _loadBackgroundImage();
    }
  }

  /// Calculates the rounded corner position
  void _calculateCornerStylePosition() {
    final double _cornerCenter = (_axisRect.right - _axisRect.left) / 2;
    _cornerAngle = _cornerRadiusAngle(_cornerCenter, _actualAxisWidth / 2);

    switch (axisLineStyle.cornerStyle) {
      case CornerStyle.startCurve:
        {
          _startCornerRadian = isInversed
              ? _degreeToRadian(-_cornerAngle)
              : _degreeToRadian(_cornerAngle);
          _sweepCornerRadian = isInversed
              ? _degreeToRadian((-_sweepAngle) + _cornerAngle)
              : _degreeToRadian(_sweepAngle - _cornerAngle);
        }
        break;
      case CornerStyle.endCurve:
        {
          _startCornerRadian = _degreeToRadian(0);
          _sweepCornerRadian = isInversed
              ? _degreeToRadian((-_sweepAngle) + _cornerAngle)
              : _degreeToRadian(_sweepAngle - _cornerAngle);
        }
        break;
      case CornerStyle.bothCurve:
        {
          _startCornerRadian = isInversed
              ? _degreeToRadian(-_cornerAngle)
              : _degreeToRadian(_cornerAngle);
          _sweepCornerRadian = isInversed
              ? _degreeToRadian((-_sweepAngle) + (2 * _cornerAngle))
              : _degreeToRadian(_sweepAngle - (2 * _cornerAngle));
        }
        break;
      case CornerStyle.bothFlat:
        _startCornerRadian = !isInversed
            ? _degreeToRadian(0)
            : _degreeToRadian(startAngle + _sweepAngle);
        final double _value = isInversed ? -1 : 1;
        _sweepCornerRadian = _degreeToRadian(_sweepAngle * _value);
        break;
    }
  }

  /// Calculates the axis rect
  void _calculateAxisRect() {
    _axisOffset =
        _axisOffset > _axisFeatureOffset ? _axisOffset : _axisFeatureOffset;
    _axisRect = Rect.fromLTRB(
        -(_radius - (_actualAxisWidth / 2 + _axisOffset)),
        -(_radius - (_actualAxisWidth / 2 + _axisOffset)),
        _radius - (_actualAxisWidth / 2 + _axisOffset),
        _radius - (_actualAxisWidth / 2 + _axisOffset));
    _axisPath = Path();
    final Rect _rect = Rect.fromLTRB(
      _axisRect.left + _axisSize.width / 2,
      _axisRect.top + _axisSize.height / 2,
      _axisRect.right + _axisSize.width / 2,
      _axisRect.bottom + _axisSize.height / 2,
    );
    _axisPath.arcTo(_rect, _startRadian, _endRadian, false);
  }

  /// Method to calculate the angle from the tapped point
  void _getAngleFromOffset(Offset _offset) {
    final double _centerX = _axisSize.width * centerX;
    final double _centerY = _axisSize.height * centerY;
    double _angle = math.atan2(_offset.dy - _centerY, _offset.dx - _centerX) *
            (180 / math.pi) +
        360;
    final double _endAngle = startAngle + _sweepAngle;
    if (_angle < 360 && _angle > 180) {
      _angle += 360;
    }

    if (_angle > _endAngle) {
      _angle %= 360;
    }

    if (_angle >= startAngle && _angle <= _endAngle) {
      final double _angleFactor = (_angle - startAngle) / _sweepAngle;
      final double _value = factorToValue(_angleFactor);
      if (_value >= minimum && _value <= maximum) {
        final double _tappedValue = _angleToValue(_angle);
        onAxisTapped(_tappedValue);
      }
    }
  }

  /// To calculate the offset based on pointers and range
  double _calculateAxisFeatureOffset() {
    _axisFeatureOffset = 0;
    if (pointers != null && pointers.isNotEmpty) {
      for (num i = 0; i < pointers.length; i++) {
        if (pointers[i] is MarkerPointer) {
          final MarkerPointer _markerPointer = pointers[i];
          if (_markerPointer.markerOffset != null &&
              _markerPointer.markerOffset < 0 &&
              _axisFeatureOffset > _markerPointer.markerOffset) {
            _axisFeatureOffset = _markerPointer.markerOffset;
          }
        } else if (pointers[i] is RangePointer) {
          final RangePointer _rangePointer = pointers[i];
          if (_rangePointer.pointerOffset != null &&
              _rangePointer.pointerOffset < 0 &&
              _axisFeatureOffset > _rangePointer.pointerOffset) {
            _axisFeatureOffset = _rangePointer.pointerOffset;
          }
        }
      }
    }

    if (ranges != null && ranges.isNotEmpty) {
      for (num i = 0; i < ranges.length; i++) {
        if (ranges[i].rangeOffset != null &&
            ranges[i].rangeOffset < 0 &&
            _axisFeatureOffset > ranges[i].rangeOffset) {
          _axisFeatureOffset = ranges[i].rangeOffset;
        }
      }
    }

    _axisFeatureOffset = _axisFeatureOffset.abs();
    return _axisFeatureOffset;
  }

  /// Calculate the offset for axis line based on ticks and labels
  double _calculateAxisOffset() {
    double _offset = 0;
    _offset = _isTicksOutside
        ? showTicks ? (_maximumTickLength + _actualTickOffset) : 0
        : 0;
    _offset += _isLabelsOutside
        ? showLabels
            ? (math.max(_maximumLabelSize.height, _maximumLabelSize.width) / 2 +
                _actualLabelOffset)
            : 0
        : 0;
    return _offset;
  }

  /// Converts the axis value to angle
  double _valueToAngle(double _value) {
    double _angle = 0;
    _value = _minMax(_value, minimum, maximum);
    if (!isInversed) {
      _angle =
          (_sweepAngle / (maximum - minimum).abs()) * (minimum - _value).abs();
    } else {
      _angle = _sweepAngle -
          ((_sweepAngle / (maximum - minimum).abs()) *
              (minimum - _value).abs());
    }

    return _angle;
  }

  /// Converts the angle to corresponding axis value
  double _angleToValue(double _angle) {
    double _value = 0;
    if (!isInversed) {
      _value = (_angle -
              startAngle +
              ((_sweepAngle / (maximum - minimum)) * minimum)) *
          ((maximum - minimum) / _sweepAngle);
    } else {
      _value = -(_angle -
              startAngle -
              _sweepAngle +
              ((_sweepAngle / (maximum - minimum)) * minimum.abs())) *
          ((maximum - minimum) / _sweepAngle);
    }

    return _value;
  }

  /// Calculates the major ticks position
  void _calculateMajorTicksPosition() {
    if (_axisLabels != null && _axisLabels.isNotEmpty) {
      _majorTicksCount = _axisLabels.length;
      final double _angularSpaceForTicks =
          _degreeToRadian(_sweepAngle / (_majorTicksCount - 1));
      double _angleForTicks = 0;
      final double _axisLineWidth = showAxisLine ? _actualAxisWidth : 0;
      double _tickStartOffset = 0;
      double _tickEndOffset = 0;
      _majorTickOffsets = <_TickOffset>[];
      _angleForTicks = _degreeToRadian(startAngle - 90);
      final double _offset = _isLabelsOutside
          ? showLabels
              ? (math.max(_maximumLabelSize.height, _maximumLabelSize.width) /
                      2 +
                  _actualLabelOffset)
              : 0
          : 0;
      if (!_isTicksOutside) {
        _tickStartOffset = _radius -
            (_axisLineWidth + _actualTickOffset + _offset + _axisFeatureOffset);
        _tickEndOffset = _radius -
            (_axisLineWidth +
                _actualMajorTickLength +
                _actualTickOffset +
                _offset +
                _axisFeatureOffset);
      } else {
        final bool _isGreater = _actualMajorTickLength > _actualMinorTickLength;
        if (!_useAxisElementsInsideRadius) {
          _tickStartOffset = _radius + _actualTickOffset - _axisFeatureOffset;
          _tickEndOffset = _radius +
              _actualMajorTickLength +
              _actualTickOffset -
              _axisFeatureOffset;
        } else {
          if (_axisOffset < _axisFeatureOffset) {
            final double _diff = _axisFeatureOffset - _axisOffset;
            _tickEndOffset = _radius - (_diff + _offset + _maximumTickLength);

            _tickStartOffset = _isGreater
                ? _radius - (_diff + _offset)
                : _radius -
                    (_maximumTickLength - _actualMajorTickLength) -
                    (_diff + _offset);
          } else {
            _tickStartOffset = _isGreater
                ? _radius - _offset
                : _radius -
                    (_maximumTickLength - _actualMajorTickLength + _offset);
            _tickEndOffset = _radius - (_offset + _maximumTickLength);
          }
        }
      }

      _calculateOffsetForMajorTicks(_tickStartOffset, _tickEndOffset,
          _angularSpaceForTicks, _angleForTicks);
    }
  }

  /// Calculates the offset for major ticks
  void _calculateOffsetForMajorTicks(
      double _tickStartOffset,
      double _tickEndOffset,
      double _angularSpaceForTicks,
      double _angleForTicks) {
    for (num i = 0; i < _majorTicksCount; i++) {
      double _tickAngle = 0;
      if (i == 0 || i == _majorTicksCount - 1) {
        _tickAngle =
            _adjustTickPositionInCorner(i, _angleForTicks, _tickStartOffset);
      } else {
        _tickAngle = _angleForTicks;
      }
      final List<Offset> _tickPosition =
          _getTickPosition(_tickStartOffset, _tickEndOffset, _tickAngle);
      final _TickOffset _tickOffset = _TickOffset();
      _tickOffset.startPoint = _tickPosition[0];
      _tickOffset.endPoint = _tickPosition[1];
      _tickOffset.value = factorToValue(
          (_radianToDegree(_tickAngle) + 90 - startAngle) / _sweepAngle);
      _tickOffset.startPoint = Offset(_tickOffset.startPoint.dx - _centerX,
          _tickOffset.startPoint.dy - _centerY);
      _tickOffset.endPoint = Offset(_tickOffset.endPoint.dx - _centerX,
          _tickOffset.endPoint.dy - _centerY);
      _majorTickOffsets.add(_tickOffset);
      _angleForTicks += _angularSpaceForTicks;
    }

    _majorTickOffsets =
        isInversed ? _majorTickOffsets.reversed.toList() : _majorTickOffsets;
  }

  /// Returns the corresponding range color for the value
  Color _getRangeColor(double _value) {
    Color _color;
    if (ranges != null && ranges.isNotEmpty) {
      for (num i = 0; i < ranges.length; i++) {
        if (ranges[i].startValue <= _value && ranges[i].endValue >= _value) {
          _color = ranges[i].color ?? _gauge._gaugeTheme.rangeColor;
          break;
        }
      }
    }
    return _color;
  }

  /// Calculates the angle to adjust the start and end tick
  double _adjustTickPositionInCorner(
      num _num, double _angleForTicks, double _startOffset) {
    final double _angle = _cornerRadiusAngle(
        _startOffset + _actualAxisWidth / 2, majorTickStyle.thickness / 2);
    final double _ticksAngle = _num == 0
        ? _radianToDegree(_angleForTicks) + _angle
        : _radianToDegree(_angleForTicks) - _angle;
    return _degreeToRadian(_ticksAngle);
  }

  /// Calculates the minor tick position
  void _calculateMinorTickPosition() {
    if (_axisLabels != null && _axisLabels.isNotEmpty) {
      final double _axisLineWidth = showAxisLine ? _actualAxisWidth : 0;
      double _tickStartOffset = 0;
      double _tickEndOffset = 0;
      final double _offset = _isLabelsOutside
          ? showLabels
              ? (_actualLabelOffset +
                  math.max(_maximumLabelSize.height, _maximumLabelSize.width) /
                      2)
              : 0
          : 0;
      if (!_isTicksOutside) {
        _tickStartOffset = _radius -
            (_axisLineWidth + _actualTickOffset + _offset + _axisFeatureOffset);
        _tickEndOffset = _radius -
            (_axisLineWidth +
                _actualMinorTickLength +
                _actualTickOffset +
                _offset +
                _axisFeatureOffset);
      } else {
        final bool _isGreater = _actualMinorTickLength > _actualMajorTickLength;
        if (!_useAxisElementsInsideRadius) {
          _tickStartOffset = _radius + _actualTickOffset - _axisFeatureOffset;
          _tickEndOffset = _radius +
              _actualMinorTickLength +
              _actualTickOffset -
              _axisFeatureOffset;
        } else {
          if (_axisOffset < _axisFeatureOffset) {
            final double _diff = _axisFeatureOffset - _axisOffset;
            _tickStartOffset = _isGreater
                ? _radius - (_offset + _diff)
                : _radius -
                    (_maximumTickLength - _actualMinorTickLength) -
                    (_diff + _offset);
            _tickEndOffset = _radius - (_diff + _offset + _maximumTickLength);
          } else {
            _tickStartOffset = _isGreater
                ? _radius - _offset
                : _radius -
                    (_maximumTickLength - _actualMinorTickLength + _offset);
            _tickEndOffset = _radius - (_maximumTickLength + _offset);
          }
        }
      }

      _calculateOffsetForMinorTicks(_tickStartOffset, _tickEndOffset);
    }
  }

  /// Calculates the offset for minor ticks
  void _calculateOffsetForMinorTicks(
      double _tickStartOffset, double _tickEndOffset) {
    _minorTickOffsets = <_TickOffset>[];
    final double _angularSpaceForTicks =
        _degreeToRadian(_sweepAngle / (_majorTicksCount - 1));
    double _angleForTicks = _degreeToRadian(startAngle - 90);
    final double _totalMinorTicks =
        (_majorTicksCount - 1) * minorTicksPerInterval;
    const num _minorTickIndex =
        1; // Since the minor tick rendering needs to be start in the index one
    final double _minorTickAngle =
        _angularSpaceForTicks / (minorTicksPerInterval + 1);

    for (num i = _minorTickIndex; i <= _totalMinorTicks; i++) {
      _angleForTicks += _minorTickAngle;
      final List<Offset> _tickPosition =
          _getTickPosition(_tickStartOffset, _tickEndOffset, _angleForTicks);
      final _TickOffset _tickOffset = _TickOffset();
      _tickOffset.startPoint = _tickPosition[0];
      _tickOffset.endPoint = _tickPosition[1];
      _tickOffset.value = factorToValue(
          (_radianToDegree(_angleForTicks) + 90 - startAngle) / _sweepAngle);
      _tickOffset.startPoint = Offset(_tickOffset.startPoint.dx - _centerX,
          _tickOffset.startPoint.dy - _centerY);
      _tickOffset.endPoint = Offset(_tickOffset.endPoint.dx - _centerX,
          _tickOffset.endPoint.dy - _centerY);
      _minorTickOffsets.add(_tickOffset);
      if (i % minorTicksPerInterval == 0) {
        _angleForTicks += _minorTickAngle;
      }
    }

    _minorTickOffsets =
        isInversed ? _minorTickOffsets.reversed.toList() : _minorTickOffsets;
  }

  /// Calculate the axis label position
  void _calculateAxisLabelsPosition() {
    if (_axisLabels != null && _axisLabels.isNotEmpty) {
      final double _labelSpaceInAngle = _sweepAngle / (_axisLabels.length - 1);
      final double _labelSpaceInRadian = _degreeToRadian(_labelSpaceInAngle);

      final double _tickLength = _actualMajorTickLength > _actualMinorTickLength
          ? _actualMajorTickLength
          : _actualMinorTickLength;
      final double _tickPadding =
          showTicks ? _tickLength + _actualTickOffset : 0;
      double _labelRadian = 0;
      double _labelAngle = 0;
      double _labelPosition = 0;
      if (!isInversed) {
        _labelAngle = startAngle - 90;
        _labelRadian = _degreeToRadian(_labelAngle);
      } else {
        _labelAngle = startAngle + _sweepAngle - 90;
        _labelRadian = _degreeToRadian(_labelAngle);
      }

      final double _labelSize =
          math.max(_maximumLabelSize.height, _maximumLabelSize.width) / 2;
      if (_isLabelsOutside) {
        final double _featureOffset = _axisOffset > _axisFeatureOffset
            ? _labelSize
            : (_axisFeatureOffset - _axisOffset) + _labelSize;
        _labelPosition = _useAxisElementsInsideRadius
            ? _radius - _featureOffset
            : _radius + _tickPadding + _actualLabelOffset - _axisFeatureOffset;
      } else {
        _labelPosition = _radius -
            (_actualAxisWidth +
                _tickPadding +
                _actualLabelOffset +
                _axisFeatureOffset);
      }

      for (num i = 0; i < _axisLabels.length; i++) {
        final CircularAxisLabel label = _axisLabels[i];
        label.angle = _labelAngle;
        label.value =
            factorToValue((_labelAngle + 90 - startAngle) / _sweepAngle);
        final double x = ((_axisSize.width / 2) -
                (_labelPosition * math.sin(_labelRadian))) -
            _centerX;
        final double y = ((_axisSize.height / 2) +
                (_labelPosition * math.cos(_labelRadian))) -
            _centerY;
        label.position = Offset(x, y);

        if (!isInversed) {
          _labelRadian += _labelSpaceInRadian;
          _labelAngle += _labelSpaceInAngle;
        } else {
          _labelRadian -= _labelSpaceInRadian;
          _labelAngle -= _labelSpaceInAngle;
        }
      }
    }
  }

  /// To find the maximum label size
  void _measureAxisLabels() {
    _maximumLabelSize = const Size(0, 0);
    for (num i = 0; i < _axisLabels.length; i++) {
      final CircularAxisLabel label = _axisLabels[i];
      label.labelSize = _measureText(label.text, label.labelStyle);
      final double maxWidth = _maximumLabelSize.width < label.labelSize.width
          ? label._needsRotateLabel
              ? label.labelSize.height
              : label.labelSize.width
          : _maximumLabelSize.width;
      final double maxHeight = _maximumLabelSize.height < label.labelSize.height
          ? label.labelSize.height
          : _maximumLabelSize.height;

      _maximumLabelSize = Size(maxWidth, maxHeight);
    }
  }

  /// Gets the start and end offset of tick
  List<Offset> _getTickPosition(
      double _tickStartOffset, double _tickEndOffset, double _angleForTicks) {
    final double tickStartX =
        _axisSize.width / 2 - _tickStartOffset * math.sin(_angleForTicks);
    final double tickStartY =
        _axisSize.height / 2 + _tickStartOffset * math.cos(_angleForTicks);
    final double tickStopX =
        _axisSize.width / 2 + (1 - _tickEndOffset) * math.sin(_angleForTicks);
    final double tickStopY =
        _axisSize.height / 2 - (1 - _tickEndOffset) * math.cos(_angleForTicks);
    final Offset startOffset = Offset(tickStartX, tickStartY);
    final Offset endOffset = Offset(tickStopX, tickStopY);
    return <Offset>[startOffset, endOffset];
  }

  ///Method to calculate teh sweep angle of axis
  double _calculateSweepAngle() {
    final double _actualEndAngle = endAngle > 360 ? endAngle % 360 : endAngle;
    double totalAngle = _actualEndAngle - startAngle;
    totalAngle = totalAngle <= 0 ? (totalAngle + 360) : totalAngle;
    return totalAngle;
  }

  ///Calculates the axis width based on the coordinate unit
  double _calculateActualValue(
      double value, GaugeSizeUnit _sizeUnit, bool isOffset) {
    double _actualValue = 0;
    if (value != null) {
      switch (_sizeUnit) {
        case GaugeSizeUnit.factor:
          {
            if (!isOffset) {
              value = value < 0 ? 0 : value;
              value = value > 1 ? 1 : value;
            }

            _actualValue = value * _radius;
          }
          break;
        case GaugeSizeUnit.logicalPixel:
          {
            _actualValue = value;
          }
          break;
      }
    }

    return _actualValue;
  }

  ///Calculates the maximum tick length
  double _calculateTickLength(bool isMajorTick) {
    if (isMajorTick) {
      return _calculateActualValue(
          majorTickStyle.length, majorTickStyle.lengthUnit, false);
    } else {
      return _calculateActualValue(
          minorTickStyle.length, minorTickStyle.lengthUnit, false);
    }
  }

  /// Renders the axis pointers
  void _renderPointers() {
    for (num i = 0; i < pointers.length; i++) {
      final GaugePointer _pointer = pointers[i];
      _pointer._axis = this;
      _pointer._calculatePosition();
    }
  }

  /// Method to render the range
  void _renderRanges() {
    for (num i = 0; i < ranges.length; i++) {
      ranges[i]._axis = this;
      ranges[i]._calculateRangePosition();
    }
  }

  /// Calculates the visible labels based on axis interval and range
  @override
  List<CircularAxisLabel> generateVisibleLabels() {
    final List<CircularAxisLabel> _visibleLabels = <CircularAxisLabel>[];
    final num _actualInterval = calculateNiceInterval();
    for (num i = minimum; i <= maximum; i += _actualInterval) {
      num _value = i;
      String _labelText = _value.toString();
      final List<dynamic> list = _labelText.split('.');
      _value = double.parse(_value.toStringAsFixed(3));
      if (list != null &&
          list.length > 1 &&
          (list[1] == '0' || list[1] == '00' || list[1] == '000'))
        _value = _value.round();
      _labelText = _value.toString();

      if (numberFormat != null) {
        _labelText = numberFormat.format(_value);
      }
      if (labelFormat != null) {
        _labelText = labelFormat.replaceAll(RegExp('{value}'), _labelText);
      }
      AxisLabelCreatedArgs labelCreatedArgs;
      GaugeTextStyle _argsLabelStyle;
      if (onLabelCreated != null) {
        labelCreatedArgs = AxisLabelCreatedArgs();
        labelCreatedArgs.text = _labelText;
        onLabelCreated(labelCreatedArgs);

        _labelText = labelCreatedArgs.text;
        _argsLabelStyle = labelCreatedArgs.labelStyle;
      }

      final GaugeTextStyle _labelStyle = _argsLabelStyle ?? axisLabelStyle;
      final CircularAxisLabel label = CircularAxisLabel(
          _labelStyle,
          _labelText,
          i,
          labelCreatedArgs != null
              ? labelCreatedArgs.canRotate != null
                  ? labelCreatedArgs.canRotate
                  : false
              : false);
      label.value = _value;
      _visibleLabels.add(label);
    }

    return _visibleLabels;
  }

  /// Calculates the interval of axis based on its range
  num calculateNiceInterval() {
    if (interval != null) {
      return interval;
    }

    return _calculateAxisInterval(maximumLabels);
  }

  /// To calculate the axis label based on the maximum axis label
  num _calculateAxisInterval(int _actualMaximumValue) {
    final num _delta = calculateRange();
    final num _circumference = 2 * math.pi * _center * (_sweepAngle / 360);
    final num _desiredIntervalCount =
        math.max(_circumference * ((0.533 * _actualMaximumValue) / 100), 1);
    num _niceInterval = _delta / _desiredIntervalCount;
    final num _minimumInterval =
        math.pow(10, (math.log(_niceInterval) / math.log(10)).floor());
    final dynamic intervalDivisions = <dynamic>[10, 5, 2, 1];
    for (int i = 0; i < intervalDivisions.length; i++) {
      final num _currentInterval = _minimumInterval * intervalDivisions[i];
      if (_desiredIntervalCount < (_delta / _currentInterval)) {
        break;
      }
      _niceInterval = _currentInterval;
    }

    return _niceInterval;
  }

  /// To load the image from the image provider
  void _loadBackgroundImage() {
    final ImageStream newImageStream =
        backgroundImage.resolve(createLocalImageConfiguration(_context));
    if (newImageStream.key != _imageStream?.key) {
      _imageStream?.removeListener(_listener);
      _imageStream = newImageStream;
      _imageStream.addListener(_listener);
    }
  }

  /// Update the background image
  void _updateBackgroundImage(ImageInfo _imageInfo, bool _synchronousCall) {
    if (_imageInfo?.image != null) {
      _backgroundImageInfo = _imageInfo;
      _gauge._radialGaugeState.axisRepaintNotifier.value++;
    }
  }

  /// Returns the axis range based on its minimum and maximum
  @override
  num calculateRange() {
    return maximum - minimum;
  }

  /// Converts the axis value to factor based on angle
  @override
  double valueToFactor(double value) {
    final double _angle = _valueToAngle(value);
    return _angle / _sweepAngle;
  }

  /// Converts the factor value to axis value
  @override
  double factorToValue(double factor) {
    final double _angle = (factor * _sweepAngle) + startAngle;
    return _angleToValue(_angle);
  }
}
