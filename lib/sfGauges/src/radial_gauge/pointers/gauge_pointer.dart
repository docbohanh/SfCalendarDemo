part of gauges;

/// Represents the pointer for radial axis.
abstract class GaugePointer {
  /// Creates the abstract constructor for pointer
  GaugePointer(
      {this.value = 0,
      this.enableDragging = false,
      this.onValueChanged,
      this.onValueChangeStart,
      this.onValueChanging,
      this.onValueChangeEnd,
      this.enableAnimation = false,
      this.animationType = AnimationType.ease,
      this.animationDuration = 1000}) {
    _needsRepaintPointer = true;
    _currentValue = value;
    _isDragStarted = false;
    _animationEndValue = 0;
  }

  /// Specifies the value of pointer.
  ///
  /// Defaults to 0
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
  final double value;

  /// Enable or disable the pointer dragging.
  ///
  /// Defaults to false
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///             pointers: <GaugePointer>[MarkerPointer(value: 50,
  ///             enableDragging: true)],
  ///            )]
  ///        ));
  ///}
  /// ```
  final bool enableDragging;

  /// Called when the user is selecting a new value for the pointers by dragging.
  ///
  /// ```dart
  ///  void _markerValueChanged(double value){
  ///    final double _currentValue = value;
  ///  }
  ///
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///             pointers: <GaugePointer>[MarkerPointer(value: 50,
  ///              onValueChanged: _markerValueChanged,)],
  ///            )]
  ///        ));
  ///}
  /// ```
  final ValueChanged<double> onValueChanged;

  /// Called when the user starts selecting a new value of pointer by dragging. .
  ///
  /// ```dart
  ///  void _markerValueChangeStart(double value){
  ///    final double _currentValue = value;
  ///  }
  ///
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///             pointers: <GaugePointer>[MarkerPointer(value: 50,
  ///              onValueChangeStart: _markerValueChangeStart,)],
  ///            )]
  ///        ));
  ///}
  /// ```
  final ValueChanged<double> onValueChangeStart;

  /// Called when the user is done selecting a new value of the pointer by dragging.
  ///
  /// ```dart
  ///  void _markerValueChangeEnd(double value){
  ///    final double _currentValue = value;
  ///  }
  ///
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///             pointers: <GaugePointer>[MarkerPointer(value: 50,
  ///              onValueChangeEnd: _markerValueChangeEnd,)],
  ///            )]
  ///        ));
  ///}
  /// ```
  final ValueChanged<double> onValueChangeEnd;

  /// Called before when the user is selecting a new value for the pointers by dragging.
  ///
  /// ```dart
  ///  void _markerValueChanging(ValueChangingArgs args){
  ///    if(args.value > 10){
  ///    args.cancel = false;
  ///    }
  ///  }
  ///
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///             pointers: <GaugePointer>[MarkerPointer(value: 50,
  ///              onValueChanging: _markerValueChanging,)],
  ///            )]
  ///        ));
  ///}
  /// ```
  final ValueChanged<ValueChangingArgs> onValueChanging;

  /// Enables or disables the pointer animation.
  ///
  /// Defaults to false
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///             pointers: <GaugePointer>[MarkerPointer(value: 50,
  ///             enableAnimation: true)],
  ///            )]
  ///        ));
  ///}
  /// ```
  final bool enableAnimation;

  /// Specifies the pointer animation duration.
  ///
  /// Defaults to 1000
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///             pointers: <GaugePointer>[MarkerPointer(value: 50,
  ///             enableAnimation: true, animationDuration: 2000 )],
  ///            )]
  ///        ));
  ///}
  /// ```
  final double animationDuration;

  /// Specifies the animation type for pointer.
  ///
  /// Also refer [AnimationType]
  ///
  /// Defaults to AnimationType.linear
  ///```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///             pointers: <GaugePointer>[MarkerPointer(value: 50,
  ///             animationType: AnimationType.ease
  ///             enableAnimation: true, animationDuration: 2000 )],
  ///            )]
  ///        ));
  ///}
  ///```
  final AnimationType animationType;

