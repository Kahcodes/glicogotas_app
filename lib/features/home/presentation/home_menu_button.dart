import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glicogotas_app/core/theme/app_text_styles.dart';

class HomeMenuButton extends StatefulWidget {
  const HomeMenuButton({
    super.key,
    required this.onTap,
    required this.color,
    required this.label,
    required this.icon,
  });

  final VoidCallback onTap;
  final Color color;
  final String label;
  final IconData icon;

  @override
  State<HomeMenuButton> createState() => _HomeMenuButtonState();
}

class _HomeMenuButtonState extends State<HomeMenuButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(20.r),
          border: Border(
            bottom: BorderSide(
              color: _isPressed
                  ? Colors.transparent
                  : Colors.grey.withValues(alpha: 0.4),
              width: 3,
            ),
          ),
          boxShadow: _isPressed
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        margin: EdgeInsets.all(6.w),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon, size: 26.sp, color: Colors.white),
            SizedBox(height: 6.h),
            Text(
              widget.label.toUpperCase(),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.podkova(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                height: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
