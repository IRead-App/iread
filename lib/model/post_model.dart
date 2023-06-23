class PostModel {
  String? owner;
  String? ownerImage;
  String? text;
  String? date;
  String? time;
  String? image;
  int? reacts;
  List<Map<String, String>>? comments;

  PostModel({
    this.owner,
    this.ownerImage,
    this.text,
    this.date,
    this.time,
    this.image,
    this.reacts,
    this.comments,
  });

  factory PostModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return PostModel();
    return PostModel(
      owner: json['owner'],
      ownerImage: json['ownerImage'],
      text: json['text'],
      date: json['date'],
      time: json['time'],
      image: json['image'],
      reacts: json['reacts'],
      comments: (json['comments'] as List<dynamic>?)
          ?.map<Map<String, String>>((item) => Map<String, String>.from(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'owner': owner,
      'ownerImage': ownerImage,
      'text': text,
      'date': date,
      'time': time,
      'image': image,
      'reacts': reacts,
      'comments': comments?.map((item) => Map<String, String>.from(item)).toList(),
    };
  }
}
