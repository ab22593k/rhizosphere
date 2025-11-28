/// Rhizosphere: An accessible Flutter component library.
///
/// This library follows Flutter best practices for accessibility:
/// - Semantics: Uses `Semantics` widget for labels, headers, and descriptions.
/// - Hierarchy: Uses `Semantics(header: true)` and Landmarks via `container: true`.
/// - Reading Order: Ensures top-down logical flow.
/// - Focus: Manages `FocusNode` and `FocusScope` for keyboard/switch navigation.
/// - Contrast: Default theme meets WCAG AA (4.5:1 / 3:1).
/// - Target Sizes: Enforces 48x48dp touch targets.
/// - Shortcuts: Implements keyboard shortcuts using `Shortcuts` and `Actions`.
library;

export 'src/config/accessibility_config.dart';
export 'src/config/text_scaler.dart';
export 'src/providers/theme_provider.dart';
export 'src/widgets/accessible_wrapper.dart';
export 'src/widgets/live_announcer.dart';
export 'src/components/accessible_button.dart';
export 'src/components/accessible_text_field.dart';
export 'src/components/gesture_handler.dart';

// New Accessibility Hierarchy Exports
export 'models/app_theme.dart';
export 'models/navigation_item.dart';
export 'models/intents.dart';
export 'viewmodels/accessibility_viewmodel.dart';
export 'views/base_layout.dart';
export 'views/hierarchy_view.dart';
export 'views/shortcuts_help_view.dart';
export 'views/components/accessible_header.dart';
export 'views/components/accessible_card.dart';

// New Accessible Widgets Exports
export 'accessible_widgets/accessible_image.dart';
export 'accessible_widgets/accessible_text.dart';
export 'accessible_widgets/expandable_truncated_text.dart';
export 'accessible_widgets/dynamic_tooltip_label.dart';
export 'accessible_widgets/image_caption.dart';
export 'accessible_widgets/utils/accessibility_extensions.dart';
export 'accessible_widgets/utils/contrast_checker.dart';
export 'accessible_widgets/utils/truncation_handler.dart';
export 'accessible_widgets/utils/accessibility_helpers.dart';

// Adaptive Layout System
export 'core/adaptive/layout/window_size_class.dart';
export 'core/adaptive/layout/adaptive_builder.dart';
export 'core/adaptive/layout/navigation_strategy.dart';
export 'core/adaptive/layout/pane_configuration.dart';
export 'core/adaptive/components/adaptive_fab.dart';
export 'core/adaptive/components/adaptive_app_bar.dart';
export 'features/adaptive_layout/views/adaptive_scaffold.dart';
export 'features/adaptive_layout/widgets/responsive_pane.dart';
export 'features/adaptive_layout/providers/adaptive_layout_provider.dart';
