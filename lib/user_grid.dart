import 'package:flutter/material.dart';

import 'user_view_model.dart';

class UserGrid extends StatelessWidget {
  final UserViewModel viewModel;

  const UserGrid({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: viewModel.refresh,
      child: GridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: viewModel.users.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
      final user = viewModel.users[index];
      return GridTile(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            viewModel.buildAvatar(user.avatarUrl),
            const SizedBox(height: 8),
            Text(user.fullName),
            const SizedBox(height: 4),
            Text(user.email),
          ],
        ),
      );
    },
  ),
);
}
}