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
    
    @ShowLoading(commandName: 'showLoadingForLoadPosts')
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
      _$showLoadingForLoadPosts(),
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
#### The commandName in the annotation defines the names of the generated method and the corresponding command class, with the addition of a ```Command``` suffix.
###### * The generated method will be named by taking the ```commandName```, prefixing it with ```_$```, and keeping the first letter uncapitalized.
###### * The method returns a command, whose class name follows this pattern:
######      * The commandName with the first letter capitalized.
######      * Prefixed by ```_$```.
######      * Followed by the suffix Command to clearly identify it as a command class.
###### * Note: Both the generated method and the command class are prefixed with ```_$``` to signify that they are generated code.
###### * The generated command class encapsulates the behavior defined by the annotation.

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

  @ShowLoading(commandName: 'showLoadingForLoadPosts')
  void loadPosts() => _$executeAllCommands([
    _$showLoadingForLoadPosts(),
  ]);
}

mixin _$GetPostsCubitMixin implements Cubit<PostsState> {
    void _$executeAllCommands(List<_$Command> commands) async {
      await _$CompoundCommand(commands: commands).execute();
    }
    
    _$Command _$showLoadingForLoadPosts() {
        return _$ShowLoadingForLoadPostsCommand(emit: emit);
    }
}

abstract interface class _$Command {
  FutureOr<void> execute();
}

final class _$CompoundCommand implements _$Command {
  _$CompoundCommand({
    required List<_$Command> commands,
  }) : _commands = commands;
  
  final List<_$Command> _commands;
  
  @override
  FutureOr<void> execute() async {
    for (final command in _commands) {
      await command.execute();
    }
  }
}

final class _$ShowLoadingForLoadPostsCommand implements _$Command {
  _$ShowLoadingForLoadPostsCommand({required this.emit});
  
  final void Function(PostsState) emit;

  @override
  FutureOr<void> execute() => emit(PostsState.loading());
}
```
#### Breakdown
###### * In this example, the ```commandName``` is ```'showLoadingForLoadPosts'```.
###### * The generated method is still named ```_$showLoadingForLoadPosts()``` (with no capitalization on the first character) and is prefixed with ```_$``` to indicate it's generated code.
###### * The generated command class now has the name ```_$ShowLoadingForLoadPostsCommand```, where:
######      * The commandName is capitalized.
######      * Prefixed with _$.
######      * Suffix Command is added to clearly identify it as a command class..
###### * The generated method returns this command class, which encapsulates the behavior required by the annotation—in this case, showing the loading state while posts are being loaded.


### callbackName
###### is the name of the callback method that will be called when the command is executed.
###### if you don't specify it, the callback name will be the default value passed in the annotation constructor.