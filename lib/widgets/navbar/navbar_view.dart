import 'package:main_project/widgets/navbar/navbar_link.dart';
import 'package:flutter/material.dart';

class DesktopDisplay extends StatelessWidget {
  const DesktopDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        const NavbarLogo(),
        const NavbarLinks(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: const Text(
                'JK',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.logout),
              label: Text('Logout',
                  style: Theme.of(context).textTheme.displaySmall),
              style: ElevatedButton.styleFrom(
                elevation: 5,
                side: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                  // strokeAlign: BorderSide.strokeAlignCenter,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

class TabletDisplay extends StatelessWidget {
  final List<String> items;
  const TabletDisplay({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [NavbarLogo(), NavbarLinks()],
    );
  }
}

class MobileDisplay extends StatelessWidget {
  final Function() toggleSidebar;
  final bool isSidebarOpen;
  const MobileDisplay(
      {super.key, required this.toggleSidebar, required this.isSidebarOpen});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        const NavbarLogo(),
        IconButton(
          onPressed: toggleSidebar,
          icon: Icon(
            isSidebarOpen ? Icons.close : Icons.menu,
            color: Theme.of(context).colorScheme.onTertiary,
            size: 30,
          ),
        ),
      ],
    );
  }
}

class NavbarLogo extends StatelessWidget {
  const NavbarLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Project'.toUpperCase(),
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w900,
        color: Theme.of(context).colorScheme.onTertiary,
      ),
    );
  }
}

class NavbarLinks extends StatelessWidget {
  const NavbarLinks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        NavbarLink(title: 'Home', route: '/'),
        NavbarLink(title: 'Tasks', route: '/tasks'),
        NavbarLink(title: 'Assign task', route: '/new-task')
      ],
    );
  }
}
