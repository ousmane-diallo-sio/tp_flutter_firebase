part of 'post_bloc.dart';

@immutable
sealed class PostEvent {}

class GetPostsEvent extends PostEvent {}

class CreatePostEvent extends PostEvent {
  final Post post;

  CreatePostEvent({required this.post});
}

class UpdatePostEvent extends PostEvent {
  final Post post;

  UpdatePostEvent({required this.post});
}
