import 'package:chat_app/constants/colors.dart';
import 'package:chat_app/services/auth/auth_services.dart';
import 'package:chat_app/services/chat/chat_services.dart';
import 'package:chat_app/view/chat_screen/chat_screen.dart';
import 'package:chat_app/view/home_screen/widgets/drawer_widget.dart';
import 'package:chat_app/view/home_screen/widgets/usertile_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ChatServices _chatServices = ChatServices();
  final AuthServices _authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor:cTransparentColor,
        foregroundColor: cGreyColor,
        elevation: 0,
        centerTitle: true,
      ),
      drawer: const DrawerWidget(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatServices.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading..");
        }
        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != _authServices.getCurrentUser()!.email) {
      return UserTileWidget(
        text: userData["email"],
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  ChatScreen(receiverEmail: userData["email"],receiverID: userData["uid"]),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
