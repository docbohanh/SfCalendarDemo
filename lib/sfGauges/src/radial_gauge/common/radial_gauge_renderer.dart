part of gauges;

/// Represents the container to render the axis and its element
///
// ignore: must_be_immutable
class _AxisContainer extends StatelessWidget {
  _AxisContainer(this.gauge);

  /// Specifies the radial gauge
  SfRadialGauge gauge;

  ///list of widgets present in gauge
  List<Widget> _gaugeWidgets;

  /// Specifies the render box
  RenderBox _renderBox;

  /// Specifies the axis tap position
  Offset tapPosition;

  /// Specifies the axis line interval for animation
  List<double> _axisLineInterval;

  /// Specifies the axis element interval for load time animation
  List<double> _axisElementsInterval;

  /// Specifies the range interval for initial animation
  List<double> _rangesInterval;

  /// Specifies the pointer interval for load time animation
  List<double> _pointersInterval;

  /// Specifies the annotation interval for load time animation
  List<double> _annotationInterval;

  /// Specifies whether the axis line is enabled
  bool _hasAxisLine = false;

  /// Specifies whether the axis element is enabled
  bool _hasAxisElements = false;

  /// Specifies whether axis range is enabled
  bool _hasRanges = false;

  /// Specifies whether the axis pointers is enabled
  bool _hasPointers = false;

  /// Specifies whether the annotation is added
  bool _hasAnnotations = false;

