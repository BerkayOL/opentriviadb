import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum ThemeStatus { initial, loading, ready, failure }

class ThemeState extends Equatable {
  static const Object _unset = Object();

  const ThemeState({
    this.status = ThemeStatus.initial,
    this.themeMode = ThemeMode.system,
    this.errorMessage,
  });

  final ThemeStatus status;
  final ThemeMode themeMode;
  final String? errorMessage;
  ThemeState copyWith({
    ThemeStatus? status,
    ThemeMode? themeMode,
    Object? errorMessage = _unset,
  }) {
    return ThemeState(
      status: status ?? this.status,
      themeMode: themeMode ?? this.themeMode,
      errorMessage: identical(errorMessage, _unset)
          ? this.errorMessage
          : errorMessage as String?,
    );
  }

  @override
  List<Object?> get props => [status, themeMode, errorMessage];
}
