import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meal_plan/core/feat_core.dart';
import 'package:meal_plan/models/models.dart';

import '../widgets/widgets.dart';

@RoutePage()
class FavoritePage extends ConsumerStatefulWidget {
  const FavoritePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavoritePageState();
}

class _FavoritePageState extends ConsumerState<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ValueListenableBuilder<Box>(
            valueListenable: Hive.box(AppDb.favorite).listenable(),
            builder: (context, box, child) {
              if (box.isEmpty) {
                return favoriteListEmpty();
              }

              return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, i) {
                  final info = box.getAt(i);
                  final recipe = RecipeModel.fromJson(info);
                  return RecipeItem(recipe: recipe);
                },
              );
            }),
      ),
    );
  }

  Center favoriteListEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            CupertinoIcons.heart_fill,
            size: 105,
            color: Colors.grey,
          ),
          SizedBox(
            width: 250,
            child: Text(
              "You don't have any Favorite recipe yet.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
