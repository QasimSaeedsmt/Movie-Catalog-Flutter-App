// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/bloc/favourite_bloc.dart';
import '../../domain/bloc/favourite_state.dart';
import '../constants/constants_resources.dart';
import '../constants/dimension_resources.dart';
import '../constants/responsive_resources.dart';
import '../constants/string_resources.dart';
import 'favourite_button.dart';

/// Represents a widget for displaying a movie in a list.
class MovieListWidget extends StatelessWidget {
  const MovieListWidget({
    Key? key,
    required this.index,
    required this.snapshot,
    required this.movieList,
    required this.formattedDate,
  }) : super(key: key);

  final List movieList;
  final int index;
  final snapshot;
  final String formattedDate;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return buildCard(constraints.maxWidth);
      },
    );
  }

  /// Builds the card displaying movie information.
  Widget buildCard(double width) {
    bool isWideScreen = width > ResponsiveResources.WIDE_SCREEN_THRESHOLD;

    return SingleChildScrollView(
      child: Card(
        elevation: DimensionResources.D_8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DimensionResources.D_8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: isWideScreen
                  ? DimensionResources.D_200
                  : DimensionResources.D_150,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(DimensionResources.D_8),
                ),
                child: Image.network(
                  movieList[index].posterUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(DimensionResources.D_8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: DimensionResources.D_40,
                    child: Text(
                      movieList[index].title,
                      style: TextStyle(
                        fontSize: isWideScreen
                            ? DimensionResources.D_20
                            : DimensionResources.D_16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: DimensionResources.D_4),
                  SizedBox(
                    height: isWideScreen
                        ? DimensionResources.D_60
                        : DimensionResources.D_40,
                    child: Text(
                      movieList[index].overview,
                      maxLines: ConstantsResources.OVERVIEW_MAX_LINES,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: DimensionResources.D_8),
                  SizedBox(
                    height: DimensionResources.D_18,
                    child: Text(
                      '${StringResources.RELEASE_DATE_TEXT} $formattedDate',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: isWideScreen
                            ? DimensionResources.D_16
                            : DimensionResources.D_14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: DimensionResources.D_48,
              child: BlocBuilder<FavouriteBloc, FavouriteState>(
                builder: (context, state) {
                  // Update UI based on the FavouriteBloc state.
                  return FavouriteButton(snapshot: snapshot, index: index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
