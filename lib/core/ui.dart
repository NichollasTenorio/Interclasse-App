import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';


abstract final class AppColors {
  static const teal = Color(0xFF005C6D);
  static const red = Color(0xFFB20000);
  static const highlight = Color(0xFF00C1CF);
  static const tealDark = Color(0xFF004854);
  static const bg = Color(0xFFF4F4F4);
  static const surface = Color(0xFFFFFFFF);
  static const border = Color(0xFFC8C8C8);
  static const borderDark = Color(0xFF999999);
  static const text = Color(0xFF333333);
  static const muted = Color(0xFF888888);
  static const placeholder = Color(0xFFDADADA);

  static const pageBg = Color(0xFFF0F0F0);
  static const success = Color(0xFF3ACF1F);
  static const warning = Color(0xFFB78718);

  static const white = Color(0xFFFFFFFF);
  static const white80 = Color.fromRGBO(255, 255, 255, 0.8);
  static const white70 = Color.fromRGBO(255, 255, 255, 0.7);
  static const white60 = Color.fromRGBO(255, 255, 255, 0.6);
  static const white50 = Color.fromRGBO(255, 255, 255, 0.5);
  static const white40 = Color.fromRGBO(255, 255, 255, 0.4);
  static const white30 = Color.fromRGBO(255, 255, 255, 0.3);
  static const white20 = Color.fromRGBO(255, 255, 255, 0.2);
  static const white15 = Color.fromRGBO(255, 255, 255, 0.15);
  static const white10 = Color.fromRGBO(255, 255, 255, 0.1);
}


abstract final class AppIcons {
  static const home = 'M10 20v-6h4v6h5v-8h3L12 3 2 12h3v8z';
  static const games =
      'M11.99 2C6.47 2 2 6.48 2 12s4.47 10 9.99 10C17.52 22 22 17.52 22 12S17.52 2 11.99 2zm4.24 16L12 15.45 7.77 18l1.12-4.81-3.73-3.23 4.92-.42L12 5l1.92 4.53 4.92.42-3.73 3.23L16.23 18z';
  static const rank = 'M7 17H2v-5h5v5zm5 3H7V10h5v10zm5-6h-5v6h5v-6zm5-6h-5v12h5V8z';
  static const stats =
      'M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-5 14H7v-2h7v2zm3-4H7v-2h10v2zm0-4H7V7h10v2z';
  static const user =
      'M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z';
  static const back = 'M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z';
  static const bell =
      'M12 22c1.1 0 2-.9 2-2h-4c0 1.1.9 2 2 2zm6-6v-5c0-3.07-1.64-5.64-4.5-6.32V4c0-.83-.67-1.5-1.5-1.5s-1.5.67-1.5 1.5v.68C7.63 5.36 6 7.92 6 11v5l-2 2v1h16v-1l-2-2z';
}

class SvgIcon extends StatelessWidget {
  const SvgIcon(this.pathData, {super.key, this.size = 20, required this.color});

  final String pathData;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(
      '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24"><path d="$pathData"/></svg>',
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}


List<Widget> _spaced(List<Widget> children, double gap, Axis axis) {
  if (gap == 0 || children.length < 2) return children;
  return [
    for (var i = 0; i < children.length; i++) ...[
      if (i > 0)
        SizedBox(
          width: axis == Axis.horizontal ? gap : null,
          height: axis == Axis.vertical ? gap : null,
        ),
      children[i],
    ],
  ];
}


class Col extends StatelessWidget {
  const Col({
    super.key,
    required this.children,
    this.gap = 0,
    this.align = CrossAxisAlignment.stretch,
    this.main = MainAxisAlignment.start,
  });

  final List<Widget> children;
  final double gap;
  final CrossAxisAlignment align;
  final MainAxisAlignment main;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: main,
        crossAxisAlignment: align,
        children: _spaced(children, gap, Axis.vertical),
      );
}

