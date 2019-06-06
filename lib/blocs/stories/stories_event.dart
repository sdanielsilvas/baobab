abstract class StoriesEvent {}

class LoadStoriesEvent extends StoriesEvent {}

class ViewStoriesEvent extends StoriesEvent {
  final String personID;

  ViewStoriesEvent({this.personID});
}

class StorieItemSelectedEvent extends StoriesEvent {
  final String storieId;

  StorieItemSelectedEvent({this.storieId});
}
