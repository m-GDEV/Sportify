import 'package:flutter/material.dart';

class SportCard extends StatefulWidget {
  final String name;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const SportCard({
    super.key,
    required this.name,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<SportCard> createState() => _SportCardState();
}

class _SportCardState extends State<SportCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -0.2),
    ).chain(CurveTween(curve: Curves.easeOut)).animate(_controller);
  }

  void _handleTap() {
    widget.onTap();

    _controller.forward().then((_) {
      _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color borderColor = widget.isSelected ? Colors.green.shade400 : Colors.green.shade100;
    final Color bgColor = widget.isSelected ? Colors.green.shade100 : Colors.green.shade50;
    final Color iconColor = widget.isSelected ? Colors.green[800]! : Colors.green[600]!;

    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: widget.isSelected ? Colors.green[500] : Colors.grey[900],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.green),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: _offsetAnimation,
              child: Icon(widget.icon, size: 26, color: widget.isSelected ? Colors.white : Colors.green),
            ),
            const SizedBox(height: 8),
            Text(
              widget.name,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: widget.isSelected ? Colors.white : iconColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
