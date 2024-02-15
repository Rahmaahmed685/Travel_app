import 'package:firebase_auth/firebase_auth.dart';

class Place {
  String _id = '';
  String _userId = '';
  String _title = '';
  String _content = '';
  String _image = '';
  bool _isFavorite = false;

  Place(this._id, this._title, this._content,this._isFavorite,this._image) {
    userId = FirebaseAuth.instance.currentUser?.uid ?? '';
  }

  Place.fromMap(Map<dynamic, dynamic> data) {
    _id = data['id'];
    _userId = data['userId'];
    _title = data['title'];
    _content = data['content'];
    _image = data['image'];
    _isFavorite = data['isFavorite'];
  }

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  String get userId => _userId;

  set userId(String value) {
    _userId = value;
  }

  String get content => _content;

  set content(String value) {
    _content = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  bool get isFavorite => _isFavorite;

  set isFavorite(bool value) {
    _isFavorite = value;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'content': content,
      'image': image,
      'isFavorite': isFavorite
    };
  }
}