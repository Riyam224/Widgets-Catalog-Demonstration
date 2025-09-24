import 'package:flutter/material.dart';

class SliverFadeAnimation extends StatefulWidget {
  const SliverFadeAnimation({super.key});

  @override
  State<SliverFadeAnimation> createState() => _SliverFadeAnimationState();
}

class _SliverFadeAnimationState extends State<SliverFadeAnimation>
    with TickerProviderStateMixin {
  late Animation<double> _sliverFadeAnimation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _sliverFadeAnimation = Tween<double>(
      begin: 0.0, // مخفي
      end: 1.0, // ظاهر
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            expandedHeight: 100,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text("SliverFadeTransition"),
            ),
          ),
          SliverFadeTransition(
            opacity: _sliverFadeAnimation, // 👈 الأنيميشن
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return ListTile(
                  title: Text("Item $index"),
                  tileColor: index.isEven
                      ? Colors.blue[100]
                      : Colors.green[100],
                );
              }, childCount: 10),
            ),
          ),
        ],
      ),
    );
  }
}
