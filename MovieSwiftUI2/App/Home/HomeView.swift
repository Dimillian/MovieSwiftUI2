import SwiftUI
import Backend
import UI

struct HomeView: View {
  @Environment(\.isSearching) var isSearching: Bool
  @ObservedObject var viewModel: HomeViewModel
  
  var body: some View {
    List {
      if isSearching {
        searchResultsView
      } else {
        if viewModel.sections.isEmpty {
          loadView
        } else {
          ForEach(viewModel.sections) { section in
            makeSection(title: section.title, movies: section.movies)
          }
        }
      }
    }
    .background(Color.primaryBackground)
    .listStyle(.plain)
    .listRowSeparator(.hidden)
    .refreshable {
      await viewModel.fetchData()
    }
    .navigationTitle("Movies")
  }
  
  
  private var loadView: some View {
    HStack {
      Spacer()
      ProgressView()
        .frame(width: 200, height: 200)
      Spacer()
    }
  }
  
  private var searchResultsView: some View {
    ForEach(viewModel.searchResults) { movie in
      Text(movie.title)
    }
  }
  
  private func makeSection(title: String, movies: [Movie]) -> some View {
    Section(header: Text(title)
              .font(.title)
              .fontWeight(.bold),
            content: {
      ScrollView(.horizontal, showsIndicators: false) {
        LazyHStack(alignment: .center, spacing: 32) {
          ForEach(movies) { movie in
            NavigationLink {
              MovieDetailView()
            } label: {
              MovieCarrouselView(movie: movie)
            }
            .buttonStyle(.plain)
          }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
      }
      .listRowInsets(EdgeInsets())
      .listRowBackground(Color.primaryBackground)
    })
  }
}

struct HomrView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView(viewModel: HomeViewModel())
  }
}
