part of charts;

abstract class _CustomizeLegend {
  void drawLegendItem(int index, _LegendRenderContext legendItem, Legend legend,
      dynamic chart, Canvas canvas, Size size);
  Color getLegendTextColor(
      int index, _LegendRenderContext legendItem, Color textColor);
  Color getLegendIconColor(
      int index, _LegendRenderContext legendItem, Color iconColor);
  Color getLegendIconBorderColor(
      int index, _LegendRenderContext legendItem, Color iconBorderColor);
  double getLegendIconBorderWidth(
      int index, _LegendRenderContext legendItem, double iconBorderWidth);
}

class _LegendRenderer with _CustomizeLegend {
  @override
  Color getLegendIconBorderColor(
          int index, _LegendRenderContext legendItem, Color iconBorderColor) =>
      iconBorderColor;

  @override
  Color getLegendIconColor(
          int index, _LegendRenderContext legendItem, Color iconColor) =>
      iconColor;

  @override
  Color getLegendTextColor(
          int index, _LegendRenderContext legendItem, Color textColor) =>
      textColor;

  @override
  double getLegendIconBorderWidth(
          int index, _LegendRenderContext legendItem, double iconBorderWidth) =>
      iconBorderWidth;

  @override
  void drawLegendItem(int index, _LegendRenderContext legendItem, Legend legend,
      dynamic chart, Canvas canvas, Size size) {
    final String legendText = legendItem.text;
    final List<Color> palette = chart.palette;
    Color color = legendItem.iconColor ?? palette[index % palette.length];
    color = legend._renderer.getLegendIconColor(index, legendItem, color);
    final Size textSize = legendItem.textSize;
    final Offset iconOffset =
        Offset(legend.itemPadding + legend.iconWidth / 2, size.height / 2);
    legendItem.isSelect = chart is SfCartesianChart
        ? !legendItem.series._visible
        : !legendItem.point.isVisible;
    final ChartTextStyle textStyle = legendItem.isSelect
        ? _getTextStyle(
            textStyle: legend.textStyle,
            takeFontColorValue: true,
            fontColor: const Color.fromRGBO(211, 211, 211, 1))
        : _getTextStyle(
            textStyle: legend.textStyle,
            fontColor: legend._renderer.getLegendTextColor(
                index, legendItem, chart._chartTheme.legendLabelColor));

    _drawLegendShape(
        index,
        iconOffset,
        canvas,
        Size(legend.iconWidth.toDouble(), legend.iconHeight.toDouble()),
        legend,
        legendItem.iconType,
        color,
        legendItem,
        chart);
    _drawText(
        canvas,
        legendText,
        Offset(iconOffset.dx + legend.padding + legend.iconWidth / 2,
            (size.height / 2) - textSize.height / 2),
        textStyle);
  }

  LegendIconType _getIconType(DataMarkerType shape) {
    LegendIconType iconType;
    switch (shape) {
      case DataMarkerType.circle:
        iconType = LegendIconType.circle;
        break;
      case DataMarkerType.rectangle:
        iconType = LegendIconType.rectangle;
        break;
      case DataMarkerType.image:
        iconType = LegendIconType.image;
        break;
      case DataMarkerType.pentagon:
        iconType = LegendIconType.pentagon;
        break;
      case DataMarkerType.verticalLine:
        iconType = LegendIconType.verticalLine;
        break;
      case DataMarkerType.invertedTriangle:
        iconType = LegendIconType.invertedTriangle;
        break;
      case DataMarkerType.horizontalLine:
        iconType = LegendIconType.horizontalLine;
        break;
      case DataMarkerType.diamond:
        iconType = LegendIconType.diamond;
        break;
      case DataMarkerType.triangle:
        iconType = LegendIconType.triangle;
        break;
    }
    return iconType;
  }

