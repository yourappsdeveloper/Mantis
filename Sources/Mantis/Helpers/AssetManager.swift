import UIKit

/// Used to load assets from Lightbox bundle
class AssetManager {

  static func image(_ named: String) -> UIImage? {
    let bundle = Bundle(for: AssetManager.self)
    return UIImage(named: "Mantis.bundle/\(named)", in: bundle, compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
  }
}
