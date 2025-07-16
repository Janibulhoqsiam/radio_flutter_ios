import 'dashboard_model.dart';

class LiveShowModel {
  final Data data;

  LiveShowModel({
    required this.data,
  });
  //
  // factory LiveShowModel.fromJson(Map<String, dynamic> json) => LiveShowModel(
  //   // Debug print only for imagePath
  //   data: Data.fromJson(json["data"]),
  // );


  factory LiveShowModel.fromJson(Map<String, dynamic> json) {
    print("LiveShowModel.fromJson received: $json");

    final dataJson = json['data'];
    if (dataJson == null) {
      throw Exception("Missing 'data' in LiveShowModel JSON");
    }

    return LiveShowModel(
      data: Data.fromJson(dataJson),
    );
  }





}

class Data {
  final List<NextShowClass> schedule;
  final String baseUrl;
  final String imagePath;

  Data({
    required this.schedule,
    required this.baseUrl,
    required this.imagePath,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    schedule: List<NextShowClass>.from(json["schedule"].map((x) => NextShowClass.fromJson(x))),
    baseUrl: json["base_url"],
    imagePath: json["image-path"],
  );
}
