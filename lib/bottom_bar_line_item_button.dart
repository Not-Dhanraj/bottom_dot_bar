import 'package:bottom_bar_line/bottom_bar_line.dart';
import 'package:flutter/material.dart';

class BottomBarLineItemButton extends StatelessWidget {
  final BottomBarLineItem item;
  final Function()? onTap;
  final bool isActive;
  final Color splashColor;
  final Color highlightColor;
  final Duration duration;
  final bool iconJump;
  final BottomNavItems navItems;
  final double capsulePaddingHorizontal;
  final double capsulePaddingVertical;
  final double rippleRadius;

  BottomBarLineItemButton({
    required this.item,
    required this.onTap,
    required this.duration,
    this.isActive = false,
    required this.splashColor,
    required this.highlightColor,
    required this.iconJump,
    required this.navItems,
    required this.capsulePaddingHorizontal,
    required this.capsulePaddingVertical,
    this.rippleRadius = 0,
  });

  @override
  Widget build(BuildContext context) {
    final icon = TweenAnimationBuilder(
      duration: Duration(milliseconds: duration.inMilliseconds * 2),
      curve: Curves.fastOutSlowIn,
      tween: ColorTween(
        begin: item.icon.color,
        end: isActive
            ? item.selectedColor
            : (item.icon.color ?? Theme.of(context).iconTheme.color),
      ),
      builder: (_, dynamic color, __) {
        return navItems == BottomNavItems.onlyIcon
            ? Icon(
                item.icon.icon,
                color: color,
                size: item.icon.size,
              )
            : navItems == BottomNavItems.iconWithText
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        item.icon.icon,
                        color: color,
                        size: item.icon.size,
                      ),
                      isActive ? item.title : Container(),
                      SizedBox(
                        height: 8,
                      )
                    ],
                  )
                : navItems == BottomNavItems.showAll
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            item.icon.icon,
                            color: color,
                            size: item.icon.size,
                          ),
                          item.title,
                          SizedBox(
                            height: 8,
                          )
                        ],
                      )
                    : navItems == BottomNavItems.textOnly
                        ? item.title
                        : isActive
                            ? item.title
                            : Icon(
                                item.icon.icon,
                                color: color,
                                size: item.icon.size,
                              );
      },
    );

    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: capsulePaddingHorizontal,
            vertical: capsulePaddingVertical),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(rippleRadius),
          child: Stack(
            fit: StackFit.expand,
            children: [
              iconJump
                  ? AnimatedAlign(
                      duration: duration,
                      alignment:
                          isActive ? Alignment(0, -.2) : Alignment.center,
                      child: icon,
                    )
                  : icon,
              Positioned.fill(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onTap,
                    splashColor: splashColor,
                    highlightColor: highlightColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

enum BottomNavItems {
  onlyIcon,
  iconWithText,
  textWhenSelected,
  showAll,
  textOnly
}
