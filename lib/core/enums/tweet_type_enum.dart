//定義一個列舉類，利用定義一個變數type來包含2個不同的type，分別為text及image
enum TweetType {
  text('text'),
  image('image');

  final String type;

  const TweetType(this.type);
}

//擴充字串的方法，讓字串調用toEnum()並回傳一個TweetType的列舉物件
//在toEnum中如果字串不是text或image就傳回預設值TweetType.text
extension ConvertTweet on String {
  TweetType toTweetTypeEnum() {
    switch (this) {
      case 'text':
        return TweetType.text;
      case 'image':
        return TweetType.image;
      default:
        return TweetType.text;
    }
  }
}
