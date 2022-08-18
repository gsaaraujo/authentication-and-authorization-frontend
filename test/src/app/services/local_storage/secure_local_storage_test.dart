import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:authentication_and_authorization_frontend/src/app/services/local_storage/models/user_tokens.dart';
import 'package:authentication_and_authorization_frontend/src/app/services/local_storage/secure_local_storage.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late SecureLocalStorage secureLocalStorage;
  late FlutterSecureStorage mockSecureLocalStorage;

  const String fakeKey = 'any_key';
  const fakeUserTokens = UserTokens(
    accessToken: 'any_access_token',
    refreshToken: 'any_refresh_token',
  );

  setUp(() {
    mockSecureLocalStorage = MockFlutterSecureStorage();
    secureLocalStorage = SecureLocalStorage(mockSecureLocalStorage);
  });

  test('should call secureLocalStorage.add once if successful', () async {
    when(() => mockSecureLocalStorage.write(
          key: fakeKey,
          value: fakeUserTokens.toJson(),
        )).thenAnswer((_) async => {});

    await secureLocalStorage.add(fakeKey, fakeUserTokens);

    verify(() => mockSecureLocalStorage.write(
          key: fakeKey,
          value: fakeUserTokens.toJson(),
        )).called(1);
  });

  test('should call secureLocalStorage.delete once if successful', () async {
    when(() => mockSecureLocalStorage.delete(key: fakeKey))
        .thenAnswer((_) async => {});

    await secureLocalStorage.delete(fakeKey);
    verify(() => mockSecureLocalStorage.delete(key: fakeKey)).called(1);
  });

  test('should return userTokens if successfully read', () async {
    when(() => mockSecureLocalStorage.read(key: fakeKey))
        .thenAnswer((_) async => fakeUserTokens.toJson());

    final userTokens = await secureLocalStorage.read(fakeKey);
    expect(userTokens, fakeUserTokens);
    verify(() => mockSecureLocalStorage.read(key: fakeKey)).called(1);
  });

  test('should return null if data is not found', () async {
    when(() => mockSecureLocalStorage.read(key: fakeKey))
        .thenAnswer((_) async => null);

    final userTokens = await secureLocalStorage.read(fakeKey);
    expect(userTokens, isNull);
    verify(() => mockSecureLocalStorage.read(key: fakeKey)).called(1);
  });

  test('should call secureLocalStorage.delete once if successful', () async {
    when(() => mockSecureLocalStorage.write(
          key: fakeKey,
          value: fakeUserTokens.toJson(),
        )).thenAnswer((_) async => {});

    await secureLocalStorage.update(fakeKey, fakeUserTokens);
    verify(() => mockSecureLocalStorage.write(
          key: fakeKey,
          value: fakeUserTokens.toJson(),
        )).called(1);
  });
}