  /// Method to update the pointer value
  void _updatePointerValue(BuildContext context, DragUpdateDetails details) {
    _renderBox = _renderBox ?? context.findRenderObject();
    if (details != null && details.globalPosition != null) {
      tapPosition = _renderBox.globalToLocal(details.globalPosition);
      for (num i = 0; i < gauge.axes.length; i++) {
        if (gauge.axes[i].pointers != null &&
            gauge.axes[i].pointers.isNotEmpty) {
          for (num j = 0; j < gauge.axes[i].pointers.length; j++) {
            final GaugePointer _pointer = gauge.axes[i].pointers[j];
            if (_pointer.enableDragging && _pointer._isDragStarted) {
              final Rect _rect = Rect.fromLTRB(
                  _pointer._axis._axisRect.left +
                      _pointer._axis._axisSize.width / 2 -
                      _pointer._axis._centerX,
                  _pointer._axis._axisRect.top +
                      _pointer._axis._axisSize.height / 2 -
                      _pointer._axis._centerY,
                  _pointer._axis._axisRect.right +
                      _pointer._axis._axisSize.width / 2 -
                      _pointer._axis._centerX,
                  _pointer._axis._axisRect.bottom +
                      _pointer._axis._axisSize.height / 2 -
                      _pointer._axis._centerY);
              if (_pointer is RangePointer) {
                final RangePointer _rangePointer = _pointer;
                final double _centerX = _rangePointer._pointerRect.left +
                    _rangePointer._axis._axisSize.width / 2 -
                    _rangePointer._axis._centerX +
                    _rangePointer._axis._radius;
                final double _centerY = _rangePointer._pointerRect.top +
                    _rangePointer._axis._axisSize.height / 2 -
                    _rangePointer._axis._centerX +
                    _rangePointer._axis._radius;
                final double _x = tapPosition.dx - _centerX;
                final double _y = tapPosition.dy - _centerY;
                final bool _isInside = (_x * _x) + (_y * _y) <=
                    (_rangePointer._axis._radius * _rangePointer._axis._radius);
                if (_isInside) {
                  _pointer._updateDragValue(tapPosition.dx, tapPosition.dy);
                }
              } else if (_rect.contains(tapPosition)) {
                _pointer._updateDragValue(tapPosition.dx, tapPosition.dy);
              }
            }
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        decoration: BoxDecoration(color: Colors.transparent),
        child: _getGaugeElements(context, constraints),
      );
    });
  }

  /// To initialize the gauge elements
  Widget _getGaugeElements(BuildContext context, BoxConstraints constraints) {
    _gaugeWidgets = <Widget>[];
    _calculateAxisElementPosition(context, constraints);
    _addGaugeElements(constraints, context);

    return GestureDetector(
        onPanStart: (DragStartDetails details) =>
            _checkPointerDragging(context, details),
        onPanUpdate: (DragUpdateDetails details) =>
            _updatePointerValue(context, details),
        onPanEnd: (DragEndDetails details) => _checkPointerIsDragged(),
        onTapUp: (TapUpDetails details) => _checkIsAxisTapped(context, details),
        child: Container(
          decoration: BoxDecoration(color: Colors.transparent),
          child: Stack(children: _gaugeWidgets),
        ));
  }

  /// Method to check whether the axis is tapped
  void _checkIsAxisTapped(BuildContext context, TapUpDetails details) {
    _renderBox = _renderBox ?? context.findRenderObject();
    if (details != null && details.globalPosition != null) {
      if (gauge.axes.isNotEmpty) {
        for (num i = 0; i < gauge.axes.length; i++) {
          final RadialAxis _axis = gauge.axes[i];
          final Offset _offset =
              _renderBox.globalToLocal(details.globalPosition);
          if (_axis.onAxisTapped != null &&
              _axis._axisPath.getBounds().contains(_offset)) {
            _axis._getAngleFromOffset(_offset);
          }
        }
      }
    }
  }

  /// Method to check whether the axis pointer is dragging
  void _checkPointerDragging(BuildContext context, DragStartDetails details) {
    _renderBox = _renderBox ?? context.findRenderObject();
    if (details != null && details.globalPosition != null) {
      tapPosition = _renderBox.globalToLocal(details.globalPosition);
      for (num i = 0; i < gauge.axes.length; i++) {
        if (gauge.axes[i].pointers != null &&
            gauge.axes[i].pointers.isNotEmpty) {
          for (num j = 0; j < gauge.axes[i].pointers.length; j++) {
            final GaugePointer _pointer = gauge.axes[i].pointers[j];
            if (_pointer.enableDragging) {
              if (_pointer is RangePointer) {
                final RangePointer _rangePointer = _pointer;
                final RadialAxis _axis = gauge.axes[i];
                final Rect _pathRect = Rect.fromLTRB(
                    _rangePointer._arcPath.getBounds().left +
                        _axis._axisSize.width / 2 -
                        _axis._centerX -
                        5,
                    _rangePointer._arcPath.getBounds().top +
                        _axis._axisSize.height / 2 -
                        _axis._centerY -
                        5,
                    _rangePointer._arcPath.getBounds().right +
                        _axis._axisSize.width / 2 -
                        _axis._centerX +
                        5,
                    _rangePointer._arcPath.getBounds().bottom +
                        _axis._axisSize.height / 2 -
                        _axis._centerY +
                        5);
                if (_pathRect.contains(tapPosition)) {
                  _rangePointer._isDragStarted = true;
                  _pointer._createPointerValueChangeStartArgs();
                  break;
                } else {
                  _rangePointer._isDragStarted = false;
                }
              } else {
                if (_pointer._pointerRect.contains(tapPosition)) {
                  _pointer._isDragStarted = true;
                  _pointer._createPointerValueChangeStartArgs();
                  break;
                } else {
                  _pointer._isDragStarted = false;
                }
              }
            }
          }
        }
      }
    }
  }

  /// Method to ensure whether the pointer was dragged
  void _checkPointerIsDragged() {
    if (gauge.axes != null) {
      for (num i = 0; i < gauge.axes.length; i++) {
        if (gauge.axes[i].pointers != null &&
            gauge.axes[i].pointers.isNotEmpty) {
          for (num j = 0; j < gauge.axes[i].pointers.length; j++) {
            final GaugePointer _pointer = gauge.axes[i].pointers[j];
            if (_pointer.enableDragging) {
              if (_pointer._isDragStarted) {
                _pointer._createPointerValueChangeEndArgs();

                if (_pointer is NeedlePointer) {
                  final NeedlePointer _needlePointer = _pointer;
                  _needlePointer._animationEndValue =
                      _needlePointer._getSweepAngle();
                } else if (_pointer is MarkerPointer) {
                  final MarkerPointer _markerPointer = _pointer;
                  _markerPointer._animationEndValue =
                      _markerPointer._getSweepAngle();
                } else {
                  final RangePointer _rangePointer = _pointer;
                  _rangePointer._animationEndValue =
                      _rangePointer._getSweepAngle();
                }
              }
              _pointer._isDragStarted = false;
            }
          }
        }
      }
    }
  }

  /// Calculates the axis position
  void _calculateAxisElementPosition(
      BuildContext context, BoxConstraints constraints) {
    if (gauge.axes != null && gauge.axes.isNotEmpty) {
      for (int i = 0; i < gauge.axes.length; i++) {
        gauge.axes[i]._gauge = gauge;
        gauge.axes[i]._context = context;
        gauge.axes[i]._calculateAxisRange(constraints);
      }
    }
  }

  /// Methods to add the gauge elements
  void _addGaugeElements(BoxConstraints constraints, BuildContext context) {
    if (gauge.axes != null && gauge.axes.isNotEmpty) {
      _calculateDurationForAnimation();
      for (int i = 0; i < gauge.axes.length; i++) {
        final RadialAxis _axis = gauge.axes[i];
        _addAxis(_axis, constraints);

        if (_axis.ranges != null && _axis.ranges.isNotEmpty) {
          _addRange(_axis, constraints);
        }

        if (_axis.pointers != null && _axis.pointers.isNotEmpty) {
          for (num j = 0; j < _axis.pointers.length; j++) {
            if (_axis.pointers[j] is NeedlePointer) {
              final NeedlePointer _needlePointer = _axis.pointers[j];
              _addNeedlePointer(_axis, constraints, _needlePointer);
            } else if (_axis.pointers[j] is MarkerPointer) {
              final MarkerPointer _markerPointer = _axis.pointers[j];
              _addMarkerPointer(_axis, constraints, _markerPointer);
            } else if (_axis.pointers[j] is RangePointer) {
              final RangePointer _rangePointer = _axis.pointers[j];
              _addRangePointer(_axis, constraints, _rangePointer);
            }
          }
        }

        if (_axis.annotations != null && _axis.annotations.isNotEmpty) {
          _addAnnotation(_axis);
        }
      }
    }
  }

  /// Adds the axis
  void _addAxis(RadialAxis axis, BoxConstraints constraints) {
    Animation<double> _axisAnimation;
    Animation<double> _axisElementAnimation;
    if (gauge._needsToAnimateAxes && (_hasAxisLine || _hasAxisElements)) {
      gauge._radialGaugeState.animationController.duration =
          Duration(milliseconds: gauge.animationDuration.toInt());

      if (_hasAxisLine) {
        _axisAnimation = Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(
                parent: gauge._radialGaugeState.animationController,
                curve: Interval(_axisLineInterval[0], _axisLineInterval[1],
                    curve: Curves.easeIn)));
      }

      if (_hasAxisElements) {
        _axisElementAnimation = Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(
                parent: gauge._radialGaugeState.animationController,
                curve: Interval(
                    _axisElementsInterval[0], _axisElementsInterval[1],
                    curve: Curves.easeIn)));
      }
    }

