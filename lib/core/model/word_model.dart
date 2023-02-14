class WordModel {
  final String uz;
  final String en;

  WordModel._(this.uz, this.en);

  factory WordModel.fromJson(Map<String, dynamic> json) {
    return WordModel._(json["uz"] ?? "", json["en"] ?? "");
  }
}
