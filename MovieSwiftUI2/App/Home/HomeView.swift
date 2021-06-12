import SwiftUI
import Backend
import UI

struct HomeView: View {
  @StateObject var viewModel = HomeViewModel()
  
  private func makeSection(title: String, movies: [Movie]) -> some View {
    Section(header: Text(title)
              .font(.title)
              .fontWeight(.bold),
            content: {
      ScrollView(.horizontal) {
        LazyHStack(alignment: .center, spacing: 32) {
          ForEach(movies) { movie in
            MovieCarrouselView(movie: movie)
          }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
      }
      .listRowInsets(EdgeInsets())
      .listRowBackground(Color.primaryBackground)
    })
  }
  
  var body: some View {
    NavigationView {
      List {
        if viewModel.sections.isEmpty {
          HStack {
            Spacer()
            ProgressView()
              .frame(width: 200, height: 200)
            Spacer()
          }
        } else {
          ForEach(viewModel.sections) { section in
            makeSection(title: section.title, movies: section.movies)
          }
        }
      }
      .background(Color.primaryBackground)
      .listStyle(.plain)
      .listRowSeparator(.hidden)
      .task {
        await viewModel.fetchData()
      }
      .refreshable {
        await viewModel.fetchData()
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
