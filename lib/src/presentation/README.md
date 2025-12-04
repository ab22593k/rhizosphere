# Accessible Widgets

A collection of Flutter widgets designed to enhance accessibility and provide inclusive user experiences.

## Widgets

### AccessibleImage

Displays images with proper semantic labels and optional captions.

```dart
AccessibleImage(
  image: AssetImage('my_image.png'),
  semanticsLabel: 'A beautiful sunset over the mountains',
  caption: 'Sunset at Mount Fuji',
)
```

### AccessibleText

Text widget that automatically applies text scaling and enforces contrast ratios.

```dart
AccessibleText(
  text: 'Welcome to our app!',
  style: TextStyle(fontSize: 16),
  maxLines: 2,
)
```

### TruncationHandler

Handles text truncation with ellipsis and provides tooltips for full text on long press.

```dart
TruncationHandler(
  text: 'Very long text that might not fit',
  maxWidth: 200,
  style: TextStyle(fontSize: 14),
)
```

### DynamicTooltipLabel

Displays text with automatic truncation and scaled tooltips for navigation bars.

```dart
DynamicTooltipLabel(
  text: 'Long navigation title',
  style: TextStyle(fontSize: 16),
)
```

## Usage Examples

### Basic App Bar with Accessible Title

```dart
AppBar(
  title: DynamicTooltipLabel(
    text: 'My Very Long Application Title',
    style: Theme.of(context).textTheme.titleLarge,
  ),
)
```

### Image with Caption

```dart
Column(
  children: [
    AccessibleImage(
      image: NetworkImage('https://example.com/image.jpg'),
      semanticsLabel: 'Product image',
      caption: 'Wireless headphones in black',
    ),
    AccessibleText(
      text: 'High-quality wireless headphones with noise cancellation.',
      maxLines: 3,
    ),
  ],
)
```

### Form with Accessible Fields

```dart
Form(
  child: Column(
    children: [
      AccessibleText(
        text: 'Enter your name:',
        style: Theme.of(context).textTheme.labelLarge,
      ),
      TextField(
        decoration: InputDecoration(
          labelText: 'Full Name',
          hintText: 'Enter your full name',
        ),
      ),
    ],
  ),
)
```

## Accessibility Features

- **Text Scaling**: All widgets respect system text scale factor (1x to 2x+)
- **Semantic Labels**: Proper screen reader support
- **Contrast Enforcement**: Debug warnings for poor contrast ratios
- **Touch Targets**: Adequate sizing for motor-impaired users
- **RTL Support**: Automatic layout mirroring for right-to-left languages

## Testing

Run tests with different text scale factors:

```bash
flutter test --tags accessibility
```

## Dependencies

- `accessibility_tools` (dev) - Automated accessibility checks
- `flutter_riverpod` - State management
- `flutter_screenutil` - Responsive utilities