class PostListLoadDto {
  String loadTimestamp;
  int lastPage;

  PostListLoadDto(this.loadTimestamp, this.lastPage);

  Map<String, dynamic> toJson() =>
      {'loadTimestamp': loadTimestamp, 'lastPage': lastPage};
}
