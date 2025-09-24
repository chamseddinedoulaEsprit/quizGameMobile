import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final bool isExpanded;
  final bool isAnimated;
  final double? width;
  final double height;

  const CustomButton({
    super.key,
    required this.text,
    this.icon,
    required this.onPressed,
    this.isPrimary = true,
    this.isExpanded = false,
    this.isAnimated = true,
    this.width,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    Widget button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary ? colorScheme.primary : Colors.transparent,
        foregroundColor: isPrimary ? colorScheme.onPrimary : colorScheme.primary,
        elevation: isPrimary ? 2 : 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: isPrimary
              ? BorderSide.none
              : BorderSide(color: colorScheme.primary, width: 2),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        minimumSize: Size(isExpanded ? double.infinity : (width ?? 120), height),
      ),
      child: Row(
        mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20, color: isPrimary ? colorScheme.onPrimary : colorScheme.primary),
            const SizedBox(width: 8),
          ],
          Text(
            text,
            style: theme.textTheme.labelLarge?.copyWith(
              color: isPrimary ? colorScheme.onPrimary : colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );

    return isAnimated
        ? button.animate()
            .fadeIn(duration: 300.ms)
            .scale(
              begin: const Offset(0.9, 0.9),
              end: const Offset(1, 1),
              duration: 300.ms,
              curve: Curves.easeOut,
            )
        : button;
  }
}

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final bool hasShadow;
  final bool isAnimated;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  const CustomCard({
    super.key,
    required this.child,
    this.backgroundColor,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = 16,
    this.hasShadow = true,
    this.isAnimated = true,
    this.onTap,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = backgroundColor ?? theme.colorScheme.surface;

    Widget card = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: hasShadow
            ? [
                BoxShadow(
                  color: theme.colorScheme.shadow.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                )
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );

    return isAnimated
        ? card.animate()
            .fadeIn(duration: 400.ms)
            .slide(begin: const Offset(0, 0.05), end: const Offset(0, 0), duration: 400.ms)
        : card;
  }
}

class TeamAvatar extends StatelessWidget {
  final String emoji;
  final double size;
  final Color? backgroundColor;
  final bool isAnimated;

  const TeamAvatar({
    super.key,
    required this.emoji,
    this.size = 50,
    this.backgroundColor,
    this.isAnimated = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bgColor = backgroundColor ?? theme.colorScheme.primary.withOpacity(0.2);

    Widget avatar = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          emoji,
          style: TextStyle(fontSize: size * 0.5),
        ),
      ),
    );

    return isAnimated
        ? avatar.animate()
            .fadeIn(duration: 300.ms)
            .scale(
              begin: const Offset(0.8, 0.8),
              end: const Offset(1, 1),
              duration: 400.ms,
              curve: Curves.elasticOut,
            )
        : avatar;
  }
}

class AnimatedCounter extends StatelessWidget {
  final int value;
  final TextStyle? style;
  final Duration duration;
  final bool isIncrement;

  const AnimatedCounter({
    super.key,
    required this.value,
    this.style,
    this.duration = const Duration(milliseconds: 500),
    this.isIncrement = true,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: value - (isIncrement ? 1 : 0), end: value),
      duration: duration,
      builder: (context, value, child) {
        return Text(
          value.toString(),
          style: style ?? Theme.of(context).textTheme.headlineMedium,
        );
      },
    ).animate().fadeIn(duration: 300.ms);
  }
}

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData? icon;

  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primary : colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? colorScheme.primary : colorScheme.outline,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: colorScheme.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 18,
                color: isSelected ? colorScheme.onPrimary : colorScheme.primary,
              ),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ConfettiOverlay extends StatelessWidget {
  final bool show;
  final Widget child;

  const ConfettiOverlay({
    super.key,
    required this.show,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (show)
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                color: Colors.transparent,
              ).animate()
                .custom(
                  duration: 2.seconds,
                  builder: (context, value, child) {
                    return Stack(
                      children: List.generate(
                        30,
                        (index) {
                          final random = index * 0.1;
                          final size = (10 + random * 10) * value;
                          final color = [
                            Colors.red,
                            Colors.blue,
                            Colors.green,
                            Colors.yellow,
                            Colors.purple,
                            Colors.orange,
                          ][index % 6];
                          
                          return Positioned(
                            left: MediaQuery.of(context).size.width * (0.1 + 0.8 * random),
                            top: MediaQuery.of(context).size.height * value * (1.0 + random * 0.2) - size,
                            child: Opacity(
                              opacity: 1.0 - value * random,
                              child: Transform.rotate(
                                angle: random * 10,
                                child: Container(
                                  width: size,
                                  height: size,
                                  decoration: BoxDecoration(
                                    color: color,
                                    shape: index % 2 == 0 ? BoxShape.circle : BoxShape.rectangle,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
            ),
          ),
      ],
    );
  }
}
