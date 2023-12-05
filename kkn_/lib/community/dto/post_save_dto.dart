// post form
class PostSaveDto {
  String userid;

  String title;
  String content;
  String likes;
  String imageurl;
  PostSaveDto(this.userid, this.title, this.content, this.likes, this.imageurl);

  PostSaveDto.fromJson(Map<String, dynamic> json)
      : userid = json['userid'],
        title = json['title'],
        content = json['content'],
        likes = json['likes'].toString(),
        imageurl = json['imageurl'].toString();

  Map<String, dynamic> toJson() => {
        'userid': userid,
        'title': title,
        'content': content,
        'likes': int.parse(likes),
        'imageurl': imageurl,
      };
}
