import SwiftUI
import Backend

@available(iOS 15.0, *)
public struct MovieCarrouselView: View {
  public let movie: Movie
  
  public init(movie: Movie) {
    self.movie = movie
  }
  
  private var backdropView: some View {
    ZStack {
      if let backdropPath = movie.backdropPath {
        AsyncImage(url: ImageURL.build(size: .original,
                                       path: backdropPath),
                   content: {
          image in
          image.resizable()
            .aspectRatio(contentMode: .fill)
            .blur(radius: 4, opaque: true)
        }, placeholder: {
            Rectangle()
            .fill(Color.black)
            .frame(width: 270, height: 160)
        })
      }
      Color.black.opacity(0.5)
    }
    .clipShape(RoundedRectangle(cornerRadius: 16))
  }
  
  public var body: some View {
    HStack(alignment: .center) {
      if let posterPath = movie.posterPath {
        AsyncImage(url: ImageURL.build(size: .w500, path: posterPath),
                   content: {
          image in
          image.resizable()
            .aspectRatio(contentMode: .fit)
        }, placeholder: {
            Rectangle()
            .fill(Color.gray)
        })
        .clipShape(RoundedRectangle(cornerRadius: 4))
        .frame(width: 80)
      }
      VStack(alignment: .leading, spacing: 8) {
        Text(movie.title)
          .font(.title3)
          .fontWeight(.bold)
          .foregroundColor(.white)
          .lineLimit(2)
        Text(movie.overview ?? "")
          .font(.footnote)
          .foregroundColor(.white)
          .lineLimit(3)
      }
    }
    .padding(8)
    .frame(width: 270, height: 160)
    .background {
      backdropView
    }
    .shadow(color: .black.opacity(0.5), radius: 5)
  }
}

@available(iOS 15.0, *)
struct MovieCarrouselView_Previews: PreviewProvider {
  static var previews: some View {
    MovieCarrouselView(movie: PLACEHODLER_MOVIE)
  }
}
