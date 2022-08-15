import 'package:get/get.dart';

class Manager {
  late String _email;
  late Profile _profile;
  late String _role;
  late String _userUID;
  late List<String> _wishList;
  var _userName = ''.obs;
  var _heart = 0.obs;
  var _isPressedList = <String>[].obs;

  Manager(
      {required String email,
      required Profile profile,
      required String role,
      required String userName,
      required String userUID,
      required List<String> wishList,
      required int heart,
      required List<String> isPressedList}) {
    _email = email;
    _profile = profile;
    _role = role;
    _userName.value = userName;
    _userUID = userUID;
    _wishList = wishList;
    _heart.value = heart;
    _isPressedList.value = isPressedList;
  }

  Manager.fromJson(dynamic json) {
    _email = json['email'];
    _profile = (json['profile'] != null ? Profile.fromJson(json['profile']) : null)!;
    _role = json['role'];
    _userName.value = json['userName'];
    _heart.value = json['heart'];
    _userUID = json['userUID'];
    _wishList = json['wishList'] != null ? json['wishList'].cast<String>() : [];
    _isPressedList.value = json['isPressedList'] != null ? json['isPressedList'].cast<String>() : [];
  }

  String? get email => _email;

  Profile? get profile => _profile;

  String? get role => _role;

  get userName => _userName;

  get heart => _heart;

  set userName(value) {
    _userName = value;
  }

  String get userUID => _userUID;

  List<String>? get wishList => _wishList;

  List<String>? get isPressedList => _isPressedList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    if (_profile != null) {
      map['profile'] = _profile.toJson();
    }
    map['role'] = _role;
    map['userName'] = _userName;
    map['heart'] = _heart;
    map['userUID'] = _userUID;
    map['wishList'] = _wishList;
    map['isPressedList'] = _isPressedList;
    return map;
  }

  void addLike(String uid) {
    _isPressedList.add(uid);
  }

  void removeLike(String uid) {
    _isPressedList.remove(uid);
  }
}

class Profile {
  late String _mbti;
  late String _area;
  late String _course;
  late String _description;
  late int _distance1;
  late int _distance2;
  late String _imageUrl;
  late String _like;
  late String _name;
  late int _price1;
  late int _price2;
  late int _price3;
  late int _reviewCount;
  late int _star;
  late int _year;

  Profile({
    required String mbti,
    required String area,
    required String course,
    required String description,
    required int distance1,
    required int distance2,
    required int heart,
    required String imageUrl,
    required List<String> isPressedList,
    required String like,
    required String name,
    required int price1,
    required int price2,
    required int price3,
    required int reviewCount,
    required int star,
    required int year,
  }) {
    _mbti = mbti;
    _area = area;
    _course = course;
    _description = description;
    _distance1 = distance1;
    _distance2 = distance2;
    _imageUrl = imageUrl;
    _like = like;
    _name = name;
    _price1 = price1;
    _price2 = price2;
    _price3 = price3;
    _reviewCount = reviewCount;
    _star = star;
    _year = year;
  }

  Profile.fromJson(dynamic json) {
    _mbti = json['MBTI'];
    _area = json['area'];
    _course = json['course'];
    _description = json['description'];
    _distance1 = json['distance1'];
    _distance2 = json['distance2'];
    _imageUrl = json['imageUrl'];
    _like = json['like'];
    _name = json['name'];
    _price1 = json['price1'];
    _price2 = json['price2'];
    _price3 = json['price3'];
    _reviewCount = json['reviewCount'];
    _star = json['star'];
    _year = json['year'];
  }

  String get mbti => _mbti;

  String get area => _area;

  String get course => _course;

  String get description => _description;

  int get distance1 => _distance1;

  int get distance2 => _distance2;

  // int get heart => _heart;

  String get imageUrl => _imageUrl;

  // List<String> get isPressedList => _isPressedList;

  String get like => _like;

  String get name => _name;

  int get price1 => _price1;

  int get price2 => _price2;

  int get price3 => _price3;

  int get reviewCount => _reviewCount;

  int get star => _star;

  int get year => _year;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['MBTI'] = _mbti;
    map['area'] = _area;
    map['course'] = _course;
    map['description'] = _description;
    map['distance1'] = _distance1;
    map['distance2'] = _distance2;
    map['imageUrl'] = _imageUrl;
    map['like'] = _like;
    map['name'] = _name;
    map['price1'] = _price1;
    map['price2'] = _price2;
    map['price3'] = _price3;
    map['reviewCount'] = _reviewCount;
    map['star'] = _star;
    map['year'] = _year;
    return map;
  }
}
