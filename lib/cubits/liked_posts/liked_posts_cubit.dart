import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:app_social/models/models.dart';
import 'package:app_social/blocs/blocs.dart';
import 'package:app_social/repositories/repositories.dart';

part 'liked_posts_state.dart';

class LikedPostsCubit extends Cubit<LikedPostsState> {
  final PostRepository _postRepository;
  final AuthBloc _authBloc;

  LikedPostsCubit({
    @required PostRepository postRepository,
    @required AuthBloc authBloc,
  })  : _postRepository = postRepository,
        _authBloc = authBloc,
        super(LikedPostsState.initial());

  void updateLikedPosts({@required Set<String> postIds}) {
    emit(state.copyWith(
        likedPostIds: Set<String>.from(state.likedPostIds)..addAll(postIds)));
  }

  void likedPost({@required Post post}) {
    _postRepository.createLike(post: post, userId: _authBloc.state.user.uid);

    emit(
      state.copyWith(
        likedPostIds: Set<String>.from(state.likedPostIds)..add(post.id),
        recentlyLikedPostsIds: Set<String>.from(state.recentlyLikedPostsIds)
          ..add(post.id),
      ),
    );
  }

  void unlikedPost({@required Post post}) {
    _postRepository.deleteLike(
        postId: post.id, userId: _authBloc.state.user.uid);

    emit(
      state.copyWith(
        likedPostIds: Set<String>.from(state.likedPostIds)..remove(post.id),
        recentlyLikedPostsIds: Set<String>.from(state.recentlyLikedPostsIds)
          ..remove(post.id),
      ),
    );
  }

  void clearAllLikedPosts() {
    emit(LikedPostsState.initial());
  }
}
