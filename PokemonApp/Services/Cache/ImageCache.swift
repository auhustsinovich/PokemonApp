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

    // MARK: - Private interface

    private let cache = NSCache<NSString, UIImage>()

    private init() {}
}
