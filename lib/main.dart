import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:widgets_testing/hero_second_page.dart';
import 'package:flutter/services.dart';
import 'package:widgets_testing/todo_list_view.dart';

/// The application's entry-point.
///
/// Starts the application by running the [WidgetsCatelog] widget.
void main() {
  runApp(const WidgetsCatelog());
}

class WidgetsCatelog extends StatelessWidget {
  const WidgetsCatelog({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Widgets Catalog')),
        body: const TodayTodoList(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<AlignmentGeometry> _alignmentanim;
  late Animation<Color?> _colorAnimation;

  late Animation<Decoration> _decorationAnimation;
  late Animation<TextStyle> _textStyleAnimation;

  late Animation<double> _fadeAnimation;
  late Animation<Matrix4> _matrixAnimation;

  late Animation<RelativeRect> _positionAnimation;

  late Animation<Rect?> _relativePositionAnimation;
  late Animation<double> _scaleAnimation;

  late Animation<double> _sizeAnimation;

  late Animation<Offset> _slideAnimation;

  // todo
  bool isTopLeft = false;
  bool _isBig = true;
  bool _showFirst = true;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final List<int> _items = [0, 1, 2, 3, 4, 5];
  int _nextItem = 6;
  bool _visible = false;
  bool _isCircle = true;
  bool _moved = false;
  bool _expanded = false;
  bool _toggled = false;
  // todo additem

  void _addItem() {
    _items.insert(0, _nextItem++);
    _listKey.currentState?.insertItem(0); // safe call بدل !
  }

  // todo remove item
  void _removeItem(int index) {
    final removeItem = _items.removeAt(index);
    _listKey.currentState!.removeItem(
      index,
      (context, animation) => _buildItem(removeItem, animation),
      duration: const Duration(seconds: 1),
    );
  }

  Widget _buildItem(int item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        color: Colors.red,
        child: ListTile(
          title: Text('item $item'),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _removeItem(_items.indexOf(item)),
          ),
        ),
      ),
    );
  }

  // TODO  initstate _______________
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    // todo alignment animation
    _alignmentanim = Tween<AlignmentGeometry>(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).animate(_controller);
    //  todo text style animation

