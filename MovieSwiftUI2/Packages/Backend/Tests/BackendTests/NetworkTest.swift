import XCTest
@testable import Backend

@available(iOS 15.0, *)
final class NetworkTests: XCTestCase {
  func testGET() async {
    do {
      let movies: PaginatedResponse<Movie> = try await Network.shared.GET(endpoint: .moviePopular)
      XCTAssertEqual(movies.results.count, 20)
      XCTAssertEqual(movies.page, 1)
    } catch let error {
      XCTAssertThrowsError(error)
    }
  }
  
  func testGETPage2() async {
    do {
      let movies: PaginatedResponse<Movie> = try await Network.shared.GET(endpoint: .moviePopular, params: [.page(page: 2)])
      XCTAssertEqual(movies.results.count, 20)
      XCTAssertEqual(movies.page, 2)
    } catch let error {
      XCTAssertThrowsError(error)
    }
  }
}
