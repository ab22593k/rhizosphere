import 'package:flutter/material.dart';

class BaseLayout extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? floatingActionButton;

  const BaseLayout({
    super.key,
    required this.title,
    required this.body,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // AppBar title is automatically a semantic header on most platforms,
        // but we can enforce it if needed.
        title: Semantics(header: true, label: 'Page Title', child: Text(title)),
      ),
      body: SafeArea(
        child: Semantics(
          // Mark the body as a container for semantic traversal
          container: true,
          // Add a label to identify the main content area (Landmark)
          label: 'Main Content',
          explicitChildNodes: true,
          child: body,
        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
