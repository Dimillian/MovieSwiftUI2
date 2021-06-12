import Foundation

public struct PaginatedResponse<T: Codable>: Codable {
  public let page: Int
  public let results: [T]
}
