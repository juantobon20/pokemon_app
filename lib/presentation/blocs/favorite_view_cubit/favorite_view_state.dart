part of 'favorite_view_cubit.dart';

class FavoriteViewState extends Equatable {

  final bool isLoading;
  final bool isFinishList;
  final int limit;
  final int offset;
  final List<PokemonView> pokemonsView;
  final ErrorData? errorData;

  const FavoriteViewState({
    this.isLoading = false,
    this.isFinishList = false,
    this.limit = 10,
    this.offset = 0,
    this.pokemonsView = const [],
    this.errorData
  });

  FavoriteViewState copyWith({
    bool? isLoading,
    bool? isFinishList,
    int? limit,
    int? offset,
    List<PokemonView>? pokemonsView,
    ErrorData? errorData
  }) => FavoriteViewState(
    isLoading: isLoading ?? this.isLoading,
    isFinishList: isFinishList ?? this.isFinishList,
    limit: limit ?? this.limit,
    offset: offset ?? this.offset,
    pokemonsView: pokemonsView ?? this.pokemonsView,
    errorData: errorData
  );

  @override
  List<Object> get props => [isLoading, pokemonsView];
}

final class FavoriteViewInitial extends FavoriteViewState {}
