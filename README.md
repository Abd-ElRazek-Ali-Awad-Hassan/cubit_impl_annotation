## cubit_impl_annotation
#### A package that helps you generate cubit implementations with annotations.
#### Use it along with cubit_impl_generator package.

## Usage
```dart
abstract interface class PostRepository {
    Future<Either<Failure, List<Post>>> getPosts();
}

final class GetPostsCubit extends Cubit<PostsState> with _$GetPostsCubitMixin {
    GetPostsCubit({
      required PostRepository postRepository,
    }) : super(PostsState.initial()) {
      _postRepository = postRepository;
    }
    
    late final PostRepository _postRepository;
    
    @ShowLoading()
    @OnEither<Failure, List<Post>>(
      callbackName: 'gettingPostsCallback',
      onSuccess: [ShowSuccess()],
      onFailure: [
        ReportServerFailure(),
        ReportNetworkFailure(),
      ],
    )
    void loadPosts() => _$loadPosts(
      gettingPostsCallback: _postRepository.getPosts,
    );
}
```

###### as you can see, our package CubitImplGenerator will generate commands based on annotations
```dart
ShowLoading()
```
```dart
OnEither()
```

#### Example

```dart
abstract interface class PostRepository {
  Future<Either<Failure, List<Post>>> getPosts();
}

final class GetPostsCubit extends Cubit<PostsState> with _$GetPostsCubitMixin {
  GetPostsCubit({
    required PostRepository postRepository,
  }) : super(PostsState.initial()) {
    _postRepository = postRepository;
  }

  late final PostRepository _postRepository;

  @ShowLoading()
  void loadPosts() => _$loadPosts();
}

mixin _$GetPostsCubitMixin implements Cubit<PostsState> {
    void _$loadPosts() async {
      _$showLoadingForLoadPosts();
    }
    
    void _$showLoadingForLoadPosts() {
      emit(PostsState.loading());
    }
}
```

### ```callbackName```
###### is the name of the callback method that will be called when the command is executed.
###### if you don't specify it, the callback name will be the default value passed in the annotation constructor.