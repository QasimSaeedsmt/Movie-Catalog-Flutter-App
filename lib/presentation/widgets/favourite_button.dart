// ignore_for_file: prefer_typing_uninitialized_variables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nextion/presentation/extensions/build_context_extension.dart';

import '../../core/boxes.dart';
import '../../data/models/movie_model.dart';
import '../../domain/bloc/favourite_bloc.dart';
import '../../domain/bloc/favourite_event.dart';
import '../../domain/bloc/favourite_state.dart';
import '../constants/dimension_resources.dart';
import '../constants/responsive_resources.dart';
import '../constants/string_resources.dart';
import '../screens/favorite_screen.dart';

/// Represents a button used for adding movies to favorites.
class FavouriteButton extends StatelessWidget {
  final snapshot;
  final int index;

  /// Constructor for the [FavouriteButton] widget.
  const FavouriteButton({
    Key? key,
    required this.snapshot,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    // Access the FavouriteBloc.
    final bloc = context.read<FavouriteBloc>();

    // Access the Hive box for data storage.
    var box = Boxes.getData();
    List<Movie> data = box.values.toList().cast<Movie>();

    return BlocListener<FavouriteBloc, FavouriteState>(
      listener: (context, state) {
        // Handle state changes here, and update the UI accordingly.
        if (state is AddToFavouriteState) {
          // Update UI for the added movie.
          // You can perform any necessary UI changes here.
        } else if (state is RemoveFromFavouriteState) {
          // Update UI for the removed movie.
          // You can perform any necessary UI changes here.
        }
      },
      child: _buildButtonContent(context, bloc, data),
    );
  }

  /// Builds the appropriate button based on the movie's favorite status.
  Widget _buildButtonContent(
      BuildContext context, FavouriteBloc bloc, List<Movie> data) {
    if (!data.any((movie) => movie.id == snapshot.data![index].id)) {
      // Build button for adding to favorites.
      final size = MediaQuery.of(context).size;

      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // Add movie to favorites when tapped.
            bloc.add(AddToFavouriteEvent(
              data: snapshot.data,
              isFavourite: true,
              title: snapshot.data![index].title,
              id: snapshot.data![index].id,
              posterUrl: snapshot.data![index].posterUrl,
              overview: snapshot.data![index].overview,
              releaseDate: snapshot.data![index].releaseDate,
            ));
          },
          borderRadius: BorderRadius.circular(DimensionResources.D_12),
          child: Ink(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(DimensionResources.D_12),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context)
                      .colorScheme
                      .background, // Add a subtle shadow
                  blurRadius: DimensionResources.D_5,
                  offset: const Offset(
                      DimensionResources.D_0, DimensionResources.D_5),
                ),
              ],
            ),
            child: SizedBox(
              height: size.height * ResponsiveResources.R_5,
              child: const Center(
                child: Text(
                  StringResources.ADD_TO_FAVOURITES,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: DimensionResources.D_16,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      // Build button for navigating to favorites when movie is already saved.
      return InkWell(
        onTap: () => context.navigateTo(const FavouriteScreen()),
        child: Container(
          height: MediaQuery.of(context).size.height * ResponsiveResources.R_5,
          color: Theme.of(context).colorScheme.background,
          child: const Center(
            child: Text(
              StringResources.SAVED_IN_FAVOURITES,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: DimensionResources.D_16,
              ),
            ),
          ),
        ),
      );
    }
  }
}
