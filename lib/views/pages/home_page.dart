import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_plan/core/feat_core.dart';

import '../../models/recipe_model.dart';
import '../../view_models/view_models.dart';
import '../widgets/widgets.dart';

@RoutePage()
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final searchController = TextEditingController();
  // List of chip labels
  final List<String> _chipLabels = [];

  // Track selected chips
  final List<String> _selectedChips = [];
  List<RecipeModel> itemResult = [];
  @override
  void initState() {
    super.initState();
    fetchIngredients();
  }

  Future<void> fetchIngredients() async {
    Future.microtask(() async {
      searchController.clear();
      _selectedChips.clear();
      await ref.read(recipeViewModelProvider.notifier).fetchRecipes();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(ingredientViewModelProvider, (previous, next) {
      next.when(
        data: (result) {
          for (var ingredient in result) {
            if (ingredient.name != null) _chipLabels.add(ingredient.name!);
          }
          setState(() {});
        },
        error: (error, stackTrace) {},
        loading: () {},
      );
    });

    ref.listen(recipeViewModelProvider, (previous, next) {
      next.when(
        data: (result) async {
          await ref
              .read(ingredientViewModelProvider.notifier)
              .fetchIngredients();
          itemResult = result;
        },
        error: (error, stackTrace) {},
        loading: () {},
      );
    });

    final recipeState = ref.watch(recipeViewModelProvider);
    final ingredientState = ref.watch(ingredientViewModelProvider);

    void onSearch(String value) {
      List<RecipeModel> tempList = [];
      tempList = itemResult;
      if (value.isNotEmpty) {
        tempList = itemResult
            .where((item) =>
                item.title!.toLowerCase().contains(value.toLowerCase()))
            .toList();
      }

      setState(() {
        itemResult = tempList;
      });
      setState(() {});
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Meal Plan"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: fetchIngredients,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Column(
            children: [
              TextFormField(
                controller: searchController,
                readOnly: false,
                decoration: InputDecoration(
                  hintText: "Select ingredients",
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (_selectedChips.isNotEmpty) {
                        ref
                            .read(recipeViewModelProvider.notifier)
                            .fetchRecipesByIngredients(
                                _selectedChips.join(','));
                      }
                    },
                    icon: Icon(Icons.search, size: 22),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    onSearch(value);
                  });
                },
              ),
              ingredientState.when(
                data: (result) => ingredientList(),
                error: (error, stackTrace) => const SizedBox(),
                loading: () => SizedBox(),
              ),
              Expanded(
                child: recipeState.when(
                  data: (result) => ListView.builder(
                    itemCount: itemResult.length,
                    itemBuilder: (context, index) {
                      return RecipeItem(recipe: itemResult[index]);
                    },
                  ),
                  error: (error, stackTrace) => AppError(
                    message: error.toString(),
                    onTap: fetchIngredients,
                  ),
                  loading: () => AppLoading(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox ingredientList() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final label = _chipLabels[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: FilterChip(
                label: Text(label),
                selected: _selectedChips.contains(label),
                onSelected: (isSelected) {
                  setState(() {
                    if (isSelected) {
                      _selectedChips.add(label);
                    } else {
                      _selectedChips.remove(label);
                    }
                  });
                  searchController.text = _selectedChips.join(', ');
                },
                selectedColor: context.color.primaryContainer,
                checkmarkColor: context.color.onPrimaryContainer,
              ),
            );
          },
          itemCount: _chipLabels.length),
    );
  }
}
