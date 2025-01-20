import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:revision/presentation/cubit/cubit/anime_shows_cubit.dart';
import 'package:revision/presentation/widgets/anime_show_card_widget.dart';

class AnimeShowsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anime Shows'), // You can customize the title here
      ),
      body: FutureBuilder(
        future: context.read<AnimeShowsCubit>().loadAnimeShows(),
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
                  return Center(child: Text(state.message));
                } else if (state is AnimeShowsLoaded) {
                  return ListView.builder(
                    itemCount: state.shows.length,
                    itemBuilder: (context, index) {
                      final show = state.shows[index];
                      return AnimeShowCard(show: show);
                    },
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
