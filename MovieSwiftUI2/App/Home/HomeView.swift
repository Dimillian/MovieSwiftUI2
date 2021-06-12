import SwiftUI

struct HomeView: View {
  @StateObject var viewModel = HomeViewModel()
  
  var body: some View {
    NavigationView {
      List {
        ForEach(viewModel.movies) { movie in
          Text(movie.title)
        }
        if !viewModel.movies.isEmpty {
          Rectangle()
            .fill(Color.clear)
            .frame(width: 1, height: 1)
            .task {
              await viewModel.fetchNextPage()
            }
            .listRowInsets(EdgeInsets())
        }
      }
      .task {
        await viewModel.fetchPopularMovies()
      }
      .refreshable {
        await viewModel.fetchPopularMovies()
      }
      .searchable(text: $viewModel.searchText)
      .navigationTitle("Movies")
    }
  }
}

struct HomrView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
