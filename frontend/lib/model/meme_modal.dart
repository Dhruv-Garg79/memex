import 'dart:convert';

class MemeModal {
  final int id;
  final String name;
  final String caption;
  final String url;
  
  MemeModal({
    this.id,
    this.name,
    this.caption,
    this.url,
  });

  MemeModal copyWith({
    int id,
    String name,
    String caption,
    String url,
  }) {
    return MemeModal(
      id: id ?? this.id,
      name: name ?? this.name,
      caption: caption ?? this.caption,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'caption': caption,
      'url': url,
    };
  }

  factory MemeModal.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return MemeModal(
      id: map['id'],
      name: map['name'],
      caption: map['caption'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MemeModal.fromJson(String source) => MemeModal.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MemeModal(id: $id, name: $name, caption: $caption, url: $url)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is MemeModal &&
      o.id == id &&
      o.name == name &&
      o.caption == caption &&
      o.url == url;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      caption.hashCode ^
      url.hashCode;
  }
}
