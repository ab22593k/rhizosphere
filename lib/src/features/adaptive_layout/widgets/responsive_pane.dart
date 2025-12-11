import 'package:flutter/material.dart';

import '../../../core/adaptive/layout/adaptive_builder.dart';
import '../../../core/adaptive/layout/pane_configuration.dart';
import 'pane_drag_handle.dart';

class ThreePaneLayout extends StatefulWidget {
  final Widget? supportingPane;
  final Widget primaryPane;
  final Widget? detailPane;

  /// Whether to show the drag handle. In list-detail, set to false until item selected.
  final bool showDragHandle;

  /// Callback when pane width changes.
  final ValueChanged<double>? onPaneWidthChanged;

  /// Initial width ratio of primary pane (0.0 to 1.0).
  final double initialPrimaryRatio;

  const ThreePaneLayout({
    this.supportingPane,
    required this.primaryPane,
    this.detailPane,
    this.showDragHandle = true,
    this.onPaneWidthChanged,
    this.initialPrimaryRatio = 0.5,
    super.key,
  });

  @override
  State<ThreePaneLayout> createState() => _ThreePaneLayoutState();
}

class _ThreePaneLayoutState extends State<ThreePaneLayout> {
  double? _primaryPaneWidth;
  bool _isInitialized = false;

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: (context, sizeClass, _) {
        final config = PaneConfiguration.forSizeClass(sizeClass);

        switch (config.behavior) {
          case PaneBehavior.stacked:
            return widget.primaryPane;

          case PaneBehavior.sidebar:
            return Row(
              children: [
                if (widget.supportingPane != null &&
                    config.supportingPane == PaneVisibility.permanent)
                  SizedBox(width: 250, child: widget.supportingPane),
                Expanded(child: widget.primaryPane),
              ],
            );

          case PaneBehavior.reflow:
            return LayoutBuilder(
              builder: (context, constraints) {
                final availableWidth = constraints.maxWidth;
                final supportingWidth =
                    widget.supportingPane != null &&
                        config.supportingPane == PaneVisibility.permanent
                    ? 200.0
                    : 0.0;
                final contentWidth = availableWidth - supportingWidth;

                // Initialize primary pane width
                if (!_isInitialized) {
                  _primaryPaneWidth = contentWidth * widget.initialPrimaryRatio;
                  _isInitialized = true;
                }

                // Clamp to valid range
                final minPaneWidth = 280.0;
                final maxPaneWidth =
                    contentWidth - minPaneWidth - 48; // 48 for handle
                _primaryPaneWidth = _primaryPaneWidth?.clamp(
                  minPaneWidth,
                  maxPaneWidth,
                );

                final hasDetail =
                    widget.detailPane != null &&
                    config.detailPane == PaneVisibility.permanent;
                final showHandle = widget.showDragHandle && hasDetail;

                return Row(
                  children: [
                    // Supporting Pane
                    if (widget.supportingPane != null &&
                        config.supportingPane == PaneVisibility.permanent)
                      Container(
                        width: supportingWidth,
                        color: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerLow,
                        child: widget.supportingPane,
                      ),

                    // Primary Pane (resizable)
                    SizedBox(
                      width: hasDetail ? _primaryPaneWidth : null,
                      child: hasDetail
                          ? widget.primaryPane
                          : Expanded(child: widget.primaryPane),
                    ),

                    // Drag Handle
                    if (showHandle)
                      PaneDragHandle(
                        currentPaneWidth: _primaryPaneWidth ?? contentWidth / 2,
                        minPaneWidth: minPaneWidth,
                        maxPaneWidth: maxPaneWidth,
                        isVisible: showHandle,
                        onDrag: (newWidth) {
                          setState(() {
                            _primaryPaneWidth = newWidth;
                          });
                          widget.onPaneWidthChanged?.call(newWidth);
                        },
                        snapWidths: [
                          minPaneWidth,
                          360,
                          412,
                          contentWidth / 2,
                          maxPaneWidth,
                        ],
                      ),

                    // Detail Pane
                    if (hasDetail)
                      Expanded(
                        child: Container(
                          color: Theme.of(context).colorScheme.surfaceContainer,
                          child: widget.detailPane,
                        ),
                      ),
                  ],
                );
              },
            );
        }
      },
    );
  }
}
