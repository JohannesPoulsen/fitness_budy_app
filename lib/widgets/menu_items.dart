import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class MenuItem2 {
  final String text;
  final IconData icon;

  const MenuItem2({
    required this.text,
    required this.icon,
  });
}

class MenuItems {
  static const List<MenuItem2> firstItems = [clone, delete];
  static const List<MenuItem2> secondItems = [edit, clone, delete];
  static const List<MenuItem2> thirdItems = [clone, remove];

  static const clone = MenuItem2(text: 'Clone', icon: Icons.copy);
  static const delete = MenuItem2(text: 'Delete', icon: Icons.delete);
  static const edit = MenuItem2(text: 'Edit', icon: Icons.edit);
  static const remove = MenuItem2(text: 'Remove', icon: Icons.remove);

  static Widget buildItem(MenuItem2 item) {
    return Row(
      children: [
        Icon(
          item.icon,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
        ),
      ],
    );
  }
}