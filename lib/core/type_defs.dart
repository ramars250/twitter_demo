import 'package:fpdart/fpdart.dart';
import 'package:twitter_demo/core/core.dart';
//定義函數別名，定義一個名稱供函數回傳以及宣告使用
//定義FutureEither<T>，失敗返回Failuer(),成功返回一個T
typedef FutureEither<T> = Future<Either<Failuer, T>>;
//定義FutureEitherVoid，返回FutureEither<void>
typedef FutureEitherVoid = FutureEither<void>;
