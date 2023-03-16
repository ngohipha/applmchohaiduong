import 'package:flutter/material.dart';

import 'user_view_model.dart';

class UserList extends StatelessWidget {
  final UserViewModel viewModel;

  const UserList({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: viewModel.refresh,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: viewModel.users.length,
        itemBuilder: (context, index) {
          final user = viewModel.users[index];
          return ListTile(
            leading: viewModel.buildAvatar(user.avatarUrl),
            title: Text(user.fullName),
            subtitle: Text(user.email),
          );
        },
      ),
    );
  }
}