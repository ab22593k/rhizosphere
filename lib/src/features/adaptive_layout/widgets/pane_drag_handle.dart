import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Snap widths for pane resizing as per M3 specs.
class PaneSnapWidths {
  static const double small = 360.0;
  static const double medium = 412.0;
  static const double collapsed = 0.0;
}

/// Position state of the drag handle.
enum PaneLayoutState { leftExpanded, rightExpanded, equalSized }

/// A drag handle widget for resizing panes in a layout.
///
/// Implements Material Design 3 specifications for pane drag handles:
/// - Hover state with size change and cursor
/// - Keyboard navigation (Tab, Space/Enter, Arrows)
/// - Screen reader support with roles and states
/// - Snap-to-width behavior
/// - Touch region priority over back gesture
class PaneDragHandle extends StatefulWidget {
  /// Callback when the pane width changes via drag.
  final ValueChanged<double> onDrag;

  /// Callback when a snap position is activated (e.g., via double-tap or keyboard).
  final ValueChanged<double>? onSnapToWidth;

  /// Current width of the left/primary pane.
  final double currentPaneWidth;

  /// Minimum width for the pane.
  final double minPaneWidth;

  /// Maximum width for the pane.
  final double maxPaneWidth;

  /// Whether the handle is horizontal (between side-by-side panes).
  /// False for vertical (between stacked panes).
  final bool isHorizontal;

  /// Whether to show the handle. In list-detail, hide until item selected.
  final bool isVisible;

  /// Custom snap widths. Defaults to [PaneSnapWidths] values.
  final List<double>? snapWidths;

  const PaneDragHandle({
    required this.onDrag,
    required this.currentPaneWidth,
    required this.minPaneWidth,
    required this.maxPaneWidth,
    this.onSnapToWidth,
    this.isHorizontal = true,
    this.isVisible = true,
    this.snapWidths,
    super.key,
  });

  @override
  State<PaneDragHandle> createState() => _PaneDragHandleState();
}

class _PaneDragHandleState extends State<PaneDragHandle> {
  bool _isHovered = false;
  bool _isFocused = false;
  bool _isDragging = false;

  late List<double> _snapWidths;
  int _currentSnapIndex = 0;

  @override
  void initState() {
    super.initState();
    _snapWidths =
        widget.snapWidths ??
        [
          PaneSnapWidths.collapsed,
          PaneSnapWidths.small,
          PaneSnapWidths.medium,
          widget.maxPaneWidth / 2, // Split-pane centered
          widget.maxPaneWidth,
        ];
  }

  PaneLayoutState get _layoutState {
    if (widget.currentPaneWidth <= widget.minPaneWidth) {
      return PaneLayoutState.rightExpanded;
    } else if (widget.currentPaneWidth >= widget.maxPaneWidth) {
      return PaneLayoutState.leftExpanded;
    }
    return PaneLayoutState.equalSized;
  }

  String get _accessibilityLabel {
    switch (_layoutState) {
      case PaneLayoutState.leftExpanded:
        return 'Resize layout. Left pane expanded.';
      case PaneLayoutState.rightExpanded:
        return 'Resize layout. Right pane expanded.';
      case PaneLayoutState.equalSized:
        return 'Resize layout. Panes equally sized.';
    }
  }

  void _handleTap() {
    // Snap to next predefined width
    _currentSnapIndex = (_currentSnapIndex + 1) % _snapWidths.length;
    final targetWidth = _snapWidths[_currentSnapIndex];
    widget.onSnapToWidth?.call(targetWidth);
    widget.onDrag(targetWidth.clamp(widget.minPaneWidth, widget.maxPaneWidth));
  }

  void _handleDoubleTap() {
    // Toggle between collapsed and split
    final isMostlyCollapsed =
        widget.currentPaneWidth < (widget.maxPaneWidth * 0.2);
    final targetWidth = isMostlyCollapsed
        ? widget.maxPaneWidth / 2
        : widget.minPaneWidth;
    widget.onSnapToWidth?.call(targetWidth);
    widget.onDrag(targetWidth);
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is! KeyDownEvent) return;

