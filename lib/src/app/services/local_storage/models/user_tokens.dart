import 'dart:convert';
import 'package:equatable/equatable.dart';

class UserTokens extends Equatable {
  final String accessToken;
  final String refreshToken;

  const UserTokens({
    required this.accessToken,
    required this.refreshToken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  factory UserTokens.fromMap(Map<String, dynamic> map) {
    return UserTokens(
      accessToken: map['accessToken'] as String,
      refreshToken: map['refreshToken'] as String,
    );
  }

  UserTokens copyWith({
    String? accessToken,
    String? refreshToken,
  }) {
    return UserTokens(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserTokens.fromJson(String source) =>
      UserTokens.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props => [accessToken, refreshToken];
}
