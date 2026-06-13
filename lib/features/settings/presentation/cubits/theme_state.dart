import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum ThemeStatus { initial, loading, ready, failure }

class ThemeState extends Equatable {
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
    String? errorMessage,
  }) {
    return ThemeState(
      status: status ?? this.status,
      themeMode: themeMode ?? this.themeMode,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, themeMode, errorMessage];
}
