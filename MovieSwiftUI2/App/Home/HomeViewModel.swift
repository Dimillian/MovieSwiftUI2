
import Foundation
import SwiftUI
import Backend

class HomeViewModel: ObservableObject {
  @Published var movies: [Movie] = []
  @Published var error: Error?
  @Published var searchText = ""
  
  private var currentPage = 1
  
  func fetchPopularMovies() async {
    do {
      let paginatedMovies: PaginatedResponse<Movie> = try await Network.shared.GET(endpoint: .moviePopular,
                                                                                   params: [.page(page: 1)])
      self.movies = paginatedMovies.results
    } catch let error {
      self.error = error
    }
  }
  
  func fetchNextPage() async {
    do {
      currentPage += 1
      let paginatedMovies: PaginatedResponse<Movie> = try await Network.shared.GET(endpoint: .moviePopular,
                                                                                   params: [.page(page: currentPage)])
      self.movies.append(contentsOf: paginatedMovies.results)
    } catch let error {
      self.error = error
    }
  }
}
