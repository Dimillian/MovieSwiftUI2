import XCTest
@testable import Backend

@available(iOS 15.0, *)
final class NetworkTests: XCTestCase {
  func testGET() async {
    let movies: PaginatedResponse<Movie> = try! await Network.shared.GET(endpoint: .moviePopular)
    XCTAssertEqual(movies.results.count, 20)
    XCTAssertEqual(movies.page, 1)
  }
  
  func testGETPage2() async {
    let movies: PaginatedResponse<Movie> = try! await Network.shared.GET(endpoint: .moviePopular, params: [.page(page: 2)])
    XCTAssertEqual(movies.results.count, 20)
    XCTAssertEqual(movies.page, 2)
  }
}