  void _drawLegendShape(
      int index,
      Offset location,
      Canvas canvas,
      Size size,
      Legend legend,
      LegendIconType iconType,
      Color color,
      _LegendRenderContext legendRenderContext,
      dynamic chart) {
    final Path path = Path();
    final LegendIconType actualIconType = iconType;
    PaintingStyle style = PaintingStyle.fill;
    iconType = _getLegendIconType(iconType, legendRenderContext);
    final double width = (legendRenderContext.series.legendIconType ==
                LegendIconType.seriesType &&
            (legendRenderContext.series._seriesType == 'line' ||
                legendRenderContext.series._seriesType == 'stackedline' ||
                legendRenderContext.series._seriesType == 'stackedline100'))
        ? size.width / 1.5
        : size.width;
    final double height = (legendRenderContext.series.legendIconType ==
                LegendIconType.seriesType &&
            (legendRenderContext.series._seriesType == 'line' ||
                legendRenderContext.series._seriesType == 'stackedline' ||
                legendRenderContext.series._seriesType == 'stackedline100'))
        ? size.height / 1.5
        : size.height;
    style = _getPathAndStyle(iconType, style, path, location, width, height,
        legendRenderContext.series, chart, canvas);
    if (color != null) {
      final Paint fillPaint = Paint()
        ..color = !legendRenderContext.isSelect
            ? (color == Colors.transparent
                ? color
                : color.withOpacity(legend.opacity))
            : const Color.fromRGBO(211, 211, 211, 1)
        ..strokeWidth = legend.iconBorderWidth > 0 ? legend.iconBorderWidth : 1
        ..style = (iconType == LegendIconType.seriesType)
            ? style
            : (iconType == LegendIconType.horizontalLine ||
                    iconType == LegendIconType.verticalLine
                ? PaintingStyle.stroke
                : PaintingStyle.fill);
      final String _seriesType = legendRenderContext.series._seriesType;
      if ((actualIconType == LegendIconType.seriesType &&
              (_seriesType == 'line' ||
                  _seriesType == 'fastline' ||
                  _seriesType == 'stackedline' ||
                  _seriesType == 'stackedline100')) ||
          (iconType == LegendIconType.seriesType &&
              (_seriesType == 'radialbar' || _seriesType == 'doughnut'))) {
        _drawIcon(iconType, index, _seriesType, legendRenderContext, chart,
            width, height, location, size, canvas, fillPaint, path);
      } else {
        (legendRenderContext.series.legendIconType ==
                    LegendIconType.seriesType &&
                (_seriesType == 'spline' || _seriesType == 'stepline') &&
                legendRenderContext.series.dashArray[0] != 0)
            ? canvas.drawPath(
                _dashPath(path,
                    dashArray: _CircularIntervalList<double>(<double>[3, 2])),
                fillPaint)
            : canvas.drawPath(
                path,
                (legendRenderContext.series is CartesianSeries &&
                        !legendRenderContext.isSelect &&
                        legendRenderContext.series.gradient != null)
                    ? _getLinearGradientPaint(
                        legendRenderContext.series.gradient,
                        path.getBounds(),
                        legendRenderContext.series._chart._requireInvertedAxis)
                    : fillPaint);
      }
    }
    final double iconBorderWidth = legend._renderer.getLegendIconBorderWidth(
        index, legendRenderContext, legend.iconBorderWidth);
    if (iconBorderWidth != null && iconBorderWidth > 0) {
      final Paint strokePaint = Paint()
        ..color = !legendRenderContext.isSelect
            ? legend._renderer.getLegendIconBorderColor(
                index,
                legendRenderContext,
                legend.iconBorderColor.withOpacity(legend.opacity))
            : const Color.fromRGBO(211, 211, 211, 1)
        ..strokeWidth = iconBorderWidth
        ..style = PaintingStyle.stroke;
      canvas.drawPath(path, strokePaint);
    }
  }

