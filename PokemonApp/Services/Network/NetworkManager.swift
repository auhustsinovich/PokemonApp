import Foundation
/// Handles network requests and responses.
/// - Note: This class is a singleton, and should be accessed via the shared property.
final class NetworkManager {

    // MARK: - Internal interface

    /// The shared singleton `NetworkManager` object.
    static let shared = NetworkManager()

    /// Sends a network request to the specified endpoint.
    /// - Parameters:
    ///   - endpoint: The API endpoint to send the request to.
    ///   - page: An integer value that represents the desired page number for the request.
    ///   - completion: A closure to be called with the result of the network request.
    /// - Note: If an error occurs while processing the network request,
    /// the completion closure will be called with a `NetworkError`.
    /// - Important: The completion closure will be called on a background thread.
    func sendRequest(endpoint: EndpointAPI, page: Int,
                     completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = buildURL(endpoint: endpoint, page: page) else {
            completion(.failure(.invalidURL))
            return
        }

        let task = session.dataTask(with: url) { data, response, error in
            self.handleResponse(data: data,
                                response: response,
                                error: error,
                                completion: completion)
        }

        task.resume()
    }

    /// Fetches an image from the specified URL.
    /// - Parameters:
    ///   - url: The URL of the image to fetch.
    ///   - completion: A closure to be called with the result of the network request.
    /// - Note: If an error occurs while processing the network request,
    /// the completion closure will be called with a `NetworkError`.
    /// - Important: The completion closure will be called on a background thread.
    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
            self.handleResponse(data: data,
                                response: response,
                                error: error,
                                completion: completion)
        }

        task.resume()
    }

    // MARK: - Private interface
    
    private init() {}

    private let session = URLSession.shared

    private func buildURL(endpoint: EndpointAPI, page: Int) -> URL? {
        switch endpoint {
        case .pokemonList(page: _):
            let urlComponents = URLComponents(string: endpoint.baseURL + endpoint.path + "\(20 * (page - 1))")
            return urlComponents?.url
        case .pokemonDetail(id: _):
            let urlComponents = URLComponents(string: endpoint.baseURL + endpoint.path)
            return urlComponents?.url
        }
    }

    private func handleResponse(data: Data?,
                                response: URLResponse?,
                                error: Error?,
                                completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard error == nil else {
            completion(.failure(.networkError))
            return
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            completion(.failure(.invalidResponse))
            return
        }

        guard (200..<300).contains(httpResponse.statusCode) else {
            completion(.failure(.networkError))
            return
        }

        guard let data else {
            completion(.failure(.invalidData))
            return
        }

        completion(.success(data))
    }
}
