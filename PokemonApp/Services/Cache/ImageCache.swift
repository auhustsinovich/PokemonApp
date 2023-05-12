import UIKit

/// A simple image cache that stores images in memory using NSCache.
class ImageCache {

    // MARK: - Internal interface

    /// Singleton instance of the cache.
    static let shared = ImageCache()

    /// Retrieves an image from the cache.
    /// - Parameter key: The unique key associated with the image.
    /// - Returns: The cached image, or nil if it is not present in the cache.
    func object(forKey key: NSString) -> UIImage? {
        return cache.object(forKey: key)
    }

    /// Adds an image to the cache.
    /// - Parameters:
    ///   - object: The image to be cached.
    ///   - key: The unique key associated with the image.
    func setObject(_ object: UIImage, forKey key: NSString) {
        cache.setObject(object, forKey: key)
    }

    /// Fetches an image from a URL, caching it if possible.
    /// - Parameters:
    ///   - url: The URL of the image to fetch.
    ///   - completion: A closure that is called when the image is fetched or an error occurs.
    func getImage(from url: URL, completion: @escaping(Result<UIImage, Error>) -> Void) {
        // Getting image from cache
        if let cacheImage = ImageCache.shared.object(forKey: url.lastPathComponent as NSString) {
            completion(.success(cacheImage))
            return
        }

        // Fetching image from network
        NetworkManager.shared.fetchImage(from: url) { result in
            switch result {
            case .success(let imageData):
                guard let image = UIImage(data: imageData) else { return }
                ImageCache.shared.setObject(image, forKey: url.lastPathComponent as NSString)
                completion(.success(image))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // MARK: - Private interface

    private let cache = NSCache<NSString, UIImage>()

    private init() {}
}
