import Foundation

@available(iOS 15.0, *)
@available(macOS 12.0, *)
@available(tvOS 15.0, *)
public class Network {
  public static let shared = Network()
  private let decoder: JSONDecoder
  private let urlSession = URLSession.shared
  
  init() {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    self.decoder = decoder
  }
  
  public func GET<JSONModel: Codable>(endpoint: Endpoint, params: [Param]? = nil) async throws -> JSONModel {
    var request = buildRequest(endpoint, params: params)
    request.httpMethod = "GET"
    let (data, _) = try await urlSession.data(for: request, delegate: nil)
    let object = try decoder.decode(JSONModel.self, from: data)
    return object
  }
  
  private func buildRequest(_ endpoint: Endpoint, params: [Param]?) -> URLRequest {
    let url = buildURL(endpoint)
    var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
    components.queryItems = [
      URLQueryItem(name: "api_key", value: Constants.API_KEY),
      URLQueryItem(name: "language", value: Locale.preferredLanguages[0])
    ]
    if let params = params {
      components.queryItems?.append(contentsOf: params.map{ $0.build() })
    }
    return URLRequest(url: components.url!)
  }
  
  private func buildURL(_ endpoint: Endpoint) -> URL {
    Constants.BASE_URL.appendingPathComponent(endpoint.rawValue)
  }
}
