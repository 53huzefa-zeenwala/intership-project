import 'package:flutter/material.dart';
import 'package:main_project/widgets/navbar/mobile_sidebar.dart';
import 'package:main_project/widgets/navbar/navbar_layout.dart';
import 'package:main_project/widgets/navbar/navbar_view.dart';

class BaseLayout extends StatefulWidget {
  final Widget child;
  const BaseLayout({super.key, required this.child});

  @override
  State<BaseLayout> createState() => _BaseLayoutState();
}

class _BaseLayoutState extends State<BaseLayout> {
  bool isSidebarOpen = false;

  void toggleSidebar() {
    setState(() {
      isSidebarOpen = !isSidebarOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    const double sidebarWidth = 220;
    return Scaffold(
        body: Stack(
      children: [
        Column(
          children: [
            const Navbar(
              // child: DesktopDisplay(),
              child: DesktopDisplay(),
            ),
            Expanded(child: widget.child),
          ],
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          top: 0,
          bottom: 0,
          left: isSidebarOpen ? 0 : -sidebarWidth,
          // right: isSidebarOpen ? 0 : 100,
          child: MobileSideBar(
            toggleSidebar: toggleSidebar,
            sidebarWidth: sidebarWidth,
          ),
        )
      ],
    ),);
  }
}
