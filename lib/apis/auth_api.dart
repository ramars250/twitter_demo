import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_demo/core/core.dart';
import 'package:twitter_demo/core/providers.dart';

//設置Provider，Provider只能讀值，無法改變返回的值
final authAPIProvider = Provider((ref) {
  final account = ref.watch(appwriteAccountProvider);
  return AuthAPI(account: account);
});

//抽象類的Api
abstract class IAuthAPI {
  //Account是appwrite裡面的東西
  //想要利用用戶服務時，使用services類型=>Account
  //想訪問用戶數據時，使用帳戶模型=>model.Account
  FutureEither<model.Account> signUp({
    required String email,
    required String password,
  });

  FutureEither<model.Session> login({
    required String email,
    required String password,
  });
}

class AuthAPI implements IAuthAPI {
  //建立私有變量
  final Account _account;

  AuthAPI({required Account account}) : _account = account;

  @override
  Future<model.Account?> currentUserAccount() async {
    try {
      return await _account.get();
    } on AppwriteException {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  //FutureEither一個自定義的泛型類，可以在一個異步函數中返回一個成功或一個失敗的訊息
  //可以通過left及right分別返回失敗和成功的結果
  FutureEither<model.Account> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final account = await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
      );
      return right(account);
      //獲取額外的異常報告
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failuer(e.message ?? 'Some unexpected error occurred', stackTrace),
      );
    } catch (e, stackTrace) {
      return left(
        Failuer(e.toString(), stackTrace),
      );
    }
  }

  @override
  FutureEither<model.Session> login({
    required String email,
    required String password,
  }) async {
    try {
      //利用appwrite的createEmailSession對email及password進行驗證
      final session = await _account.createEmailSession(
        email: email,
        password: password,
      );
      return right(session);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failuer(e.message ?? 'Some unexpected error occurred', stackTrace),
      );
    } catch (e, stackTrace) {
      return left(
        Failuer(e.toString(), stackTrace),
      );
    }
  }
}
