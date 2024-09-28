## Cubit Impl Annotation
#### A package that helps you generate cubit implementations with annotations.
#### Use it along with cubit_impl_generator package.

## Usage
```dart

abstract interface class PostRepository {
    Future<Either<Failure, List<Post>>> getPosts();
}

final class GetPostsCubit extends Cubit<PostsState> {
    GetPostsCubit({
      required PostRepository postRepository,
    }) : super(PostsState.initial()) {
      _postRepository = postRepository;
    }
    
    late final PostRepository _postRepository;
    
    @ShowLoading(commandName: 'showLoadingLoadPosts')
    @OnEither<Failure, List<Post>>(
      commandName: 'loadPosts',
      callbackName: 'gettingPostsCallback',
      onSuccess: [ShowSuccess()],
      onFailure: [
        ReportServerFailure(),
        ReportNetworkFailure(),
      ],
    )
    void loadPosts() => _$executeAllCommands([
      _$showLoadingLoadPosts(),
      _$loadPosts(
        gettingPostsCallback: _postRepository.getPosts,
      ),
    ]);
}
```

###### as you can see, our package CubitImplGenerator will generate commands based on annotations
```dart
ShowLoading()
```
```dart
ShowLoadingByCalling()
```
```dart
OnEither()
```

### commandName
###### is the name of the generate command method prefixed with ```_$``` to note that it is a generated command

### callbackName
###### is the name of the callback method that will be called when the command is executed.
###### if you don't specify it, the callback name will be the default value passed in the constructor.