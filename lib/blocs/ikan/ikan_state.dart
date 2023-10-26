abstract class IkanState {}

class IkanInitial extends IkanState {}

class IkanLoading extends IkanState {}

class IkanLoaded extends IkanState {
  final List<Ikan> ikanList;

  IkanLoaded(this.ikanList);
}

class IkanError extends IkanState {
  final String error;

  IkanError(this.error);
}
