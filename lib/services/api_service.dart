import 'dart:convert';
import 'package:http/http.dart as http;
import '../models/ikan_model.dart';

class ApiService {
  final String baseUrl = "https://responsi1a.dalhaqq.xyz/ikan";

  Future<List<Ikan>> getIkanList() async {
    final response = await http.get(Uri.parse('$baseUrl/ikan'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)["data"];
      List<Ikan> ikanList = data.map((json) => Ikan.fromJson(json)).toList();
      return ikanList;
    } else {
      throw Exception('Failed to load ikan list');
    }
  }