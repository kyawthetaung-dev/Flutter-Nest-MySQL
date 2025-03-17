import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_plan/models/models.dart';
import 'package:meal_plan/view_models/user_view_model.dart';

@RoutePage()
class UserPage extends ConsumerStatefulWidget {
  const UserPage({super.key});

  @override
  ConsumerState<UserPage> createState() => _UserPageState();
}

class _UserPageState extends ConsumerState<UserPage> {
  List<UserModel> users = [];
  @override
  void initState() {
    super.initState();
    getUsers();
  }

  Future<void> getUsers() async {
    Future.microtask(() async {
      await ref.read(userViewModelProvider.notifier).fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userViewModelProvider);
    ref.listen(userViewModelProvider, (pre, next) {
      next.when(
        data: (result) {
          users = result;
          log(users.toString());
        },
        error: (error, stackTrace) {},
        loading: () {},
      );
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('User Lists'),
      ),
      body: userState.maybeWhen(
          orElse: () {
            return null;
          },
          data: (data) => ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                var user = users[index];
                return ListTile(
                  leading: Text(user.userCode.toString()),
                );
              }),
          loading: () => Center(child: CircularProgressIndicator())),
    );
  }
}
