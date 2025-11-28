import 'package:flutter/material.dart';

import '../../../core/adaptive/layout/adaptive_builder.dart';
import '../../../core/adaptive/layout/pane_configuration.dart';

class ThreePaneLayout extends StatelessWidget {
  final Widget? supportingPane;
  final Widget primaryPane;
  final Widget? detailPane;

  const ThreePaneLayout({
    this.supportingPane,
    required this.primaryPane,
    this.detailPane,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveBuilder(
      builder: (context, sizeClass, _) {
        final config = PaneConfiguration.forSizeClass(sizeClass);

        switch (config.behavior) {
          case PaneBehavior.stacked:
            return primaryPane; // Basic stacked, navigation handles others

          case PaneBehavior.sidebar:
            return Row(
              children: [
                // Navigation Rail is usually handled by Scaffold, but supporting pane
                // might be a list of items.
                if (supportingPane != null &&
                    config.supportingPane == PaneVisibility.permanent)
                  SizedBox(
                    width: 250, // Fixed or flexible
                    child: supportingPane,
                  ),
                Expanded(child: primaryPane),
                // Detail pane floating/levitating handled via overlay or separate route usually
              ],
            );

          case PaneBehavior.reflow:
            return Row(
              children: [
                if (supportingPane != null &&
                    config.supportingPane == PaneVisibility.permanent)
                  SizedBox(width: 200, child: supportingPane),
                Expanded(child: primaryPane),
                if (detailPane != null &&
                    config.detailPane == PaneVisibility.permanent)
                  SizedBox(width: 300, child: detailPane),
              ],
            );
        }
      },
    );
  }
}
