part of gauges;

/// Renders the radial gauge
///
/// ```dart
/// Widget build(BuildContext context) {
///    return Container(
///        child: SfRadialGauge());
///}
/// ```
// ignore: must_be_immutable
class SfRadialGauge extends StatefulWidget {
  /// Creates the radial gauge
  // ignore: prefer_const_constructors_in_immutables
  SfRadialGauge(
      {Key key,
      List<RadialAxis> axes,
      this.enableLoadingAnimation = false,
      this.animationDuration = 2000,
      this.title})
      : axes = axes ?? <RadialAxis>[RadialAxis()],
        super(key: key) {
    _gaugeTheme = GaugeTheme();
  }

  /// Specifies a list of radial axes.
  ///
  /// Also refer [RadialAxis]
  /// ```dart
  /// Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///          axes:<RadialAxis>[RadialAxis(
  ///            )]
  ///        ));
  ///}
  /// ```
  final List<RadialAxis> axes;

  /// Customizes the radial gauge title.
  ///
  /// Also refer [GaugeTitle]
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(
  ///            title: GaugeTitle(
  ///                    text: 'Gauge Title',
  ///                    textStyle: TextStyle(
  ///                                 color: Colors.red,
  ///                                 fontSize: 12,
  ///                                 fontStyle: FontStyle.normal,
  ///                                 fontWeight: FontWeight.w400,
  ///                                 fontFamily: 'Roboto'
  ///                               ))
  ///        ));
  ///}
  /// ```
  final GaugeTitle title;

  /// Specifies the load time animation of gauge.
  ///
  /// Defaults to false
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(enableLoadingAnimation: true
  ///        ));
  ///}
  /// ```
  final bool enableLoadingAnimation;

  /// Specifies the load time animation duration.
  ///
  /// Defaults to 2000
  /// ```dart
  ///Widget build(BuildContext context) {
  ///    return Container(
  ///        child: SfRadialGauge(animationDuration: 4000
  ///        ));
  ///}
  /// ```
  final double animationDuration;

  /// Holds the circular gauge state
  _SfRadialGaugeState _radialGaugeState;

  /// Represents the gauge theme
  GaugeTheme _gaugeTheme;

  /// Specifies whether to animate axes
  bool _needsToAnimateAxes;

  /// Specifies whether to animate ranges
  bool _needsToAnimateRanges;

  /// Specifies whether to animate pointers
  bool _needsToAnimatePointers;

  /// Specifies whether to animate annotation
  bool _needsToAnimateAnnotation;

  @override
  State<StatefulWidget> createState() {
    return _SfRadialGaugeState();
  }
}

/// Represents the radial gauge state
class _SfRadialGaugeState extends State<SfRadialGauge>
    with SingleTickerProviderStateMixin {
  /// Holds the pointer repaint notifier
  ValueNotifier<int> pointerRepaintNotifier;

  /// Holds the range repaint notifier
  ValueNotifier<int> rangeRepaintNotifier;

  /// Holds the axis repaint notifier
  ValueNotifier<int> axisRepaintNotifier;

  /// Holds the animation controller
  AnimationController animationController;

  /// Holds the animation value
  Animation<double> animation;

  @override
  void initState() {
    pointerRepaintNotifier = ValueNotifier<int>(0);
    rangeRepaintNotifier = ValueNotifier<int>(0);
    axisRepaintNotifier = ValueNotifier<int>(0);
    animationController = AnimationController(vsync: this)
      ..addListener(_repaintGaugeElements);
    widget._needsToAnimateAxes =
        widget.enableLoadingAnimation && widget.animationDuration > 0;
    widget._needsToAnimateRanges =
        widget.enableLoadingAnimation && widget.animationDuration > 0;
    widget._needsToAnimatePointers =
        widget.enableLoadingAnimation && widget.animationDuration > 0;
    widget._needsToAnimateAnnotation =
        widget.enableLoadingAnimation && widget.animationDuration > 0;
    if (widget.axes != null && widget.axes.isNotEmpty) {
      for (num i = 0; i < widget.axes.length; i++) {
        final RadialAxis axis = widget.axes[i];
        if (axis.pointers != null && axis.pointers.isNotEmpty) {
          for (num j = 0; j < axis.pointers.length; j++) {
            final GaugePointer _pointer = axis.pointers[j];
            _pointer._needsAnimate = true;
            _pointer._animationStartValue =
                axis.isInversed && !(_pointer is RangePointer) ? 1 : 0;
          }
        }
      }
    }

    super.initState();
  }

  @override
  void didUpdateWidget(SfRadialGauge oldWidget) {
    if (widget.axes != null && widget.axes.isNotEmpty) {
      widget._needsToAnimateAnnotation = false;
      widget._needsToAnimatePointers = false;
      widget._needsToAnimateRanges = false;
      widget._needsToAnimateAxes = false;
      _needsRepaintGauge(oldWidget, widget);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    if (animationController != null) {
      animationController.removeListener(_repaintGaugeElements);
      animationController.dispose();
    }

    if (widget.axes != null && widget.axes.isNotEmpty) {
      for (int i = 0; i < widget.axes.length; i++) {
        final RadialAxis _axis = widget.axes[i];
        if (_axis._imageStream != null) {
          _axis._imageStream.removeListener(_axis._listener);
        }
      }
    }

    super.dispose();
  }

  /// Method to repaint the gauge elements
  void _repaintGaugeElements() {
    if (widget._needsToAnimateAxes) {
      axisRepaintNotifier.value++;
    }

    if (widget._needsToAnimateRanges) {
      rangeRepaintNotifier.value++;
    }

    pointerRepaintNotifier.value++;
  }

  /// Method to check whether the gauge needs to be repainted
  void _needsRepaintGauge(SfRadialGauge oldGauge, SfRadialGauge newGauge) {
    if (oldGauge.axes != null && oldGauge.axes.length == newGauge.axes.length) {
      for (num i = 0; i < newGauge.axes.length; i++) {
        _needsRepaintAxis(oldGauge.axes[i], newGauge.axes[i]);
      }
    } else {
      for (num i = 0; i < newGauge.axes.length; i++) {
        newGauge.axes[i]._needsRepaintAxis = true;
      }
    }
  }

  /// Method to check whether the axis needs to be repainted
  void _needsRepaintAxis(RadialAxis oldAxis, RadialAxis newAxis) {
    if (oldAxis.backgroundImage == newAxis.backgroundImage &&
        oldAxis._backgroundImageInfo?.image != null) {
      newAxis._backgroundImageInfo = oldAxis._backgroundImageInfo;
    }

    if (newAxis.startAngle != oldAxis.startAngle ||
        newAxis.endAngle != oldAxis.endAngle ||
        newAxis.ranges != oldAxis.ranges ||
        newAxis.minimum != oldAxis.minimum ||
        newAxis.maximum != oldAxis.maximum ||
        newAxis.axisLineStyle != oldAxis.axisLineStyle ||
        newAxis.labelOffset != oldAxis.labelOffset ||
        newAxis.tickOffset != oldAxis.tickOffset ||
        newAxis.showLabels != oldAxis.showLabels ||
        newAxis.showTicks != oldAxis.showTicks ||
        newAxis.showAxisLine != oldAxis.showAxisLine ||
        newAxis.showLastLabel != oldAxis.showLastLabel ||
        newAxis.showFirstLabel != oldAxis.showFirstLabel ||
        newAxis.interval != oldAxis.interval ||
        newAxis.minorTicksPerInterval != oldAxis.minorTicksPerInterval ||
        newAxis.maximumLabels != oldAxis.maximumLabels ||
        newAxis.isInversed != oldAxis.isInversed ||
        newAxis.labelFormat != oldAxis.labelFormat ||
        newAxis.numberFormat != oldAxis.numberFormat ||
        newAxis.radiusFactor != oldAxis.radiusFactor ||
        newAxis.ticksPosition != oldAxis.ticksPosition ||
        newAxis.labelsPosition != oldAxis.labelsPosition ||
        newAxis.onLabelCreated != oldAxis.onLabelCreated ||
        newAxis.centerX != oldAxis.centerX ||
        newAxis.centerY != oldAxis.centerY ||
        newAxis.onAxisTapped != oldAxis.onAxisTapped ||
        newAxis.needsRotateLabels != oldAxis.needsRotateLabels ||
        newAxis.majorTickStyle != oldAxis.majorTickStyle ||
        newAxis.minorTickStyle != oldAxis.minorTickStyle ||
        newAxis.useRangeColorForAxis != oldAxis.useRangeColorForAxis ||
        newAxis.axisLabelStyle != oldAxis.axisLabelStyle ||
        newAxis.backgroundImage != oldAxis.backgroundImage) {
      newAxis._needsRepaintAxis = true;
    } else {
      newAxis._needsRepaintAxis = false;
    }

    if (newAxis.pointers != null) {
      _needsRepaintPointer(oldAxis, newAxis);
    }

    if (newAxis.ranges != null) {
      _needsRepaintRange(oldAxis, newAxis);
    }

    if (newAxis.annotations != null) {
      _checkGaugeAnnotation(oldAxis, newAxis);
    }
  }

  /// Compares the old annotations with new annotation
  void _checkGaugeAnnotation(RadialAxis oldAxis, RadialAxis newAxis) {
    if (oldAxis.annotations != null) {
      if (newAxis.annotations.length == oldAxis.annotations.length) {
        for (num i = 0; i < newAxis.annotations.length; i++) {
          final GaugeAnnotation _newAnnotation = newAxis.annotations[i];
          final GaugeAnnotation _oldAnnotation = oldAxis.annotations[i];
          if (_newAnnotation.angle == _oldAnnotation.angle &&
              _newAnnotation.axisValue == _oldAnnotation.axisValue &&
              _newAnnotation.horizontalAlignment ==
                  _oldAnnotation.horizontalAlignment &&
              _newAnnotation.verticalAlignment ==
                  _oldAnnotation.verticalAlignment &&
              _newAnnotation.positionFactor == _oldAnnotation.positionFactor &&
              _newAnnotation.widget != _oldAnnotation.widget) {
            _newAnnotation._isOldAnnotation = true;
            _newAnnotation._left = _oldAnnotation._left;
            _newAnnotation._top = _oldAnnotation._top;
          } else {
            _newAnnotation._isOldAnnotation = false;
          }
        }
      }
    }
  }

  /// Checks whether to repaint the ranges
  void _needsRepaintRange(RadialAxis oldAxis, RadialAxis newAxis) {
    if (newAxis.ranges != null) {
      if (oldAxis.ranges != null) {
        if (newAxis.ranges.length == oldAxis.ranges.length) {
          for (num i = 0; i < newAxis.ranges.length; i++) {
            final GaugeRange _newRange = newAxis.ranges[i];
            final GaugeRange _oldRange = oldAxis.ranges[i];
            if (_newRange.startValue != _oldRange.startValue ||
                _newRange.endValue != _oldRange.endValue ||
                _newRange.startWidth != _oldRange.startWidth ||
                _newRange.endWidth != _oldRange.endWidth ||
                _newRange.sizeUnit != _oldRange.sizeUnit ||
                _newRange.color != _oldRange.color ||
                _newRange.rangeOffset != _oldRange.rangeOffset ||
                _newRange.label != _oldRange.label ||
                _newRange.gradient != _oldRange.gradient ||
                _newRange.labelStyle != _oldRange.labelStyle) {
              _newRange._needsRepaintRange = true;
            } else {
              if (newAxis._needsRepaintAxis) {
                _newRange._needsRepaintRange = true;
              } else {
                _newRange._needsRepaintRange = false;
              }
            }
          }
        } else {
          for (num i = 0; i < newAxis.ranges.length; i++) {
            newAxis.ranges[i]._needsRepaintRange = true;
          }
        }
      } else {
        for (num i = 0; i < newAxis.ranges.length; i++) {
          newAxis.ranges[i]._needsRepaintRange = true;
        }
      }
    }
  }

  /// Checks whether to repaint the axis pointers
  void _needsRepaintPointer(RadialAxis oldAxis, RadialAxis newAxis) {
    if (newAxis.pointers != null) {
      if (oldAxis.pointers != null) {
        if (newAxis.pointers.length == oldAxis.pointers.length) {
          _needsAnimatePointers(oldAxis, newAxis);
          _needsResetPointerValue(oldAxis, newAxis);
          for (num i = 0; i < newAxis.pointers.length; i++) {
            final GaugePointer _newPointer = newAxis.pointers[i];
            final GaugePointer _oldPointer = oldAxis.pointers[i];

            if (_newPointer.enableDragging != _oldPointer.enableDragging ||
                _newPointer.onValueChanged != _oldPointer.onValueChanged ||
                _newPointer.enableAnimation != _oldPointer.enableAnimation ||
                _newPointer.animationType != _oldPointer.animationType ||
                _newPointer.animationDuration !=
                    _oldPointer.animationDuration ||
                _newPointer.value != _oldPointer.value) {
              _newPointer._needsRepaintPointer = true;
            } else if (_newPointer is MarkerPointer &&
                _oldPointer is MarkerPointer) {
              final MarkerPointer newMarker = _newPointer;
              final MarkerPointer oldMarker = _oldPointer;
              _needsRepaintMarker(oldMarker, newMarker, newAxis);
            } else if (_newPointer is RangePointer &&
                _oldPointer is RangePointer) {
              final RangePointer _oldRangePointer = _oldPointer;
              final RangePointer _newRangePointer = _newPointer;
              _needsRepaintRangePointer(
                  _oldRangePointer, _newRangePointer, newAxis);
            } else if (_newPointer is NeedlePointer &&
                _oldPointer is NeedlePointer) {
              final NeedlePointer _oldNeedle = _oldPointer;
              final NeedlePointer _newNeedle = _newPointer;
              _needsRepaintNeedle(_oldNeedle, _newNeedle, newAxis);
            }
          }
        } else {
          for (num i = 0; i < newAxis.pointers.length; i++) {
            newAxis.pointers[i]._needsRepaintPointer = true;
          }
        }
      }
    }
  }

  /// Checks whether to repaint the needle pointer
  void _needsRepaintNeedle(
      NeedlePointer _oldNeedle, NeedlePointer _newNeedle, RadialAxis newAxis) {
    if (_newNeedle.knobStyle != _oldNeedle.knobStyle ||
        _newNeedle.tailStyle != _oldNeedle.tailStyle ||
        _newNeedle.needleLength != _oldNeedle.needleLength ||
        _newNeedle.lengthUnit != _oldNeedle.lengthUnit ||
        _newNeedle.needleStartWidth != _oldNeedle.needleStartWidth ||
        _newNeedle.needleEndWidth != _oldNeedle.needleEndWidth ||
        _newNeedle.gradient != _oldNeedle.gradient ||
        _newNeedle.needleColor != _oldNeedle.needleColor) {
      _newNeedle._needsRepaintPointer = true;
    } else {
      _newNeedle._needsRepaintPointer = false;
    }
  }

  /// Checks whether to repaint the range pointer
  void _needsRepaintRangePointer(
      RangePointer _oldPointer, RangePointer _newPointer, RadialAxis newAxis) {
    if (_newPointer.width != _oldPointer.width ||
        _newPointer.sizeUnit != _oldPointer.sizeUnit ||
        _newPointer.pointerOffset != _oldPointer.pointerOffset ||
        _newPointer.color != _oldPointer.color ||
        _newPointer.gradient != _oldPointer.gradient ||
        _newPointer.cornerStyle != _oldPointer.cornerStyle) {
      _newPointer._needsRepaintPointer = true;
    } else {
      if (newAxis._needsRepaintAxis) {
        _newPointer._needsRepaintPointer = true;
      } else {
        _newPointer._needsRepaintPointer = false;
      }
    }
  }

  /// Checks whether to redraw the marker
  void _needsRepaintMarker(
      MarkerPointer _oldMarker, MarkerPointer _newMarker, RadialAxis newAxis) {
    if (_newMarker.markerType != _oldMarker.markerType ||
        _newMarker.markerHeight != _oldMarker.markerHeight ||
        _newMarker.markerWidth != _oldMarker.markerWidth ||
        _newMarker.markerOffset != _oldMarker.markerOffset ||
        _newMarker.imageUrl != _oldMarker.imageUrl ||
        _newMarker.text != _oldMarker.text ||
        _newMarker.textStyle != _oldMarker.textStyle) {
      _newMarker._needsRepaintPointer = true;
    } else {
      if (newAxis._needsRepaintAxis) {
        _newMarker._needsRepaintPointer = true;
      } else {
        _newMarker._needsRepaintPointer = false;
      }
    }
  }

  /// Checks whether to animate the pointers
  void _needsAnimatePointers(RadialAxis oldAxis, RadialAxis newAxis) {
    for (num i = 0; i < newAxis.pointers.length; i++) {
      if (oldAxis.pointers[i].value != newAxis.pointers[i].value) {
        setState(() {
          newAxis.pointers[i]._needsAnimate = true;
          newAxis.pointers[i]._animationStartValue =
              oldAxis.pointers[i]._animationEndValue;
        });
      } else if (oldAxis.pointers[i].animationType !=
          newAxis.pointers[i].animationType) {
        newAxis.pointers[i]._needsAnimate = true;
      } else {
        setState(() {
          newAxis.pointers[i]._needsAnimate = false;
        });
      }
    }
  }

  /// Check to reset the pointer current value
  void _needsResetPointerValue(RadialAxis oldAxis, RadialAxis newAxis) {
    for (num i = 0; i < newAxis.pointers.length; i++) {
      if (oldAxis.pointers[i].enableDragging ==
          newAxis.pointers[i].enableDragging) {
        if (oldAxis.pointers[i].value == newAxis.pointers[i].value &&
            newAxis.pointers[i].value == newAxis.pointers[i]._currentValue &&
            oldAxis.pointers[i]._currentValue !=
                newAxis.pointers[i]._currentValue) {
          newAxis.pointers[i]._currentValue = oldAxis.pointers[i]._currentValue;
        }

        newAxis.pointers[i]._isDragStarted = oldAxis.pointers[i]._isDragStarted;
      }
    }
  }

  ///
  @override
  Widget build(BuildContext context) {
//    SyncfusionLicense.validateLicense(context);
    widget._radialGaugeState = this;
    final ThemeData _theme = Theme.of(context);
    widget._gaugeTheme.initializeGaugeTheme(_theme);

    return LimitedBox(
        maxHeight: 350,
        maxWidth: 350,
        child:
            Column(children: <Widget>[_addGaugeTitle(), _addGaugeElements()]));
  }

  /// Methods to add the title of circular gauge
  Widget _addGaugeTitle() {
    if (widget.title != null && widget.title.text.isNotEmpty) {
      final Widget titleWidget = Container(
          child: Container(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              decoration: BoxDecoration(
                  color: widget.title.backgroundColor ??
                      widget._gaugeTheme.titleBackgroundColor,
                  border: Border.all(
                      color: widget.title.borderColor ??
                          widget._gaugeTheme.titleBorderColor,
                      width: widget.title.borderWidth)),
              child: Text(
                widget.title.text,
                style: widget.title.textStyle,
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
              ),
              alignment: (widget.title.alignment == GaugeAlignment.near)
                  ? Alignment.topLeft
                  : (widget.title.alignment == GaugeAlignment.far)
                      ? Alignment.topRight
                      : (widget.title.alignment == GaugeAlignment.center)
                          ? Alignment.topCenter
                          : Alignment.topCenter));

      return titleWidget;
    } else {
      return Container();
    }
  }

  /// Method to add the elements of gauge
  Widget _addGaugeElements() {
    return Expanded(child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return _AxisContainer(widget);
      },
    ));
  }
}
