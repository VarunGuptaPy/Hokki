class Posts {
  String city;
  String description;
  String downloadUrl;
  String name;
  String role;
  String title;
  String uid;
  String profilePic;
  Posts({required this.profilePic,required this.city,required this.description,required this.downloadUrl,required this.name,required this.role,required this.title,required this.uid,});
  Map<String,dynamic> toMap() => {
    'city': city,
    'desciption': description,
    'downloadUrl': downloadUrl,
    'name': name,
    'role': role,
    'title': title,
    'uid':uid,
    'profileScreen': profilePic,
  };
  static Posts fromMap(Map<String,dynamic> data){
    return Posts(profilePic: data['profileScreen'], city:data['city'], description: data['description'], downloadUrl: data['downloadUrl'], name: data['name'], role: data['role'], title: data['title'], uid: data['uid']);
  }
}