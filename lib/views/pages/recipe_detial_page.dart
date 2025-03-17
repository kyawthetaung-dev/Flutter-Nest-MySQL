import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_plan/core/feat_core.dart';
import 'package:meal_plan/models/models.dart';
import 'package:meal_plan/views/widgets/widgets.dart';

import '../../view_models/view_models.dart';

@RoutePage()
class RecipeDetialPage extends ConsumerStatefulWidget {
  const RecipeDetialPage({super.key, required this.recipe});

  final RecipeModel recipe;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RecipeDetialPageState();
}

class _RecipeDetialPageState extends ConsumerState<RecipeDetialPage> {
  @override
  void initState() {
    super.initState();
    fetchIngredients();
  }

  Future<void> fetchIngredients() async {
    Future.microtask(() async {
      await ref
          .read(recipeDetailViewModelProvider.notifier)
          .fetchRecipeDetail(widget.recipe.id.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final recipeDetailState = ref.watch(recipeDetailViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe.title ?? 'Recipe Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: recipeDetailState.when(
          data: (result) {
            if (result == null) return SizedBox();
            return recipeDetial(result);
          },
          error: (error, stackTrace) => AppError(
            message: error.toString(),
            onTap: fetchIngredients,
          ),
          loading: () => AppLoading(),
        ),
      ),
      floatingActionButton: recipeDetailState.maybeWhen(
        orElse: () => SizedBox(),
        data: (result) =>
            result == null ? SizedBox() : SaveAndFavoriteButton(recipe: result),
      ),
    );
  }

  ListView recipeDetial(RecipeModel result) {
    return ListView(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: result.image ?? '',
            placeholder: (context, url) => const AppLoading(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 8, bottom: 4),
          height: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ingredients",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final ingredient = result.extendedIngredients![index];
                      return Card(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            height: 50,
                            width: 50,
                            fit: BoxFit.fill,
                            imageUrl: ingredient.image ?? "",
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                                    child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                              strokeWidth: 2,
                              color: context.color.primaryContainer,
                            )),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.image, size: 46),
                          ),
                        ),
                      );
                    },
                    itemCount: result.extendedIngredients!.length),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Instructions",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Html(
          data: result.instructions,
          style: {
            'p': Style(
              fontSize: FontSize.large,
              color: Colors.black,
            ),
          },
        ),
      ],
    );
  }
}