    double delta = 0;
    if (widget.isHorizontal) {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        delta = -20;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        delta = 20;
      }
    } else {
      if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        delta = -20;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        delta = 20;
      }
    }

    if (delta != 0) {
      final newWidth = (widget.currentPaneWidth + delta).clamp(
        widget.minPaneWidth,
        widget.maxPaneWidth,
      );
      widget.onDrag(newWidth);
    }

    // Space or Enter to snap
    if (event.logicalKey == LogicalKeyboardKey.space ||
        event.logicalKey == LogicalKeyboardKey.enter) {
      _handleTap();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isVisible) {
      return const SizedBox.shrink();
    }

    final colorScheme = Theme.of(context).colorScheme;
    final handleColor = colorScheme.outlineVariant;
    final hoverColor = colorScheme.outline;

    // Handle visual dimensions
    final handleWidth = widget.isHorizontal ? 4.0 : double.infinity;
    final handleHeight = widget.isHorizontal ? double.infinity : 4.0;
    final touchTargetSize = 48.0; // Touch target for accessibility

    // Expand on hover/focus
    final visualWidth = widget.isHorizontal
        ? (_isHovered || _isFocused ? 6.0 : 4.0)
        : null;
    final visualHeight = !widget.isHorizontal
        ? (_isHovered || _isFocused ? 6.0 : 4.0)
        : null;

    return Semantics(
      button: true,
      label: _accessibilityLabel,
      child: Focus(
        onFocusChange: (focused) {
          setState(() {
            _isFocused = focused;
          });
        },
        onKeyEvent: (node, event) {
          _handleKeyEvent(event);
          return KeyEventResult.handled;
        },
        child: MouseRegion(
          cursor: widget.isHorizontal
              ? SystemMouseCursors.resizeColumn
              : SystemMouseCursors.resizeRow,
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: GestureDetector(
            onTap: _handleTap,
            onDoubleTap: _handleDoubleTap,
            onHorizontalDragStart: widget.isHorizontal
                ? (_) => _startDrag()
                : null,
            onHorizontalDragUpdate: widget.isHorizontal
                ? _onHorizontalDrag
                : null,
            onHorizontalDragEnd: widget.isHorizontal ? (_) => _endDrag() : null,
            onVerticalDragStart: !widget.isHorizontal
                ? (_) => _startDrag()
                : null,
            onVerticalDragUpdate: !widget.isHorizontal ? _onVerticalDrag : null,
            onVerticalDragEnd: !widget.isHorizontal ? (_) => _endDrag() : null,
            behavior: HitTestBehavior.opaque,
            child: SizedBox(
              width: widget.isHorizontal ? touchTargetSize : handleWidth,
              height: widget.isHorizontal ? handleHeight : touchTargetSize,
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: visualWidth ?? handleWidth,
                  height: visualHeight ?? handleHeight,
                  constraints: BoxConstraints(
                    maxHeight: widget.isHorizontal ? 48 : double.infinity,
                    maxWidth: widget.isHorizontal ? double.infinity : 48,
                  ),
                  decoration: BoxDecoration(
                    color: _isHovered || _isFocused || _isDragging
                        ? hoverColor
                        : handleColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Center(
                    child: Container(
                      width: widget.isHorizontal ? 2 : 24,
                      height: widget.isHorizontal ? 24 : 2,
                      decoration: BoxDecoration(
                        color: colorScheme.onSurfaceVariant,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _startDrag() {
    setState(() => _isDragging = true);
  }

  void _endDrag() {
    setState(() => _isDragging = false);
    // Snap to nearest width on release
    _snapToNearestWidth();
  }

  void _onHorizontalDrag(DragUpdateDetails details) {
    final newWidth = (widget.currentPaneWidth + details.delta.dx).clamp(
      widget.minPaneWidth,
      widget.maxPaneWidth,
    );
    widget.onDrag(newWidth);
  }

  void _onVerticalDrag(DragUpdateDetails details) {
    final newWidth = (widget.currentPaneWidth + details.delta.dy).clamp(
      widget.minPaneWidth,
      widget.maxPaneWidth,
    );
    widget.onDrag(newWidth);
  }

  void _snapToNearestWidth() {
    double nearestWidth = _snapWidths.first;
    double minDistance = (widget.currentPaneWidth - nearestWidth).abs();

    for (final snapWidth in _snapWidths) {
      final distance = (widget.currentPaneWidth - snapWidth).abs();
      if (distance < minDistance) {
        minDistance = distance;
        nearestWidth = snapWidth;
      }
    }

    // Only snap if within 24dp of a snap point
    if (minDistance <= 24) {
      widget.onSnapToWidth?.call(nearestWidth);
      widget.onDrag(
        nearestWidth.clamp(widget.minPaneWidth, widget.maxPaneWidth),
      );
    }
  }
}
