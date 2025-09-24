
📚 Flutter Widgets Catalog & JSON To-Do App

A Flutter playground project showcasing a wide variety of Flutter widgets:
animations, layouts, scrolling, accessibility, input, and interaction models.
Also includes a JSON-powered To-Do List for demonstrating asset loading and dynamic rendering.

⸻

✨ Features

🎯 Accessibility Widgets
 • ExcludeSemantics – hide from screen readers.
 • MergeSemantics – merge multiple semantics nodes.
 • Semantics – add custom accessibility labels.

⸻

🎞️ Animation & Motion

Implicit Animations
 • AnimatedAlign
 • AnimatedBuilder
 • AnimatedContainer
 • AnimatedCrossFade
 • AnimatedDefaultTextStyle
 • AnimatedList
 • AnimatedModalBarrier
 • AnimatedOpacity
 • AnimatedPhysicalModel
 • AnimatedPositioned
 • AnimatedSize

Explicit Animations
 • AlignTransition
 • DecoratedBoxTransition
 • DefaultTextStyleTransition
 • FadeTransition
 • Hero (with HeroSecondPage)
 • Matrix4Transform (via AnimatedBuilder)
 • PositionedTransition
 • RelativePositionedTransition
 • RotationTransition
 • ScaleTransition
 • SizeTransition
 • SlideTransition

Custom Animations
 • MyAnimatedColorBox – custom ImplicitlyAnimatedWidget.
 • DecoratedBoxTransitionExample – interactive decoration.
 • SliverFadeAnimation – fading list inside a CustomScrollView.

⸻

🧩 Input & Basic Widgets
 • Placeholder – grey debug box.
 • Autocomplete – text field with suggestions.
 • KeyboardListener – detect keyboard events.
 • RichText – inline styled text.

⸻

🕹️ Interaction Widgets
 • AbsorbPointer – block touches.
 • Dismissible – swipe to dismiss list items.
 • DragTarget – drop targets for draggables.
 • Draggable – draggable widget.
 • DraggableScrollableSheet – resizable bottom sheet.
 • IgnorePointer – ignore gestures.
 • InteractiveViewer – pan & zoom.
 • LongPressDraggable – drag on long press.

⸻

📐 Layout Widgets
 • Align – align inside parent.
 • AspectRatio – maintain ratio.
 • Transform – rotate, scale, skew.
 • IntrinsicHeight – match tallest child.
 • IntrinsicWidth – match widest child.

⸻

📜 Scrolling
 • Scrollable – low-level scroll container.
 • CarouselView – horizontal carousel.
 • DraggableScrollableSheet – draggable bottom sheet.
 • SliverFadeTransition – fade animation in a sliver list.

⸻

✅ JSON-powered To-Do List

This project also demonstrates how to load JSON from assets and render it dynamically.

📂 File Structure

assets/
 └── data.json
lib/
 ├── today_todo_list.dart   # JSON To-Do List widget
 ├── main.dart              # Entry point with widget catalog
 ├── hero_second_page.dart  # Hero animation page
 └── sliver_fade_animation.dart

📝 Example data.json

[
  { "task": "Wake up at 6 AM", "done": false },
  { "task": "Meditate for 20 minutes", "done": true },
  { "task": "Complete Flutter assignment", "done": false }
]

⚡ Core Logic

final String response = await rootBundle.loadString('assets/data.json');
final data = json.decode(response);
setState(() {
  tasks = data;
});

Rendered as an interactive list:

ListView.builder(
  itemCount: tasks.length,
  itemBuilder: (context, index) {
    final task = tasks[index];
    return CheckboxListTile(
      title: Text(task["task"]),
      value: task["done"],
      onChanged: (val) {
        setState(() {
          task["done"] = val;
        });
      },
    );
  },
)

⚠️ Add to pubspec.yaml

flutter:
  assets:
    - assets/data.json

⸻

📸 Demo

You can record a demo GIF (demo.gif) to showcase all widget interactions:

![Demo](demo.gif)

⸻

🛠 Getting Started

Prerequisites
 • Flutter SDK
 • Dart SDK
 • Emulator or physical device

Installation

git clone <https://github.com/your-username/flutter-widgets-catalog.git>
cd flutter-widgets-catalog
flutter pub get

Run

flutter run

⸻

🎯 Learning Goals
 • Compare implicit vs explicit animations.
 • Explore gesture-driven interactions (drag, dismiss, pointer control).
 • Experiment with scrolling & slivers.
 • Understand layout constraints (IntrinsicHeight, AspectRatio).
 • Learn how to load and render JSON data from assets.

⸻

📖 References
 • Flutter Widget Catalog
 • Animations in Flutter
 • Flutter Accessibility
 • Working with JSON

⸻

🔥 This catalog can be used as a learning tool, teaching reference, or a widget demo library.
Contributions and extensions are welcome!

⸻
