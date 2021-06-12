import Foundation

public struct Movie: Codable, Identifiable {
  public let id: Int
  public let title: String
  public let posterPath: String?
  public let backdropPath: String?
  public let overview: String?
  
  public init(id: Int,
              title: String,
              posterPath: String?,
              backdropPath: String?,
              overview: String?) {
    self.id = id
    self.title = title
    self.posterPath = posterPath
    self.backdropPath = backdropPath
    self.overview = overview
  }
}
