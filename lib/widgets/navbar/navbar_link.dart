import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavbarLink extends StatefulWidget {
  final String route;
  final String title;

  const NavbarLink({super.key, required this.title, required this.route});

  @override
  State<NavbarLink> createState() => _NavbarLinkState();
}

class _NavbarLinkState extends State<NavbarLink> {
  late bool _isHovered;

  @override
  void initState() {
    // TODO: implement initState224
    super.initState();
    _isHovered = false;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => _isHovered = true),
      onExit: (event) => setState(() => _isHovered = false),

      child: InkWell(
        onTap: () => context.go(widget.route),
onFocusChange: (value) =>  setState(() => _isHovered = value),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _isHovered
                    ? Theme.of(context).primaryColorLight.withOpacity(0.5)
                    : Theme.of(context).primaryColorLight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
