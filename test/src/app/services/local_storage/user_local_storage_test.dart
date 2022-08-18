import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:authentication_and_authorization_frontend/src/app/services/local_storage/models/user_info.dart';
import 'package:authentication_and_authorization_frontend/src/app/services/local_storage/user_local_storage.dart';

class MockHiveInterface extends Mock implements HiveInterface {}

class MockBox extends Mock implements Box {}

void main() {
  late UserLocalStorage userLocalStorage;
  late MockHiveInterface mockHiveInterface;

  const fakeKey = 'any_key';
  const fakeValue = UserInfo(
    id: 'any_id',
    name: 'any_name',
    email: 'any_email',
  );

  final mockBox = MockBox();

  setUp(() {
    mockHiveInterface = MockHiveInterface();
    userLocalStorage = UserLocalStorage(mockHiveInterface);
  });

  test('should call hive.openBox and box.put once if successfully add',
      () async {
    when(() => mockHiveInterface.openBox('BOX'))
        .thenAnswer((_) async => mockBox);

    when(() => mockBox.put(fakeKey, fakeValue.toMap()))
        .thenAnswer((_) async => {});

    await userLocalStorage.add(fakeKey, fakeValue);

    verify(() => mockHiveInterface.openBox('BOX')).called(1);
    verify(() => mockBox.put(fakeKey, fakeValue.toMap())).called(1);
  });

  test('should call hive.openBox and box.delete once if successfully delete',
      () async {
    when(() => mockHiveInterface.openBox('BOX'))
        .thenAnswer((_) async => mockBox);

    when(() => mockBox.delete(fakeKey)).thenAnswer((_) async => {});

    await userLocalStorage.delete(fakeKey);

    verify(() => mockHiveInterface.openBox('BOX')).called(1);
    verify(() => mockBox.delete(fakeKey)).called(1);
  });

  test('should return UserInfo if successfully read', () async {
    when(() => mockHiveInterface.openBox('BOX'))
        .thenAnswer((_) async => mockBox);

    when(() => mockBox.containsKey(fakeKey)).thenReturn(true);
    when(() => mockBox.get(fakeKey)).thenAnswer((_) => fakeValue.toMap());

    final userInfo = await userLocalStorage.read(fakeKey);

    expect(userInfo, fakeValue);
    verify(() => mockHiveInterface.openBox('BOX')).called(1);
    verify(() => mockBox.containsKey(fakeKey)).called(1);
    verify(() => mockBox.get(fakeKey)).called(1);
  });

  test('should return null if no data was found', () async {
    when(() => mockHiveInterface.openBox('BOX'))
        .thenAnswer((_) async => mockBox);

    when(() => mockBox.containsKey(fakeKey)).thenReturn(false);
    when(() => mockBox.get(fakeKey)).thenAnswer((_) => fakeValue.toMap());

    final userInfo = await userLocalStorage.read(fakeKey);

    expect(userInfo, isNull);
    verify(() => mockHiveInterface.openBox('BOX')).called(1);
    verify(() => mockBox.containsKey(fakeKey)).called(1);
  });

  test('should call hive.openBox and box.put once if successfully update',
      () async {
    when(() => mockHiveInterface.openBox('BOX'))
        .thenAnswer((_) async => mockBox);

    when(() => mockBox.put(fakeKey, fakeValue.toMap()))
        .thenAnswer((_) async => {});

    await userLocalStorage.update(fakeKey, fakeValue);

    verify(() => mockHiveInterface.openBox('BOX')).called(1);
    verify(() => mockBox.put(fakeKey, fakeValue.toMap())).called(1);
  });
}
