import 'package:flutter/material.dart';
import 'package:main_project/widgets/navbar/navbar_link.dart';

class MobileSideBar extends StatelessWidget {
  final Function() toggleSidebar;
  final double sidebarWidth;

  const MobileSideBar(
      {super.key, required this.toggleSidebar, required this.sidebarWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: const Color(0xff000000).withOpacity(1),
              offset: const Offset(0, 2),
              spreadRadius: -5,
              blurRadius: 16)
        ],
        color: Colors.blueAccent,
      ),
      width: sidebarWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/dummy_user.webp',
                    width: 60,
                    height: 60,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'User Name',
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSecondary),
                  )
                ],
              ),
            ),
            Positioned(
                left: sidebarWidth - 40,
                child: IconButton(
                  onPressed: toggleSidebar,
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ))
          ]),
          const NavbarLink(title: 'Home', route: '/'),
          const NavbarLink(title: 'Tasks', route: '/tasks'),
          const NavbarLink(title: 'Assign task', route: '/new-task'),
          const NavbarLink(title: 'Add member', route: '/new-member')
        ],
      ),
    );
  }
}
