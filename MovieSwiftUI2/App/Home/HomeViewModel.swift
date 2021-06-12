
import Foundation
import SwiftUI
import Backend

@MainActor
class HomeViewModel: ObservableObject {
  struct Section: Identifiable {
    let id = UUID()
    let title: String
    let movies: [Movie]
  }
  
  @Published var sections: [Section] = []
  @Published var error: Error?
  @Published var searchText = ""
    
  func fetchData() async {
    do {
      async let popularMovies: PaginatedResponse<Movie> = Network.shared.GET(endpoint: .moviePopular)
      async let trendingMovies: PaginatedResponse<Movie> = Network.shared.GET(endpoint: .trending(mediaType: .movie,
                                                                                                      timeWindow: .week))
      async let topRatedMovies: PaginatedResponse<Movie> = Network.shared.GET(endpoint: .topRated)
      async let upcomingMovies: PaginatedResponse<Movie> = Network.shared.GET(endpoint: .upcoming)
      self.sections = try await [.init(title: "Popular", movies: popularMovies.results),
                                  .init(title: "Trending", movies: trendingMovies.results),
                                  .init(title: "Top Rated", movies: topRatedMovies.results),
                                  .init(title: "Upcoming", movies: upcomingMovies.results)]
    } catch let error {
      self.error = error
    }
  }
}
