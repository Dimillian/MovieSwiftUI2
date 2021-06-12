import Foundation
@available(iOS 15.0, *)
extension Network {
  public enum Param {
    case page(page: Int)
    case region(region: String)
    case query(query: String)
    
    func build() -> URLQueryItem {
      switch self {
      case let .page(page):
        return .init(name: "page", value: String(page))
      case let .region(region):
        return .init(name: "region", value: region)
      case let .query(query):
        return .init(name: "query", value: query)
      }
    }
  }
}
