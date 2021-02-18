part of 'liked_posts_cubit.dart';

class LikedPostsState extends Equatable {
  final Set<String> likedPostIds;
  final Set<String> recentlyLikedPostsIds;

  const LikedPostsState({
    @required this.likedPostIds,
    @required this.recentlyLikedPostsIds,
  });

  factory LikedPostsState.initial() {
    return LikedPostsState(likedPostIds: {}, recentlyLikedPostsIds: {});
  }

  @override
  List<Object> get props => [
        likedPostIds,
        recentlyLikedPostsIds,
      ];

  LikedPostsState copyWith({
    Set<String> likedPostIds,
    Set<String> recentlyLikedPostsIds,
  }) {
    return LikedPostsState(
      likedPostIds: likedPostIds ?? this.likedPostIds,
      recentlyLikedPostsIds:
          recentlyLikedPostsIds ?? this.recentlyLikedPostsIds,
    );
  }
}
