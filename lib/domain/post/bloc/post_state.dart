part of 'post_bloc.dart';

enum PostStatus {
  initial,
  gettingPosts,
  gotPostsWithSuccess,
  creatingPost,
  createdPostWithSuccess,
  updatingPost,
  updatedPostWithSuccess,
  error,
}

class PostState {
  final PostStatus status;
  final PostException? error;

  const PostState({
    this.status = PostStatus.initial,
    this.error,
  });

  PostState copyWith({
    PostStatus? status,
    PostException? error,
  }) {
    return PostState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
