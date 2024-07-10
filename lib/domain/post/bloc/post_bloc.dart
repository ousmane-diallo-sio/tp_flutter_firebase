import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tp_flutter_firebase/domain/post/models/post.dart';
import 'package:tp_flutter_firebase/domain/post/models/post_exception.dart';
import 'package:tp_flutter_firebase/domain/post/post_repository.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository _postRepository;

  PostBloc(this._postRepository) : super(const PostState()) {
    on<GetPostsEvent>(_onGetAllPosts);
    on<CreatePostEvent>(_onCreatePost);
    on<UpdatePostEvent>(_onUpdatePost);
  }

  void _onGetAllPosts(GetPostsEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.gettingPosts));
    try {
      final posts = await _postRepository.getAllPosts();

      emit(state.copyWith(
        status: PostStatus.gotPostsWithSuccess,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostStatus.error,
        error: GetPostsException()
      ));
    }
  }

  void _onCreatePost(CreatePostEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.creatingPost));
    try {
      await _postRepository.createPost(event.post);
      await Future.delayed(const Duration(seconds: 1));

      emit(state.copyWith(
        status: PostStatus.createdPostWithSuccess,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostStatus.error,
        error: CreatePostException()
      ));
    }
  }

  void _onUpdatePost(UpdatePostEvent event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.updatingPost));
    try {
      await _postRepository.updatePost(event.post);
      await Future.delayed(const Duration(seconds: 1));

      emit(state.copyWith(
        status: PostStatus.updatedPostWithSuccess,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: PostStatus.error,
        error: UpdatePostException()
      ));
    }
  }
}