class HRow extends StatelessWidget {
  const HRow({
    super.key,
    required this.children,
    this.gap = 0,
    this.align = CrossAxisAlignment.center,
    this.main = MainAxisAlignment.start,
  });

  final List<Widget> children;
  final double gap;
  final CrossAxisAlignment align;
  final MainAxisAlignment main;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: main,
        crossAxisAlignment: align,
        children: _spaced(children, gap, Axis.horizontal),
      );
}


/// Texto de corpo (Roboto).
class Label extends StatelessWidget {
  const Label(
    this.text, {
    super.key,
    this.size = 12,
    this.color = AppColors.muted,
    this.weight = FontWeight.w400,
    this.textAlign,
  });

  final String text;
  final double size;
  final Color color;
  final FontWeight weight;
  final TextAlign? textAlign;

  static TextStyle style(double size, Color color, FontWeight weight) =>
      GoogleFonts.roboto(fontSize: size, color: color, fontWeight: weight);

  @override
  Widget build(BuildContext context) =>
      Text(text, textAlign: textAlign, style: style(size, color, weight));
}

class Heading extends StatelessWidget {
  const Heading(
    this.text, {
    super.key,
    this.size = 16,
    this.color = AppColors.text,
    this.weight = FontWeight.w700,
    this.textAlign,
  });

  final String text;
  final double size;
  final Color color;
  final FontWeight weight;
  final TextAlign? textAlign;

  static TextStyle style(double size, Color color, FontWeight weight) =>
      GoogleFonts.robotoSlab(fontSize: size, color: color, fontWeight: weight);

  @override
  Widget build(BuildContext context) =>
      Text(text, textAlign: textAlign, style: style(size, color, weight));
}


class PlaceholderBox extends StatelessWidget {
  const PlaceholderBox({super.key, this.width, this.height, this.child});

  final double? width;
  final double? height;
  final Widget? child;

  @override
  Widget build(BuildContext context) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.placeholder,
          borderRadius: BorderRadius.circular(4),
        ),
        child: child,
      );
}

class HDivider extends StatelessWidget {
  const HDivider({super.key, this.topMargin = 0});

  final double topMargin;

  @override
  Widget build(BuildContext context) => Container(
        height: 1,
        margin: EdgeInsets.only(top: topMargin),
        color: AppColors.border,
      );
}

class AppChip extends StatelessWidget {
  const AppChip({super.key, required this.label, this.active = false});

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        decoration: BoxDecoration(
          color: active ? AppColors.teal : AppColors.surface,
          border: Border.all(color: active ? AppColors.teal : AppColors.border),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Label(
          label,
          size: 11,
          color: active ? AppColors.white : AppColors.muted,
          weight: FontWeight.w500,
        ),
      );
}

class AppBadge extends StatelessWidget {
  const AppBadge({super.key, required this.label, this.color = AppColors.teal});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
        child: Label(label, size: 10, color: AppColors.white, weight: FontWeight.w700),
      );
}

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.borderColor = AppColors.border,
    this.borderWidth = 1,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) => Container(
        padding: padding,
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: borderColor, width: borderWidth),
          borderRadius: BorderRadius.circular(6),
        ),
        child: child,
      );
}

class Section extends StatelessWidget {
  const Section({super.key, this.title, required this.children});

  final String? title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Col(
        gap: 8,
        children: [
          if (title != null)
            Heading(title!.toUpperCase(), size: 13, color: AppColors.teal, weight: FontWeight.w700),
          ...children,
        ],
      );
}

class StatBlock extends StatelessWidget {
  const StatBlock({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Expanded(
        child: Col(
          gap: 2,
          align: CrossAxisAlignment.center,
          children: [
            Heading(value, size: 20),
            Label(label, size: 10),
          ],
        ),
      );
}

class TeamAvatar extends StatelessWidget {
  const TeamAvatar({super.key, required this.abbr, this.size = 36});

  final String abbr;
  final double size;

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.placeholder,
          border: Border.all(color: AppColors.border, width: 2),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Label(abbr, size: size * 0.27, weight: FontWeight.w700),
      );
}

class TeamColumn extends StatelessWidget {
  const TeamColumn({
    super.key,
    required this.abbr,
    required this.name,
    this.avatarSize = 36,
    this.nameSize = 11,
    this.nameColor = AppColors.text,
    this.nameWeight = FontWeight.w500,
    this.gap = 4,
  });

