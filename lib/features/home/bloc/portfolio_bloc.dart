import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/portfolio_models.dart';
import '../../../domain/repositories/portfolio_repository.dart';

part 'portfolio_event.dart';
part 'portfolio_state.dart';

class PortfolioBloc extends Bloc<PortfolioEvent, PortfolioState> {
  PortfolioBloc(this._repo) : super(const PortfolioState()) {
    on<PortfolioStarted>(_onStarted);
  }

  final PortfolioRepository _repo;

  Future<void> _onStarted(PortfolioStarted event, Emitter<PortfolioState> emit) async {
    emit(state.copyWith(status: PortfolioStatus.loading));
    try {
      final data = await _repo.getPortfolio();
      emit(state.copyWith(status: PortfolioStatus.ready, data: data));
    } catch (e) {
      emit(state.copyWith(status: PortfolioStatus.failure, error: e.toString()));
    }
  }
}
