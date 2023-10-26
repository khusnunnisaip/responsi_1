import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;

// Event
abstract class IkanEvent {}

class LoadIkanEvent extends IkanEvent {}

// State
abstract class IkanState {}

class IkanInitial extends IkanState {}

class IkanLoaded extends IkanState {
  final List<Ikan> ikan;

  IkanLoaded({required this.ikan});
}

class IkanError extends IkanState {
  final String message;

  IkanError({required this.message});
}

class Ikan {
  final String name;
  final String species;

  Ikan({required this.name, required this.species});
}

class IkanBloc extends Bloc<IkanEvent, IkanState> {
  IkanBloc() : super(IkanInitial());

  @override
  Stream<IkanState> mapEventToState(IkanEvent event) async* {
    if (event is LoadIkanEvent) {
      try {
        final response = await http.get('https://responsi1a.dalhaqq.xyz/ikan');
        
        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          List<Ikan> ikanList = data.map((json) {
            return Ikan(
              name: json['name'],
              species: json['species'],
            );
          }).toList();

          yield IkanLoaded(ikan: ikanList);
        } else {
          yield IkanError(message: 'Gagal mengambil data ikan');
        }
      } catch (e) {
        yield IkanError(message: 'Terjadi kesalahan: $e');
      }
    }
  }
}
