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

// Accessibility - State
export 'src/accessibility/state/accessibility_settings.dart';
export 'src/accessibility/state/accessibility_controller.dart';

// Accessibility - Utils
export 'src/accessibility/utils/text_scaler.dart';
export 'src/accessibility/utils/accessibility_extensions.dart';
export 'src/accessibility/utils/contrast_checker.dart';
export 'src/accessibility/utils/truncation_handler.dart';
export 'src/accessibility/utils/accessibility_helpers.dart';

// Accessibility - Widgets
export 'src/accessibility/widgets/accessible_wrapper.dart';
export 'src/accessibility/widgets/live_announcer.dart';
export 'src/accessibility/widgets/accessible_image.dart';
export 'src/accessibility/widgets/accessible_text.dart';
export 'src/accessibility/widgets/expandable_truncated_text.dart';
export 'src/accessibility/widgets/dynamic_tooltip_label.dart';
export 'src/accessibility/widgets/image_caption.dart';

// Accessibility - Components
export 'src/accessibility/components/accessible_button.dart';
export 'src/accessibility/components/accessible_text_field.dart';
export 'src/accessibility/components/gesture_handler.dart';

// Theme
export 'src/theme/app_theme.dart';
export 'src/theme/scroll/scroll_behavior.dart';

// Data Models
export 'src/data/navigation_item.dart';
export 'src/data/intents.dart';

// Presentation - ViewModels
export 'src/presentation/viewmodels/accessibility_viewmodel.dart';

// Presentation - Views
export 'src/presentation/views/base_layout.dart';
export 'src/presentation/views/hierarchy_view.dart';
export 'src/presentation/views/shortcuts_help_view.dart';
export 'src/presentation/views/components/accessible_header.dart';
export 'src/presentation/views/components/accessible_card.dart';

// Adaptive Layout System
export 'src/adaptive/layout/window_size_class.dart';
export 'src/adaptive/layout/adaptive_builder.dart';
export 'src/adaptive/layout/navigation_strategy.dart';
export 'src/adaptive/layout/pane_configuration.dart';

// Adaptive Widgets
export 'src/adaptive/widgets/adaptive_fab.dart';
export 'src/adaptive/widgets/adaptive_app_bar.dart';
export 'src/adaptive/widgets/three_pane_layout.dart';
export 'src/adaptive/widgets/pane_drag_handle.dart';

// Adaptive Scaffolds
export 'src/adaptive/scaffolds/navigation_suite_scaffold.dart';

// Adaptive State
export 'src/adaptive/state/window_size_class_provider.dart';

// Motion System
export 'src/motion/motion_scheme.dart';
export 'src/motion/motion_tokens.dart';
export 'src/motion/motion_provider.dart';
export 'src/motion/spring_wrapper.dart';
export 'src/motion/motion_routes.dart';
export 'src/motion/motion_adaptive.dart';
export 'src/motion/spring_extensions.dart';

// Shape Tokens
export 'src/shapes/corner_style.dart';
export 'src/shapes/corner_radius.dart';
export 'src/shapes/shape_theme.dart';
export 'src/shapes/shape_borders.dart';
export 'src/shapes/shape_morphing.dart';
export 'src/shapes/optical_roundness.dart';
export 'src/shapes/svg_shapes.dart';
