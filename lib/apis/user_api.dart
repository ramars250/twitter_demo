import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_demo/constants/constants.dart';
import 'package:twitter_demo/core/core.dart';
import 'package:twitter_demo/core/providers.dart';
import 'package:twitter_demo/models/user_model.dart';

//先在provider.dart中建立好後才可以在此處進行設置userAPIProvider
final userAPIProvider = Provider((ref) {
  return UserAPI(
    db: ref.watch(appwriteDatabaseProvider),
  );
});

//建立一個抽象IUserAPI類，該類中有一個saveUserData方法接收一個UserModel參數並回傳FutureEitherVoid
//該方法為異步操作，會回傳一個錯誤訊息(Failuer)或一個泛型類(<T>)
abstract class IUserAPI {
  FutureEitherVoid saveUserData(UserModel userModel);

  Future<model.Document> getUserData(String uid);
}

//UserAPI實作了IUserAPI，並傳入一個Database物件(Database為appwrite的類別)
class UserAPI implements IUserAPI {
  final Databases _db;

  UserAPI({required Databases db}) : _db = db;

  @override
  //FutureEitherVoid自定義的泛型類，可以返回一個成功或一個失敗的結果，但是不包含任何值
  FutureEitherVoid saveUserData(UserModel userModel) async {
    try {
      await _db.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.userCollection,
        documentId: userModel.uid,
        data: userModel.toMap(),
      );
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(
        Failuer(e.message ?? '發生一些錯誤', st),
      );
    } catch (e, st) {
      return left(
        Failuer(e.toString(), st),
      );
    }
  }

  @override
  Future<model.Document> getUserData(String uid) {
    return _db.getDocument(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.userCollection,
      documentId: uid,
    );
  }
}
