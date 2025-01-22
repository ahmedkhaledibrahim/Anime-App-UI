import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:pagination_flutter/pagination.dart';
import 'package:revision/presentation/cubit/cubit/anime_shows_cubit.dart';
import 'package:revision/presentation/screens/search_anime_shows_screen.dart';
import 'package:revision/presentation/widgets/anime_show_card_widget.dart';

class AnimeShowsScreen extends StatelessWidget {
  final NumberPaginatorController _controller = NumberPaginatorController();
  final int _currentPage = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anime Shows'), // You can customize the title here
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => SearchAnimeShowsScreen(),
                ),
              );
            },
            icon: Icon(Icons.search),
          ),
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
      body: FutureBuilder(
        future: context.read<AnimeShowsCubit>().loadAnimeShows(
          page: _currentPage,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return BlocBuilder<AnimeShowsCubit, AnimeShowsState>(
              builder: (context, state) {
                if (state is AnimeShowsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AnimeShowsError) {
                  return Center(
                    child: Text("Error Happend While Getting Anime Shows!!"),
                  );
                } else if (state is AnimeShowsLoaded) {
                  return Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.all(8.0),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio:
                                0.7, // Adjust this value to control card height
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                          ),
                          itemCount: state.shows.items.length,
                          itemBuilder: (context, index) {
                            final show = state.shows.items[index];
                            return AnimeShowCard(show: show);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: NumberPaginator(
                          controller: _controller,
                          numberPages:
                              int.parse(
                                (state.shows.totalCount /
                                            state.shows.pageSize) >
                                        1
                                    ? (state.shows.totalCount /
                                            state.shows.pageSize)
                                        .toString()
                                    : "1",
                              ).round(),
                          onPageChange: (int index) {
                            // // When the page changes, load the relevant anime shows
                            context.read<AnimeShowsCubit>().loadAnimeShows(
                              page: index + 1,
                            );
                          },
                          // show/hide the prev/next buttons
                          showPrevButton: true,
                          showNextButton: true, // defaults to true
                          nextButtonBuilder:
                              (context) => TextButton(
                                onPressed:
                                    _controller.currentPage > 0
                                        ? () => _controller.next()
                                        : null, // _controller must be passed to NumberPaginator
                                child: const Row(
                                  children: [
                                    Icon(Icons.chevron_right),
                                    Text("Next"),
                                  ],
                                ),
                              ),
                          prevButtonBuilder:
                              (context) => TextButton(
                                onPressed:
                                    _controller.currentPage > 0
                                        ? () => _controller.prev()
                                        : null, // _controller must be passed to NumberPaginator
                                child: const Row(
                                  children: [
                                    Icon(Icons.chevron_left),
                                    Text("Previous"),
                                  ],
                                ),
                              ),
                        ),
                      ),
                    ],
                  );
                }
                return Container();
              },
            );
          }
        },
      ),
    );
  }
}