  LegendIconType _getLegendIconType(
      LegendIconType iconType, _LegendRenderContext legendRenderContext) {
    return legendRenderContext.series._seriesType == 'scatter'
        ? (iconType != LegendIconType.seriesType
            ? iconType
            : _getIconType(legendRenderContext.series.markerSettings.shape))
        : (iconType == LegendIconType.seriesType &&
                (legendRenderContext.series._seriesType == 'line' ||
                    legendRenderContext.series._seriesType == 'fastline' ||
                    legendRenderContext.series._seriesType == 'stackedline' ||
                    legendRenderContext.series._seriesType ==
                        'stackedline100') &&
                legendRenderContext.series.markerSettings.isVisible &&
                legendRenderContext.series.markerSettings.shape !=
                    DataMarkerType.image
            ? _getIconType(legendRenderContext.series.markerSettings.shape)
            : iconType);
  }

  PaintingStyle _getPathAndStyle(
      LegendIconType iconType,
      PaintingStyle style,
      Path path,
      Offset location,
      double width,
      double height,
      dynamic series,
      dynamic chart,
      Canvas canvas) {
    final double x = location.dx;
    final double y = location.dy;
    switch (iconType) {
      case LegendIconType.seriesType:
        style = _calculateLegendShapes(
            path, x, y, width, height, series._seriesType);
        break;
      case LegendIconType.circle:
        _ChartShapeUtils._drawCircle(path, x, y, width, height);
        break;

      case LegendIconType.rectangle:
        _ChartShapeUtils._drawRectangle(path, x, y, width, height);
        break;
      case LegendIconType.image:
        {
          void _drawLegendImage(Canvas canvas, dart_ui.Image image) {
            final Rect rect =
                Rect.fromLTWH(x - width / 2, y - height / 2, width, height);
            paintImage(
                canvas: canvas, rect: rect, image: image, fit: BoxFit.fill);
          }

          if (chart.legend.image != null &&
              chart._chartState._legendIconImage != null) {
            _drawLegendImage(canvas, chart._chartState._legendIconImage);
          } else if (series._seriesType == 'scatter' &&
              series.markerSettings.shape == DataMarkerType.image &&
              series.markerSettings._image != null) {
            _drawLegendImage(canvas, series.markerSettings._image);
          }
          break;
        }
      case LegendIconType.pentagon:
        _ChartShapeUtils._drawPentagon(path, x, y, width, height);
        break;

      case LegendIconType.verticalLine:
        _ChartShapeUtils._drawVerticalLine(path, x, y, width, height);
        break;

      case LegendIconType.invertedTriangle:
        _ChartShapeUtils._drawInvertedTriangle(path, x, y, width, height);
        break;

      case LegendIconType.horizontalLine:
        _ChartShapeUtils._drawHorizontalLine(path, x, y, width, height);
        break;

      case LegendIconType.diamond:
        _ChartShapeUtils._drawDiamond(path, x, y, width, height);
        break;

      case LegendIconType.triangle:
        _ChartShapeUtils._drawTriangle(path, x, y, width, height);
        break;
    }
    return style;
  }

