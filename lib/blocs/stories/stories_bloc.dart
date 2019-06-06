import 'package:baobab_app/blocs/stories/stories_event.dart';
import 'package:baobab_app/blocs/stories/stories_state.dart';
import 'package:baobab_app/database/database.dart';
import 'package:baobab_app/models.dart';
import 'package:bloc/bloc.dart';

class StoriesBloc extends Bloc<StoriesEvent, StoriesState> {
  String _storiesCollectionPath = 'stories';
  String _playListPath = 'playlist';

  /// Stores the currently displayed documents
  List<Story> stories;
  List<Song> songs;

  StoriesState get initialState {
    if (stories != null) {
      return StoriesState(
        stories: stories,
        isInitialising: false,
        isLoading: false,
        error: '',
      );
    } else if (songs != null) {
      return StoriesState(
        songs: songs,
        isInitialising: false,
        isLoading: false,
        error: '',
      );
    } else {
      return StoriesState.initialising();
    }
  }

  @override
  Stream<StoriesState> mapEventToState(StoriesState currentState, StoriesEvent event) async* {
    if (event is LoadStoriesEvent) {
      yield StoriesState.loading();

      try {
        List<Map<String, dynamic>> documents =
            await Database.readDocumentsAtCollectionWithLimitByTimestampDescending(_storiesCollectionPath, 10);
        stories = documents.map((map) => Story.fromMap(map)).toList();
        yield StoriesState.normal(stories);
      } catch (error) {
        yield StoriesState.failure(error.message);
      }
    } else if (event is StorieItemSelectedEvent) {
      try {
        yield StoriesState.initialisingPlayList();
        List<Map<String, dynamic>> documentsSub =
            await Database.readDocumentsSubCollection(event.storieId, _storiesCollectionPath, _playListPath, 10);
        songs = documentsSub.map((map) => Song.fromMap(map)).toList();
        yield StoriesState.detail(songs);
      } catch (error) {
        yield StoriesState.failure(error.zmessage);
      }
    }
  }

  void loadEvents() {
    dispatch(LoadStoriesEvent());
  }

  void loadStoryDetail(String storieId) {
    dispatch(StorieItemSelectedEvent(storieId: storieId));
  }
}
