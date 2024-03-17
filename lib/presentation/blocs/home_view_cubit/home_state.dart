part of 'home_cubit.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final bool isFinishList;
  final int limit;
  final int offset;
  final List pokemons;
  final ErrorData? errorData;
  final FilterData? filterData;
  final bool isFilter;

  const HomeState({
    this.isLoading = false,
    this.isFinishList = false,
    this.limit = 10,
    this.offset = 0,
    this.pokemons = const [],
    this.errorData,
    this.filterData,
    this.isFilter = false
  });

  HomeState copyWith({
    bool? isLoading,
    bool? isFinishList,
    int? limit,
    int? offset,
    List? pokemons,
    ErrorData? errorData,
    FilterData? filterData,
    bool? isFilter
  }) => HomeState(
    isLoading: isLoading ?? this.isLoading,
    isFinishList: isFinishList ?? this.isFinishList,
    limit: limit ?? this.limit,
    offset: offset ?? this.offset,
    pokemons: pokemons ?? this.pokemons,
    errorData: errorData,
    filterData: filterData,
    isFilter: isFilter ?? this.isFilter
  );

  @override
  List<Object?> get props => [isLoading, pokemons, errorData];
}
