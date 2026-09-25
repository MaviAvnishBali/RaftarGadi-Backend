import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:shared_widgets/src/layout/responsive.dart';

/// One entry in the app's primary navigation.
class RaftarDestination {
  const RaftarDestination({
    required this.icon,
    required this.label,
    IconData? selectedIcon,
  }) : selectedIcon = selectedIcon ?? icon;

  final IconData icon;
  final IconData selectedIcon;
  final String label;
}

/// Adaptive primary navigation scaffold: a bottom bar on mobile, a navigation
/// rail on tablet/desktop (extended on desktop). Router-agnostic — the host
/// app owns [selectedIndex]/[onDestinationSelected] and passes the current
/// page as [body], so it drops straight onto a GoRouter shell.
class RaftarNavShell extends StatelessWidget {
  const RaftarNavShell({
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.body,
    this.leading,
    super.key,
  });

  final List<RaftarDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final Widget body;

  /// Optional header widget (e.g. logo) shown atop the rail on wide layouts.
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) {
      return Scaffold(
        body: body,
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: onDestinationSelected,
          destinations: [
            for (final d in destinations)
              NavigationDestination(
                icon: Icon(d.icon),
                selectedIcon: Icon(d.selectedIcon),
                label: d.label,
              ),
          ],
        ),
      );
    }

    final extended = context.isDesktop;
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: extended,
            minExtendedWidth: 208,
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            leading: leading == null
                ? null
                : Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: RaftarSpacing.lg,
                    ),
                    child: leading,
                  ),
            labelType: extended
                ? NavigationRailLabelType.none
                : NavigationRailLabelType.all,
            destinations: [
              for (final d in destinations)
                NavigationRailDestination(
                  icon: Icon(d.icon),
                  selectedIcon: Icon(d.selectedIcon),
                  label: Text(d.label),
                ),
            ],
          ),
          const VerticalDivider(width: 1),
          Expanded(child: body),
        ],
      ),
    );
  }
}
