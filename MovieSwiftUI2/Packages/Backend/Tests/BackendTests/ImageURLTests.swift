import XCTest
@testable import Backend

@available(iOS 15.0, *)
final class ImageURLTests: XCTestCase {
  func testURLBuilder() async {
    var result = URL(string: "https://image.tmdb.org/t/p/w500/path.jpg")!
    XCTAssertEqual(ImageURL.build(size: .w500, path: "path.jpg"), result)
    
    result = URL(string: "https://image.tmdb.org/t/p/original/path.jpg")!
    XCTAssertEqual(ImageURL.build(size: .original, path: "path.jpg"), result)
  }
}
