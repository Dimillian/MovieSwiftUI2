import SwiftUI

struct HomeView: View {
  @StateObject var viewModel = HomeViewModel()
  
  var body: some View {
    NavigationView {
      List(viewModel.movies) { movie in
        Text(movie.title)
      }
      .task {
        await viewModel.fetchPopularMoview()
      }
      .refreshable {
        await viewModel.fetchPopularMoview()
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
