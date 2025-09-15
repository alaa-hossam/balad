class News {
  late String title;
  late String summary;
  late String imageUrl;
  late String publishDate;
  late String author;


  News.fromJson(Map<String, dynamic> json) {
    title = json['title'] ;
    summary = json['summary'];
    imageUrl = json['image'];
    publishDate = json['publish_date'];
    author = json['author'] ;
  }

}
