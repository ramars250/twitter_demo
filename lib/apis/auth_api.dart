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
}

class AuthAPI implements IAuthAPI {
  //建立私有變量
  final Account _account;

  AuthAPI({required Account account}) : _account = account;

  @override
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
}
