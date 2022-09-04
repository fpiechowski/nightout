import 'package:nightout/party/data.dart';

class NearByPartiesState {
  final Party? selectedParty;
  final NearByViewType viewType;

  NearByPartiesState({
    this.selectedParty,
    this.viewType = NearByViewType.map,
  });
}

enum NearByViewType {
  map,
}
