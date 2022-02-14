import 'package:flashy_tab_bar/models/flashy_tab_item.dart';
import 'package:flutter/material.dart';

class FlashyBar extends StatelessWidget {
  FlashyBar({
    Key? key,
    this.selectedIndex = 0,
    this.height = 60,
    this.showElevation = true,
    this.iconSize = 20,
    this.backgroundColor,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.linear,
    this.shadows = const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 3,
      )
    ],
    required this.items,
    required this.onItemSelected,
  }) : super(key: key) {
    assert(height >= 55 && height <= 100);
    assert(items.length >= 2 && items.length <= 5);
  }

  final Curve animationCurve;
  final Duration animationDuration;
  final Color? backgroundColor;
  final double height;
  final double iconSize;
  final List<FlashyTabBarItem> items;
  final Function(int) onItemSelected;
  final int selectedIndex;
  final List<BoxShadow> shadows;
  final bool showElevation;

  @override
  Widget build(BuildContext context) {
    // final bg = (backgroundColor == null) ? Theme.of(context).bottomAppBarColor : backgroundColor;
    final bg = backgroundColor ?? Theme.of(context).bottomAppBarColor;
    return Container(
      decoration: BoxDecoration(
        color: bg,
        boxShadow: showElevation ? shadows : null,
      ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: height,
          padding: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 20,
          ),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: items.map((item) {
                var index = items.indexOf(item);
                return Expanded(
                  child: GestureDetector(
                    onTap: () => onItemSelected(index),
                    child: _FlashTabBarItem(
                      item: item,
                      tabBarHeight: height,
                      iconSize: iconSize,
                      isSelected: index == selectedIndex,
                      backgroundColor: bg,
                      animationCurve: animationCurve,
                      animationDuration: animationDuration,
                    ),
                  ),
                );
              }).toList()),
        ),
      ),
    );
  }
}

class _FlashTabBarItem extends StatelessWidget {
  const _FlashTabBarItem({
    Key? key,
    required this.item,
    required this.isSelected,
    required this.animationCurve,
    required this.animationDuration,
    required this.backgroundColor,
    required this.iconSize,
    required this.tabBarHeight,
  }) : super(key: key);

  final Curve animationCurve;
  final Duration animationDuration;
  final Color backgroundColor;
  final double iconSize;
  final bool isSelected;
  final FlashyTabBarItem item;
  final double tabBarHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      height: double.maxFinite,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.center,
        children: [
          AnimatedAlign(
            duration: animationDuration,
            alignment: isSelected ? Alignment.topCenter : Alignment.center,
            child: IconTheme(
              data: IconThemeData(
                size: iconSize,
                color: isSelected ? item.activeColor : item.inActiveColor,
              ),
              child: item.icon,
            ),
          ),
          AnimatedPositioned(
            curve: animationCurve,
            duration: animationDuration,
            top: isSelected ? -2.0 * iconSize : tabBarHeight / 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: iconSize,
                  height: iconSize,
                ),
                CustomPaint(
                  child: SizedBox(
                    width: 80,
                    height: iconSize,
                  ),
                  painter: _CustomPath(backgroundColor),
                ),
              ],
            ),
          ),
          AnimatedAlign(
            alignment: isSelected ? Alignment.center : Alignment.bottomCenter,
            duration: animationDuration,
            curve: animationCurve,
            child: AnimatedOpacity(
              opacity: isSelected ? 1.0 : 0.0,
              duration: animationDuration,
              child: DefaultTextStyle.merge(
                child: item.title,
                style: TextStyle(
                  color: item.activeColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: CustomPaint(
              painter: _CustomPath(backgroundColor),
              child: SizedBox(
                width: 80,
                height: iconSize,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedOpacity(
              duration: animationDuration,
              opacity: isSelected ? 1 : 0,
              child: Container(
                width: 5,
                height: 5,
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: item.activeColor,
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomPath extends CustomPainter {
  _CustomPath(this.backgroundColor);

  final Color backgroundColor;

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();
    path.lineTo(0, 0);
    path.lineTo(0, 2 * size.height);
    path.lineTo(size.width, 2 * size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(0, 0);
    path.close();

    paint.color = backgroundColor;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
