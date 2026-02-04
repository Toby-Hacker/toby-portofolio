part of 'portfolio_bloc.dart';

enum PortfolioStatus { initial, loading, ready, failure }

class PortfolioState extends Equatable {
  final PortfolioStatus status;
  final PortfolioData? data;
  final String? error;

  const PortfolioState({
    this.status = PortfolioStatus.initial,
    this.data,
    this.error,
  });

  PortfolioState copyWith({
    PortfolioStatus? status,
    PortfolioData? data,
    String? error,
  }) {
    return PortfolioState(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, data, error];
}