  /// Specifies the axis for this pointer
  RadialAxis _axis;

  /// Specifies whether to repaint the marker
  bool _needsRepaintPointer;

  /// Specifies the current value of the point
  double _currentValue;

  /// Specifies the pointer rect
  Rect _pointerRect;

  /// Specifies the value whether the pointer is dragged
  bool _isDragStarted;

  /// Holds the end value of pointer animation
  double _animationEndValue;

  /// Holds the animation start value;
  double _animationStartValue;

  /// Holds the value whether to animate the pointer
  bool _needsAnimate;

  /// Method to calculates the pointer position
  void _calculatePosition();

  /// Method to draw pointers.
  void drawPointer(Canvas canvas, double animationValue, Offset startPosition,
      Offset endPosition, double pointerAngle);

  /// Method to update the drag value
  void _updateDragValue(double _x, double _y) {
    final double _centerX = _axis._axisSize.width * _axis.centerX;
    final double _centerY = _axis._axisSize.height * _axis.centerY;
    double _angle =
        math.atan2(_y - _centerY, _x - _centerX) * (180 / math.pi) + 360;
    final double _endAngle = _axis.startAngle + _axis._sweepAngle;
    if (_angle < 360 && _angle > 180) {
      _angle += 360;
    }

    if (_angle > _endAngle) {
      _angle %= 360;
    }

    if (_angle >= _axis.startAngle && _angle <= _endAngle) {
      double _dragValue = 0;
      if (!_axis.isInversed) {
        _dragValue = _axis.minimum +
            (_angle - _axis.startAngle) *
                ((_axis.maximum - _axis.minimum) / _axis._sweepAngle);
      } else {
        _dragValue = _axis.maximum -
            (_angle - _axis.startAngle) *
                ((_axis.maximum - _axis.minimum) / _axis._sweepAngle);
      }

      if (this is RangePointer) {
        final num _interval = _axis._calculateAxisInterval(3);
        if (_dragValue < _axis.minimum + _interval / 2) {
          return;
        }
      }

      final double _actualValue =
          _minMax(_dragValue, _axis.minimum, _axis.maximum);
      const int _maximumLabel = 3;
      final int _niceInterval =
          _axis._calculateAxisInterval(_maximumLabel).toInt();
      if (_axis._sweepAngle != 360 &&
          ((_actualValue.round() <= _niceInterval &&
                  _currentValue >= _axis.maximum - _niceInterval) ||
              (_actualValue.round() >= _axis.maximum - _niceInterval &&
                  _currentValue <= _niceInterval))) {
        _isDragStarted = false;
        return;
      }

      if (onValueChanging != null) {
        final ValueChangingArgs args = ValueChangingArgs()
          ..value = _actualValue;
        onValueChanging(args);
        if (args.cancel != null && args.cancel) {
          return;
        }
      }
      _currentValue = _actualValue;
      _calculatePosition();
      _createPointerValueChangedArgs();
      _axis._gauge._radialGaugeState.pointerRepaintNotifier.value++;
    }
  }

  /// Method to fire the on value change end event
  void _createPointerValueChangeEndArgs() {
    if (onValueChangeEnd != null) {
      onValueChangeEnd(_currentValue);
    }
  }

  /// Method to fire the on value changed event
  void _createPointerValueChangedArgs() {
    if (onValueChanged != null) {
      onValueChanged(_currentValue);
    }
  }

  /// Method to fire the on value change start event
  void _createPointerValueChangeStartArgs() {
    if (onValueChangeStart != null) {
      onValueChangeStart(_currentValue);
    }
  }

  /// Specifies whether the pointer animation is enabled
  bool _isPointerAnimationEnabled() {
    return enableAnimation &&
        animationDuration > 0 &&
        _needsAnimate != null &&
        _needsAnimate;
  }
}
