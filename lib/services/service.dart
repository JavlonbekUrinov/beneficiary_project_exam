import 'dart:convert';
import 'package:beneficiary_project_exam/models/model.dart';
import 'package:http/http.dart';

class Network{

  static String baseApi = "62345894c47cffbb870c6bde.mockapi.io";






  static Future<String?> GET(String api, Map<String, dynamic> params) async {
    var uri = Uri.https(baseApi, api, params); // http or https
    var response = await get(uri, );
    if (response.statusCode == 200) return response.body;
    return null;
  }

  static Future<String?> POST(String api, Map<String, dynamic> params) async{
    var uri = Uri.https(baseApi, api);
    var response = await post(uri, body: params);
    if(response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> DELETE(String api, Map<String, dynamic> params) async{
    var uri = Uri.https(baseApi, api, params);
    var response = await delete(uri);
    if(response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  /* Http Apis */
  static String API_GET = "/api/contact";
  static String API_POST = "/api/contact";
  static String API_DELETE = "/api/contact/"; //{id}

  /* Http Params */
  static Map<String, String> paramsEmpty() {
    Map<String, String> params = {};
    return params;
  }

  static Map<String, dynamic> paramsPost(ModelCard contact) {
    Map<String, dynamic> params = {};
    params.addAll({
      'name': contact.name,
      'phoneNumber': contact.phoneNumber,
      'relationShip': contact.relationShip,
    });
    return params;
  }

  /* Http parsing */
  static List<ModelCard> parseResponse(String response) {
    List json = jsonDecode(response);
    List<ModelCard> cards = List<ModelCard>.from(json.map((x) => ModelCard.fromJson(x)));
    return cards;
  }
}