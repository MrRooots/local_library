import 'package:flutter/material.dart';

class ExpandableTextWidget extends StatefulWidget {
  final int maxCollapseLength;
  final String text;
  final TextStyle? style;

  const ExpandableTextWidget({
    super.key,
    required this.text,
    this.maxCollapseLength = 150,
    this.style,
  });

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget>
    with SingleTickerProviderStateMixin {
  bool isCollapse = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          isCollapse
              ? '${widget.text.substring(0, widget.maxCollapseLength)}...'
              : widget.text,
          style: widget.style,
        ),
        Align(
          alignment: Alignment.center,
          child: TextButton(
            onPressed: () => setState(() => isCollapse = !isCollapse),
            child: Text(
              isCollapse ? 'Read more' : 'Hide',
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        )
      ],
    );
  }
}
