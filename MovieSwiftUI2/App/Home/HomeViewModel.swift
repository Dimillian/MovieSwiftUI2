
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
  @Published var searchResults: [Movie] = []
  @Published var error: Error?
  @Published var searchText = ""
    
  init() {
    async {
      await fetchData()
    }
  }
  
  func fetchData() async {
    do {
      async let popularMovies: PaginatedResponse<Movie> = Network.shared.GET(endpoint: .moviePopular)
      async let trendingMovies: PaginatedResponse<Movie> = Network.shared.GET(endpoint: .trending(mediaType: .movie,
                                                                                                  timeWindow: .week))
      async let topRatedMovies: PaginatedResponse<Movie> = Network.shared.GET(endpoint: .topRated)
      async let nowPlayingMovies: PaginatedResponse<Movie> = Network.shared.GET(endpoint: .nowPlaying)
      async let upcomingMovies: PaginatedResponse<Movie> = Network.shared.GET(endpoint: .upcoming)
      self.sections = try await [.init(title: "Popular", movies: popularMovies.results),
                                  .init(title: "Trending", movies: trendingMovies.results),
                                  .init(title: "Top Rated", movies: topRatedMovies.results),
                                  .init(title: "Now Playing", movies: nowPlayingMovies.results),
                                  .init(title: "Upcoming", movies: upcomingMovies.results)]
    } catch let error {
      self.error = error
    }
  }
  
  func fetchSearch(query: String) async {
    do {
      let results: PaginatedResponse<Movie> = try await Network.shared.GET(endpoint: .searchMovie, params: [.query(query: query)])
      searchResults = results.results
    } catch {}
  }
}
