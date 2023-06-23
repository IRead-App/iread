class RoadmapModel {
  final String name;
  final String poster;
  final Map<String, Map<String, dynamic>> details;

  RoadmapModel({
    required this.name,
    required this.poster,
    required this.details,
  });

  factory RoadmapModel.fromJson(Map<String, dynamic> json) {
    return RoadmapModel(
      name: json['name'],
      poster: json['poster'],
      details: Map<String, Map<String, dynamic>>.from(json['details']),
    );
  }
}