  void _drawIcon(
      LegendIconType iconType,
      int index,
      String seriesType,
      _LegendRenderContext legendRenderContext,
      dynamic chart,
      double width,
      double height,
      Offset location,
      Size size,
      Canvas canvas,
      Paint fillPaint,
      Path path) {
    if (seriesType.contains('line')) {
      if (iconType != LegendIconType.seriesType) {
        canvas.drawPath(path, fillPaint);
      }
      final Path linePath = Path();
      linePath.moveTo(location.dx - size.width / 1.5, location.dy);
      linePath.lineTo(location.dx + size.width / 1.5, location.dy);
      final Paint _paint = Paint()
        ..color = fillPaint.color.withOpacity(chart.legend.opacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth =
            chart.legend.iconBorderWidth > 0 ? chart.legend.iconBorderWidth : 2;
      legendRenderContext.series.dashArray[0] != 0
          ? canvas.drawPath(
              _dashPath(linePath,
                  dashArray: _CircularIntervalList<double>(<double>[3, 2])),
              _paint)
          : canvas.drawPath(linePath, _paint);
    } else if (seriesType == 'radialbar') {
      final num radius = (width + height) / 2;
      _drawPath(
          canvas,
          _StyleOptions(Colors.grey[100], fillPaint.strokeWidth,
              Colors.grey[300].withOpacity(0.5)),
          _getArcPath(
              (radius / 2) - 2,
              radius / 2,
              Offset(location.dx, location.dy),
              0,
              360 - 0.01,
              360 - 0.01,
              chart,
              true));
      const num pointStartAngle = -90;
      num degree = legendRenderContext.series._renderPoints[index].y.abs() /
          (legendRenderContext.series.maximumValue ??
              legendRenderContext.series._sumOfPoints);
      degree = (degree > 1 ? 1 : degree) * (360 - 0.001);
      final num pointEndAngle = pointStartAngle + degree;
      _drawPath(
          canvas,
          _StyleOptions(
              fillPaint.color, fillPaint.strokeWidth, Colors.transparent),
          _getArcPath(
              (radius / 2) - 2,
              radius / 2,
              Offset(location.dx, location.dy),
              pointStartAngle,
              pointEndAngle,
              degree,
              chart,
              true));
    } else {
      final num radius = (width + height) / 2;
      _drawPath(
          canvas,
          _StyleOptions(fillPaint.color, fillPaint.strokeWidth,
              Colors.grey[300].withOpacity(0.5)),
          _getArcPath(radius / 4, radius / 2, Offset(location.dx, location.dy),
              0, 270, 270, chart, true));
      _drawPath(
          canvas,
          _StyleOptions(fillPaint.color, fillPaint.strokeWidth,
              Colors.grey[300].withOpacity(0.5)),
          _getArcPath(
              radius / 4,
              radius / 2,
              Offset(location.dx + 1, location.dy - 1),
              -5,
              -85,
              -85,
              chart,
              true));
    }
  }
}

class _RenderLegend extends StatelessWidget {
  const _RenderLegend({this.index, this.size, this.chart, this.template});

  final int index;

  final Size size;

  final dynamic chart;

  final Widget template;

  @override
  Widget build(BuildContext context) {
    bool isSelect;
    if (chart.legend.legendItemBuilder != null) {
      final _MeasureWidgetContext _measureWidgetContext =
          chart._chartState.legendWidgetContext[index];
      isSelect = chart is SfCartesianChart
          ? chart.series[_measureWidgetContext.seriesIndex]._visible
          : chart._chartSeries.visibleSeries[_measureWidgetContext.seriesIndex]
              ._renderPoints[_measureWidgetContext.pointIndex].isVisible;
    }
    return Container(
        height: size.height,
        width: chart.legend._orientation == LegendItemOrientation.vertical &&
                (chart.legend.overflowMode == LegendItemOverflowMode.scroll ||
                    chart.legend.overflowMode == LegendItemOverflowMode.none)
            ? chart._chartLegend.legendSize.width
            : size.width,
        child: GestureDetector(
            onTapUp: (TapUpDetails details) {
              if (chart is SfCartesianChart) {
                _processCartesianSeriesToggle();
              } else {
                _processCircularPointsToggle();
              }
            },
            child: template != null
                ? !isSelect ? Opacity(child: template, opacity: 0.5) : template
                : CustomPaint(
                    painter: _ChartLegendPainter(
                        chart: chart,
                        legendIndex: index,
                        isSelect: chart
                            ._chartLegend.legendCollections[index].isSelect,
                        notifier: chart._chartLegend.legendRepaintNotifier))));
  }

