// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:nextion/presentation/constants/string_resources.dart';
import 'package:nextion/presentation/extensions/build_context_extension.dart';

import '../../core/boxes.dart';
import '../../domain/bloc/favourite_bloc.dart';
import '../../domain/bloc/favourite_state.dart';
import '../../domain/respository/movie_repository.dart';
import '../constants/constants_resources.dart';
import '../constants/dimension_resources.dart';
import '../constants/responsive_resources.dart';
import '../widgets/movie_list_widget.dart';
import 'favorite_screen.dart';

/// Represents the screen displaying a list of movies.
class ListScreen extends StatelessWidget {
  List<bool>? isFavoriteList;

  // Constructor for ListScreen.
  ListScreen({Key? key}) : super(key: key);

  // Access the Hive box for data storage.
  var box = Boxes.getData();
  final getIt = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    // Get the size of the screen.
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        // Action to navigate to the FavoriteScreen.
        actions: [
          ElevatedButton(
            onPressed: () {
              context.navigateTo(const FavouriteScreen());
            },
            child: Padding(
              padding: const EdgeInsets.all(DimensionResources.D_8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(DimensionResources.D_10),
                  color: Colors.white24,
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(DimensionResources.D_8),
                    child: Text(
                      StringResources.GO_TO_FAVOURITES,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: DimensionResources.D_18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
        title: Text(StringResources.LIST_SCREEN_TITLE),
      ),
      body: BlocListener<FavouriteBloc, FavouriteState>(
        listener: (context, state) {
          // Update the list of favorite movies based on state changes.
          if (state is AddToFavouriteState) {
            isFavoriteList = state.isFavouriteList;
          }
        },
        child: FutureBuilder(
          future: getIt<MovieRepository>().getMovies(),
          builder: (context, snapshot) {
            List movieList = snapshot.data ?? ConstantsResources.EMPTY_LIST;
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show loading indicator while fetching data.
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
                crossAxisCount: ConstantsResources.GRID_CROSS_ACCESS_COUNT,
                mainAxisSpacing: size.height * ResponsiveResources.R_3,
                crossAxisSpacing: size.width * ResponsiveResources.R_3,
                itemCount: movieList.length,
                itemBuilder: (context, index) {
                  // Format the release date using intl package.
                  String formattedDate =
                      DateFormat.yMMMd().format(movieList[index].releaseDate);

                  return BlocListener<FavouriteBloc, FavouriteState>(
                    listener: (context, state) {
                      // Show a snackbar when a movie is added to favorites.
                      if (state is AddToFavouriteState) {
                        context.showSnackbar(
                          StringResources.SNACK_BAR_SAVED_TO_FAVOURITE_TEXT,
                          hideOnTap: true,
                        );
                      }
                    },
                    child: MovieListWidget(
                      movieList: movieList,
                      formattedDate: formattedDate,
                      index: index,
                      snapshot: snapshot,
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
