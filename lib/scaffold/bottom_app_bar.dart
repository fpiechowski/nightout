import 'package:flutter/material.dart';

import '../party/nearBy/filters/filters.dart';

class NightOutBottomNavigationBar extends StatelessWidget {

  const NightOutBottomNavigationBar.home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      key: key,
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () =>
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => const Filters(),
                    ),
                icon: const Icon(Icons.filter_list_alt)),
            IconButton(
                onPressed: () =>
                    Navigator.pushNamed(context, "/user/groups"),
                icon: const Icon(Icons.people))
          ],
        ),
      ),
    );
  }
}