  final String abbr;
  final String name;
  final double avatarSize;
  final double nameSize;
  final Color nameColor;
  final FontWeight nameWeight;
  final double gap;

  @override
  Widget build(BuildContext context) => Col(
        gap: gap,
        align: CrossAxisAlignment.center,
        children: [
          TeamAvatar(abbr: abbr, size: avatarSize),
          Label(name, size: nameSize, color: nameColor, weight: nameWeight),
        ],
      );
}

class BarTrack extends StatelessWidget {
  const BarTrack({
    super.key,
    required this.height,
    required this.fraction,
    required this.fill,
    required this.track,
  });

  final double height;
  final double fraction;
  final Color fill;
  final Color track;

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(999),
        child: Container(
          height: height,
          color: track,
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: fraction.clamp(0.0, 1.0),
            child: ColoredBox(color: fill),
          ),
        ),
      );
}

class StatBar extends StatelessWidget {
  const StatBar({super.key, required this.label, required this.valA, required this.valB});

  final String label;
  final int valA;
  final int valB;

  @override
  Widget build(BuildContext context) {
    final total = (valA + valB) == 0 ? 1 : valA + valB;
    final pA = (valA / total * 100).round();
    return Col(
      gap: 4,
      children: [
        HRow(
          main: MainAxisAlignment.spaceBetween,
          children: [
            Label('$valA', color: AppColors.text, weight: FontWeight.w500),
            Label(label, size: 10),
            Label('$valB', color: AppColors.text, weight: FontWeight.w500),
          ],
        ),
        BarTrack(height: 6, fraction: pA / 100, fill: AppColors.teal, track: AppColors.borderDark),
      ],
    );
  }
}

class ProgBar extends StatelessWidget {
  const ProgBar({super.key, required this.label, required this.pct, required this.value});

  final String label;
  final double pct;
  final String value;

  @override
  Widget build(BuildContext context) => Col(
        gap: 4,
        children: [
          HRow(
            main: MainAxisAlignment.spaceBetween,
            children: [
              Label(label, color: AppColors.text),
              Label(value, color: AppColors.teal, weight: FontWeight.w600),
            ],
          ),
          BarTrack(height: 5, fraction: pct / 100, fill: AppColors.teal, track: AppColors.placeholder),
        ],
      );
}

class KeyValueRow extends StatelessWidget {
  const KeyValueRow({super.key, required this.label, required this.value, required this.spacing});

  final String label;
  final String value;
  final double spacing;

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.only(bottom: spacing),
        padding: EdgeInsets.only(bottom: spacing),
        decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
        child: HRow(
          main: MainAxisAlignment.spaceBetween,
          children: [
            Label(label),
            const SizedBox(width: 8),
            Flexible(
              child: Label(value, color: AppColors.text, weight: FontWeight.w500, textAlign: TextAlign.right),
            ),
          ],
        ),
      );
}

class TabStrip extends StatelessWidget {
  const TabStrip({
    super.key,
    required this.labels,
    required this.selected,
    required this.onSelect,
    required this.fontSize,
    required this.border,
  });

  final List<String> labels;
  final int selected;
  final ValueChanged<int> onSelect;
  final double fontSize;
  final Border border;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(border: border),
        child: Row(
          children: [
            for (var i = 0; i < labels.length; i++)
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onSelect(i),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: i == selected ? AppColors.highlight : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Label(
                      labels[i],
                      size: fontSize,
                      color: i == selected ? AppColors.highlight : AppColors.white60,
                      weight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
}
