part of 'root_bloc.dart';

class RootState extends Equatable {
  final RootTabs selectedTab;


  int get currentIndex =>  selectedTab.index;

  const RootState({this.selectedTab = RootTabs.myLocation});

  RootState copyWith({RootTabs selectedTab}) {
    return RootState(selectedTab: selectedTab?? this.selectedTab);
  }

  @override
  List<Object> get props => [selectedTab];
}

