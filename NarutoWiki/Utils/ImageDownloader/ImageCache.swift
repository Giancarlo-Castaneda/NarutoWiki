import UIKit

final class DownloadedImageCache {
    var cache = NSCache<NSString, UIImage>()

    init() {
        cache.totalCostLimit = 20_000_000
    }

    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }

    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}

extension DownloadedImageCache {
    private static var imageCache = DownloadedImageCache()

    static func getImageCache() -> DownloadedImageCache {
        return imageCache
    }
}
