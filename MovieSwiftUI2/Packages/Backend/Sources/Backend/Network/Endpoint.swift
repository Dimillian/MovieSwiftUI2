@available(iOS 15.0, *)
extension Network {
  public enum Endpoint {
    case moviePopular
    case topRated
    case upcoming
    case trending(mediaType: MediaType, timeWindow: TimeWindow)
    case searchMovie
    
    public func build() -> String {
      switch self {
      case .moviePopular:
        return "movie/popular"
      case .topRated:
        return "movie/top_rated"
      case .upcoming:
        return "movie/upcoming"
      case let .trending(mediaType, timeWindow):
        return "trending/\(mediaType.rawValue)/\(timeWindow.rawValue)"
      case .searchMovie:
        return "search/movie"
      }
    }
  }
  
  public enum MediaType: String {
    case all, movie, tv, person
  }
  
  public enum TimeWindow: String {
    case day, week
  }
}
