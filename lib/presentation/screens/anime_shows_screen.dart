class AnimeShowsScreen extends StatefulWidget {
  @override
  _AnimeShowsScreenState createState() => _AnimeShowsScreenState();
}

class _AnimeShowsScreenState extends State<AnimeShowsScreen> {
  final NumberPaginatorController _controller = NumberPaginatorController();
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    // Load initial data when the screen is first created
    context.read<AnimeShowsCubit>().loadAnimeShows(page: _currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anime Shows'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
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
                    context.read<AnimeShowsCubit>().sortByRate(sortOrder: order);
                  },
                  itemBuilder: (context) => [
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
          } else if (state is AnimeShowsError) {
            return Center(
              child: Text("Error Happened While Getting Anime Shows!!"),
            );
          } else if (state is AnimeShowsLoaded) {
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.7,
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
                    numberPages: (state.shows.totalCount / state.shows.pageSize).ceil(),
                    onPageChange: (int index) {
                      // Update the current page and load new data
                      _currentPage = index + 1;
                      context.read<AnimeShowsCubit>().loadAnimeShows(page: _currentPage);
                    },
                    showPrevButton: true,
                    showNextButton: true,
                    nextButtonBuilder: (context) => TextButton(
                      onPressed: _controller.currentPage > 0
                          ? () => _controller.next()
                          : null,
                      child: const Row(
                        children: [
                          Icon(Icons.chevron_right),
                          Text("Next"),
                        ],
                      ),
                    ),
                    prevButtonBuilder: (context) => TextButton(
                      onPressed: _controller.currentPage > 0
                          ? () => _controller.prev()
                          : null,
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
      ),
    );
  }
}
