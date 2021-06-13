import Foundation

public struct Movie: Codable, Identifiable {
  public let id: Int
  public let title: String
  public let posterPath: String?
  public let backdropPath: String?
  public let overview: String?
  public let tagline: String?
  public let releaseDate: String?
  public var releaseDateAsDate: Date?  {
    guard let releaseDate = releaseDate else { return nil }
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.date(from: releaseDate)
  }
  
  public init(id: Int,
              title: String,
              posterPath: String?,
              backdropPath: String?,
              overview: String?,
              tagline: String?,
              releaseDate: String?) {
    self.id = id
    self.title = title
    self.posterPath = posterPath
    self.backdropPath = backdropPath
    self.overview = overview
    self.tagline = tagline
    self.releaseDate = releaseDate
  }
}
