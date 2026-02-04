import '../models/portfolio_models.dart';

abstract class PortfolioRepository {
  Future<PortfolioData> getPortfolio();

  Future<CaseStudy?> getCaseStudyById(String id);
  Future<RecentWork?> getRecentWorkById(String id);
}
