import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool isTop;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.isTop,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading:
          isTop ? null
                : IconButton(
                    icon: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 13, 0, 0),
                      child: Icon(
                        Icons.arrow_back,
                        color: Color(0xFF5B67CA),
                        size: 40,
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
      elevation: 0,
      centerTitle: false,
      title: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Row(
          children: [
            const SizedBox(width: 20),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
      bottom: isTop ? null
                    : PreferredSize(
                        preferredSize: const Size.fromHeight(4),
                        child: Container(
                          color: Color(0xFFE8ECFD),
                          height: 4,
                        )
                      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
