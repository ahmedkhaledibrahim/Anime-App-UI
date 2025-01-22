Anime Shows App
This Flutter app displays a list of anime shows with features like sorting, searching, filtering, lazy loading (pagination), and error handling. The app follows Clean Architecture principles and uses MVVM with Cubit/BLoC for state management. Dependency injection is handled using get_it.

Features
Main Screen:
Displays anime shows in a grid or list format.
Implements lazy loading or pagination.
Sorting options by rating or release date.
Filter/Search Screen:
Filters for categories or other properties like rating.
A text search field for titles with dynamic result updates.
State Management:
Handles loading, error, and data states with proper feedback.
Displays loading indicators while fetching data.
Graceful error handling for network issues with UI feedback.
Dependencies
get_it: Dependency injection.
flutter_bloc: For state management (Cubit or BLoC).
number_paginator: For implementing pagination.
http: For making API calls.
