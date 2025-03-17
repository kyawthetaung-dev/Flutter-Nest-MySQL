import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/feat_core.dart';
import '../../models/models.dart';

class SaveAndFavoriteButton extends StatelessWidget {
  final RecipeModel recipe;
  const SaveAndFavoriteButton({super.key, required this.recipe});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueListenableBuilder<Box>(
          valueListenable: Hive.box(AppDb.favorite).listenable(),
          builder: (context, box, child) {
            bool isfavorite = box.containsKey(recipe.id);
            return FloatingActionButton(
              backgroundColor: Colors.transparent,
              elevation: 0.07,
              mini: true,
              onPressed: () async {
                if (isfavorite) {
                  await box.delete(recipe.id);
                } else {
                  await box.put(recipe.id, recipe.toJson());
                }
              },
              child: Icon(
                Icons.favorite,
                color:
                    isfavorite ? context.color.error : context.color.onPrimary,
              ),
            );
          },
        ),
        const SizedBox(height: 8),
        Card(
          margin: EdgeInsets.zero,
          color: Colors.transparent,
          elevation: 0.07,
          child: IconButton(
            onPressed: () async {
              final now = DateTime.now();
              var selectDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(now.year, now.month - 6),
                lastDate: DateTime(now.year, now.month + 6),
              );
              if (selectDate != null) {
                final updateRecipe =
                    recipe.copyWith(mealPlanDate: selectDate.toString());
                String id = "${updateRecipe.id}${updateRecipe.mealPlanDate}";
                final box = Hive.box(AppDb.weeklyPlan);
                await box.put(id, updateRecipe.toJson());
              }
            },
            icon: Icon(Icons.save, color: context.color.primary),
          ),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:meal_plan/core/feat_core.dart';
// import 'package:meal_plan/models/feat_models.dart';

// class FavoriteButton extends StatelessWidget {
//   final RecipeModel recipe;
//   const FavoriteButton({super.key, required this.recipe});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         FloatingActionButton(
//           backgroundColor: Colors.transparent,
//           elevation: 0.07,
//           onPressed: () async {
//             final now = DateTime.now();
//             var selectDate = await showDatePicker(
//               context: context,
//               firstDate: DateTime(now.year, now.month, now.day - 7),
//               lastDate: DateTime(now.year, now.month, now.day + 7),
//             );
//             if (selectDate != null) {
//               plog("selectDate", recipe);
//               plog(
//                 "selectDate",
//                 recipe.copyWith(mealPlanDate: selectDate.toString()).toJson(),
//               );

//               final updateRecipe =
//                   recipe.copyWith(mealPlanDate: selectDate.toString());
//               final box = Hive.box(AppDb.weeklyPlan);
//               box.put(
//                 "${updateRecipe.id}${updateRecipe.mealPlanDate}",
//                 updateRecipe.toJson(),
//               );
//             }
//           },
//           child: Icon(
//             Icons.save,
//             color: context.color.primary,
//           ),
//         ),
//         const SizedBox(height: 8),
//         ValueListenableBuilder<Box>(
//           valueListenable: Hive.box(AppDb.favorite).listenable(),
//           builder: (context, box, child) {
//             bool isfavorite = box.containsKey(recipe.id);
//             if (isfavorite) {
//               return FloatingActionButton(
//                 backgroundColor: Colors.transparent,
//                 elevation: 0.07,
//                 onPressed: () {
//                   final box = Hive.box(AppDb.favorite);
//                   box.delete(recipe.id);
//                 },
//                 child: Icon(
//                   Icons.favorite,
//                   color: context.color.error,
//                 ),
//               );
//             } else {
//               return FloatingActionButton(
//                 backgroundColor: Colors.transparent,
//                 elevation: 0.07,
//                 onPressed: () {
//                   final box = Hive.box(AppDb.favorite);
//                   box.put(recipe.id, recipe.toJson());
//                 },
//                 child: Icon(
//                   Icons.favorite,
//                   color: context.color.onPrimary,
//                 ),
//               );
//             }
//           },
//         ),
//       ],
//     );
//   }
// }
