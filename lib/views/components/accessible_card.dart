import 'package:flutter/material.dart';

class AccessibleCard extends StatefulWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const AccessibleCard({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
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
    return Semantics(
      button: true,
      label: '${widget.title}, ${widget.description}',
      hint: 'Double tap to activate',
      child: Padding(
        padding: const EdgeInsets.all(8.0), // 8dp spacing
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
    );
  }
}
