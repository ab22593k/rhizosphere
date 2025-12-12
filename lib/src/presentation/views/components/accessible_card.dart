import 'package:flutter/material.dart';

/// An accessible card widget that properly augments semantics.
///
/// Uses [MergeSemantics] to combine:
/// - Custom label (title + description) for clear announcement
/// - InkWell's native semantics (tap action, focus state)
/// - Platform-specific behaviors (long-press, context menus)
///
/// This approach preserves child semantics like tooltips, hints, and
/// values that might be added by child widgets.
class AccessibleCard extends StatefulWidget {
  final String title;
  final String description;
  final VoidCallback? onTap;

  const AccessibleCard({
    super.key,
    required this.title,
    required this.description,
    this.onTap,
  });

  @override
  State<AccessibleCard> createState() => _AccessibleCardState();
}

class _AccessibleCardState extends State<AccessibleCard> {
  // FocusNode to control focus behavior manually if needed,
  // though InkWell handles it automatically.
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onTap != null;

    // Use MergeSemantics to augment (not replace) InkWell's semantics.
    // This preserves:
    // - Tap action from InkWell
    // - Focus state for keyboard navigation
    // - Any tooltips or hints from child widgets
    return MergeSemantics(
      child: Padding(
        padding: const EdgeInsets.all(8.0), // 8dp spacing
        child: Semantics(
          // Provide combined label for clarity
          label: '${widget.title}, ${widget.description}',
          // Hint only shown when card is actionable
          hint: isEnabled ? 'Double tap to activate' : null,
          // Let InkWell provide the button role via its onTap
          enabled: isEnabled,
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).cardColor,
            child: InkWell(
              focusNode: _focusNode,
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(8),
              // Ensure minimum touch target size of 48x48
              child: Container(
                constraints: const BoxConstraints(minHeight: 48, minWidth: 48),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
