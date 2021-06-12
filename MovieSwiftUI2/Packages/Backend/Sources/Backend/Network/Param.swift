import Foundation
@available(iOS 15.0, *)
extension Network {
  public enum Param {
    case page(page: Int)
    case region(region: String)
    
    func build() -> URLQueryItem {
      switch self {
      case let .page(page):
        return .init(name: "page", value: String(page))
      case let .region(region):
        return .init(name: "region", value: region)
      }
    }
  }
}
