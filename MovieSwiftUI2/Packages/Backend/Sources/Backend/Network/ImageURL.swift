import Foundation

public struct ImageURL {
  public enum Constants {
    static let BASE_URL = URL(string: "https://image.tmdb.org/t/p")!
  }
  
  public enum size: String {
    case original
    case w500
  }
  
  public static func build(size: size, path: String) -> URL {
    var url = Constants.BASE_URL
    url.appendPathComponent(size.rawValue)
    url.appendPathComponent(path)
    return url
  }
}
