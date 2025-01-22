import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revision/presentation/cubit/cubit/anime_shows_cubit.dart';
import 'package:revision/presentation/screens/anime_shows_screen.dart';
import 'package:revision/presentation/widgets/anime_show_card_widget.dart';

class SearchAnimeShowsScreen extends StatelessWidget {
  const SearchAnimeShowsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => AnimeShowsScreen()),
            );
          },
        ),
        title: TextField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search anime...',
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
            border: InputBorder.none,
            prefixIcon: const Icon(Icons.search, color: Colors.white),
          ),
          onChanged: (value) {
            // Call your search function here
            context.read<AnimeShowsCubit>().loadAnimeShows(
              title: value.isEmpty ? null : value,
            );
          },
        ), // You can customize the title here
        actions: [
          BlocBuilder<AnimeShowsCubit, AnimeShowsState>(
            builder: (context, state) {
              if (state is AnimeShowsLoaded) {
                return PopupMenuButton(
                  child: const Icon(Icons.sort),
                  onSelected: (String order) {
                    context.read<AnimeShowsCubit>().sortByRate(
                      sortOrder: order,
                    );
                  },
                  itemBuilder:
                      (context) => [
                        PopupMenuItem(
                          value: "Ascending",
                          child: Row(
                            children: [
                              const Icon(Icons.arrow_upward),
                              const SizedBox(width: 8),
                              const Text(
                                'Ascending',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: "Descending",
                          child: Row(
                            children: [
                              const Icon(Icons.arrow_downward),
                              const SizedBox(width: 8),
                              const Text(
                                'Descending',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<AnimeShowsCubit, AnimeShowsState>(
        builder: (context, state) {
          if (state is AnimeShowsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AnimeShowsLoaded) {
            return GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio:
                    0.7, // Adjust this value to control card height
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: state.shows.items.length,
              itemBuilder: (context, index) {
                final show = state.shows.items[index];
                return AnimeShowCard(
                  show: show,
                  onTap: () => {/* Handle tap */},
                );
              },
            );
          } else if (state is AnimeShowsError) {
            return Center(
              child: Text("Error Happend While Getting Anime Shows!!"),
            );
          }
          return const Center(child: Text('No shows found'));
        },
      ),
    );
  }
}
