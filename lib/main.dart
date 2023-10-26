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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailIkanPage(ikan),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TambahIkanForm(),
            ),
          );
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: namaController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            TextFormField(
              controller: jenisController,
              decoration: InputDecoration(labelText: 'Jenis'),
            ),
            TextFormField(
              controller: warnaController,
              decoration: InputDecoration(labelText: 'Warna'),
            ),
            TextFormField(
              controller: habitatController,
              decoration: InputDecoration(labelText: 'Habitat'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                apiService.addIkan(
                  Ikan(
                    nama: namaController.text,
                    jenis: jenisController.text,
                    warna: warnaController.text,
                    habitat: habitatController.text,
                  ),
                );
                Navigator.pop(context); 
              },
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailIkanPage extends StatelessWidget {
  final Ikan ikan;

  DetailIkanPage(this.ikan);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Ikan'),
      ),
      body: Column(
        children: [
          Text('Nama: ${ikan.nama}'),
          Text('Jenis: ${ikan.jenis}'),
          Text('Warna: ${ikan.warna}'),
          Text('Habitat: ${ikan.habitat}'),
        ],
      ),
    );
  }
}
