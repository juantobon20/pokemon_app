class FilterData {

  final String name;
  final FilterType filterType;
  final bool isChecked;


  FilterData({
    required this.name, 
    required this.filterType,
    this.isChecked = false
  });

  FilterData copyWith({
    required bool isChecked
  }) => FilterData(
    name: name,
    filterType: filterType,
    isChecked: isChecked 
  );
}

enum FilterType {
  type,
  ability
}

extension StringToFilterType on String {

  FilterType getFilterType() {
    switch (this){
      case "type":
        return FilterType.type;
      case "ability":
        return FilterType.ability;
      default:
        throw UnimplementedError();
    }
  }
}