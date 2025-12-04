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
export 'src/config/rhizosphere_scroll_behavior.dart';
export 'src/config/text_scaler.dart';
export 'src/providers/theme_provider.dart';
export 'src/widgets/accessible_wrapper.dart';
export 'src/widgets/live_announcer.dart';
export 'src/components/accessible_button.dart';
export 'src/components/accessible_text_field.dart';
export 'src/components/gesture_handler.dart';

// New Accessibility Hierarchy Exports
export 'src/data/app_theme.dart';
export 'src/data/navigation_item.dart';
export 'src/data/intents.dart';
export 'src/presentation/viewmodels/accessibility_viewmodel.dart';
export 'src/presentation/views/base_layout.dart';
export 'src/presentation/views/hierarchy_view.dart';
export 'src/presentation/views/shortcuts_help_view.dart';
export 'src/presentation/views/components/accessible_header.dart';
export 'src/presentation/views/components/accessible_card.dart';

// New Accessible Widgets Exports
export 'src/presentation/accessible_image.dart';
export 'src/presentation/accessible_text.dart';
export 'src/presentation/expandable_truncated_text.dart';
export 'src/presentation/dynamic_tooltip_label.dart';
export 'src/presentation/image_caption.dart';
export 'src/presentation/utils/accessibility_extensions.dart';
export 'src/presentation/utils/contrast_checker.dart';
export 'src/presentation/utils/truncation_handler.dart';
export 'src/presentation/utils/accessibility_helpers.dart';

// Adaptive Layout System
export 'src/core/adaptive/layout/window_size_class.dart';
export 'src/core/adaptive/layout/adaptive_builder.dart';
export 'src/core/adaptive/layout/navigation_strategy.dart';
export 'src/core/adaptive/layout/pane_configuration.dart';
export 'src/core/adaptive/components/adaptive_fab.dart';
export 'src/core/adaptive/components/adaptive_app_bar.dart';
export 'src/features/adaptive_layout/views/adaptive_scaffold.dart';
export 'src/features/adaptive_layout/widgets/responsive_pane.dart';
export 'src/features/adaptive_layout/providers/adaptive_layout_provider.dart';

// Localization
export 'src/core/l10n/app_localizations.dart';
export 'src/core/l10n/app_localizations_en.dart';

// Motion System
export 'src/motion/motion_scheme.dart';
export 'src/motion/motion_tokens.dart';
export 'src/motion/motion_provider.dart';
export 'src/motion/spring_wrapper.dart';
export 'src/motion/motion_routes.dart';
export 'src/motion/motion_adaptive.dart';
export 'src/motion/spring_extensions.dart';