    _gaugeWidgets.add(Container(
      child: RepaintBoundary(
        child: CustomPaint(
            painter: _AxisPainter(
                gauge,
                axis,
                axis._needsRepaintAxis ?? true,
                gauge._radialGaugeState.axisRepaintNotifier,
                _axisAnimation,
                _axisElementAnimation),
            size: Size(constraints.maxWidth, constraints.maxHeight)),
      ),
    ));

    if (_axisAnimation != null || _axisElementAnimation != null) {
      gauge._radialGaugeState.animationController.forward(from: 0.0);
    }
  }

  /// Adds the range pointer
  void _addRangePointer(
      RadialAxis axis, BoxConstraints constraints, RangePointer _rangePointer) {
    _rangePointer._animationEndValue = _rangePointer._getSweepAngle();
    Animation<double> _pointerAnimation;
    final List<double> _intervals = _getPointerAnimationInterval();
    if (gauge._needsToAnimatePointers ||
        (_rangePointer.enableAnimation &&
            _rangePointer.animationDuration > 0 &&
            _rangePointer._needsAnimate)) {
      gauge._radialGaugeState.animationController.duration = Duration(
          milliseconds:
              _getPointerAnimationDuration(_rangePointer.animationDuration));
      final Curve _animationType =
          _getCurveAnimation(_rangePointer.animationType);
      final double _endValue = _rangePointer._animationEndValue;
      _pointerAnimation = Tween<double>(
              begin: _rangePointer._animationStartValue ?? 0, end: _endValue)
          .animate(CurvedAnimation(
              parent: gauge._radialGaugeState.animationController,
              curve: Interval(_intervals[0], _intervals[1],
                  curve: _animationType)));
    }

    _gaugeWidgets.add(Container(
      child: RepaintBoundary(
        child: CustomPaint(
            painter: _RangePointerPainter(
                gauge,
                axis,
                _rangePointer,
                _rangePointer._needsRepaintPointer ?? true,
                _pointerAnimation,
                gauge._radialGaugeState.pointerRepaintNotifier),
            size: Size(constraints.maxWidth, constraints.maxHeight)),
      ),
    ));
    if (gauge._needsToAnimatePointers ||
        _rangePointer._isPointerAnimationEnabled()) {
      gauge._radialGaugeState.animationController.forward(from: 0.0);
    }
  }

  /// Adds the needle pointer
  void _addNeedlePointer(RadialAxis axis, BoxConstraints constraints,
      NeedlePointer _needlePointer) {
    Animation<double> _pointerAnimation;
    final List<double> _intervals = _getPointerAnimationInterval();
    _needlePointer._animationEndValue = _needlePointer._getSweepAngle();
    if (gauge._needsToAnimatePointers ||
        (_needlePointer.enableAnimation &&
            _needlePointer.animationDuration > 0 &&
            _needlePointer._needsAnimate)) {
      gauge._radialGaugeState.animationController.duration = Duration(
          milliseconds:
              _getPointerAnimationDuration(_needlePointer.animationDuration));

      final double _startValue = axis.isInversed ? 1 : 0;
      final double _endValue = axis.isInversed ? 0 : 1;
      double _actualValue = _needlePointer._animationStartValue ?? _startValue;
      _actualValue = _actualValue == _endValue ? _startValue : _actualValue;
      _pointerAnimation = Tween<double>(
              begin: _actualValue, end: _needlePointer._animationEndValue)
          .animate(CurvedAnimation(
              parent: gauge._radialGaugeState.animationController,
              curve: Interval(_intervals[0], _intervals[1],
                  curve: _getCurveAnimation(_needlePointer.animationType))));
    }

    _gaugeWidgets.add(Container(
      child: RepaintBoundary(
        child: CustomPaint(
            painter: _NeedlePointerPainter(
                gauge,
                axis,
                _needlePointer,
                _needlePointer._needsRepaintPointer ?? true,
                _pointerAnimation,
                gauge._radialGaugeState.pointerRepaintNotifier),
            size: Size(constraints.maxWidth, constraints.maxHeight)),
      ),
    ));

    if (gauge._needsToAnimatePointers ||
        _needlePointer._isPointerAnimationEnabled()) {
      gauge._radialGaugeState.animationController.forward(from: 0.0);
    }
  }

  /// Adds the marker pointer
  void _addMarkerPointer(RadialAxis axis, BoxConstraints constraints,
      MarkerPointer _markerPointer) {
    Animation<double> _pointerAnimation;
    final List<double> _intervals = _getPointerAnimationInterval();
    _markerPointer._animationEndValue = _markerPointer._getSweepAngle();
    if (gauge._needsToAnimatePointers ||
        (_markerPointer.enableAnimation &&
            _markerPointer.animationDuration > 0 &&
            _markerPointer._needsAnimate)) {
      gauge._radialGaugeState.animationController.duration = Duration(
          milliseconds:
              _getPointerAnimationDuration(_markerPointer.animationDuration));

      final double _startValue = axis.isInversed ? 1 : 0;
      _pointerAnimation = Tween<double>(
              begin: _markerPointer._animationStartValue ?? _startValue,
              end: _markerPointer._animationEndValue)
          .animate(CurvedAnimation(
              parent: gauge._radialGaugeState.animationController,
              curve: Interval(_intervals[0], _intervals[1],
                  curve: _getCurveAnimation(_markerPointer.animationType))));
    }

    _gaugeWidgets.add(Container(
      child: RepaintBoundary(
        child: CustomPaint(
            painter: _MarkerPointerPainter(
                gauge,
                axis,
                _markerPointer,
                _markerPointer._needsRepaintPointer ?? true,
                _pointerAnimation,
                gauge._radialGaugeState.pointerRepaintNotifier),
            size: Size(constraints.maxWidth, constraints.maxHeight)),
      ),
    ));

    if (gauge._needsToAnimatePointers ||
        _markerPointer._isPointerAnimationEnabled()) {
      gauge._radialGaugeState.animationController.forward(from: 0.0);
    }
  }

  /// Adds the axis range
  void _addRange(RadialAxis axis, BoxConstraints constraints) {
    for (num k = 0; k < axis.ranges.length; k++) {
      Animation<double> _rangeAnimation;
      if (gauge._needsToAnimateRanges) {
        gauge._radialGaugeState.animationController.duration =
            Duration(milliseconds: gauge.animationDuration.toInt());
        _rangeAnimation = Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(
                parent: gauge._radialGaugeState.animationController,
                curve: Interval(_rangesInterval[0], _rangesInterval[1],
                    curve: Curves.easeIn)));
      }

      _gaugeWidgets.add(Container(
        child: RepaintBoundary(
          child: CustomPaint(
              painter: _RangePainter(
                  gauge,
                  axis,
                  axis.ranges[k],
                  axis.ranges[k]._needsRepaintRange ?? true,
                  _rangeAnimation,
                  gauge._radialGaugeState.rangeRepaintNotifier),
              size: Size(constraints.maxWidth, constraints.maxHeight)),
        ),
      ));

      if (_rangeAnimation != null) {
        gauge._radialGaugeState.animationController.forward(from: 0.0);
      }
    }
  }

  /// Return the animation duration
  int _getPointerAnimationDuration(double _duration) {
    if (gauge._needsToAnimatePointers) {
      return gauge.animationDuration.toInt();
    } else {
      return _duration.toInt();
    }
  }

  /// Returns the animation interval of pointers
  List<double> _getPointerAnimationInterval() {
    List<double> _intervals = List<double>(2);
    if (gauge._needsToAnimatePointers) {
      _intervals = _pointersInterval;
    } else {
      _intervals[0] = 0.15;
      _intervals[1] = 1;
    }

    return _intervals;
  }

  /// Adds the axis annotation
  void _addAnnotation(RadialAxis axis) {
    for (num j = 0; j < axis.annotations.length; j++) {
      final GaugeAnnotation _annotation = axis.annotations[j];
      _gaugeWidgets.add(_AnnotationRenderer(
          key: GlobalKey(),
          annotation: _annotation,
          gauge: gauge,
          axis: axis,
          interval: _annotationInterval,
          duration: gauge.animationDuration.toInt()));
    }
  }

  ///calculates the duration for animation
  void _calculateDurationForAnimation() {
    num _totalCount = 5;
    double _interval;
    double _startValue = 0.05;
    double _endValue = 0;
    for (num i = 0; i < gauge.axes.length; i++) {
      _calculateAxisElements(gauge.axes[i]);
    }

    _totalCount = _getElementsCount(_totalCount);

    _interval = 1 / _totalCount;
    _endValue = _interval;
    if (_hasAxisLine) {
      _axisLineInterval = List<double>(2);
      _axisLineInterval[0] = _startValue;
      _axisLineInterval[1] = _endValue;
      _startValue = _endValue;
      _endValue += _interval;
    }

    if (_hasAxisElements) {
      _axisElementsInterval = List<double>(2);
      _axisElementsInterval[0] = _startValue;
      _axisElementsInterval[1] = _endValue;
      _startValue = _endValue;
      _endValue += _interval;
    }

    if (_hasRanges) {
      _rangesInterval = List<double>(2);
      _rangesInterval[0] = _startValue;
      _rangesInterval[1] = _endValue;
      _startValue = _endValue;
      _endValue += _interval;
    }

    if (_hasPointers) {
      _pointersInterval = List<double>(2);
      _pointersInterval[0] = _startValue;
      _pointersInterval[1] = _endValue;
      _startValue = _endValue;
      _endValue += _interval;
    }

    if (_hasAnnotations) {
      _annotationInterval = List<double>(2);
      _annotationInterval[0] = _startValue;
      _annotationInterval[1] = _endValue;
    }
  }

  /// Returns the total elements count
  num _getElementsCount(num _totalCount) {
    if (!_hasAnnotations) {
      _totalCount -= 1;
    }

    if (!_hasPointers) {
      _totalCount -= 1;
    }

    if (!_hasRanges) {
      _totalCount -= 1;
    }

    if (!_hasAxisElements) {
      _totalCount -= 1;
    }

    if (!_hasAxisLine) {
      _totalCount -= 1;
    }

    return _totalCount;
  }

  /// Calculates the  gauge elements
  void _calculateAxisElements(RadialAxis _axis) {
    if (_axis.showAxisLine && !_hasAxisLine) {
      _hasAxisLine = true;
    }

    if ((_axis.showTicks || _axis.showLabels) && !_hasAxisElements) {
      _hasAxisElements = true;
    }

    if (_axis.ranges != null && _axis.ranges.isNotEmpty && !_hasRanges) {
      _hasRanges = true;
    }

    if (_axis.pointers != null && _axis.pointers.isNotEmpty && !_hasPointers) {
      _hasPointers = true;
    }

    if (_axis.annotations != null &&
        _axis.annotations.isNotEmpty &&
        !_hasAnnotations) {
      _hasAnnotations = true;
    }
  }

  /// Method returns the curve animation function based on the animation type
  Curve _getCurveAnimation(AnimationType type) {
    Curve _curve = Curves.linear;
    switch (type) {
      case AnimationType.bounceOut:
        _curve = Curves.bounceOut;
        break;
      case AnimationType.ease:
        _curve = Curves.ease;
        break;
      case AnimationType.easeInCirc:
        _curve = Curves.easeInCirc;
        break;
      case AnimationType.easeOutBack:
        _curve = Curves.easeOutBack;
        break;
      case AnimationType.elasticOut:
        _curve = Curves.elasticOut;
        break;
      case AnimationType.linear:
        _curve = Curves.linear;
        break;
      case AnimationType.slowMiddle:
        _curve = Curves.slowMiddle;
        break;
    }
    return _curve;
  }
}
