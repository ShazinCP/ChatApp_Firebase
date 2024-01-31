import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserTileWidget extends StatelessWidget {

  String text;
  final void Function()? onTap;
  
  UserTileWidget({
    super.key,
    required this.text,
    required this.onTap,
  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12),),
            margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 25),
            padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Icon(Icons.person),
            const SizedBox(width: 20),
            Text(text),
          ],
        ),
      ),
    );
  }
}
