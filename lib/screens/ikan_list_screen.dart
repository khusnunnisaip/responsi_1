import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsi_1/blocs/ikan/ikan_bloc.dart';

class _IkanListPageState extends State<IkanListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Ikan'),
      ),
      body: BlocBuilder<IkanBloc, IkanState>(
        builder: (context, state) {
          if (state is IkanInitial) {
          
            BlocProvider.of<IkanBloc>(context).add(LoadIkanEvent());
            return Center(child: CircularProgressIndicator());
          } else if (state is IkanLoaded) {
          
            List<Ikan> ikanList = state.ikanList;
            return ListView.builder(
              itemCount: ikanList.length,
              itemBuilder: (context, index) {
                Ikan ikan = ikanList[index];
                return ListTile(
                  title: Text(ikan.name),
                  subtitle: Text(ikan.species),
                  onTap: () {
          
                  },
                );
              },
            );
          } else if (state is IkanError) {
          
            return Center(child: Text('Error: ${state.message}'));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
