class AuthorsList {
  List<AuthorData>? authorData;

  AuthorsList({this.authorData});

  AuthorsList.fromJson(Map<String, dynamic> json) {
    if (json['authorData'] != null) {
      authorData = <AuthorData>[];
      json['authorData'].forEach((v) {
        authorData!.add(new AuthorData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.authorData != null) {
      data['authorData'] = this.authorData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AuthorData {
  String? id;
  String? author;
  int? width;
  int? height;
  String? url;
  String? downloadUrl;

  AuthorData(
      {this.id,
      this.author,
      this.width,
      this.height,
      this.url,
      this.downloadUrl});

  AuthorData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    author = json['author'];
    width = json['width'];
    height = json['height'];
    url = json['url'];
    downloadUrl = json['download_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['author'] = this.author;
    data['width'] = this.width;
    data['height'] = this.height;
    data['url'] = this.url;
    data['download_url'] = this.downloadUrl;
    return data;
  }
}
