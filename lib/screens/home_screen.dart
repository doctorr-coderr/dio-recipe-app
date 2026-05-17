import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/recipe_bloc.dart';
import '../bloc/recipe_event.dart';
import '../bloc/recipe_state.dart';

import '../models/recipe.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  // ADD / EDIT BOTTOM SHEET
  void showRecipeForm(
      BuildContext context, {
        Recipe? recipe,
        int? index,
      }) {

    final nameController =
    TextEditingController(
      text: recipe?.name ?? '',
    );

    final cuisineController =
    TextEditingController(
      text: recipe?.cuisine ?? '',
    );

    final difficultyController =
    TextEditingController(
      text: recipe?.difficulty ?? '',
    );

    final imageController =
    TextEditingController(
      text: recipe?.image ?? '',
    );

    showModalBottomSheet(
      context: context,

      isScrollControlled: true,

      backgroundColor: Colors.white,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),

      builder: (_) {

        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 25,

            bottom:
            MediaQuery.of(context)
                .viewInsets
                .bottom + 20,
          ),

          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [

                // TOP BAR
                Container(
                  width: 50,
                  height: 5,

                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,

                    borderRadius:
                    BorderRadius.circular(20),
                  ),
                ),

                const SizedBox(height: 25),

                // TITLE
                Text(
                  recipe == null
                      ? 'Add Recipe'
                      : 'Edit Recipe',

                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 25),

                // NAME
                TextField(
                  controller: nameController,

                  decoration: InputDecoration(
                    hintText: 'Recipe Name',

                    filled: true,
                    fillColor: Colors.grey.shade100,

                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(14),

                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // CUISINE
                TextField(
                  controller: cuisineController,

                  decoration: InputDecoration(
                    hintText: 'Cuisine',

                    filled: true,
                    fillColor: Colors.grey.shade100,

                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(14),

                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // DIFFICULTY
                TextField(
                  controller:
                  difficultyController,

                  decoration: InputDecoration(
                    hintText: 'Difficulty',

                    filled: true,
                    fillColor: Colors.grey.shade100,

                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(14),

                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // IMAGE
                TextField(
                  controller: imageController,

                  decoration: InputDecoration(
                    hintText: 'Image URL',

                    filled: true,
                    fillColor: Colors.grey.shade100,

                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(14),

                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // BUTTON
                SizedBox(
                  width: double.infinity,

                  child: ElevatedButton(
                    onPressed: () {

                      final newRecipe = Recipe(
                        id: recipe?.id ??
                            DateTime.now()
                                .millisecondsSinceEpoch,

                        name:
                        nameController.text,

                        image:
                        imageController.text,

                        cuisine:
                        cuisineController.text,

                        difficulty:
                        difficultyController.text,
                      );

                      if (recipe == null) {

                        context.read<RecipeBloc>().add(
                          AddRecipe(newRecipe),
                        );

                      } else {

                        context.read<RecipeBloc>().add(
                          UpdateRecipe(
                            index!,
                            newRecipe,
                          ),
                        );
                      }

                      Navigator.pop(context);
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      Colors.black,

                      padding:
                      const EdgeInsets.symmetric(
                        vertical: 15,
                      ),

                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(14),
                      ),
                    ),

                    child: Text(
                      recipe == null
                          ? 'Add Recipe'
                          : 'Update Recipe',

                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,

        title: const Text(
          'RecipeSnap',

          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: BlocBuilder<
          RecipeBloc,
          RecipeState>(
        builder: (context, state) {

          // LOADING
          if (state is RecipeLoading) {

            return const Center(
              child:
              CircularProgressIndicator(),
            );
          }

          // ERROR
          if (state is RecipeError) {

            return Center(
              child: Text(state.message),
            );
          }

          // LOADED
          if (state is RecipeLoaded) {

            return RefreshIndicator(
              onRefresh: () async {

                context.read<RecipeBloc>().add(
                  FetchRecipes(),
                );
              },

              child: ListView.separated(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),

                itemCount: state.recipes.length,

                separatorBuilder: (_, __) {

                  return Divider(
                    thickness: 0.5,
                    color:
                    Colors.grey.shade300,
                  );
                },

                itemBuilder: (context, index) {

                  final recipe =
                  state.recipes[index];

                  return Padding(
                    padding:
                    const EdgeInsets.symmetric(
                      vertical: 10,
                    ),

                    child: Row(
                      children: [

                        // IMAGE
                        ClipRRect(
                          borderRadius:
                          BorderRadius.circular(
                            16,
                          ),

                          child: Image.network(
                            recipe.image,

                            width: 70,
                            height: 70,

                            fit: BoxFit.cover,

                            errorBuilder:
                                (_, __, ___) {

                              return Container(
                                width: 70,
                                height: 70,

                                color:
                                Colors.grey
                                    .shade200,

                                child: const Icon(
                                  Icons
                                      .image_not_supported,
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(width: 15),

                        // TEXT
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                            children: [

                              Text(
                                recipe.name,

                                maxLines: 1,

                                overflow:
                                TextOverflow
                                    .ellipsis,

                                style:
                                const TextStyle(
                                  fontSize: 16,

                                  fontWeight:
                                  FontWeight
                                      .w600,
                                ),
                              ),

                              const SizedBox(
                                height: 5,
                              ),

                              Text(
                                '${recipe.cuisine} • ${recipe.difficulty}',

                                style: TextStyle(
                                  color:
                                  Colors.grey
                                      .shade600,

                                  fontSize: 13,
                                ),
                              ),

                            ],
                          ),
                        ),

                        // ACTIONS
                        Row(
                          children: [

                            IconButton(
                              onPressed: () {

                                showRecipeForm(
                                  context,

                                  recipe: recipe,
                                  index: index,
                                );
                              },

                              icon: Icon(
                                Icons
                                    .edit_outlined,

                                color:
                                Colors.grey
                                    .shade700,

                                size: 20,
                              ),
                            ),

                            IconButton(
                              onPressed: () {

                                context
                                    .read<
                                    RecipeBloc>()
                                    .add(
                                  DeleteRecipe(
                                    recipe.id,
                                  ),
                                );
                              },

                              icon: Icon(
                                Icons
                                    .delete_outline,

                                color:
                                Colors.red
                                    .shade300,

                                size: 20,
                              ),
                            ),

                          ],
                        ),

                      ],
                    ),
                  );
                },
              ),
            );
          }

          return const SizedBox();
        },
      ),

      floatingActionButton:
      FloatingActionButton(
        backgroundColor: Colors.black,
        elevation: 1,

        onPressed: () {
          showRecipeForm(context);
        },

        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}