  void _processCircularPointsToggle() {
    LegendTapArgs legendTapArgs;
    const int seriesIndex = 0;
    if (chart.onLegendTapped != null) {
      legendTapArgs = LegendTapArgs();
      if (chart is SfCircularChart) {
        legendTapArgs.series = chart.series[seriesIndex];
      } else {
        legendTapArgs.series = chart._series[seriesIndex];
      }
      legendTapArgs.seriesIndex = seriesIndex;
      legendTapArgs.pointIndex = index;
      chart.onLegendTapped(legendTapArgs);
    }
    if (chart.legend.toggleSeriesVisibility) {
      if (chart.legend.legendItemBuilder != null) {
        _legendToggleTemplateState(
            chart._chartState.legendWidgetContext[index], chart, '');
      } else {
        _legendToggleState(chart._chartLegend.legendCollections[index], chart);
      }
      chart._chartState._isLegendToggled = true;
      chart._chartState._redraw();
    }
  }

  void _processCartesianSeriesToggle() {
    LegendTapArgs legendTapArgs;
    _MeasureWidgetContext _measureWidgetContext;
    _LegendRenderContext _legendRenderContext;
    if (chart.onLegendTapped != null) {
      legendTapArgs = LegendTapArgs();
      if (chart.legend.legendItemBuilder != null) {
        _measureWidgetContext = chart._chartState.legendWidgetContext[index];
        legendTapArgs.seriesIndex = _measureWidgetContext.seriesIndex;
        legendTapArgs.series =
            chart._chartSeries.visibleSeries[_measureWidgetContext.seriesIndex];
      } else {
        _legendRenderContext = chart._chartLegend.legendCollections[index];
        legendTapArgs.seriesIndex = _legendRenderContext.seriesIndex;
        legendTapArgs.series = _legendRenderContext.series;
      }
      chart.onLegendTapped(legendTapArgs);
    }
    if (chart.legend.toggleSeriesVisibility) {
      if (chart.legend.legendItemBuilder != null) {
        _legendToggleTemplateState(
            chart._chartState.legendWidgetContext[index], chart, '');
      } else {
        _legendToggleState(chart._chartLegend.legendCollections[index], chart);
      }
      if (chart._chartSeries.visibleSeries[0]._seriesType == 'column' ||
          chart._chartSeries.visibleSeries[0]._seriesType == 'bar') {
        chart._chartState._isLegendToggled = true;
      }
      chart._chartState._legendToggling = true;
      chart._chartState._redraw();
    }
  }
}

class _ChartLegendStylePainter extends CustomPainter {
  _ChartLegendStylePainter({this.chart});

  final dynamic chart;

  @override
  void paint(Canvas canvas, Size size) {
    final Legend legend = chart.legend;
    if (legend.backgroundColor != null) {
      canvas.drawRect(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Paint()
            ..color = legend.backgroundColor ??
                chart._chartTheme.legendBackGroundColor
            ..style = PaintingStyle.fill);
    }
    if (legend.borderColor != null && legend.borderWidth > 0) {
      canvas.drawRect(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Paint()
            ..color = legend.borderColor
            ..strokeWidth = legend.borderWidth
            ..style = PaintingStyle.stroke);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class _ChartLegendPainter extends CustomPainter {
  _ChartLegendPainter(
      {this.chart,
      this.legendIndex,
      this.isSelect,
      ValueNotifier<int> notifier})
      : super(repaint: notifier);

  final dynamic chart;

  final int legendIndex;

  final bool isSelect;

  @override
  void paint(Canvas canvas, Size size) {
    final Legend legend = chart.legend;
    final _LegendRenderContext legendRenderContext =
        chart._chartLegend.legendCollections[legendIndex];
    legend._renderer.drawLegendItem(
        legendIndex, legendRenderContext, legend, chart, canvas, size);
  }

  @override
  bool shouldRepaint(_ChartLegendPainter oldDelegate) => true;
}

class _LegendRenderContext {
  _LegendRenderContext(
      {this.size,
      this.text,
      this.textSize,
      this.iconColor,
      this.iconType,
      this.point,
      this.isSelect,
      this.seriesIndex,
      this.series});

  String text;

  Color iconColor;

  Size textSize;

  LegendIconType iconType;

  Size size;

  Size templateSize;

  dynamic series;

  dynamic point;

  int seriesIndex;

  bool isSelect;

  bool isRender = false;
}
