import 'package:flutter/material.dart';
import 'package:responsi_1/services/api_service.dart';
import 'package:responsi_1/models/ikan_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: IkanListPage(),
    );
  }
}

class IkanListPage extends StatefulWidget {
  @override
  _IkanListPageState createState() => _IkanListPageState();
}

class _IkanListPageState extends State<IkanListPage> {
  ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Ikan'),
      ),
      body: FutureBuilder<List<Ikan>>(
        future: apiService.getIkanList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tidak ada data.'));
          } else {
            List<Ikan> ikanList = snapshot.data!;
            return ListView.builder(
              itemCount: ikanList.length,
              itemBuilder: (context, index) {
                Ikan ikan = ikanList[index];
                return ListTile(
                  title: Text(ikan.nama),
                  subtitle: Text(ikan.jenis),
                  onTap: () {

                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Tampilkan formulir tambah ikan
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class TambahIkanForm extends StatefulWidget {
  @override
  _TambahIkanFormState createState() => _TambahIkanFormState();
}

class _TambahIkanFormState extends State<TambahIkanForm> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController jenisController = TextEditingController();
  final TextEditingController warnaController = TextEditingController();
  final TextEditingController habitatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Ikan'),
      ),
      body: Padding(
        padding: EdgeInsets.all
