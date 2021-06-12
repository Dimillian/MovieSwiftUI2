
import Foundation
import SwiftUI
import Backend

class HomeViewModel: ObservableObject {
  @Published var movies: [Movie] = []
  @Published var error: Error?
  @Published var searchText = ""
  
  func fetchPopularMoview() async {
    do {
      let paginatedMovies: PaginatedResponse<Movie> = try await Network.shared.GET(endpoint: .moviePopular, params: [.page(page: 1)])
      self.movies = paginatedMovies.results
    } catch let error {
      self.error = error
    }
  }
}
