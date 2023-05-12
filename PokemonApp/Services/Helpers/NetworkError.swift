import Foundation

/// Possible error cases  that can occur during network communication.
enum NetworkError: Error {
    /// The URL provided for network communication is invalid.
    case invalidURL
    /// An error occurred while attempting to communicate over the network.
    case networkError
    /// The data received from the network is invalid or corrupted.
    case invalidData
    /// The response received from the network is not in the expected format.
    case invalidResponse
}
