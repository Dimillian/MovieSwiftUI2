import SwiftUI

struct HomeContainerView: View {
  @StateObject var viewModel = HomeViewModel()
  
  var body: some View {
    NavigationView {
      HomeView(viewModel: viewModel)
        .searchable(text: $viewModel.searchText)
        .onReceive(viewModel.$searchText.debounce(for: 0.5, scheduler: DispatchQueue.main),
                   perform: { query in
          async {
            await viewModel.fetchSearch(query: query)
          }
        })
    }
  }
}

struct HomeContainerView_Previews: PreviewProvider {
  static var previews: some View {
    HomeContainerView()
  }
}
