import 'package:baobab_app/models.dart';

class StoriesState {
  final bool isLoading;
  final bool isInitialising;
  final bool isLoadingPlaylist;
  final String error;
  final List<Story> stories;
  final List<Song> songs;

  StoriesState({this.isLoading, this.isInitialising,this.isLoadingPlaylist, this.error, this.stories,this.songs});

  /// This state is typical for when the HomePage has just been navigated to.
  factory StoriesState.initialising() {
    return StoriesState(
      stories: null,
      isLoading: false,
      isInitialising: true,
      isLoadingPlaylist:false,
      error: '',
    );
  }


  factory StoriesState.initialisingPlayList() {
    return StoriesState(
      stories: null,
      isLoading: false,
      isInitialising: false,
      isLoadingPlaylist:true,
      error: '',
    );
  }


  factory StoriesState.loading() {
    return StoriesState(
      stories: null,
      isLoading: true,
      isInitialising: false,
      error: '',
    );
  }

  factory StoriesState.failure(String error) {
    return StoriesState(
      stories: null,
      isLoading: false,
      isInitialising: false,
      error: error,
    );
  }


  factory StoriesState.detail(List<Song> songs) {
    return StoriesState(
      songs: songs,
      isLoading: false,
      isInitialising: false,
      isLoadingPlaylist: false,
      error: '',
    );
  }




  factory StoriesState.normal(List<Story> stories) {
    return StoriesState(
      stories: stories,
      isLoading: false,
      isInitialising: false,
      error: '',
    );
  }
}