    _textStyleAnimation = TextStyleTween(
      begin: const TextStyle(
        fontSize: 20,
        color: Colors.blue,
        fontWeight: FontWeight.normal,
      ),
      end: const TextStyle(
        fontSize: 40,
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // todo color animation
    _colorAnimation = ColorTween(
      begin: Colors.transparent,
      end: Colors.black54,
    ).animate(_controller);
    // todo fade animation
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // todo MatrixTransition

    _matrixAnimation = Matrix4Tween(
      begin: Matrix4.identity(),
      end: Matrix4.identity()
        ..rotateZ(0.5)
        ..scale(1.5)
        ..translate(50.0, 50.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // todo Position animation

    _positionAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0, 0, 200, 200),
      end: RelativeRect.fromLTRB(200, 200, 0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    //  todo RelativePositionAnimation

    _relativePositionAnimation = RectTween(
      begin: Rect.fromLTWH(0, 0, 150, 150),
      end: Rect.fromLTWH(150, 150, 100, 100),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // todo scale animation
    _scaleAnimation = Tween<double>(
      begin: 0.5, // same size
      end: 1.5, // 1.5x bigger
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // todo size animation
    _sizeAnimation = Tween<double>(
      begin: 0.0, // مخفي
      end: 1.0, // الحجم كامل
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // todo slide animation
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  // TODO  toggle barrier
  void _toggleBarrier() {
    setState(() {
      _visible = !_visible;
      if (_visible) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  // TODO  dispose
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // TODO  Dismissible
  List<String> items = ["One", "Two", "Three"];

  // TODO ________________________________________
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // TODO  section /  Accessibility widgets
          // todo  ExcludeSemantics
          ExcludeSemantics(excluding: true, child: Text('I am invisible')),
          // todo  MergeSemantics
          MergeSemantics(
            child: Row(
              children: <Widget>[
                Checkbox(value: true, onChanged: (bool? value) {}),
                const Text('Settings'),
              ],
            ),
          ),
          //todo  semantics
          Semantics(
            label: 'Save file',
            child: ElevatedButton(onPressed: () {}, child: Icon(Icons.save)),
          ),

          // TODO  section / Animation and motion
          // AlignTransition _______________________
          AlignTransition(
            alignment: _alignmentanim,
            child: FlutterLogo(size: 100.0),
          ),
          // AnimatedAlign ___________________
          GestureDetector(
            onTap: () {
              setState(() {
                isTopLeft = !isTopLeft;
              });
            },
            child: Container(
              width: 200,
              height: 200,
              color: Colors.amberAccent,
              child: AnimatedAlign(
                alignment: isTopLeft
                    ? Alignment.topLeft
                    : Alignment.bottomRight,
                duration: Duration(seconds: 2),
                curve: Curves.easeInOut,
                child: FlutterLogo(size: 100.0),
              ),
            ),
          ),

          //todo  AnimatedBuilder ________________
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: _controller.value * 2 * 3.14,
                child: FlutterLogo(size: 100.0),
              );
            },
          ),

          //todo  AnimatedContainer ________
          GestureDetector(
            onTap: () => setState(() {
              _isBig = !_isBig;
            }),
            child: AnimatedContainer(
              width: _isBig ? 200 : 100,
              height: _isBig ? 200 : 100,
              color: _isBig ? Colors.red : Colors.green,
              duration: Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
              child: FlutterLogo(size: 50.0),
            ),
          ),

          //todo  AnimatedCrossFade ________
          GestureDetector(
            onTap: () {
              setState(() {
                _showFirst = !_showFirst;
              });
            },
            child: AnimatedCrossFade(
              firstChild: Container(
                width: 200,
                height: 200,
                color: Colors.greenAccent,
                child: Center(child: Text('first child')),
              ),
              secondChild: Container(
                width: 200,
                height: 200,
                color: Colors.redAccent,
                child: Center(child: Text('second child')),
              ),
              crossFadeState: _showFirst
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: Duration(milliseconds: 1000),
            ),
          ),

          // todo AnimatedDefaultTextStyle ___________
          GestureDetector(
            onTap: () {
              setState(() {
                _isBig = !_isBig;
              });
            },
            child: AnimatedDefaultTextStyle(
              duration: Duration(seconds: 2),
              style: _isBig
                  ? TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    )
                  : TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.black12,
                    ),

              curve: Curves.fastOutSlowIn,
              child: Text("Hello Flutter!"),
            ),
          ),
          // todo Animated List __________
          SizedBox(
            height: 500,
            child: AnimatedList(
              key: _listKey,
              initialItemCount: _items.length,
              itemBuilder: (context, index, animation) {
                return _buildItem(_items[index], animation);
              },
            ),
          ),
          FloatingActionButton(onPressed: _addItem, child: Icon(Icons.add)),

          // todo AnimatedModalBarrier _____________
          Stack(
            children: [
              Center(
                child: ElevatedButton(
                  onPressed: _toggleBarrier,
                  child: Text("Toggle Barrier"),
                ),
              ),
              if (_visible)
                Positioned.fill(
                  child: AnimatedModalBarrier(
                    color: _colorAnimation,
                    dismissible: true,
                    semanticsLabel: "Barrier",
                  ),
                ),

              if (_visible)
                Center(
                  child: ScaleTransition(
                    scale: CurvedAnimation(
                      parent: _controller,
                      curve: Curves.easeOutBack,
                    ),
                    child: Material(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      elevation: 8,
                      child: Container(
                        width: 250,
                        height: 150,
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "This is a dialog ✨",
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _toggleBarrier,
                              child: Text("Close"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),

          // todo AnimatedOpacity ________________
          AnimatedOpacity(
            opacity: _visible ? 1.0 : 0.0,
            duration: Duration(seconds: 3),
            curve: Curves.easeInOut,
            child: Container(width: 200, height: 200, color: Colors.blue),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _visible = !_visible; // نبدل الحالة
              });
            },
            child: Text(_visible ? "Hide" : "Show"),
          ),

          // todo AnimatedPhysicalModel ___________________
          Center(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isCircle = !_isCircle; // نبدل بين دائرة ومستطيل
                });
              },
              child: AnimatedPhysicalModel(
                duration: Duration(seconds: 1),
                curve: Curves.easeInOut,
                elevation: _isCircle ? 4 : 16, // فرق أكبر في الظل
                color: _isCircle ? Colors.blue : Colors.red,
                shadowColor: Colors.black,
                shape: _isCircle ? BoxShape.circle : BoxShape.rectangle,
                borderRadius: _isCircle
                    ? BorderRadius
                          .zero // 👈 ما نستخدم BorderRadius مع Circle
                    : BorderRadius.circular(24),
                child: Container(
                  width: _isCircle ? 120 : 180, // 👈 حجم مختلف
                  height: _isCircle ? 120 : 100, // 👈 حجم مختلف
                  alignment: Alignment.center,
                  child: Text(
                    _isCircle ? "Circle" : "Rectangle",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ),
          // todo AnimatedPositioned  _______________
          Stack(
            children: [
              Container(width: 300, height: 300, color: Colors.blue[50]),
              AnimatedPositioned(
                duration: Duration(seconds: 2),
                curve: Curves.easeInOut,
                left: _moved ? 150 : 0,
                top: _moved ? 150 : 0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _moved = !_moved; // نبدل الحالة عند الضغط
                    });
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.red,
                    child: Center(
                      child: Text(
                        "Tap me",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          //  todo AnimatedSize __________
          GestureDetector(
            onTap: () {
              setState(() {
                _expanded = !_expanded; // نبدل بين صغير/كبير
              });
            },
            child: AnimatedSize(
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              child: Container(
                width: _expanded ? 250 : 100,
                height: _expanded ? 250 : 100,
                color: Colors.blue,
                alignment: Alignment.center,
                child: Text(
                  _expanded ? "Big Box" : "Small Box",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),

          // todo AnimatedWidgetCenter _______________
          RotationTransition(turns: _controller, child: FlutterLogo(size: 100)),

          // todo ImplicitlyAnimatedWidget _____________
          // MyAnimatedColorBox Example
          GestureDetector(
            onTap: () {
              setState(() {
                _toggled = !_toggled;
              });
            },
            child: Center(
              child: MyAnimatedColorBox(
                duration: Duration(seconds: 1),
                color: _toggled ? Colors.red : Colors.green,
                width: 150,
                height: 150,
              ),
            ),
          ),

          // todo  DecoratedBoxTransition _________________
          DecoratedBoxTransitionExample(),

          // todo DefaultTextStyleTransition  _________
          DefaultTextStyleTransition(
            style: _textStyleAnimation,
            child: Text("Flutter Rocks!"),
          ),

          // todo FadeTransition  _________
          FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              width: 200,
              height: 200,
              color: Colors.purple,
              child: const Center(
                child: Text(
                  "Fade Me In/Out",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),

          // todo Hero _________
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => HeroSecondPage()),
                );
              },
              child: Hero(tag: 'hero-logo', child: FlutterLogo(size: 100)),
            ),
          ),

          // todo Matrix4Transition _________
          Center(
            child: AnimatedBuilder(
              animation: _matrixAnimation,
              builder: (context, child) {
                return Transform(
                  transform: _matrixAnimation.value, // 👈
                  alignment: Alignment.center,
                  child: child,
                );
              },
              child: Container(
                width: 150,
                height: 150,
                color: Colors.blue,
                child: const Center(
                  child: Text(
                    "Matrix",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ),

          // todo PositionedTransition _________
          Center(
            child: Container(
              width: 300,
              height: 300,
              color: Colors.grey[300],
              child: Stack(
                children: [
                  PositionedTransition(
                    rect: _positionAnimation,
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.blue,
                      child: const Center(
                        child: Text(
                          "Move",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // todo RelativePositionedTransition _________
          Center(
            child: Container(
              width: 300,
              height: 300,
              color: Colors.grey[300],
              child: Stack(
                children: [
                  RelativePositionedTransition(
                    rect: _relativePositionAnimation,
                    size: const Size(300, 300), // 👈 مرجع للحاوية الأم
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.green,
                      child: const Center(
                        child: Text(
                          "Relative",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // todo RotationTransition _________
          Center(
            child: RotationTransition(
              turns: _controller, // 👈 القيمة بين 0 و 1
              child: Container(
                width: 100,
                height: 100,
                color: Colors.orange,
                child: const Center(
                  child: Text("Rotate", style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ),

          // todo ScaleTransition _________
          Center(
            child: ScaleTransition(
              scale: _scaleAnimation, // 👈 ياخذ Animation<double>
              child: Container(
                width: 100,
                height: 100,
                color: Colors.teal,
                child: const Center(
                  child: Text(
                    "Scale",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ),

          // todo SizeTransition _________
          Center(
            child: SizeTransition(
              sizeFactor: _sizeAnimation, // 👈 يحدد النسبة بين 0 و 1
              axis: Axis.vertical, // 👈 يكبر ويصغر عموديًا
              child: Container(
                width: 150,
                height: 150,
                color: Colors.pink,
                child: const Center(
                  child: Text(
                    "Size Me!",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ),

          // todo SlideTransition _________
          Center(
            child: SlideTransition(
              position: _slideAnimation, // 👈 يأخذ Animation<Offset>
              child: Container(
                width: 150,
                height: 150,
                color: Colors.indigo,
                child: const Center(
                  child: Text(
                    "Slide Me!",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ),

          // TODO basic widgets

          // todo  Placeholder _________
          const Placeholder(),

          //TODO  todo input

          // todo Autocomplete __________
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                //
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<String>.empty();
                }
                //suggestions
                List<String> options = <String>[
                  'Flutter',
                  'Dart',
                  'Firebase',
                  'Supabase',
                  'Django',
                  'Python',
                ];
                //
                return options.where(
                  (option) => option.toLowerCase().contains(
                    textEditingValue.text.toLowerCase(),
                  ),
                );
              },
              onSelected: (String selection) {
                debugPrint('You selected: $selection');
              },
            ),
          ),

          // todo KeyboardListener _________
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: KeyboardListener(
              focusNode: FocusNode(),
              autofocus: true,
              onKeyEvent: (KeyEvent event) {
                if (event is KeyDownEvent) {
                  debugPrint('Key pressed: ${event.logicalKey}');
                } else if (event is KeyUpEvent) {
                  debugPrint('Key released: ${event.logicalKey}');
                }
              },
              child: Container(
                width: 250,
                height: 100,
                color: Colors.grey[300],
                alignment: Alignment.center,
                child: const Text(
                  " Press Any Key",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),

          // TODO Interaction model widgets
          // todo AbsorbPointer _________
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "Try clicking the button below 👇",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                AbsorbPointer(
                  absorbing: true, // 👈 يمنع الضغط
                  child: ElevatedButton(
                    onPressed: () {
                      debugPrint("Button Pressed!");
                    },
                    child: Text("Can't Click Me 😅"),
                  ),
                ),
              ],
            ),
          ),

          // todo Dismissible _________
          SizedBox(
            height: 500,
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Dismissible(
                  key: ValueKey(item),
                  direction:
                      DismissDirection.endToStart, // 👈 from right to left
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    //delete item from the listة
                    items.removeAt(index);
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("$item dismissed")));
                  },
                  child: ListTile(title: Text(item)),
                );
              },
            ),
          ),

          // todo DragTarget + Draggable _________
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Draggable<String>(
                  data: "🍎",
                  feedback: Material(
                    color: Colors.transparent,
                    child: Text("🍎", style: TextStyle(fontSize: 40)),
                  ),
                  childWhenDragging: Opacity(
                    opacity: 0.3,
                    child: Text("🍎", style: TextStyle(fontSize: 40)),
                  ),
                  child: Text("🍎", style: TextStyle(fontSize: 40)),
                ),
                SizedBox(height: 40),
                DragTarget<String>(
                  onWillAccept: (data) => data == "🍎", // 👈 ية
                  onAccept: (data) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Accepted $data!")));
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Container(
                      width: 150,
                      height: 150,
                      color: candidateData.isEmpty
                          ? Colors.grey[300]
                          : Colors.green[300],
                      child: Center(
                        child: Text(
                          candidateData.isEmpty ? "Drop here" : "Release!",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // todo Draggable __________
          Center(
            child: Draggable<String>(
              data: "Flutter Logo",
              feedback: Material(
                color: Colors.transparent,
                child: FlutterLogo(size: 80), // 👈 نسخة أثناء السحب
              ),
              childWhenDragging: Opacity(
                opacity: 0.3,
                child: FlutterLogo(size: 100), // 👈 يبان شفاف لما يتم سحبه
              ),
              child: FlutterLogo(size: 100), // 👈 العنصر الأساسي
              onDragStarted: () {
                debugPrint("Drag started!");
              },
              onDragEnd: (details) {
                debugPrint("Drag ended at: ${details.offset}");
              },
              onDraggableCanceled: (velocity, offset) {
                debugPrint("Drag canceled at: $offset");
              },
            ),
          ),
          // todo DraggableScrollableSheet __________
          SizedBox(
            height: 400, // لازم يكون عنده ارتفاع محدد
            child: DraggableScrollableSheet(
              initialChildSize: 0.3, // يبدأ بنسبة 30% من الشاشة
              minChildSize: 0.2, // أصغر حجم 20%
              maxChildSize: 0.8, // أكبر حجم 80%
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: ListView.builder(
                    controller:
                        scrollController, // مهم جدًا عشان يربط الـ sheet بالـ scroll
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.star),
                        title: Text("Item $index"),
                      );
                    },
                  ),
                );
              },
            ),
          ),

          //  todo
          IgnorePointer(
            ignoring: true, // true to ignore pointer events
            child: ElevatedButton(
              onPressed: () {
                print(" pressing not working 😅");
              },
              child: Text("not working 😅"),
            ),
          ),

          // todo InteractiveViewer __________
          InteractiveViewer(
            panEnabled: true, // 👈 sliding
            scaleEnabled: true, // 👈 zooming in and out
            minScale: 0.5,
            maxScale: 4.0,
            boundaryMargin: EdgeInsets.all(20),
            child: Image.network(
              "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
            ),
          ),

          // todo LongPressDraggable __________
          LongPressDraggable<String>(
            data: "🍎",
            feedback: Material(
              color: Colors.transparent,
              child: Text("🍎", style: TextStyle(fontSize: 40)),
            ),
            childWhenDragging: Opacity(
              opacity: 0.3,
              child: Text("🍎", style: TextStyle(fontSize: 40)),
            ),
            child: Text("🍎", style: TextStyle(fontSize: 40)),
            onDragStarted: () {
              debugPrint("Long press drag started!");
            },
            onDragEnd: (details) {
              debugPrint("Drag ended at: ${details.offset}");
            },
          ),

          // todo Scrollable  __________
          SizedBox(
            height: 300,
            child: Scrollable(
              axisDirection: AxisDirection.down,
              controller: ScrollController(),
              physics: BouncingScrollPhysics(),
              viewportBuilder: (BuildContext context, ViewportOffset offset) {
                return Viewport(
                  offset: offset,
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) =>
                            ListTile(title: Text("Item $index")),
                        childCount: 20,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // TODO Text
          // todo RichText __________
          RichText(
            text: TextSpan(
              text: "Hello ",
              style: TextStyle(color: Colors.black, fontSize: 20),
              children: <TextSpan>[
                TextSpan(
                  text: "Flutter ",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: "World!",
                  style: TextStyle(
                    color: Colors.red,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),

          // TODO Layout widgets

          // todo Align ______________
          Container(
            color: Colors.black,
            width: double.infinity,
            height: 200,
            child: Align(
              alignment: Alignment.bottomRight, // مكان العنصر
              child: Container(
                width: 50,
                height: 50,
                color: Colors.yellowAccent,
                child: const Center(child: Text("Box")),
              ),
            ),
          ),

          // todo aspect ratio ____________
          Center(
            child: Container(
              color: Colors.grey,
              width: 300,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  color: Colors.blue,
                  child: const Center(
                    child: Text(
                      "16:9 Box",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // todo Transform ______________
          Transform.translate(
            offset: const Offset(50, 20),
            child: Container(color: Colors.blue, width: 100, height: 100),
          ),
          // todo Transform.rotate _____
          Transform.rotate(
            angle: 0.5,
            child: Container(color: Colors.red, width: 100, height: 100),
          ),

          Transform(
            transform: Matrix4.skewX(0.3)..rotateZ(0.2),
            child: Container(color: Colors.orange, width: 120, height: 120),
          ),

          // todo IntrinsicHeight ________
          Center(
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: Colors.red,
                    width: 100,
                    child: const Text("short"),
                  ),
                  Container(
                    color: Colors.green,
                    width: 100,
                    child: const Text("little longer"),
                  ),
                  Container(
                    color: Colors.blue,
                    width: 100,
                    child: const Text(
                      "this contains long text to make others take same height",
                    ),
                  ),
                ],
              ),
            ),
          ),

          // todo IntrinsicWidth _______
          Center(
            child: IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch, // مهم
                children: [
                  Container(color: Colors.red, child: const Text("short")),
                  Container(
                    color: Colors.green,
                    child: const Text("little longer"),
                  ),
                  Container(
                    color: Colors.blue,
                    child: const Text(
                      "this contains long text to make others take same width",
                    ),
                  ),
                ],
              ),
            ),
          ),

          // TODO Scrolling widgets

          // todo carousel view ___________
          SizedBox(
            height: 250, // مهم جدًا
            child: CarouselView(
              itemExtent: 220,
              shrinkExtent: 120,
              children: List.generate(
                5,
                (index) => Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.primaries[index % Colors.primaries.length],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    "Item ${index + 1}",
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ),

          // todo DraggableScrollableSheet __________
          SizedBox(
            height: 400,
            child: DraggableScrollableSheet(
              initialChildSize: 0.3,
              minChildSize: 0.2,
              maxChildSize: 1.0,
              builder: (context, scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 5),
                    ],
                  ),
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: 10,
                    itemBuilder: (context, index) =>
                        ListTile(title: Text("Item ${index + 1}")),
                  ),
                );
              },
            ),
          ),

          //  TODO Painting and effect widgets
          // todo backdrop filter __________
          // SizedBox(
          //   height: 300,
          //   child: Stack(
          //     fit: StackFit.expand,
          //     children: [
          //       Image.network(
          //         "https://picsum.photos/400/800",
          //         fit: BoxFit.cover,
          //       ),
          //       BackdropFilter(
          //         filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          //         child: Container(
          //           color: Colors.black.withOpacity(0.2),
          //           alignment: Alignment.center,
          //           child: const Text(
          //             "Blurred Section",
          //             style: TextStyle(color: Colors.white, fontSize: 24),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // todo ClipOval  ______________
          Center(
            child: ClipOval(
              child: Image.network(
                "https://picsum.photos/200/300",
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // todo custom paint _______
          CustomPaint(
            size: const Size(200, 200), // حجم منطقة الرسم
            painter: CirclePainter(),
          ),

          SizedBox(height: 300),
        ],
      ),
    );
  }
}

//*  TODO  widget to use above. _______

// ✅  todo CirclePainter

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    // نرسم دائرة في منتصف اللوحة
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      80, // نصف القطر
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// ✅ MyAnimatedColorBox Widget _______
class MyAnimatedColorBox extends ImplicitlyAnimatedWidget {
  final Color color;
  final double width;
  final double height;

  const MyAnimatedColorBox({
    Key? key,
    required this.color,
    this.width = 100,
    this.height = 100,
    required Duration duration,
    Curve curve = Curves.linear,
  }) : super(key: key, duration: duration, curve: curve);

  @override
  _MyAnimatedColorBoxState createState() => _MyAnimatedColorBoxState();
}

class _MyAnimatedColorBoxState
    extends AnimatedWidgetBaseState<MyAnimatedColorBox> {
  ColorTween? _colorTween;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _colorTween =
        visitor(
              _colorTween,
              widget.color,
              (dynamic value) => ColorTween(begin: value as Color),
            )
            as ColorTween?;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      color: _colorTween?.evaluate(animation) ?? widget.color, // ✅ fallback
    );
  }
}

//✅  todo DecoratedBoxTransitionExample
class DecoratedBoxTransitionExample extends StatefulWidget {
  @override
  _DecoratedBoxTransitionExampleState createState() =>
      _DecoratedBoxTransitionExampleState();
}

class _DecoratedBoxTransitionExampleState
    extends State<DecoratedBoxTransitionExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Decoration> _decorationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _decorationAnimation = DecorationTween(
      begin: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(0),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 4, spreadRadius: 1),
        ],
      ),
      end: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Colors.black45, blurRadius: 12, spreadRadius: 4),
        ],
      ),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleAnimation() {
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: _toggleAnimation,
        child: DecoratedBoxTransition(
          decoration: _decorationAnimation, // 👈 الأنيميشن
          child: Container(
            width: 200,
            height: 200,
            alignment: Alignment.center,
            child: Text(
              "Tap Me",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
