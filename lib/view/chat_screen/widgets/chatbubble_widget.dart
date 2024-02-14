import 'package:chat_app/constants/colors.dart';
import 'package:chat_app/controller/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    // light vs dark mode for correct bubble colors
    bool isDarkMode = Provider.of<ThemeProvider>(context, listen: false).isDarkMode;

    return Container(
      decoration: BoxDecoration(
          color: isCurrentUser
              ? (isDarkMode ? cGreenColorShade600 : cGreenColorShade500)
              : (isDarkMode ? cGreyColorShade800 : cGreyColorShade200),
          borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 2.4, horizontal: 25),
      child: Text(
        message,
        style: TextStyle(
          color: isCurrentUser
              ? cWhiteColor
              : (isDarkMode ? cWhiteColor : cBlackColor),
        ),
      ),
    );
  }
}
