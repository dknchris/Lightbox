import UIKit
import SDWebImage

open class LightboxImage {

  open fileprivate(set) var image: UIImage?
  open fileprivate(set) var imageURL: URL?
  open fileprivate(set) var videoURL: URL?
  open fileprivate(set) var imageClosure: (() -> UIImage)?
  open fileprivate(set) var asyncImageLoaders: AsyncImageLoaders?
  open var text: String

  // MARK: - Initialization

  internal init(text: String = "") {
    self.text = text
  }

  public init(image: UIImage, text: String = "", videoURL: URL? = nil) {
    self.image = image
    self.text = text
    self.videoURL = videoURL
  }

  public init(imageURL: URL, text: String = "", videoURL: URL? = nil) {
    self.imageURL = imageURL
    self.text = text
    self.videoURL = videoURL
  }

  public init(imageClosure: @escaping () -> UIImage, text: String = "", videoURL: URL? = nil) {
    self.imageClosure = imageClosure
    self.text = text
    self.videoURL = videoURL
  }
    
  public struct AsyncImageLoaders {
    let imageClosure: () -> UIImage
    let previewClosure: () -> UIImage
      
    public init(imageClosure: @escaping () -> UIImage, previewClosure: @escaping () -> UIImage) {
      self.imageClosure = imageClosure
      self.previewClosure = previewClosure
    }
  }

  public init(asyncImageLoaders: AsyncImageLoaders, text: String = "", videoURL: URL? = nil) {
      self.asyncImageLoaders = asyncImageLoaders
      self.text = text
      self.videoURL = videoURL
  }

  open func addImageTo(_ imageView: SDAnimatedImageView, completion: ((UIImage?) -> Void)? = nil) {
    if let image = image {
      imageView.image = image
      completion?(image)
    } else if let imageURL = imageURL {
      LightboxConfig.loadImage(imageView, imageURL, completion)
    } else if let imageClosure = imageClosure {
      let img = imageClosure()
      imageView.image = img
      completion?(img)
    } else if let asyncImageLoaders = asyncImageLoaders {
        var img = asyncImageLoaders.previewClosure()
        imageView.image = img
      DispatchQueue.global(qos: .userInteractive).async {
        img = asyncImageLoaders.imageClosure()
        DispatchQueue.main.async {
          imageView.image = img
          completion?(img)
        }
      }
    } else {
      imageView.image = nil
      completion?(nil)
    }
  }
}
