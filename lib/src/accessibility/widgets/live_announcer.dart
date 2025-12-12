import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

/// Assertiveness level for screen reader announcements.
///
/// Maps to ARIA live region politeness levels:
/// - [polite]: Announcement waits for current speech to finish (default)
/// - [assertive]: Announcement interrupts current speech immediately
enum AnnouncementAssertiveness {
  /// Wait for current speech to finish before announcing.
  /// Use for most status updates and non-urgent messages.
  polite,

  /// Interrupt current speech immediately.
  /// Use sparingly, only for critical/time-sensitive messages (errors, alerts).
  assertive,
}

/// Utilities for announcing messages to screen readers.
///
/// Provides two approaches:
/// 1. [announce] - Imperative helper using [SemanticsService.sendAnnouncement]
///    (recommended for most cases, more reliable cross-platform)
/// 2. [LiveAnnouncerWidget] - Widget-based using Semantics liveRegion
///    (for content that updates with widget state)
class LiveAnnouncer {
  LiveAnnouncer._();

  /// Announces a message to screen readers using [SemanticsService.sendAnnouncement].
  ///
  /// This is the **recommended approach** for most announcements because:
  /// - More reliable cross-platform (iOS VoiceOver, Android TalkBack)
  /// - Works immediately without requiring semantics tree updates
  /// - Supports assertiveness levels (polite vs assertive)
  ///
  /// Example:
  /// ```dart
  /// // Polite announcement (waits for current speech)
  /// LiveAnnouncer.announce(context, 'Form submitted successfully');
  ///
  /// // Assertive announcement (interrupts immediately)
  /// LiveAnnouncer.announce(
  ///   context,
  ///   'Error: Invalid email address',
  ///   assertiveness: AnnouncementAssertiveness.assertive,
  /// );
  /// ```
  ///
  /// WCAG 4.1.3 Status Messages compliance.
  static Future<void> announce(
    BuildContext context,
    String message, {
    AnnouncementAssertiveness assertiveness = AnnouncementAssertiveness.polite,
  }) {
    final view = View.of(context);
    final textDirection = Directionality.of(context);
    return SemanticsService.sendAnnouncement(
      view,
      message,
      textDirection,
      assertiveness: assertiveness == AnnouncementAssertiveness.assertive
          ? Assertiveness.assertive
          : Assertiveness.polite,
    );
  }

  /// Announces a message with polite assertiveness.
  /// Convenience wrapper for [announce] with polite level.
  static Future<void> announcePolite(BuildContext context, String message) {
    return announce(
      context,
      message,
      assertiveness: AnnouncementAssertiveness.polite,
    );
  }

  /// Announces a message with assertive assertiveness (interrupts current speech).
  /// Use sparingly, only for critical/time-sensitive messages.
  static Future<void> announceAssertive(BuildContext context, String message) {
    return announce(
      context,
      message,
      assertiveness: AnnouncementAssertiveness.assertive,
    );
  }
}

/// A widget that announces changes to screen readers using live regions.
///
/// **When to use this widget vs [LiveAnnouncer.announce]:**
///
/// Use **[LiveAnnouncer.announce]** (recommended) when:
/// - You need to announce something in response to an action
/// - The announcement is not tied to a specific widget's state
/// - You want reliable cross-platform behavior
///
/// Use **[LiveAnnouncerWidget]** when:
/// - The announcement is tied to a widget's changing state
/// - You want the announcement to happen automatically when
///   the message property changes
/// - The content is already visible and you're marking it as a live region
///
/// Example:
/// ```dart
/// LiveAnnouncerWidget(
///   message: 'Loading... $progressPercent%',
///   child: CircularProgressIndicator(),
/// )
/// ```
///
/// WCAG 4.1.3 Status Messages compliance.
class LiveAnnouncerWidget extends StatelessWidget {
  /// The message to announce when it changes.
  final String message;

  /// The child widget to display (visually).
  final Widget child;

  /// Whether the live region should be polite (default) or assertive.
  /// Assertive announcements interrupt current speech.
  final bool assertive;

  const LiveAnnouncerWidget({
    super.key,
    required this.message,
    required this.child,
    this.assertive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      label: message,
      // Note: Semantics widget doesn't support assertiveness directly;
      // for assertive announcements, use LiveAnnouncer.announce() instead.
      child: child,
    );
  }
}
