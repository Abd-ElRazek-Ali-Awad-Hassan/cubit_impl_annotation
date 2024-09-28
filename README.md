## Cubit Impl Annotation
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
    
    @ShowLoading(commandName: 'ShowLoadingForLoadPosts')
    @OnEither<Failure, List<Post>>(
      commandName: 'LoadPosts',
      callbackName: 'gettingPostsCallback',
      onSuccess: [ShowSuccess()],
      onFailure: [
        ReportServerFailure(),
        ReportNetworkFailure(),
      ],
    )
    void loadPosts() => _$executeAllCommands([
      _$ShowLoadingForLoadPosts(),
      _$LoadPosts(
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
###### is the name of the generated command prefixed with ```_$``` to note that it is a generated command.

### callbackName
###### is the name of the callback method that will be called when the command is executed.
###### if you don't specify it, the callback name will be the default value passed in the annotation constructor.