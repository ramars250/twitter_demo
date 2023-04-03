class AppwriteConstants {
  static const String databaseId = "appwrite建立後輸入";
  static const String projectId = "appwrite建立後輸入";

  //endPoint用來協助flutter跟appwrite進行通訊
  static const String endPoint = "https://localhost:(畚箕後方的連接阜號)/v1";

  //新增userCollection
  static const String userCollection = '需要先到appwrite那邊建立然後複製過來';
  static const String tweetCollection = '需要先到appwrite那邊建立然後複製過來';
  static const String imagesBucket = '需要先到appwrite那邊建立然後複製過來';

  static String imageUrl(String imageId) =>
      '$endPoint/storage/backets/$imagesBucket/file/$imageId/view?project=$projectId&mode=admin';
}