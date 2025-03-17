import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:meal_plan/core/feat_core.dart';

import '../../models/models.dart';

class RecipeItem extends StatelessWidget {
  const RecipeItem({
    super.key,
    required this.recipe,
    this.onTapToDelete,
  });

  final RecipeModel recipe;
  final void Function()? onTapToDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.color.primaryContainer.withAlpha(90),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: () {
          AutoRouter.of(context).push(
            RecipeDetialRoute(recipe: recipe),
          );
        },
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            height: 50,
            width: 50,
            fit: BoxFit.cover,
            imageUrl: recipe.image ?? "",
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
                    child: CircularProgressIndicator(
              value: downloadProgress.progress,
              strokeWidth: 2,
              color: context.color.primaryContainer,
            )),
            errorWidget: (context, url, error) =>
                const Icon(Icons.image, size: 46),
          ),
        ),
        title: Text(
          recipe.title ?? "",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: onTapToDelete == null
            ? Icon(Icons.arrow_forward_ios, size: 14)
            : IconButton(onPressed: onTapToDelete, icon: Icon(Icons.delete)),
      ),
    );
  }
}
