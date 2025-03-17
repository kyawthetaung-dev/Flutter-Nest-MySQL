import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meal_plan/core/feat_core.dart';

import '../../models/models.dart';
import '../widgets/widgets.dart';

@RoutePage()
class WeeklyPlanPage extends ConsumerStatefulWidget {
  const WeeklyPlanPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WeeklyPlanPageState();
}

class _WeeklyPlanPageState extends ConsumerState<WeeklyPlanPage> {
  DateTime firstDay = AppUtils.firstDateOfWeek();
  DateTime lastDay = AppUtils.lastDateOfWeek();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weekly Plan'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              final now = DateTime.now();
              var selectDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(now.year, now.month - 6),
                lastDate: DateTime(now.year, now.month + 6),
              );
              if (selectDate != null) {
                setState(() {
                  firstDay = AppUtils.firstDateOfWeek(date: selectDate);
                  lastDay = AppUtils.lastDateOfWeek(date: selectDate);
                });
              }
            },
            icon: Icon(Icons.calendar_month),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ValueListenableBuilder<Box>(
            valueListenable: Hive.box(AppDb.weeklyPlan).listenable(),
            builder: (context, box, child) {
              if (box.isEmpty) {
                return reciptListEmpty();
              }

              List<RecipeModel> recipeList =
                  box.values.map((e) => RecipeModel.fromJson(e)).toList();

              recipeList.removeWhere(
                (element) =>
                    (DateTime.parse(element.mealPlanDate!).isBefore(firstDay) ||
                        DateTime.parse(element.mealPlanDate!).isAfter(lastDay)),
              );
              recipeList
                  .sort((a, b) => a.mealPlanDate!.compareTo(b.mealPlanDate!));
              Map<String?, List<RecipeModel>> recipeGroupList =
                  groupBy(recipeList, (e) => e.mealPlanDate);
              final recipeGroupkeyList = recipeGroupList.keys.toList();
              final recipeGroupValueList = recipeGroupList.values.toList();

              return recipeGroupkeyList.isEmpty
                  ? reciptListEmpty()
                  : recipeListView(recipeGroupkeyList, recipeGroupValueList);
            }),
      ),
    );
  }

  ListView recipeListView(List<String?> recipeGroupkeyList,
      List<List<RecipeModel>> recipeGroupValueList) {
    return ListView.builder(
      itemCount: recipeGroupkeyList.length,
      itemBuilder: (context, index) {
        final mealPlanDate = recipeGroupkeyList[index];
        final recipesInGroup = recipeGroupValueList[index];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mealPlanDate!.ddMMyyyy ?? '',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...List.generate(
              recipesInGroup.length,
              (index) => RecipeItem(
                recipe: recipesInGroup[index],
                onTapToDelete: () {
                  final box = Hive.box(AppDb.weeklyPlan);
                  box.delete(
                      "${recipesInGroup[index].id}${recipesInGroup[index].mealPlanDate}");
                },
              ),
            )
          ],
        );
      },
    );
  }

  Center reciptListEmpty() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(
            Icons.food_bank_outlined,
            size: 105,
            color: Colors.grey,
          ),
          SizedBox(
            width: 250,
            child: Text(
              "You don't have any recipe in this week.",
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
