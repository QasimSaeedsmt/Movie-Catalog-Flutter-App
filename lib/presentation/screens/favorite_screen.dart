import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:nextion/presentation/extensions/build_context_extension.dart';
import '../../core/boxes.dart';
import '../../data/models/movie_model.dart';
import '../../domain/bloc/favourite_bloc.dart';
import '../../domain/bloc/favourite_event.dart';
import '../../domain/bloc/favourite_state.dart';
import '../constants/constants_resources.dart';
import '../constants/dimension_resources.dart';
import '../constants/string_resources.dart';

/// Represents the screen that displays the user's favorite movies.
class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  FavouriteScreenState createState() => FavouriteScreenState();
}

// The state for the [FavouriteScreen].
class FavouriteScreenState extends State<FavouriteScreen> {
  /// List of favorite movies.
  List<Movie>? data;

  @override
  void initState() {
    // Initialize the list of favorite movies from Hive database.
    var box = Boxes.getData();
    data = box.values.toList().cast<Movie>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FavouriteBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(StringResources.FAVOURITE_SCREEN_TITLE),
      ),
      body: BlocBuilder<FavouriteBloc, FavouriteState>(
        builder: (context, state) {
          // Update the list of favorite movies based on state changes.
          if (state is AddToFavouriteState) {
            data = state.data;
          }
          if (state is RemoveFromFavouriteState) {
            data = state.data;
          }

          return data == null || data!.isEmpty
              ? const Center(
                  child: Text(
                    StringResources.NO_FAVOURITE_ITEMS,
                    style: TextStyle(
                      fontSize: DimensionResources.D_16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : FutureBuilder(
                  builder: (context, snapshot) {
                    // Show loading indicator while fetching data.
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      // Display an error message if data fetching fails.
                      return const Center(
                        child: Text(StringResources.ERROR_LOADING_DATA),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.all(DimensionResources.D_8),
                      child: AlignedGridView.count(
                        crossAxisCount:
                            ConstantsResources.GRID_CROSS_ACCESS_COUNT,
                        mainAxisSpacing: DimensionResources.D_16,
                        crossAxisSpacing: DimensionResources.D_16,
                        itemCount: data?.length ?? 0,
                        itemBuilder: (context, index) {
                          // Format the release date using intl package.
                          String formattedDate = DateFormat.yMMMd()
                              .format(data![index].releaseDate);

                          return Card(
                            elevation: DimensionResources.D_8,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(DimensionResources.D_8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 180,
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(
                                          DimensionResources.D_8),
                                    ),
                                    child: Image.network(
                                      data![index].posterUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(
                                      DimensionResources.D_8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: DimensionResources.D_40,
                                        child: Text(
                                          data![index].title,
                                          style: const TextStyle(
                                            fontSize: DimensionResources.D_16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                          height: DimensionResources.D_4),
                                      SizedBox(
                                        height: DimensionResources.D_40,
                                        // Adjust as needed
                                        child: Text(
                                          data![index].overview,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(
                                          height: DimensionResources.D_4),
                                      SizedBox(
                                        height: DimensionResources.D_18,
                                        // Adjust as needed
                                        child: Text(
                                          '${StringResources.RELEASE_DATE_TEXT} $formattedDate',
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: DimensionResources.D_14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                BlocListener<FavouriteBloc, FavouriteState>(
                                  listener: (context, state) {
                                    // Show a snackbar when a movie is removed from favorites.
                                    if (state is RemoveFromFavouriteState) {
                                      context.showSnackbar(
                                        StringResources
                                            .SNACK_BAR_REMOVED_FROM_FAVOURITE_TEXT,
                                        hideOnTap: true,
                                        backgroundColor: Colors.redAccent,
                                      );
                                    }
                                  },
                                  child: ElevatedButton(
                                    onPressed: () {
                                      /// Remove the movie from favorites.
                                      bloc.add(RemoveFromFavouriteEvent(
                                          index: index, id: data![index].id));
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      minimumSize: const Size(double.infinity,
                                          DimensionResources.D_48),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: DimensionResources.D_12,
                                        horizontal: DimensionResources.D_16,
                                      ),
                                    ),
                                    child: const Text(
                                        StringResources.REMOVE_FROM_FAVOURITES),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
